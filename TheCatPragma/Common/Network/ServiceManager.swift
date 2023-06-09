//
//  ServiceManager.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//

import Foundation
import Alamofire

enum Result<T: Decodable, E: Decodable> {
    case BusinessError(E?)
    case Failure(NSError)
    case Success(T?)
}

enum ResultData<E: Decodable> {
    case BusinessError(E?)
    case Failure(NSError)
    case Success(Data)
}

enum ContentType: String {
    case json = "application/json"
    case urlencoded = "application/x-www-form-urlencoded"
}

enum AuthorizationType {
    case otp
    case none
    case header
}

enum HTTPStatus {
    case badRequest
    case businessError
    case internalServerError
    case notImplementedError
    case ok
    case unauthorized
    case resetContent
    
    var code: Int {
        switch self {
        case .ok: return 200
        case .resetContent: return 205
        case .businessError: return 280
        case .badRequest: return 400
        case .unauthorized: return 401
        case .internalServerError: return 500
        case .notImplementedError: return 501
        }
    }
}

class ServicesManager {
    
    // MARK: - Private properties -
    private let userAuthorization: String = "appuser"
    private let passAuthorization: String = "pass"
    private let authorizationKey: String = "bda53789-d59e-46cd-2936630fde39"
    private let authorizationParam: String = "x-api-key"
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private var imagesCache: [String: Data] = [:]
    
    // MARK: - Public properties -
    static let timeoutInterval: Double = 60
    
    let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.timeoutIntervalForResource = timeoutInterval
        return Alamofire.Session(configuration: configuration)
    }()
    
    // MARK: - Lifecycle -
    static let share = ServicesManager()
    private init() {}
    
    // MARK: - Private methods -
    private func getHeadersAuthorization() -> HTTPHeaders {
        var headers: HTTPHeaders = []
        headers = [
            .authorization(username: userAuthorization, password: passAuthorization), .accept(ContentType.json.rawValue),
            .contentType(ContentType.json.rawValue)
        ]
        return headers
    }
    
    private func getHeadersAuthorizationKey() -> HTTPHeaders {
        var headers: HTTPHeaders = []
        headers = [
            .accept(ContentType.json.rawValue),
            .contentType(ContentType.json.rawValue)
        ]
        return headers
    }
    
    func execute<T: Decodable, E: Decodable>(
        _ url: URL = Connections.url(.breeds, .v1),
        headers: HTTPHeaders? = nil,
        method: HTTPMethod = .get,
        params: [String: Any]? = nil,
        authorizationType: AuthorizationType = .header,
        responseHandler: @escaping (Result<T, E>) -> Void
    ) {
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        var parameters: [String: Any] = [:]
        var httpHeaders: HTTPHeaders? = headers
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        switch authorizationType {
        case .otp:
            if httpHeaders == nil { httpHeaders = [] }
            for header in getHeadersAuthorization() { httpHeaders?.add(header) }
        case .header:
            if httpHeaders == nil { httpHeaders = [] }
            for header in getHeadersAuthorizationKey() { httpHeaders?.add(header) }
            components?.queryItems = [URLQueryItem(name: authorizationParam, value: authorizationKey)]
        case .none:
            break
        }
        
        let statusCodeRange = [
            (HTTPStatus.ok.code ..< HTTPStatus.unauthorized.code),
            (HTTPStatus.internalServerError.code ..< HTTPStatus.notImplementedError.code)
        ].joined()
        
        if let params = params { parameters.merge(params) { (_, new) in new } }
        guard let urlCompleted = components?.url else { return }
        
        session.request(
            urlCompleted,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: httpHeaders
        ).validate(statusCode: statusCodeRange)
            .responseData { response in
            
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }
                switch statusCode {
                case HTTPStatus.ok.code...HTTPStatus.resetContent.code:
                    guard let serverResponse: T = try? self.decoder.decode(T.self, from: data) else {
                        let error = NSError(domain: "Parse Error - \(url)", code: 0)
                        responseHandler(Result.Failure(error))
                        return
                    }
                    responseHandler(Result.Success(serverResponse))
                case HTTPStatus.businessError.code, HTTPStatus.unauthorized.code, HTTPStatus.badRequest.code ..< HTTPStatus.notImplementedError.code:
                    do {
                        let serverResponse = try self.decoder.decode(E.self, from: data)
                        responseHandler(Result.BusinessError(serverResponse))
                    } catch let error {
                        let responseError = NSError(domain: "service-manager", code: statusCode, userInfo: ["description": error.localizedDescription])
                        responseHandler(Result.Failure(responseError))
                        return
                    }
                default: break
                }
            case .failure(let error):
                let error = NSError(domain: "Fail service - \(url) \n- error: \(error)", code: 0)
                responseHandler(Result.Failure(error))
            }
        }
    }
}



import Alamofire
import Foundation

public class Arcadia {
    private let session: Session
    
    public init(username: String, password: String) {
        // iPhone 14 Pro Max Remix The Return
        let agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 16_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5.2 (a) Mobile/15E148 Safari/604.1"
        let configuration = AF.sessionConfiguration
        configuration.headers = [
            .defaultAcceptLanguage,
            .defaultAcceptEncoding,
            HTTPHeader(name: "X-Requested-With", value: "com.tecnotrends.sagres.mobile"),
            .userAgent(agent),
            .authorization(username: username, password: password)
        ]
        
        self.session = Session(configuration: configuration, interceptor: ARTimestampInterceptor())
    }
    
    public func login() async -> Result<Person, AFError> {
        return await LoginOperation.execute(session)
    }
    
    public func messages(forProfile profile: Int, until: String = "", count: Int = 10) async -> Result<MessagesPage, AFError> {
        return await MessagesOperation.execute(session, profile, until, count)
    }
    
    public func semesters(forProfile profile: Int) async -> Result<[Semester], AFError> {
        return await SemesterOperation.execute(session, profile)
    }
    
    public func grades(forProfile profile: Int, atSemester semester: Int) async -> Result<[DisciplineData], AFError> {
        return await GradesOperation.execute(session, profile, semester)
    }
    
    public func lectures(for groupId: Int, limit: Int, offset: Int) async -> Result<[Lecture], AFError> {
        return await LecturesOperation.execute(session, groupId, limit, offset)
    }
}

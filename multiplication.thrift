namespace py python_mul_package
namespace java com.slack.thriftDemo
// namespace hack FBThrift.Slack.Slog.Flannel


//Typealias i32 to int
typedef i32 int

struct user {

}

service MultiplicationService {
    int multiply(1:int a, 2:int b),

}
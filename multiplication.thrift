namespace py python_mul_package
namespace java com.eddie.thriftDemo


//Typealias i32 to int
typedef i32 int

struct User {
    1: int userId
    2: string username
    3: int age
}

struct Channel {
    1: int channelId
    2: string name
    3: list<int> UserId
}


service UsersProviderService {
    User createUser(1: string username, 2: int age);
    User userById(1: int userId);
}

service MultiplicationService {
    int multiply(1:int a, 2:int b);
}
/**
 * Autogenerated by Thrift Compiler (0.12.0)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */

import Foundation

import Thrift


public func ==(lhs: user, rhs: user) -> Bool {
  return true
}

extension user : CustomStringConvertible {

  public var description : String {
    var desc = "user("
    return desc
  }

}

extension user : Hashable {

  public var hashValue : Int {
    return 31
  }

}

extension user : TStruct {

  public static var fieldIds: [String: Int32] {
    return [:]
  }

  public static var structName: String { return "user" }

  public static func read(from proto: TProtocol) throws -> user {
    _ = try proto.readStructBegin()

    fields: while true {

      let (_, fieldType, fieldID) = try proto.readFieldBegin()

      switch (fieldID, fieldType) {
        case (_, .stop):            break fields
        case let (_, unknownType):  try proto.skip(type: unknownType)
      }

      try proto.readFieldEnd()
    }

    try proto.readStructEnd()

    return user()
  }

}



fileprivate final class MultiplicationService_multiply_args {

  fileprivate var a: int

  fileprivate var b: int


  fileprivate init(a: int, b: int) {
    self.a = a
    self.b = b
  }

}

fileprivate func ==(lhs: MultiplicationService_multiply_args, rhs: MultiplicationService_multiply_args) -> Bool {
  return
    (lhs.a == rhs.a) &&
    (lhs.b == rhs.b)
}

extension MultiplicationService_multiply_args : Hashable {

  fileprivate var hashValue : Int {
    let prime = 31
    var result = 1
    result = prime &* result &+ (a.hashValue)
    result = prime &* result &+ (b.hashValue)
    return result
  }

}

extension MultiplicationService_multiply_args : TStruct {

  fileprivate static var fieldIds: [String: Int32] {
    return ["a": 1, "b": 2, ]
  }

  fileprivate static var structName: String { return "MultiplicationService_multiply_args" }

  fileprivate static func read(from proto: TProtocol) throws -> MultiplicationService_multiply_args {
    _ = try proto.readStructBegin()
    var a: int!
    var b: int!

    fields: while true {

      let (_, fieldType, fieldID) = try proto.readFieldBegin()

      switch (fieldID, fieldType) {
        case (_, .stop):            break fields
        case (1, .i32):             a = try int.read(from: proto)
        case (2, .i32):             b = try int.read(from: proto)
        case let (_, unknownType):  try proto.skip(type: unknownType)
      }

      try proto.readFieldEnd()
    }

    try proto.readStructEnd()
    // Required fields
    try proto.validateValue(a, named: "a")
    try proto.validateValue(b, named: "b")

    return MultiplicationService_multiply_args(a: a, b: b)
  }

}



fileprivate final class MultiplicationService_multiply_result {

  fileprivate var success: int?


  fileprivate init() { }
  fileprivate init(success: int?) {
    self.success = success
  }

}

fileprivate func ==(lhs: MultiplicationService_multiply_result, rhs: MultiplicationService_multiply_result) -> Bool {
  return
    (lhs.success == rhs.success)
}

extension MultiplicationService_multiply_result : Hashable {

  fileprivate var hashValue : Int {
    let prime = 31
    var result = 1
    result = prime &* result &+ (success?.hashValue ?? 0)
    return result
  }

}

extension MultiplicationService_multiply_result : TStruct {

  fileprivate static var fieldIds: [String: Int32] {
    return ["success": 0, ]
  }

  fileprivate static var structName: String { return "MultiplicationService_multiply_result" }

  fileprivate static func read(from proto: TProtocol) throws -> MultiplicationService_multiply_result {
    _ = try proto.readStructBegin()
    var success: int?

    fields: while true {

      let (_, fieldType, fieldID) = try proto.readFieldBegin()

      switch (fieldID, fieldType) {
        case (_, .stop):            break fields
        case (0, .i32):             success = try int.read(from: proto)
        case let (_, unknownType):  try proto.skip(type: unknownType)
      }

      try proto.readFieldEnd()
    }

    try proto.readStructEnd()

    return MultiplicationService_multiply_result(success: success)
  }

}



extension MultiplicationServiceClient : MultiplicationService {

  private func send_multiply(a: int, b: int) throws {
    try outProtocol.writeMessageBegin(name: "multiply", type: .call, sequenceID: 0)
    let args = MultiplicationService_multiply_args(a: a, b: b)
    try args.write(to: outProtocol)
    try outProtocol.writeMessageEnd()
  }

  private func recv_multiply() throws -> int {
    try inProtocol.readResultMessageBegin() 
    let result = try MultiplicationService_multiply_result.read(from: inProtocol)
    try inProtocol.readMessageEnd()

    if let success = result.success {
      return success
    }
    throw TApplicationError(error: .missingResult(methodName: "multiply"))
  }

  public func multiply(a: int, b: int) throws -> int {
    try send_multiply(a: a, b: b)
    try outProtocol.transport.flush()
    return try recv_multiply()
  }

}

extension MultiplicationServiceProcessor : TProcessor {

  static let processorHandlers: ProcessorHandlerDictionary = {

    var processorHandlers = ProcessorHandlerDictionary()

    processorHandlers["multiply"] = { sequenceID, inProtocol, outProtocol, handler in

      let args = try MultiplicationService_multiply_args.read(from: inProtocol)

      try inProtocol.readMessageEnd()

      var result = MultiplicationService_multiply_result()
      do {
        result.success = try handler.multiply(a: args.a, b: args.b)
      }
      catch let error { throw error }

      try outProtocol.writeMessageBegin(name: "multiply", type: .reply, sequenceID: sequenceID)
      try result.write(to: outProtocol)
      try outProtocol.writeMessageEnd()
    }
    return processorHandlers
  }()

  public func process(on inProtocol: TProtocol, outProtocol: TProtocol) throws {

    let (messageName, _, sequenceID) = try inProtocol.readMessageBegin()

    if let processorHandler = MultiplicationServiceProcessor.processorHandlers[messageName] {
      do {
        try processorHandler(sequenceID, inProtocol, outProtocol, service)
      }
      catch let error as TApplicationError {
        try outProtocol.writeException(messageName: messageName, sequenceID: sequenceID, ex: error)
      }
    }
    else {
      try inProtocol.skip(type: .struct)
      try inProtocol.readMessageEnd()
      let ex = TApplicationError(error: .unknownMethod(methodName: messageName))
      try outProtocol.writeException(messageName: messageName, sequenceID: sequenceID, ex: ex)
    }
  }
}

-- chunkname: @modules/proto/DispatchModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.DispatchModule_pb", package.seeall)

local DispatchModule_pb = {}

DispatchModule_pb.DISPATCHREPLY_MSG = protobuf.Descriptor()
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHINFO_MSG = protobuf.Descriptor()
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG = protobuf.Descriptor()
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG = protobuf.Descriptor()
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG = protobuf.Descriptor()
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG = protobuf.Descriptor()
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREQUEST_MSG = protobuf.Descriptor()
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD = protobuf.FieldDescriptor()
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.name = "elementId"
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.full_name = ".DispatchReply.elementId"
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.number = 1
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.index = 0
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.label = 1
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.default_value = 0
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.type = 5
DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.name = "dispatchId"
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.full_name = ".DispatchReply.dispatchId"
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.number = 2
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.index = 1
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.label = 1
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.default_value = 0
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.type = 5
DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.name = "startTime"
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.full_name = ".DispatchReply.startTime"
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.number = 3
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.index = 2
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.label = 1
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.default_value = 0
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.type = 4
DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD.cpp_type = 4
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.name = "endTime"
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.full_name = ".DispatchReply.endTime"
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.number = 4
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.index = 3
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.label = 1
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.default_value = 0
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.type = 4
DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD.cpp_type = 4
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.name = "heroIds"
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.full_name = ".DispatchReply.heroIds"
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.number = 5
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.index = 4
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.label = 3
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.default_value = {}
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.type = 5
DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHREPLY_MSG.name = "DispatchReply"
DispatchModule_pb.DISPATCHREPLY_MSG.full_name = ".DispatchReply"
DispatchModule_pb.DISPATCHREPLY_MSG.nested_types = {}
DispatchModule_pb.DISPATCHREPLY_MSG.enum_types = {}
DispatchModule_pb.DISPATCHREPLY_MSG.fields = {
	DispatchModule_pb.DISPATCHREPLYELEMENTIDFIELD,
	DispatchModule_pb.DISPATCHREPLYDISPATCHIDFIELD,
	DispatchModule_pb.DISPATCHREPLYSTARTTIMEFIELD,
	DispatchModule_pb.DISPATCHREPLYENDTIMEFIELD,
	DispatchModule_pb.DISPATCHREPLYHEROIDSFIELD
}
DispatchModule_pb.DISPATCHREPLY_MSG.is_extendable = false
DispatchModule_pb.DISPATCHREPLY_MSG.extensions = {}
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.name = "elementId"
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.full_name = ".DispatchInfo.elementId"
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.number = 1
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.index = 0
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.label = 1
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.has_default_value = false
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.default_value = 0
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.type = 5
DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.name = "dispatchId"
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.full_name = ".DispatchInfo.dispatchId"
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.number = 2
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.index = 1
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.label = 1
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.has_default_value = false
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.default_value = 0
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.type = 5
DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.name = "endTime"
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.full_name = ".DispatchInfo.endTime"
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.number = 3
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.index = 2
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.label = 1
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.has_default_value = false
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.default_value = 0
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.type = 4
DispatchModule_pb.DISPATCHINFOENDTIMEFIELD.cpp_type = 4
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.name = "heroIds"
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.full_name = ".DispatchInfo.heroIds"
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.number = 4
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.index = 3
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.label = 3
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.has_default_value = false
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.default_value = {}
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.type = 5
DispatchModule_pb.DISPATCHINFOHEROIDSFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHINFO_MSG.name = "DispatchInfo"
DispatchModule_pb.DISPATCHINFO_MSG.full_name = ".DispatchInfo"
DispatchModule_pb.DISPATCHINFO_MSG.nested_types = {}
DispatchModule_pb.DISPATCHINFO_MSG.enum_types = {}
DispatchModule_pb.DISPATCHINFO_MSG.fields = {
	DispatchModule_pb.DISPATCHINFOELEMENTIDFIELD,
	DispatchModule_pb.DISPATCHINFODISPATCHIDFIELD,
	DispatchModule_pb.DISPATCHINFOENDTIMEFIELD,
	DispatchModule_pb.DISPATCHINFOHEROIDSFIELD
}
DispatchModule_pb.DISPATCHINFO_MSG.is_extendable = false
DispatchModule_pb.DISPATCHINFO_MSG.extensions = {}
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.name = "dispatchInfos"
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.full_name = ".GetDispatchInfoReply.dispatchInfos"
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.number = 1
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.index = 0
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.label = 3
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.has_default_value = false
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.default_value = {}
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.message_type = DispatchModule_pb.DISPATCHINFO_MSG
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.type = 11
DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD.cpp_type = 10
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.name = "GetDispatchInfoReply"
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.full_name = ".GetDispatchInfoReply"
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.nested_types = {}
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.enum_types = {}
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.fields = {
	DispatchModule_pb.GETDISPATCHINFOREPLYDISPATCHINFOSFIELD
}
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.is_extendable = false
DispatchModule_pb.GETDISPATCHINFOREPLY_MSG.extensions = {}
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.name = "elementId"
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.full_name = ".InterruptDispatchRequest.elementId"
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.number = 1
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.index = 0
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.label = 1
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.has_default_value = false
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.default_value = 0
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.type = 5
DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD.cpp_type = 1
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.name = "dispatchId"
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.full_name = ".InterruptDispatchRequest.dispatchId"
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.number = 2
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.index = 1
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.label = 1
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.has_default_value = false
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.default_value = 0
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.type = 5
DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD.cpp_type = 1
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.name = "InterruptDispatchRequest"
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.full_name = ".InterruptDispatchRequest"
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.nested_types = {}
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.enum_types = {}
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.fields = {
	DispatchModule_pb.INTERRUPTDISPATCHREQUESTELEMENTIDFIELD,
	DispatchModule_pb.INTERRUPTDISPATCHREQUESTDISPATCHIDFIELD
}
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.is_extendable = false
DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG.extensions = {}
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.name = "GetDispatchInfoRequest"
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.full_name = ".GetDispatchInfoRequest"
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.nested_types = {}
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.enum_types = {}
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.fields = {}
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.is_extendable = false
DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG.extensions = {}
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.name = "elementId"
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.full_name = ".InterruptDispatchReply.elementId"
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.number = 1
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.index = 0
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.label = 1
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.has_default_value = false
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.default_value = 0
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.type = 5
DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD.cpp_type = 1
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.name = "dispatchId"
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.full_name = ".InterruptDispatchReply.dispatchId"
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.number = 2
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.index = 1
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.label = 1
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.has_default_value = false
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.default_value = 0
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.type = 5
DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD.cpp_type = 1
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.name = "InterruptDispatchReply"
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.full_name = ".InterruptDispatchReply"
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.nested_types = {}
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.enum_types = {}
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.fields = {
	DispatchModule_pb.INTERRUPTDISPATCHREPLYELEMENTIDFIELD,
	DispatchModule_pb.INTERRUPTDISPATCHREPLYDISPATCHIDFIELD
}
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.is_extendable = false
DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG.extensions = {}
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.name = "elementId"
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.full_name = ".DispatchRequest.elementId"
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.number = 1
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.index = 0
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.label = 1
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.default_value = 0
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.type = 5
DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.name = "dispatchId"
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.full_name = ".DispatchRequest.dispatchId"
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.number = 2
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.index = 1
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.label = 1
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.default_value = 0
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.type = 5
DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.name = "heroIds"
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.full_name = ".DispatchRequest.heroIds"
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.number = 3
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.index = 2
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.label = 3
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.has_default_value = false
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.default_value = {}
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.type = 5
DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD.cpp_type = 1
DispatchModule_pb.DISPATCHREQUEST_MSG.name = "DispatchRequest"
DispatchModule_pb.DISPATCHREQUEST_MSG.full_name = ".DispatchRequest"
DispatchModule_pb.DISPATCHREQUEST_MSG.nested_types = {}
DispatchModule_pb.DISPATCHREQUEST_MSG.enum_types = {}
DispatchModule_pb.DISPATCHREQUEST_MSG.fields = {
	DispatchModule_pb.DISPATCHREQUESTELEMENTIDFIELD,
	DispatchModule_pb.DISPATCHREQUESTDISPATCHIDFIELD,
	DispatchModule_pb.DISPATCHREQUESTHEROIDSFIELD
}
DispatchModule_pb.DISPATCHREQUEST_MSG.is_extendable = false
DispatchModule_pb.DISPATCHREQUEST_MSG.extensions = {}
DispatchModule_pb.DispatchInfo = protobuf.Message(DispatchModule_pb.DISPATCHINFO_MSG)
DispatchModule_pb.DispatchReply = protobuf.Message(DispatchModule_pb.DISPATCHREPLY_MSG)
DispatchModule_pb.DispatchRequest = protobuf.Message(DispatchModule_pb.DISPATCHREQUEST_MSG)
DispatchModule_pb.GetDispatchInfoReply = protobuf.Message(DispatchModule_pb.GETDISPATCHINFOREPLY_MSG)
DispatchModule_pb.GetDispatchInfoRequest = protobuf.Message(DispatchModule_pb.GETDISPATCHINFOREQUEST_MSG)
DispatchModule_pb.InterruptDispatchReply = protobuf.Message(DispatchModule_pb.INTERRUPTDISPATCHREPLY_MSG)
DispatchModule_pb.InterruptDispatchRequest = protobuf.Message(DispatchModule_pb.INTERRUPTDISPATCHREQUEST_MSG)

return DispatchModule_pb

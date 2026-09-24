-- chunkname: @modules/proto/SonnetModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.SonnetModule_pb", package.seeall)

local SonnetModule_pb = {}

SonnetModule_pb.SONNETUSEWORDREQUEST_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETGETINFOREQUEST_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETNO_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETNOWORDSFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETUSEWORDREPLY_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETWORDPUSH_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETGETINFOREPLY_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETWORDNO_MSG = protobuf.Descriptor()
SonnetModule_pb.SONNETWORDNOIDFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETWORDNOSTATUSFIELD = protobuf.FieldDescriptor()
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.name = "id"
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.full_name = ".SonnetUseWordRequest.id"
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.number = 1
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.index = 0
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.label = 1
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.has_default_value = false
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.default_value = 0
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.type = 5
SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD.cpp_type = 1
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.name = "SonnetUseWordRequest"
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.full_name = ".SonnetUseWordRequest"
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.nested_types = {}
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.enum_types = {}
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.fields = {
	SonnetModule_pb.SONNETUSEWORDREQUESTIDFIELD
}
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.is_extendable = false
SonnetModule_pb.SONNETUSEWORDREQUEST_MSG.extensions = {}
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.name = "SonnetGetInfoRequest"
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.full_name = ".SonnetGetInfoRequest"
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.nested_types = {}
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.enum_types = {}
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.fields = {}
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.is_extendable = false
SonnetModule_pb.SONNETGETINFOREQUEST_MSG.extensions = {}
SonnetModule_pb.SONNETNOWORDSFIELD.name = "words"
SonnetModule_pb.SONNETNOWORDSFIELD.full_name = ".SonnetNO.words"
SonnetModule_pb.SONNETNOWORDSFIELD.number = 1
SonnetModule_pb.SONNETNOWORDSFIELD.index = 0
SonnetModule_pb.SONNETNOWORDSFIELD.label = 3
SonnetModule_pb.SONNETNOWORDSFIELD.has_default_value = false
SonnetModule_pb.SONNETNOWORDSFIELD.default_value = {}
SonnetModule_pb.SONNETNOWORDSFIELD.message_type = SonnetModule_pb.SONNETWORDNO_MSG
SonnetModule_pb.SONNETNOWORDSFIELD.type = 11
SonnetModule_pb.SONNETNOWORDSFIELD.cpp_type = 10
SonnetModule_pb.SONNETNO_MSG.name = "SonnetNO"
SonnetModule_pb.SONNETNO_MSG.full_name = ".SonnetNO"
SonnetModule_pb.SONNETNO_MSG.nested_types = {}
SonnetModule_pb.SONNETNO_MSG.enum_types = {}
SonnetModule_pb.SONNETNO_MSG.fields = {
	SonnetModule_pb.SONNETNOWORDSFIELD
}
SonnetModule_pb.SONNETNO_MSG.is_extendable = false
SonnetModule_pb.SONNETNO_MSG.extensions = {}
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.name = "words"
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.full_name = ".SonnetConsumeWordReply.words"
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.number = 1
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.index = 0
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.label = 3
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.has_default_value = false
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.default_value = {}
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.message_type = SonnetModule_pb.SONNETWORDNO_MSG
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.type = 11
SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD.cpp_type = 10
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.name = "SonnetConsumeWordReply"
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.full_name = ".SonnetConsumeWordReply"
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.nested_types = {}
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.enum_types = {}
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.fields = {
	SonnetModule_pb.SONNETCONSUMEWORDREPLYWORDSFIELD
}
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.is_extendable = false
SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG.extensions = {}
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.name = "id"
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.full_name = ".SonnetUseWordReply.id"
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.number = 1
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.index = 0
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.label = 1
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.has_default_value = false
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.default_value = 0
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.type = 5
SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD.cpp_type = 1
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.name = "SonnetUseWordReply"
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.full_name = ".SonnetUseWordReply"
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.nested_types = {}
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.enum_types = {}
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.fields = {
	SonnetModule_pb.SONNETUSEWORDREPLYIDFIELD
}
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.is_extendable = false
SonnetModule_pb.SONNETUSEWORDREPLY_MSG.extensions = {}
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.name = "words"
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.full_name = ".SonnetWordPush.words"
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.number = 1
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.index = 0
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.label = 3
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.has_default_value = false
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.default_value = {}
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.message_type = SonnetModule_pb.SONNETWORDNO_MSG
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.type = 11
SonnetModule_pb.SONNETWORDPUSHWORDSFIELD.cpp_type = 10
SonnetModule_pb.SONNETWORDPUSH_MSG.name = "SonnetWordPush"
SonnetModule_pb.SONNETWORDPUSH_MSG.full_name = ".SonnetWordPush"
SonnetModule_pb.SONNETWORDPUSH_MSG.nested_types = {}
SonnetModule_pb.SONNETWORDPUSH_MSG.enum_types = {}
SonnetModule_pb.SONNETWORDPUSH_MSG.fields = {
	SonnetModule_pb.SONNETWORDPUSHWORDSFIELD
}
SonnetModule_pb.SONNETWORDPUSH_MSG.is_extendable = false
SonnetModule_pb.SONNETWORDPUSH_MSG.extensions = {}
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.name = "SonnetConsumeWordRequest"
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.full_name = ".SonnetConsumeWordRequest"
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.nested_types = {}
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.enum_types = {}
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.fields = {}
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.is_extendable = false
SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG.extensions = {}
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.name = "sonnet"
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.full_name = ".SonnetGetInfoReply.sonnet"
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.number = 1
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.index = 0
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.label = 1
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.has_default_value = false
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.default_value = nil
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.message_type = SonnetModule_pb.SONNETNO_MSG
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.type = 11
SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD.cpp_type = 10
SonnetModule_pb.SONNETGETINFOREPLY_MSG.name = "SonnetGetInfoReply"
SonnetModule_pb.SONNETGETINFOREPLY_MSG.full_name = ".SonnetGetInfoReply"
SonnetModule_pb.SONNETGETINFOREPLY_MSG.nested_types = {}
SonnetModule_pb.SONNETGETINFOREPLY_MSG.enum_types = {}
SonnetModule_pb.SONNETGETINFOREPLY_MSG.fields = {
	SonnetModule_pb.SONNETGETINFOREPLYSONNETFIELD
}
SonnetModule_pb.SONNETGETINFOREPLY_MSG.is_extendable = false
SonnetModule_pb.SONNETGETINFOREPLY_MSG.extensions = {}
SonnetModule_pb.SONNETWORDNOIDFIELD.name = "id"
SonnetModule_pb.SONNETWORDNOIDFIELD.full_name = ".SonnetWordNO.id"
SonnetModule_pb.SONNETWORDNOIDFIELD.number = 1
SonnetModule_pb.SONNETWORDNOIDFIELD.index = 0
SonnetModule_pb.SONNETWORDNOIDFIELD.label = 1
SonnetModule_pb.SONNETWORDNOIDFIELD.has_default_value = false
SonnetModule_pb.SONNETWORDNOIDFIELD.default_value = 0
SonnetModule_pb.SONNETWORDNOIDFIELD.type = 5
SonnetModule_pb.SONNETWORDNOIDFIELD.cpp_type = 1
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.name = "status"
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.full_name = ".SonnetWordNO.status"
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.number = 2
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.index = 1
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.label = 1
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.has_default_value = false
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.default_value = 0
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.type = 5
SonnetModule_pb.SONNETWORDNOSTATUSFIELD.cpp_type = 1
SonnetModule_pb.SONNETWORDNO_MSG.name = "SonnetWordNO"
SonnetModule_pb.SONNETWORDNO_MSG.full_name = ".SonnetWordNO"
SonnetModule_pb.SONNETWORDNO_MSG.nested_types = {}
SonnetModule_pb.SONNETWORDNO_MSG.enum_types = {}
SonnetModule_pb.SONNETWORDNO_MSG.fields = {
	SonnetModule_pb.SONNETWORDNOIDFIELD,
	SonnetModule_pb.SONNETWORDNOSTATUSFIELD
}
SonnetModule_pb.SONNETWORDNO_MSG.is_extendable = false
SonnetModule_pb.SONNETWORDNO_MSG.extensions = {}
SonnetModule_pb.SonnetConsumeWordReply = protobuf.Message(SonnetModule_pb.SONNETCONSUMEWORDREPLY_MSG)
SonnetModule_pb.SonnetConsumeWordRequest = protobuf.Message(SonnetModule_pb.SONNETCONSUMEWORDREQUEST_MSG)
SonnetModule_pb.SonnetGetInfoReply = protobuf.Message(SonnetModule_pb.SONNETGETINFOREPLY_MSG)
SonnetModule_pb.SonnetGetInfoRequest = protobuf.Message(SonnetModule_pb.SONNETGETINFOREQUEST_MSG)
SonnetModule_pb.SonnetNO = protobuf.Message(SonnetModule_pb.SONNETNO_MSG)
SonnetModule_pb.SonnetUseWordReply = protobuf.Message(SonnetModule_pb.SONNETUSEWORDREPLY_MSG)
SonnetModule_pb.SonnetUseWordRequest = protobuf.Message(SonnetModule_pb.SONNETUSEWORDREQUEST_MSG)
SonnetModule_pb.SonnetWordNO = protobuf.Message(SonnetModule_pb.SONNETWORDNO_MSG)
SonnetModule_pb.SonnetWordPush = protobuf.Message(SonnetModule_pb.SONNETWORDPUSH_MSG)

return SonnetModule_pb

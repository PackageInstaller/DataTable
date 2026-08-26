-- chunkname: @modules/proto/InvestigateModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.InvestigateModule_pb", package.seeall)

local InvestigateModule_pb = {}

InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG = protobuf.Descriptor()
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.INTELBOX_MSG = protobuf.Descriptor()
InvestigateModule_pb.INTELBOXIDFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.INTELBOXCLUEIDSFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.INVESTIGATEINFO_MSG = protobuf.Descriptor()
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG = protobuf.Descriptor()
InvestigateModule_pb.PUTCLUEREQUEST_MSG = protobuf.Descriptor()
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.PUTCLUEREPLY_MSG = protobuf.Descriptor()
InvestigateModule_pb.PUTCLUEREPLYIDFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG = protobuf.Descriptor()
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD = protobuf.FieldDescriptor()
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.name = "info"
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.full_name = ".InvestigateInfoPush.info"
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.number = 1
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.index = 0
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.label = 1
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.has_default_value = false
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.default_value = nil
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.message_type = InvestigateModule_pb.INVESTIGATEINFO_MSG
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.type = 11
InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD.cpp_type = 10
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.name = "InvestigateInfoPush"
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.full_name = ".InvestigateInfoPush"
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.nested_types = {}
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.enum_types = {}
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.fields = {
	InvestigateModule_pb.INVESTIGATEINFOPUSHINFOFIELD
}
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.is_extendable = false
InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG.extensions = {}
InvestigateModule_pb.INTELBOXIDFIELD.name = "id"
InvestigateModule_pb.INTELBOXIDFIELD.full_name = ".IntelBox.id"
InvestigateModule_pb.INTELBOXIDFIELD.number = 1
InvestigateModule_pb.INTELBOXIDFIELD.index = 0
InvestigateModule_pb.INTELBOXIDFIELD.label = 1
InvestigateModule_pb.INTELBOXIDFIELD.has_default_value = false
InvestigateModule_pb.INTELBOXIDFIELD.default_value = 0
InvestigateModule_pb.INTELBOXIDFIELD.type = 5
InvestigateModule_pb.INTELBOXIDFIELD.cpp_type = 1
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.name = "clueIds"
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.full_name = ".IntelBox.clueIds"
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.number = 2
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.index = 1
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.label = 3
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.has_default_value = false
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.default_value = {}
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.type = 5
InvestigateModule_pb.INTELBOXCLUEIDSFIELD.cpp_type = 1
InvestigateModule_pb.INTELBOX_MSG.name = "IntelBox"
InvestigateModule_pb.INTELBOX_MSG.full_name = ".IntelBox"
InvestigateModule_pb.INTELBOX_MSG.nested_types = {}
InvestigateModule_pb.INTELBOX_MSG.enum_types = {}
InvestigateModule_pb.INTELBOX_MSG.fields = {
	InvestigateModule_pb.INTELBOXIDFIELD,
	InvestigateModule_pb.INTELBOXCLUEIDSFIELD
}
InvestigateModule_pb.INTELBOX_MSG.is_extendable = false
InvestigateModule_pb.INTELBOX_MSG.extensions = {}
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.name = "intelBox"
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.full_name = ".InvestigateInfo.intelBox"
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.number = 1
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.index = 0
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.label = 3
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.has_default_value = false
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.default_value = {}
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.message_type = InvestigateModule_pb.INTELBOX_MSG
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.type = 11
InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD.cpp_type = 10
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.name = "clueIds"
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.full_name = ".InvestigateInfo.clueIds"
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.number = 2
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.index = 1
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.label = 3
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.has_default_value = false
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.default_value = {}
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.type = 5
InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD.cpp_type = 1
InvestigateModule_pb.INVESTIGATEINFO_MSG.name = "InvestigateInfo"
InvestigateModule_pb.INVESTIGATEINFO_MSG.full_name = ".InvestigateInfo"
InvestigateModule_pb.INVESTIGATEINFO_MSG.nested_types = {}
InvestigateModule_pb.INVESTIGATEINFO_MSG.enum_types = {}
InvestigateModule_pb.INVESTIGATEINFO_MSG.fields = {
	InvestigateModule_pb.INVESTIGATEINFOINTELBOXFIELD,
	InvestigateModule_pb.INVESTIGATEINFOCLUEIDSFIELD
}
InvestigateModule_pb.INVESTIGATEINFO_MSG.is_extendable = false
InvestigateModule_pb.INVESTIGATEINFO_MSG.extensions = {}
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.name = "GetInvestigateRequest"
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.full_name = ".GetInvestigateRequest"
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.nested_types = {}
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.enum_types = {}
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.fields = {}
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.is_extendable = false
InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG.extensions = {}
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.name = "id"
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.full_name = ".PutClueRequest.id"
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.number = 1
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.index = 0
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.label = 1
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.has_default_value = false
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.default_value = 0
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.type = 5
InvestigateModule_pb.PUTCLUEREQUESTIDFIELD.cpp_type = 1
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.name = "clueId"
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.full_name = ".PutClueRequest.clueId"
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.number = 2
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.index = 1
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.label = 1
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.has_default_value = false
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.default_value = 0
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.type = 5
InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD.cpp_type = 1
InvestigateModule_pb.PUTCLUEREQUEST_MSG.name = "PutClueRequest"
InvestigateModule_pb.PUTCLUEREQUEST_MSG.full_name = ".PutClueRequest"
InvestigateModule_pb.PUTCLUEREQUEST_MSG.nested_types = {}
InvestigateModule_pb.PUTCLUEREQUEST_MSG.enum_types = {}
InvestigateModule_pb.PUTCLUEREQUEST_MSG.fields = {
	InvestigateModule_pb.PUTCLUEREQUESTIDFIELD,
	InvestigateModule_pb.PUTCLUEREQUESTCLUEIDFIELD
}
InvestigateModule_pb.PUTCLUEREQUEST_MSG.is_extendable = false
InvestigateModule_pb.PUTCLUEREQUEST_MSG.extensions = {}
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.name = "id"
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.full_name = ".PutClueReply.id"
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.number = 1
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.index = 0
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.label = 1
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.has_default_value = false
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.default_value = 0
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.type = 5
InvestigateModule_pb.PUTCLUEREPLYIDFIELD.cpp_type = 1
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.name = "clueId"
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.full_name = ".PutClueReply.clueId"
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.number = 2
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.index = 1
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.label = 1
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.has_default_value = false
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.default_value = 0
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.type = 5
InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD.cpp_type = 1
InvestigateModule_pb.PUTCLUEREPLY_MSG.name = "PutClueReply"
InvestigateModule_pb.PUTCLUEREPLY_MSG.full_name = ".PutClueReply"
InvestigateModule_pb.PUTCLUEREPLY_MSG.nested_types = {}
InvestigateModule_pb.PUTCLUEREPLY_MSG.enum_types = {}
InvestigateModule_pb.PUTCLUEREPLY_MSG.fields = {
	InvestigateModule_pb.PUTCLUEREPLYIDFIELD,
	InvestigateModule_pb.PUTCLUEREPLYCLUEIDFIELD
}
InvestigateModule_pb.PUTCLUEREPLY_MSG.is_extendable = false
InvestigateModule_pb.PUTCLUEREPLY_MSG.extensions = {}
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.name = "info"
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.full_name = ".GetInvestigateReply.info"
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.number = 1
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.index = 0
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.label = 1
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.has_default_value = false
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.default_value = nil
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.message_type = InvestigateModule_pb.INVESTIGATEINFO_MSG
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.type = 11
InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD.cpp_type = 10
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.name = "GetInvestigateReply"
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.full_name = ".GetInvestigateReply"
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.nested_types = {}
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.enum_types = {}
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.fields = {
	InvestigateModule_pb.GETINVESTIGATEREPLYINFOFIELD
}
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.is_extendable = false
InvestigateModule_pb.GETINVESTIGATEREPLY_MSG.extensions = {}
InvestigateModule_pb.GetInvestigateReply = protobuf.Message(InvestigateModule_pb.GETINVESTIGATEREPLY_MSG)
InvestigateModule_pb.GetInvestigateRequest = protobuf.Message(InvestigateModule_pb.GETINVESTIGATEREQUEST_MSG)
InvestigateModule_pb.IntelBox = protobuf.Message(InvestigateModule_pb.INTELBOX_MSG)
InvestigateModule_pb.InvestigateInfo = protobuf.Message(InvestigateModule_pb.INVESTIGATEINFO_MSG)
InvestigateModule_pb.InvestigateInfoPush = protobuf.Message(InvestigateModule_pb.INVESTIGATEINFOPUSH_MSG)
InvestigateModule_pb.PutClueReply = protobuf.Message(InvestigateModule_pb.PUTCLUEREPLY_MSG)
InvestigateModule_pb.PutClueRequest = protobuf.Message(InvestigateModule_pb.PUTCLUEREQUEST_MSG)

return InvestigateModule_pb

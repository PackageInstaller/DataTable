-- chunkname: @modules/proto/HandbookModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.HandbookModule_pb", package.seeall)

local HandbookModule_pb = {}

HandbookModule_pb.CHATPERELEMENTINFO_MSG = protobuf.Descriptor()
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG = protobuf.Descriptor()
HandbookModule_pb.HANDBOOKREADREQUEST_MSG = protobuf.Descriptor()
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.HANDBOOKREADREPLY_MSG = protobuf.Descriptor()
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.HANDBOOK_MSG = protobuf.Descriptor()
HandbookModule_pb.HANDBOOKTYPEFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.HANDBOOKIDFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.HANDBOOKISREADFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG = protobuf.Descriptor()
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD = protobuf.FieldDescriptor()
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.name = "element"
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.full_name = ".ChatperElementInfo.element"
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.number = 1
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.index = 0
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.label = 1
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.has_default_value = false
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.default_value = 0
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.type = 5
HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD.cpp_type = 1
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.name = "dialogIds"
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.full_name = ".ChatperElementInfo.dialogIds"
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.number = 2
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.index = 1
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.label = 3
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.has_default_value = false
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.default_value = {}
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.type = 5
HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD.cpp_type = 1
HandbookModule_pb.CHATPERELEMENTINFO_MSG.name = "ChatperElementInfo"
HandbookModule_pb.CHATPERELEMENTINFO_MSG.full_name = ".ChatperElementInfo"
HandbookModule_pb.CHATPERELEMENTINFO_MSG.nested_types = {}
HandbookModule_pb.CHATPERELEMENTINFO_MSG.enum_types = {}
HandbookModule_pb.CHATPERELEMENTINFO_MSG.fields = {
	HandbookModule_pb.CHATPERELEMENTINFOELEMENTFIELD,
	HandbookModule_pb.CHATPERELEMENTINFODIALOGIDSFIELD
}
HandbookModule_pb.CHATPERELEMENTINFO_MSG.is_extendable = false
HandbookModule_pb.CHATPERELEMENTINFO_MSG.extensions = {}
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.name = "GetHandbookInfoRequest"
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.full_name = ".GetHandbookInfoRequest"
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.nested_types = {}
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.enum_types = {}
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.fields = {}
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.is_extendable = false
HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG.extensions = {}
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.name = "type"
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.full_name = ".HandbookReadRequest.type"
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.number = 1
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.index = 0
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.label = 1
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.default_value = 0
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.type = 5
HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD.cpp_type = 1
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.name = "id"
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.full_name = ".HandbookReadRequest.id"
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.number = 2
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.index = 1
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.label = 1
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.default_value = 0
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.type = 5
HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD.cpp_type = 1
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.name = "HandbookReadRequest"
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.full_name = ".HandbookReadRequest"
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.nested_types = {}
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.enum_types = {}
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.fields = {
	HandbookModule_pb.HANDBOOKREADREQUESTTYPEFIELD,
	HandbookModule_pb.HANDBOOKREADREQUESTIDFIELD
}
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.is_extendable = false
HandbookModule_pb.HANDBOOKREADREQUEST_MSG.extensions = {}
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.name = "type"
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.full_name = ".HandbookReadReply.type"
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.number = 1
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.index = 0
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.label = 1
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.default_value = 0
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.type = 5
HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD.cpp_type = 1
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.name = "id"
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.full_name = ".HandbookReadReply.id"
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.number = 2
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.index = 1
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.label = 1
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.default_value = 0
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.type = 5
HandbookModule_pb.HANDBOOKREADREPLYIDFIELD.cpp_type = 1
HandbookModule_pb.HANDBOOKREADREPLY_MSG.name = "HandbookReadReply"
HandbookModule_pb.HANDBOOKREADREPLY_MSG.full_name = ".HandbookReadReply"
HandbookModule_pb.HANDBOOKREADREPLY_MSG.nested_types = {}
HandbookModule_pb.HANDBOOKREADREPLY_MSG.enum_types = {}
HandbookModule_pb.HANDBOOKREADREPLY_MSG.fields = {
	HandbookModule_pb.HANDBOOKREADREPLYTYPEFIELD,
	HandbookModule_pb.HANDBOOKREADREPLYIDFIELD
}
HandbookModule_pb.HANDBOOKREADREPLY_MSG.is_extendable = false
HandbookModule_pb.HANDBOOKREADREPLY_MSG.extensions = {}
HandbookModule_pb.HANDBOOKTYPEFIELD.name = "type"
HandbookModule_pb.HANDBOOKTYPEFIELD.full_name = ".Handbook.type"
HandbookModule_pb.HANDBOOKTYPEFIELD.number = 1
HandbookModule_pb.HANDBOOKTYPEFIELD.index = 0
HandbookModule_pb.HANDBOOKTYPEFIELD.label = 1
HandbookModule_pb.HANDBOOKTYPEFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKTYPEFIELD.default_value = 0
HandbookModule_pb.HANDBOOKTYPEFIELD.type = 5
HandbookModule_pb.HANDBOOKTYPEFIELD.cpp_type = 1
HandbookModule_pb.HANDBOOKIDFIELD.name = "id"
HandbookModule_pb.HANDBOOKIDFIELD.full_name = ".Handbook.id"
HandbookModule_pb.HANDBOOKIDFIELD.number = 2
HandbookModule_pb.HANDBOOKIDFIELD.index = 1
HandbookModule_pb.HANDBOOKIDFIELD.label = 1
HandbookModule_pb.HANDBOOKIDFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKIDFIELD.default_value = 0
HandbookModule_pb.HANDBOOKIDFIELD.type = 5
HandbookModule_pb.HANDBOOKIDFIELD.cpp_type = 1
HandbookModule_pb.HANDBOOKISREADFIELD.name = "isRead"
HandbookModule_pb.HANDBOOKISREADFIELD.full_name = ".Handbook.isRead"
HandbookModule_pb.HANDBOOKISREADFIELD.number = 3
HandbookModule_pb.HANDBOOKISREADFIELD.index = 2
HandbookModule_pb.HANDBOOKISREADFIELD.label = 1
HandbookModule_pb.HANDBOOKISREADFIELD.has_default_value = false
HandbookModule_pb.HANDBOOKISREADFIELD.default_value = false
HandbookModule_pb.HANDBOOKISREADFIELD.type = 8
HandbookModule_pb.HANDBOOKISREADFIELD.cpp_type = 7
HandbookModule_pb.HANDBOOK_MSG.name = "Handbook"
HandbookModule_pb.HANDBOOK_MSG.full_name = ".Handbook"
HandbookModule_pb.HANDBOOK_MSG.nested_types = {}
HandbookModule_pb.HANDBOOK_MSG.enum_types = {}
HandbookModule_pb.HANDBOOK_MSG.fields = {
	HandbookModule_pb.HANDBOOKTYPEFIELD,
	HandbookModule_pb.HANDBOOKIDFIELD,
	HandbookModule_pb.HANDBOOKISREADFIELD
}
HandbookModule_pb.HANDBOOK_MSG.is_extendable = false
HandbookModule_pb.HANDBOOK_MSG.extensions = {}
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.name = "infos"
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.full_name = ".GetHandbookInfoReply.infos"
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.number = 1
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.index = 0
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.label = 3
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.has_default_value = false
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.default_value = {}
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.message_type = HandbookModule_pb.HANDBOOK_MSG
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.type = 11
HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD.cpp_type = 10
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.name = "elementInfo"
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.full_name = ".GetHandbookInfoReply.elementInfo"
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.number = 2
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.index = 1
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.label = 3
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.has_default_value = false
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.default_value = {}
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.message_type = HandbookModule_pb.CHATPERELEMENTINFO_MSG
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.type = 11
HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD.cpp_type = 10
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.name = "GetHandbookInfoReply"
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.full_name = ".GetHandbookInfoReply"
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.nested_types = {}
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.enum_types = {}
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.fields = {
	HandbookModule_pb.GETHANDBOOKINFOREPLYINFOSFIELD,
	HandbookModule_pb.GETHANDBOOKINFOREPLYELEMENTINFOFIELD
}
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.is_extendable = false
HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG.extensions = {}
HandbookModule_pb.ChatperElementInfo = protobuf.Message(HandbookModule_pb.CHATPERELEMENTINFO_MSG)
HandbookModule_pb.GetHandbookInfoReply = protobuf.Message(HandbookModule_pb.GETHANDBOOKINFOREPLY_MSG)
HandbookModule_pb.GetHandbookInfoRequest = protobuf.Message(HandbookModule_pb.GETHANDBOOKINFOREQUEST_MSG)
HandbookModule_pb.Handbook = protobuf.Message(HandbookModule_pb.HANDBOOK_MSG)
HandbookModule_pb.HandbookReadReply = protobuf.Message(HandbookModule_pb.HANDBOOKREADREPLY_MSG)
HandbookModule_pb.HandbookReadRequest = protobuf.Message(HandbookModule_pb.HANDBOOKREADREQUEST_MSG)

return HandbookModule_pb

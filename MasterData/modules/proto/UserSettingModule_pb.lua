-- chunkname: @modules/proto/UserSettingModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.UserSettingModule_pb", package.seeall)

local UserSettingModule_pb = {}

UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG = protobuf.Descriptor()
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG = protobuf.Descriptor()
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG = protobuf.Descriptor()
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG = protobuf.Descriptor()
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.SETTINGINFO_MSG = protobuf.Descriptor()
UserSettingModule_pb.SETTINGINFOTYPEFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.SETTINGINFOPARAMFIELD = protobuf.FieldDescriptor()
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.name = "GetSettingInfosRequest"
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.full_name = ".GetSettingInfosRequest"
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.nested_types = {}
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.enum_types = {}
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.fields = {}
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.is_extendable = false
UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG.extensions = {}
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.name = "infos"
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.full_name = ".GetSettingInfosReply.infos"
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.number = 1
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.index = 0
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.label = 3
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.has_default_value = false
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.default_value = {}
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.message_type = UserSettingModule_pb.SETTINGINFO_MSG
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.type = 11
UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD.cpp_type = 10
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.name = "GetSettingInfosReply"
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.full_name = ".GetSettingInfosReply"
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.nested_types = {}
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.enum_types = {}
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.fields = {
	UserSettingModule_pb.GETSETTINGINFOSREPLYINFOSFIELD
}
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.is_extendable = false
UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG.extensions = {}
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.name = "type"
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.full_name = ".UpdateSettingInfoReply.type"
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.number = 1
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.index = 0
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.label = 1
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.has_default_value = false
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.default_value = 0
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.type = 5
UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD.cpp_type = 1
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.name = "param"
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.full_name = ".UpdateSettingInfoReply.param"
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.number = 2
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.index = 1
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.label = 1
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.has_default_value = false
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.default_value = ""
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.type = 9
UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD.cpp_type = 9
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.name = "UpdateSettingInfoReply"
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.full_name = ".UpdateSettingInfoReply"
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.nested_types = {}
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.enum_types = {}
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.fields = {
	UserSettingModule_pb.UPDATESETTINGINFOREPLYTYPEFIELD,
	UserSettingModule_pb.UPDATESETTINGINFOREPLYPARAMFIELD
}
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.is_extendable = false
UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG.extensions = {}
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.name = "type"
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.full_name = ".UpdateSettingInfoRequest.type"
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.number = 1
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.index = 0
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.label = 1
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.has_default_value = false
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.default_value = 0
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.type = 5
UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD.cpp_type = 1
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.name = "param"
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.full_name = ".UpdateSettingInfoRequest.param"
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.number = 2
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.index = 1
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.label = 1
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.has_default_value = false
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.default_value = ""
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.type = 9
UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD.cpp_type = 9
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.name = "UpdateSettingInfoRequest"
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.full_name = ".UpdateSettingInfoRequest"
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.nested_types = {}
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.enum_types = {}
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.fields = {
	UserSettingModule_pb.UPDATESETTINGINFOREQUESTTYPEFIELD,
	UserSettingModule_pb.UPDATESETTINGINFOREQUESTPARAMFIELD
}
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.is_extendable = false
UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG.extensions = {}
UserSettingModule_pb.SETTINGINFOTYPEFIELD.name = "type"
UserSettingModule_pb.SETTINGINFOTYPEFIELD.full_name = ".SettingInfo.type"
UserSettingModule_pb.SETTINGINFOTYPEFIELD.number = 1
UserSettingModule_pb.SETTINGINFOTYPEFIELD.index = 0
UserSettingModule_pb.SETTINGINFOTYPEFIELD.label = 1
UserSettingModule_pb.SETTINGINFOTYPEFIELD.has_default_value = false
UserSettingModule_pb.SETTINGINFOTYPEFIELD.default_value = 0
UserSettingModule_pb.SETTINGINFOTYPEFIELD.type = 5
UserSettingModule_pb.SETTINGINFOTYPEFIELD.cpp_type = 1
UserSettingModule_pb.SETTINGINFOPARAMFIELD.name = "param"
UserSettingModule_pb.SETTINGINFOPARAMFIELD.full_name = ".SettingInfo.param"
UserSettingModule_pb.SETTINGINFOPARAMFIELD.number = 2
UserSettingModule_pb.SETTINGINFOPARAMFIELD.index = 1
UserSettingModule_pb.SETTINGINFOPARAMFIELD.label = 1
UserSettingModule_pb.SETTINGINFOPARAMFIELD.has_default_value = false
UserSettingModule_pb.SETTINGINFOPARAMFIELD.default_value = ""
UserSettingModule_pb.SETTINGINFOPARAMFIELD.type = 9
UserSettingModule_pb.SETTINGINFOPARAMFIELD.cpp_type = 9
UserSettingModule_pb.SETTINGINFO_MSG.name = "SettingInfo"
UserSettingModule_pb.SETTINGINFO_MSG.full_name = ".SettingInfo"
UserSettingModule_pb.SETTINGINFO_MSG.nested_types = {}
UserSettingModule_pb.SETTINGINFO_MSG.enum_types = {}
UserSettingModule_pb.SETTINGINFO_MSG.fields = {
	UserSettingModule_pb.SETTINGINFOTYPEFIELD,
	UserSettingModule_pb.SETTINGINFOPARAMFIELD
}
UserSettingModule_pb.SETTINGINFO_MSG.is_extendable = false
UserSettingModule_pb.SETTINGINFO_MSG.extensions = {}
UserSettingModule_pb.GetSettingInfosReply = protobuf.Message(UserSettingModule_pb.GETSETTINGINFOSREPLY_MSG)
UserSettingModule_pb.GetSettingInfosRequest = protobuf.Message(UserSettingModule_pb.GETSETTINGINFOSREQUEST_MSG)
UserSettingModule_pb.SettingInfo = protobuf.Message(UserSettingModule_pb.SETTINGINFO_MSG)
UserSettingModule_pb.UpdateSettingInfoReply = protobuf.Message(UserSettingModule_pb.UPDATESETTINGINFOREPLY_MSG)
UserSettingModule_pb.UpdateSettingInfoRequest = protobuf.Message(UserSettingModule_pb.UPDATESETTINGINFOREQUEST_MSG)

return UserSettingModule_pb

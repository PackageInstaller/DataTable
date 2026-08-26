-- chunkname: @modules/proto/BgmModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.BgmModule_pb", package.seeall)

local BgmModule_pb = {}

BgmModule_pb.SETFAVORITEBGMREQUEST_MSG = protobuf.Descriptor()
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD = protobuf.FieldDescriptor()
BgmModule_pb.BGMINFO_MSG = protobuf.Descriptor()
BgmModule_pb.BGMINFOBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD = protobuf.FieldDescriptor()
BgmModule_pb.BGMINFOFAVORITEFIELD = protobuf.FieldDescriptor()
BgmModule_pb.BGMINFOISREADFIELD = protobuf.FieldDescriptor()
BgmModule_pb.GETBGMINFOREPLY_MSG = protobuf.Descriptor()
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD = protobuf.FieldDescriptor()
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.SETFAVORITEBGMREPLY_MSG = protobuf.Descriptor()
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD = protobuf.FieldDescriptor()
BgmModule_pb.UPDATEBGMPUSH_MSG = protobuf.Descriptor()
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD = protobuf.FieldDescriptor()
BgmModule_pb.READBGMREPLY_MSG = protobuf.Descriptor()
BgmModule_pb.READBGMREPLYBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.READBGMREQUEST_MSG = protobuf.Descriptor()
BgmModule_pb.READBGMREQUESTBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.GETBGMINFOREQUEST_MSG = protobuf.Descriptor()
BgmModule_pb.SETUSEBGMREQUEST_MSG = protobuf.Descriptor()
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.SETUSEBGMREPLY_MSG = protobuf.Descriptor()
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD = protobuf.FieldDescriptor()
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.name = "bgmId"
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.full_name = ".SetFavoriteBgmRequest.bgmId"
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.number = 1
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.index = 0
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.label = 1
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.has_default_value = false
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.default_value = 0
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.type = 5
BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD.cpp_type = 1
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.name = "favorite"
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.full_name = ".SetFavoriteBgmRequest.favorite"
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.number = 2
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.index = 1
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.label = 1
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.has_default_value = false
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.default_value = false
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.type = 8
BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD.cpp_type = 7
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.name = "SetFavoriteBgmRequest"
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.full_name = ".SetFavoriteBgmRequest"
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.nested_types = {}
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.enum_types = {}
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.fields = {
	BgmModule_pb.SETFAVORITEBGMREQUESTBGMIDFIELD,
	BgmModule_pb.SETFAVORITEBGMREQUESTFAVORITEFIELD
}
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.is_extendable = false
BgmModule_pb.SETFAVORITEBGMREQUEST_MSG.extensions = {}
BgmModule_pb.BGMINFOBGMIDFIELD.name = "bgmId"
BgmModule_pb.BGMINFOBGMIDFIELD.full_name = ".BgmInfo.bgmId"
BgmModule_pb.BGMINFOBGMIDFIELD.number = 1
BgmModule_pb.BGMINFOBGMIDFIELD.index = 0
BgmModule_pb.BGMINFOBGMIDFIELD.label = 1
BgmModule_pb.BGMINFOBGMIDFIELD.has_default_value = false
BgmModule_pb.BGMINFOBGMIDFIELD.default_value = 0
BgmModule_pb.BGMINFOBGMIDFIELD.type = 5
BgmModule_pb.BGMINFOBGMIDFIELD.cpp_type = 1
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.name = "unlockTime"
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.full_name = ".BgmInfo.unlockTime"
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.number = 2
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.index = 1
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.label = 1
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.has_default_value = false
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.default_value = 0
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.type = 5
BgmModule_pb.BGMINFOUNLOCKTIMEFIELD.cpp_type = 1
BgmModule_pb.BGMINFOFAVORITEFIELD.name = "favorite"
BgmModule_pb.BGMINFOFAVORITEFIELD.full_name = ".BgmInfo.favorite"
BgmModule_pb.BGMINFOFAVORITEFIELD.number = 3
BgmModule_pb.BGMINFOFAVORITEFIELD.index = 2
BgmModule_pb.BGMINFOFAVORITEFIELD.label = 1
BgmModule_pb.BGMINFOFAVORITEFIELD.has_default_value = false
BgmModule_pb.BGMINFOFAVORITEFIELD.default_value = false
BgmModule_pb.BGMINFOFAVORITEFIELD.type = 8
BgmModule_pb.BGMINFOFAVORITEFIELD.cpp_type = 7
BgmModule_pb.BGMINFOISREADFIELD.name = "isRead"
BgmModule_pb.BGMINFOISREADFIELD.full_name = ".BgmInfo.isRead"
BgmModule_pb.BGMINFOISREADFIELD.number = 4
BgmModule_pb.BGMINFOISREADFIELD.index = 3
BgmModule_pb.BGMINFOISREADFIELD.label = 1
BgmModule_pb.BGMINFOISREADFIELD.has_default_value = false
BgmModule_pb.BGMINFOISREADFIELD.default_value = false
BgmModule_pb.BGMINFOISREADFIELD.type = 8
BgmModule_pb.BGMINFOISREADFIELD.cpp_type = 7
BgmModule_pb.BGMINFO_MSG.name = "BgmInfo"
BgmModule_pb.BGMINFO_MSG.full_name = ".BgmInfo"
BgmModule_pb.BGMINFO_MSG.nested_types = {}
BgmModule_pb.BGMINFO_MSG.enum_types = {}
BgmModule_pb.BGMINFO_MSG.fields = {
	BgmModule_pb.BGMINFOBGMIDFIELD,
	BgmModule_pb.BGMINFOUNLOCKTIMEFIELD,
	BgmModule_pb.BGMINFOFAVORITEFIELD,
	BgmModule_pb.BGMINFOISREADFIELD
}
BgmModule_pb.BGMINFO_MSG.is_extendable = false
BgmModule_pb.BGMINFO_MSG.extensions = {}
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.name = "bgmInfos"
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.full_name = ".GetBgmInfoReply.bgmInfos"
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.number = 1
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.index = 0
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.label = 3
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.has_default_value = false
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.default_value = {}
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.message_type = BgmModule_pb.BGMINFO_MSG
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.type = 11
BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD.cpp_type = 10
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.name = "useBgmId"
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.full_name = ".GetBgmInfoReply.useBgmId"
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.number = 2
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.index = 1
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.label = 1
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.has_default_value = false
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.default_value = 0
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.type = 5
BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD.cpp_type = 1
BgmModule_pb.GETBGMINFOREPLY_MSG.name = "GetBgmInfoReply"
BgmModule_pb.GETBGMINFOREPLY_MSG.full_name = ".GetBgmInfoReply"
BgmModule_pb.GETBGMINFOREPLY_MSG.nested_types = {}
BgmModule_pb.GETBGMINFOREPLY_MSG.enum_types = {}
BgmModule_pb.GETBGMINFOREPLY_MSG.fields = {
	BgmModule_pb.GETBGMINFOREPLYBGMINFOSFIELD,
	BgmModule_pb.GETBGMINFOREPLYUSEBGMIDFIELD
}
BgmModule_pb.GETBGMINFOREPLY_MSG.is_extendable = false
BgmModule_pb.GETBGMINFOREPLY_MSG.extensions = {}
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.name = "bgmId"
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.full_name = ".SetFavoriteBgmReply.bgmId"
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.number = 1
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.index = 0
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.label = 1
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.has_default_value = false
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.default_value = 0
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.type = 5
BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD.cpp_type = 1
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.name = "favorite"
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.full_name = ".SetFavoriteBgmReply.favorite"
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.number = 2
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.index = 1
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.label = 1
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.has_default_value = false
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.default_value = false
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.type = 8
BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD.cpp_type = 7
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.name = "SetFavoriteBgmReply"
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.full_name = ".SetFavoriteBgmReply"
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.nested_types = {}
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.enum_types = {}
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.fields = {
	BgmModule_pb.SETFAVORITEBGMREPLYBGMIDFIELD,
	BgmModule_pb.SETFAVORITEBGMREPLYFAVORITEFIELD
}
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.is_extendable = false
BgmModule_pb.SETFAVORITEBGMREPLY_MSG.extensions = {}
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.name = "bgmInfos"
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.full_name = ".UpdateBgmPush.bgmInfos"
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.number = 1
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.index = 0
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.label = 3
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.has_default_value = false
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.default_value = {}
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.message_type = BgmModule_pb.BGMINFO_MSG
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.type = 11
BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD.cpp_type = 10
BgmModule_pb.UPDATEBGMPUSH_MSG.name = "UpdateBgmPush"
BgmModule_pb.UPDATEBGMPUSH_MSG.full_name = ".UpdateBgmPush"
BgmModule_pb.UPDATEBGMPUSH_MSG.nested_types = {}
BgmModule_pb.UPDATEBGMPUSH_MSG.enum_types = {}
BgmModule_pb.UPDATEBGMPUSH_MSG.fields = {
	BgmModule_pb.UPDATEBGMPUSHBGMINFOSFIELD
}
BgmModule_pb.UPDATEBGMPUSH_MSG.is_extendable = false
BgmModule_pb.UPDATEBGMPUSH_MSG.extensions = {}
BgmModule_pb.READBGMREPLYBGMIDFIELD.name = "bgmId"
BgmModule_pb.READBGMREPLYBGMIDFIELD.full_name = ".ReadBgmReply.bgmId"
BgmModule_pb.READBGMREPLYBGMIDFIELD.number = 1
BgmModule_pb.READBGMREPLYBGMIDFIELD.index = 0
BgmModule_pb.READBGMREPLYBGMIDFIELD.label = 1
BgmModule_pb.READBGMREPLYBGMIDFIELD.has_default_value = false
BgmModule_pb.READBGMREPLYBGMIDFIELD.default_value = 0
BgmModule_pb.READBGMREPLYBGMIDFIELD.type = 5
BgmModule_pb.READBGMREPLYBGMIDFIELD.cpp_type = 1
BgmModule_pb.READBGMREPLY_MSG.name = "ReadBgmReply"
BgmModule_pb.READBGMREPLY_MSG.full_name = ".ReadBgmReply"
BgmModule_pb.READBGMREPLY_MSG.nested_types = {}
BgmModule_pb.READBGMREPLY_MSG.enum_types = {}
BgmModule_pb.READBGMREPLY_MSG.fields = {
	BgmModule_pb.READBGMREPLYBGMIDFIELD
}
BgmModule_pb.READBGMREPLY_MSG.is_extendable = false
BgmModule_pb.READBGMREPLY_MSG.extensions = {}
BgmModule_pb.READBGMREQUESTBGMIDFIELD.name = "bgmId"
BgmModule_pb.READBGMREQUESTBGMIDFIELD.full_name = ".ReadBgmRequest.bgmId"
BgmModule_pb.READBGMREQUESTBGMIDFIELD.number = 1
BgmModule_pb.READBGMREQUESTBGMIDFIELD.index = 0
BgmModule_pb.READBGMREQUESTBGMIDFIELD.label = 1
BgmModule_pb.READBGMREQUESTBGMIDFIELD.has_default_value = false
BgmModule_pb.READBGMREQUESTBGMIDFIELD.default_value = 0
BgmModule_pb.READBGMREQUESTBGMIDFIELD.type = 5
BgmModule_pb.READBGMREQUESTBGMIDFIELD.cpp_type = 1
BgmModule_pb.READBGMREQUEST_MSG.name = "ReadBgmRequest"
BgmModule_pb.READBGMREQUEST_MSG.full_name = ".ReadBgmRequest"
BgmModule_pb.READBGMREQUEST_MSG.nested_types = {}
BgmModule_pb.READBGMREQUEST_MSG.enum_types = {}
BgmModule_pb.READBGMREQUEST_MSG.fields = {
	BgmModule_pb.READBGMREQUESTBGMIDFIELD
}
BgmModule_pb.READBGMREQUEST_MSG.is_extendable = false
BgmModule_pb.READBGMREQUEST_MSG.extensions = {}
BgmModule_pb.GETBGMINFOREQUEST_MSG.name = "GetBgmInfoRequest"
BgmModule_pb.GETBGMINFOREQUEST_MSG.full_name = ".GetBgmInfoRequest"
BgmModule_pb.GETBGMINFOREQUEST_MSG.nested_types = {}
BgmModule_pb.GETBGMINFOREQUEST_MSG.enum_types = {}
BgmModule_pb.GETBGMINFOREQUEST_MSG.fields = {}
BgmModule_pb.GETBGMINFOREQUEST_MSG.is_extendable = false
BgmModule_pb.GETBGMINFOREQUEST_MSG.extensions = {}
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.name = "bgmId"
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.full_name = ".SetUseBgmRequest.bgmId"
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.number = 1
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.index = 0
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.label = 1
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.has_default_value = false
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.default_value = 0
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.type = 5
BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD.cpp_type = 1
BgmModule_pb.SETUSEBGMREQUEST_MSG.name = "SetUseBgmRequest"
BgmModule_pb.SETUSEBGMREQUEST_MSG.full_name = ".SetUseBgmRequest"
BgmModule_pb.SETUSEBGMREQUEST_MSG.nested_types = {}
BgmModule_pb.SETUSEBGMREQUEST_MSG.enum_types = {}
BgmModule_pb.SETUSEBGMREQUEST_MSG.fields = {
	BgmModule_pb.SETUSEBGMREQUESTBGMIDFIELD
}
BgmModule_pb.SETUSEBGMREQUEST_MSG.is_extendable = false
BgmModule_pb.SETUSEBGMREQUEST_MSG.extensions = {}
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.name = "bgmId"
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.full_name = ".SetUseBgmReply.bgmId"
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.number = 1
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.index = 0
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.label = 1
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.has_default_value = false
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.default_value = 0
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.type = 5
BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD.cpp_type = 1
BgmModule_pb.SETUSEBGMREPLY_MSG.name = "SetUseBgmReply"
BgmModule_pb.SETUSEBGMREPLY_MSG.full_name = ".SetUseBgmReply"
BgmModule_pb.SETUSEBGMREPLY_MSG.nested_types = {}
BgmModule_pb.SETUSEBGMREPLY_MSG.enum_types = {}
BgmModule_pb.SETUSEBGMREPLY_MSG.fields = {
	BgmModule_pb.SETUSEBGMREPLYBGMIDFIELD
}
BgmModule_pb.SETUSEBGMREPLY_MSG.is_extendable = false
BgmModule_pb.SETUSEBGMREPLY_MSG.extensions = {}
BgmModule_pb.BgmInfo = protobuf.Message(BgmModule_pb.BGMINFO_MSG)
BgmModule_pb.GetBgmInfoReply = protobuf.Message(BgmModule_pb.GETBGMINFOREPLY_MSG)
BgmModule_pb.GetBgmInfoRequest = protobuf.Message(BgmModule_pb.GETBGMINFOREQUEST_MSG)
BgmModule_pb.ReadBgmReply = protobuf.Message(BgmModule_pb.READBGMREPLY_MSG)
BgmModule_pb.ReadBgmRequest = protobuf.Message(BgmModule_pb.READBGMREQUEST_MSG)
BgmModule_pb.SetFavoriteBgmReply = protobuf.Message(BgmModule_pb.SETFAVORITEBGMREPLY_MSG)
BgmModule_pb.SetFavoriteBgmRequest = protobuf.Message(BgmModule_pb.SETFAVORITEBGMREQUEST_MSG)
BgmModule_pb.SetUseBgmReply = protobuf.Message(BgmModule_pb.SETUSEBGMREPLY_MSG)
BgmModule_pb.SetUseBgmRequest = protobuf.Message(BgmModule_pb.SETUSEBGMREQUEST_MSG)
BgmModule_pb.UpdateBgmPush = protobuf.Message(BgmModule_pb.UPDATEBGMPUSH_MSG)

return BgmModule_pb

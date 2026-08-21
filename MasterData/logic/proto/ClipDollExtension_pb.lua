-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/ClipDollExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.ClipDollExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.GetClipDollInfoRequest = protobuf.Descriptor()
field_descriptors.GetClipDollInfoRequest_aConfigId = protobuf.FieldDescriptor()
type_descriptors.RedeemPrizeRequest = protobuf.Descriptor()
field_descriptors.RedeemPrizeRequest_aConfigId = protobuf.FieldDescriptor()
field_descriptors.RedeemPrizeRequest_id = protobuf.FieldDescriptor()
type_descriptors.DollNO = protobuf.Descriptor()
field_descriptors.DollNO_id = protobuf.FieldDescriptor()
field_descriptors.DollNO_count = protobuf.FieldDescriptor()
type_descriptors.ClipDollRequest = protobuf.Descriptor()
field_descriptors.ClipDollRequest_aConfigId = protobuf.FieldDescriptor()
field_descriptors.ClipDollRequest_doll = protobuf.FieldDescriptor()
type_descriptors.ClipDollReply = protobuf.Descriptor()
field_descriptors.ClipDollReply_aConfigId = protobuf.FieldDescriptor()
field_descriptors.ClipDollReply_doll = protobuf.FieldDescriptor()
type_descriptors.RedeemPrizeReply = protobuf.Descriptor()
field_descriptors.RedeemPrizeReply_aConfigId = protobuf.FieldDescriptor()
field_descriptors.RedeemPrizeReply_redeemPrize = protobuf.FieldDescriptor()
type_descriptors.DollsChangePush = protobuf.Descriptor()
field_descriptors.DollsChangePush_aConfigId = protobuf.FieldDescriptor()
type_descriptors.RedeemPrizeNO = protobuf.Descriptor()
field_descriptors.RedeemPrizeNO_id = protobuf.FieldDescriptor()
field_descriptors.RedeemPrizeNO_count = protobuf.FieldDescriptor()
type_descriptors.GetClipDollInfoReply = protobuf.Descriptor()
field_descriptors.GetClipDollInfoReply_aConfigId = protobuf.FieldDescriptor()
field_descriptors.GetClipDollInfoReply_dolls = protobuf.FieldDescriptor()
field_descriptors.GetClipDollInfoReply_redeemPrize = protobuf.FieldDescriptor()
field_descriptors.GetClipDollInfoRequest_aConfigId.name = "aConfigId"
field_descriptors.GetClipDollInfoRequest_aConfigId.full_name = ".GetClipDollInfoRequest.aConfigId"
field_descriptors.GetClipDollInfoRequest_aConfigId.number = 1
field_descriptors.GetClipDollInfoRequest_aConfigId.index = 0
field_descriptors.GetClipDollInfoRequest_aConfigId.label = 2
field_descriptors.GetClipDollInfoRequest_aConfigId.has_default_value = false
field_descriptors.GetClipDollInfoRequest_aConfigId.default_value = 0
field_descriptors.GetClipDollInfoRequest_aConfigId.type = 5
field_descriptors.GetClipDollInfoRequest_aConfigId.cpp_type = 1
type_descriptors.GetClipDollInfoRequest.name = "GetClipDollInfoRequest"
type_descriptors.GetClipDollInfoRequest.full_name = ".GetClipDollInfoRequest"
type_descriptors.GetClipDollInfoRequest.nested_types = {}
type_descriptors.GetClipDollInfoRequest.enum_types = {}
type_descriptors.GetClipDollInfoRequest.fields = {
	field_descriptors.GetClipDollInfoRequest_aConfigId
}
type_descriptors.GetClipDollInfoRequest.is_extendable = false
type_descriptors.GetClipDollInfoRequest.extensions = {}
field_descriptors.RedeemPrizeRequest_aConfigId.name = "aConfigId"
field_descriptors.RedeemPrizeRequest_aConfigId.full_name = ".RedeemPrizeRequest.aConfigId"
field_descriptors.RedeemPrizeRequest_aConfigId.number = 1
field_descriptors.RedeemPrizeRequest_aConfigId.index = 0
field_descriptors.RedeemPrizeRequest_aConfigId.label = 2
field_descriptors.RedeemPrizeRequest_aConfigId.has_default_value = false
field_descriptors.RedeemPrizeRequest_aConfigId.default_value = 0
field_descriptors.RedeemPrizeRequest_aConfigId.type = 5
field_descriptors.RedeemPrizeRequest_aConfigId.cpp_type = 1
field_descriptors.RedeemPrizeRequest_id.name = "id"
field_descriptors.RedeemPrizeRequest_id.full_name = ".RedeemPrizeRequest.id"
field_descriptors.RedeemPrizeRequest_id.number = 2
field_descriptors.RedeemPrizeRequest_id.index = 1
field_descriptors.RedeemPrizeRequest_id.label = 2
field_descriptors.RedeemPrizeRequest_id.has_default_value = false
field_descriptors.RedeemPrizeRequest_id.default_value = 0
field_descriptors.RedeemPrizeRequest_id.type = 5
field_descriptors.RedeemPrizeRequest_id.cpp_type = 1
type_descriptors.RedeemPrizeRequest.name = "RedeemPrizeRequest"
type_descriptors.RedeemPrizeRequest.full_name = ".RedeemPrizeRequest"
type_descriptors.RedeemPrizeRequest.nested_types = {}
type_descriptors.RedeemPrizeRequest.enum_types = {}
type_descriptors.RedeemPrizeRequest.fields = {
	field_descriptors.RedeemPrizeRequest_aConfigId,
	field_descriptors.RedeemPrizeRequest_id
}
type_descriptors.RedeemPrizeRequest.is_extendable = false
type_descriptors.RedeemPrizeRequest.extensions = {}
field_descriptors.DollNO_id.name = "id"
field_descriptors.DollNO_id.full_name = ".DollNO.id"
field_descriptors.DollNO_id.number = 1
field_descriptors.DollNO_id.index = 0
field_descriptors.DollNO_id.label = 2
field_descriptors.DollNO_id.has_default_value = false
field_descriptors.DollNO_id.default_value = 0
field_descriptors.DollNO_id.type = 5
field_descriptors.DollNO_id.cpp_type = 1
field_descriptors.DollNO_count.name = "count"
field_descriptors.DollNO_count.full_name = ".DollNO.count"
field_descriptors.DollNO_count.number = 2
field_descriptors.DollNO_count.index = 1
field_descriptors.DollNO_count.label = 2
field_descriptors.DollNO_count.has_default_value = false
field_descriptors.DollNO_count.default_value = 0
field_descriptors.DollNO_count.type = 5
field_descriptors.DollNO_count.cpp_type = 1
type_descriptors.DollNO.name = "DollNO"
type_descriptors.DollNO.full_name = ".DollNO"
type_descriptors.DollNO.nested_types = {}
type_descriptors.DollNO.enum_types = {}
type_descriptors.DollNO.fields = {
	field_descriptors.DollNO_id,
	field_descriptors.DollNO_count
}
type_descriptors.DollNO.is_extendable = false
type_descriptors.DollNO.extensions = {}
field_descriptors.ClipDollRequest_aConfigId.name = "aConfigId"
field_descriptors.ClipDollRequest_aConfigId.full_name = ".ClipDollRequest.aConfigId"
field_descriptors.ClipDollRequest_aConfigId.number = 1
field_descriptors.ClipDollRequest_aConfigId.index = 0
field_descriptors.ClipDollRequest_aConfigId.label = 2
field_descriptors.ClipDollRequest_aConfigId.has_default_value = false
field_descriptors.ClipDollRequest_aConfigId.default_value = 0
field_descriptors.ClipDollRequest_aConfigId.type = 5
field_descriptors.ClipDollRequest_aConfigId.cpp_type = 1
field_descriptors.ClipDollRequest_doll.name = "doll"
field_descriptors.ClipDollRequest_doll.full_name = ".ClipDollRequest.doll"
field_descriptors.ClipDollRequest_doll.number = 2
field_descriptors.ClipDollRequest_doll.index = 1
field_descriptors.ClipDollRequest_doll.label = 2
field_descriptors.ClipDollRequest_doll.has_default_value = false
field_descriptors.ClipDollRequest_doll.default_value = 0
field_descriptors.ClipDollRequest_doll.type = 5
field_descriptors.ClipDollRequest_doll.cpp_type = 1
type_descriptors.ClipDollRequest.name = "ClipDollRequest"
type_descriptors.ClipDollRequest.full_name = ".ClipDollRequest"
type_descriptors.ClipDollRequest.nested_types = {}
type_descriptors.ClipDollRequest.enum_types = {}
type_descriptors.ClipDollRequest.fields = {
	field_descriptors.ClipDollRequest_aConfigId,
	field_descriptors.ClipDollRequest_doll
}
type_descriptors.ClipDollRequest.is_extendable = false
type_descriptors.ClipDollRequest.extensions = {}
field_descriptors.ClipDollReply_aConfigId.name = "aConfigId"
field_descriptors.ClipDollReply_aConfigId.full_name = ".ClipDollReply.aConfigId"
field_descriptors.ClipDollReply_aConfigId.number = 1
field_descriptors.ClipDollReply_aConfigId.index = 0
field_descriptors.ClipDollReply_aConfigId.label = 2
field_descriptors.ClipDollReply_aConfigId.has_default_value = false
field_descriptors.ClipDollReply_aConfigId.default_value = 0
field_descriptors.ClipDollReply_aConfigId.type = 5
field_descriptors.ClipDollReply_aConfigId.cpp_type = 1
field_descriptors.ClipDollReply_doll.name = "doll"
field_descriptors.ClipDollReply_doll.full_name = ".ClipDollReply.doll"
field_descriptors.ClipDollReply_doll.number = 2
field_descriptors.ClipDollReply_doll.index = 1
field_descriptors.ClipDollReply_doll.label = 2
field_descriptors.ClipDollReply_doll.has_default_value = false
field_descriptors.ClipDollReply_doll.default_value = 0
field_descriptors.ClipDollReply_doll.type = 5
field_descriptors.ClipDollReply_doll.cpp_type = 1
type_descriptors.ClipDollReply.name = "ClipDollReply"
type_descriptors.ClipDollReply.full_name = ".ClipDollReply"
type_descriptors.ClipDollReply.nested_types = {}
type_descriptors.ClipDollReply.enum_types = {}
type_descriptors.ClipDollReply.fields = {
	field_descriptors.ClipDollReply_aConfigId,
	field_descriptors.ClipDollReply_doll
}
type_descriptors.ClipDollReply.is_extendable = false
type_descriptors.ClipDollReply.extensions = {}
field_descriptors.RedeemPrizeReply_aConfigId.name = "aConfigId"
field_descriptors.RedeemPrizeReply_aConfigId.full_name = ".RedeemPrizeReply.aConfigId"
field_descriptors.RedeemPrizeReply_aConfigId.number = 1
field_descriptors.RedeemPrizeReply_aConfigId.index = 0
field_descriptors.RedeemPrizeReply_aConfigId.label = 2
field_descriptors.RedeemPrizeReply_aConfigId.has_default_value = false
field_descriptors.RedeemPrizeReply_aConfigId.default_value = 0
field_descriptors.RedeemPrizeReply_aConfigId.type = 5
field_descriptors.RedeemPrizeReply_aConfigId.cpp_type = 1
field_descriptors.RedeemPrizeReply_redeemPrize.name = "redeemPrize"
field_descriptors.RedeemPrizeReply_redeemPrize.full_name = ".RedeemPrizeReply.redeemPrize"
field_descriptors.RedeemPrizeReply_redeemPrize.number = 2
field_descriptors.RedeemPrizeReply_redeemPrize.index = 1
field_descriptors.RedeemPrizeReply_redeemPrize.label = 2
field_descriptors.RedeemPrizeReply_redeemPrize.has_default_value = false
field_descriptors.RedeemPrizeReply_redeemPrize.default_value = nil
field_descriptors.RedeemPrizeReply_redeemPrize.message_type = type_descriptors.RedeemPrizeNO
field_descriptors.RedeemPrizeReply_redeemPrize.type = 11
field_descriptors.RedeemPrizeReply_redeemPrize.cpp_type = 10
type_descriptors.RedeemPrizeReply.name = "RedeemPrizeReply"
type_descriptors.RedeemPrizeReply.full_name = ".RedeemPrizeReply"
type_descriptors.RedeemPrizeReply.nested_types = {}
type_descriptors.RedeemPrizeReply.enum_types = {}
type_descriptors.RedeemPrizeReply.fields = {
	field_descriptors.RedeemPrizeReply_aConfigId,
	field_descriptors.RedeemPrizeReply_redeemPrize
}
type_descriptors.RedeemPrizeReply.is_extendable = false
type_descriptors.RedeemPrizeReply.extensions = {}
field_descriptors.DollsChangePush_aConfigId.name = "aConfigId"
field_descriptors.DollsChangePush_aConfigId.full_name = ".DollsChangePush.aConfigId"
field_descriptors.DollsChangePush_aConfigId.number = 1
field_descriptors.DollsChangePush_aConfigId.index = 0
field_descriptors.DollsChangePush_aConfigId.label = 2
field_descriptors.DollsChangePush_aConfigId.has_default_value = false
field_descriptors.DollsChangePush_aConfigId.default_value = 0
field_descriptors.DollsChangePush_aConfigId.type = 5
field_descriptors.DollsChangePush_aConfigId.cpp_type = 1
type_descriptors.DollsChangePush.name = "DollsChangePush"
type_descriptors.DollsChangePush.full_name = ".DollsChangePush"
type_descriptors.DollsChangePush.nested_types = {}
type_descriptors.DollsChangePush.enum_types = {}
type_descriptors.DollsChangePush.fields = {
	field_descriptors.DollsChangePush_aConfigId
}
type_descriptors.DollsChangePush.is_extendable = false
type_descriptors.DollsChangePush.extensions = {}
field_descriptors.RedeemPrizeNO_id.name = "id"
field_descriptors.RedeemPrizeNO_id.full_name = ".RedeemPrizeNO.id"
field_descriptors.RedeemPrizeNO_id.number = 1
field_descriptors.RedeemPrizeNO_id.index = 0
field_descriptors.RedeemPrizeNO_id.label = 2
field_descriptors.RedeemPrizeNO_id.has_default_value = false
field_descriptors.RedeemPrizeNO_id.default_value = 0
field_descriptors.RedeemPrizeNO_id.type = 5
field_descriptors.RedeemPrizeNO_id.cpp_type = 1
field_descriptors.RedeemPrizeNO_count.name = "count"
field_descriptors.RedeemPrizeNO_count.full_name = ".RedeemPrizeNO.count"
field_descriptors.RedeemPrizeNO_count.number = 2
field_descriptors.RedeemPrizeNO_count.index = 1
field_descriptors.RedeemPrizeNO_count.label = 2
field_descriptors.RedeemPrizeNO_count.has_default_value = false
field_descriptors.RedeemPrizeNO_count.default_value = 0
field_descriptors.RedeemPrizeNO_count.type = 5
field_descriptors.RedeemPrizeNO_count.cpp_type = 1
type_descriptors.RedeemPrizeNO.name = "RedeemPrizeNO"
type_descriptors.RedeemPrizeNO.full_name = ".RedeemPrizeNO"
type_descriptors.RedeemPrizeNO.nested_types = {}
type_descriptors.RedeemPrizeNO.enum_types = {}
type_descriptors.RedeemPrizeNO.fields = {
	field_descriptors.RedeemPrizeNO_id,
	field_descriptors.RedeemPrizeNO_count
}
type_descriptors.RedeemPrizeNO.is_extendable = false
type_descriptors.RedeemPrizeNO.extensions = {}
field_descriptors.GetClipDollInfoReply_aConfigId.name = "aConfigId"
field_descriptors.GetClipDollInfoReply_aConfigId.full_name = ".GetClipDollInfoReply.aConfigId"
field_descriptors.GetClipDollInfoReply_aConfigId.number = 1
field_descriptors.GetClipDollInfoReply_aConfigId.index = 0
field_descriptors.GetClipDollInfoReply_aConfigId.label = 2
field_descriptors.GetClipDollInfoReply_aConfigId.has_default_value = false
field_descriptors.GetClipDollInfoReply_aConfigId.default_value = 0
field_descriptors.GetClipDollInfoReply_aConfigId.type = 5
field_descriptors.GetClipDollInfoReply_aConfigId.cpp_type = 1
field_descriptors.GetClipDollInfoReply_dolls.name = "dolls"
field_descriptors.GetClipDollInfoReply_dolls.full_name = ".GetClipDollInfoReply.dolls"
field_descriptors.GetClipDollInfoReply_dolls.number = 2
field_descriptors.GetClipDollInfoReply_dolls.index = 1
field_descriptors.GetClipDollInfoReply_dolls.label = 3
field_descriptors.GetClipDollInfoReply_dolls.has_default_value = false
field_descriptors.GetClipDollInfoReply_dolls.default_value = {}
field_descriptors.GetClipDollInfoReply_dolls.message_type = type_descriptors.DollNO
field_descriptors.GetClipDollInfoReply_dolls.type = 11
field_descriptors.GetClipDollInfoReply_dolls.cpp_type = 10
field_descriptors.GetClipDollInfoReply_redeemPrize.name = "redeemPrize"
field_descriptors.GetClipDollInfoReply_redeemPrize.full_name = ".GetClipDollInfoReply.redeemPrize"
field_descriptors.GetClipDollInfoReply_redeemPrize.number = 3
field_descriptors.GetClipDollInfoReply_redeemPrize.index = 2
field_descriptors.GetClipDollInfoReply_redeemPrize.label = 3
field_descriptors.GetClipDollInfoReply_redeemPrize.has_default_value = false
field_descriptors.GetClipDollInfoReply_redeemPrize.default_value = {}
field_descriptors.GetClipDollInfoReply_redeemPrize.message_type = type_descriptors.RedeemPrizeNO
field_descriptors.GetClipDollInfoReply_redeemPrize.type = 11
field_descriptors.GetClipDollInfoReply_redeemPrize.cpp_type = 10
type_descriptors.GetClipDollInfoReply.name = "GetClipDollInfoReply"
type_descriptors.GetClipDollInfoReply.full_name = ".GetClipDollInfoReply"
type_descriptors.GetClipDollInfoReply.nested_types = {}
type_descriptors.GetClipDollInfoReply.enum_types = {}
type_descriptors.GetClipDollInfoReply.fields = {
	field_descriptors.GetClipDollInfoReply_aConfigId,
	field_descriptors.GetClipDollInfoReply_dolls,
	field_descriptors.GetClipDollInfoReply_redeemPrize
}
type_descriptors.GetClipDollInfoReply.is_extendable = false
type_descriptors.GetClipDollInfoReply.extensions = {}
ClipDollReply = protobuf.Message(type_descriptors.ClipDollReply)
ClipDollRequest = protobuf.Message(type_descriptors.ClipDollRequest)
DollNO = protobuf.Message(type_descriptors.DollNO)
DollsChangePush = protobuf.Message(type_descriptors.DollsChangePush)
GetClipDollInfoReply = protobuf.Message(type_descriptors.GetClipDollInfoReply)
GetClipDollInfoRequest = protobuf.Message(type_descriptors.GetClipDollInfoRequest)
RedeemPrizeNO = protobuf.Message(type_descriptors.RedeemPrizeNO)
RedeemPrizeReply = protobuf.Message(type_descriptors.RedeemPrizeReply)
RedeemPrizeRequest = protobuf.Message(type_descriptors.RedeemPrizeRequest)

return _G["logic.proto.ClipDollExtension_pb"]

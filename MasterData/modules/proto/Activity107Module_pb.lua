-- chunkname: @modules/proto/Activity107Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity107Module_pb", package.seeall)

local Activity107Module_pb = {}

Activity107Module_pb.GET107GOODSINFOREQUEST_MSG = protobuf.Descriptor()
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.GET107GOODSINFOREPLY_MSG = protobuf.Descriptor()
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.ACT107GOODSINFO_MSG = protobuf.Descriptor()
Activity107Module_pb.ACT107GOODSINFOIDFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.BUY107GOODSREQUEST_MSG = protobuf.Descriptor()
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.BUY107GOODSREPLY_MSG = protobuf.Descriptor()
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD = protobuf.FieldDescriptor()
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.full_name = ".Get107GoodsInfoRequest.activityId"
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.number = 1
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.index = 0
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.label = 1
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.type = 5
Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.name = "Get107GoodsInfoRequest"
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.full_name = ".Get107GoodsInfoRequest"
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.nested_types = {}
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.enum_types = {}
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.fields = {
	Activity107Module_pb.GET107GOODSINFOREQUESTACTIVITYIDFIELD
}
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.is_extendable = false
Activity107Module_pb.GET107GOODSINFOREQUEST_MSG.extensions = {}
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.full_name = ".Get107GoodsInfoReply.activityId"
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.number = 1
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.index = 0
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.label = 1
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.default_value = 0
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.type = 5
Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.name = "goodsInfos"
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.full_name = ".Get107GoodsInfoReply.goodsInfos"
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.number = 2
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.index = 1
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.label = 3
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.has_default_value = false
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.default_value = {}
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.message_type = Activity107Module_pb.ACT107GOODSINFO_MSG
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.type = 11
Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD.cpp_type = 10
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.name = "Get107GoodsInfoReply"
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.full_name = ".Get107GoodsInfoReply"
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.nested_types = {}
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.enum_types = {}
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.fields = {
	Activity107Module_pb.GET107GOODSINFOREPLYACTIVITYIDFIELD,
	Activity107Module_pb.GET107GOODSINFOREPLYGOODSINFOSFIELD
}
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.is_extendable = false
Activity107Module_pb.GET107GOODSINFOREPLY_MSG.extensions = {}
Activity107Module_pb.ACT107GOODSINFOIDFIELD.name = "id"
Activity107Module_pb.ACT107GOODSINFOIDFIELD.full_name = ".Act107GoodsInfo.id"
Activity107Module_pb.ACT107GOODSINFOIDFIELD.number = 1
Activity107Module_pb.ACT107GOODSINFOIDFIELD.index = 0
Activity107Module_pb.ACT107GOODSINFOIDFIELD.label = 1
Activity107Module_pb.ACT107GOODSINFOIDFIELD.has_default_value = false
Activity107Module_pb.ACT107GOODSINFOIDFIELD.default_value = 0
Activity107Module_pb.ACT107GOODSINFOIDFIELD.type = 5
Activity107Module_pb.ACT107GOODSINFOIDFIELD.cpp_type = 1
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.name = "buyCount"
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.full_name = ".Act107GoodsInfo.buyCount"
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.number = 2
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.index = 1
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.label = 1
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.has_default_value = false
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.default_value = 0
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.type = 5
Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD.cpp_type = 1
Activity107Module_pb.ACT107GOODSINFO_MSG.name = "Act107GoodsInfo"
Activity107Module_pb.ACT107GOODSINFO_MSG.full_name = ".Act107GoodsInfo"
Activity107Module_pb.ACT107GOODSINFO_MSG.nested_types = {}
Activity107Module_pb.ACT107GOODSINFO_MSG.enum_types = {}
Activity107Module_pb.ACT107GOODSINFO_MSG.fields = {
	Activity107Module_pb.ACT107GOODSINFOIDFIELD,
	Activity107Module_pb.ACT107GOODSINFOBUYCOUNTFIELD
}
Activity107Module_pb.ACT107GOODSINFO_MSG.is_extendable = false
Activity107Module_pb.ACT107GOODSINFO_MSG.extensions = {}
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.full_name = ".Buy107GoodsRequest.activityId"
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.number = 1
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.index = 0
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.label = 1
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.default_value = 0
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.type = 5
Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.name = "id"
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.full_name = ".Buy107GoodsRequest.id"
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.number = 2
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.index = 1
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.label = 1
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.has_default_value = false
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.default_value = 0
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.type = 5
Activity107Module_pb.BUY107GOODSREQUESTIDFIELD.cpp_type = 1
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.name = "num"
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.full_name = ".Buy107GoodsRequest.num"
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.number = 3
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.index = 2
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.label = 1
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.has_default_value = false
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.default_value = 0
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.type = 5
Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD.cpp_type = 1
Activity107Module_pb.BUY107GOODSREQUEST_MSG.name = "Buy107GoodsRequest"
Activity107Module_pb.BUY107GOODSREQUEST_MSG.full_name = ".Buy107GoodsRequest"
Activity107Module_pb.BUY107GOODSREQUEST_MSG.nested_types = {}
Activity107Module_pb.BUY107GOODSREQUEST_MSG.enum_types = {}
Activity107Module_pb.BUY107GOODSREQUEST_MSG.fields = {
	Activity107Module_pb.BUY107GOODSREQUESTACTIVITYIDFIELD,
	Activity107Module_pb.BUY107GOODSREQUESTIDFIELD,
	Activity107Module_pb.BUY107GOODSREQUESTNUMFIELD
}
Activity107Module_pb.BUY107GOODSREQUEST_MSG.is_extendable = false
Activity107Module_pb.BUY107GOODSREQUEST_MSG.extensions = {}
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.name = "activityId"
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.full_name = ".Buy107GoodsReply.activityId"
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.number = 1
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.index = 0
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.label = 1
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.has_default_value = false
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.default_value = 0
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.type = 5
Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.name = "goodsInfo"
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.full_name = ".Buy107GoodsReply.goodsInfo"
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.number = 2
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.index = 1
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.label = 1
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.has_default_value = false
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.default_value = nil
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.message_type = Activity107Module_pb.ACT107GOODSINFO_MSG
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.type = 11
Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD.cpp_type = 10
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.name = "num"
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.full_name = ".Buy107GoodsReply.num"
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.number = 3
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.index = 2
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.label = 1
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.has_default_value = false
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.default_value = 0
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.type = 5
Activity107Module_pb.BUY107GOODSREPLYNUMFIELD.cpp_type = 1
Activity107Module_pb.BUY107GOODSREPLY_MSG.name = "Buy107GoodsReply"
Activity107Module_pb.BUY107GOODSREPLY_MSG.full_name = ".Buy107GoodsReply"
Activity107Module_pb.BUY107GOODSREPLY_MSG.nested_types = {}
Activity107Module_pb.BUY107GOODSREPLY_MSG.enum_types = {}
Activity107Module_pb.BUY107GOODSREPLY_MSG.fields = {
	Activity107Module_pb.BUY107GOODSREPLYACTIVITYIDFIELD,
	Activity107Module_pb.BUY107GOODSREPLYGOODSINFOFIELD,
	Activity107Module_pb.BUY107GOODSREPLYNUMFIELD
}
Activity107Module_pb.BUY107GOODSREPLY_MSG.is_extendable = false
Activity107Module_pb.BUY107GOODSREPLY_MSG.extensions = {}
Activity107Module_pb.Act107GoodsInfo = protobuf.Message(Activity107Module_pb.ACT107GOODSINFO_MSG)
Activity107Module_pb.Buy107GoodsReply = protobuf.Message(Activity107Module_pb.BUY107GOODSREPLY_MSG)
Activity107Module_pb.Buy107GoodsRequest = protobuf.Message(Activity107Module_pb.BUY107GOODSREQUEST_MSG)
Activity107Module_pb.Get107GoodsInfoReply = protobuf.Message(Activity107Module_pb.GET107GOODSINFOREPLY_MSG)
Activity107Module_pb.Get107GoodsInfoRequest = protobuf.Message(Activity107Module_pb.GET107GOODSINFOREQUEST_MSG)

return Activity107Module_pb

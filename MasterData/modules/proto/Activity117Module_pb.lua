-- chunkname: @modules/proto/Activity117Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity117Module_pb", package.seeall)

local Activity117Module_pb = {}

Activity117Module_pb.ACT117INFOREQUEST_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117INFOREPLY_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117ORDERPUSH_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117ORDER_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117ORDERIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117ORDERPROGRESSFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117GETBONUSREPLY_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117DEALREQUEST_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117DEALREPLY_MSG = protobuf.Descriptor()
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117DEALREPLYORDERFIELD = protobuf.FieldDescriptor()
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.full_name = ".Act117InfoRequest.activityId"
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117INFOREQUEST_MSG.name = "Act117InfoRequest"
Activity117Module_pb.ACT117INFOREQUEST_MSG.full_name = ".Act117InfoRequest"
Activity117Module_pb.ACT117INFOREQUEST_MSG.nested_types = {}
Activity117Module_pb.ACT117INFOREQUEST_MSG.enum_types = {}
Activity117Module_pb.ACT117INFOREQUEST_MSG.fields = {
	Activity117Module_pb.ACT117INFOREQUESTACTIVITYIDFIELD
}
Activity117Module_pb.ACT117INFOREQUEST_MSG.is_extendable = false
Activity117Module_pb.ACT117INFOREQUEST_MSG.extensions = {}
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.full_name = ".Act117NegotiateRequest.activityId"
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.name = "orderId"
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.full_name = ".Act117NegotiateRequest.orderId"
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.number = 2
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.index = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.label = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.has_default_value = false
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.default_value = 0
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.type = 5
Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.name = "userDealScore"
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.full_name = ".Act117NegotiateRequest.userDealScore"
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.number = 3
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.index = 2
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.label = 1
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.has_default_value = false
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.default_value = 0
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.type = 5
Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD.cpp_type = 1
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.name = "Act117NegotiateRequest"
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.full_name = ".Act117NegotiateRequest"
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.nested_types = {}
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.enum_types = {}
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.fields = {
	Activity117Module_pb.ACT117NEGOTIATEREQUESTACTIVITYIDFIELD,
	Activity117Module_pb.ACT117NEGOTIATEREQUESTORDERIDFIELD,
	Activity117Module_pb.ACT117NEGOTIATEREQUESTUSERDEALSCOREFIELD
}
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.is_extendable = false
Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG.extensions = {}
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.full_name = ".Act117InfoReply.activityId"
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.name = "score"
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.full_name = ".Act117InfoReply.score"
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.number = 2
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.index = 1
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.label = 1
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.has_default_value = false
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.default_value = 0
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.type = 5
Activity117Module_pb.ACT117INFOREPLYSCOREFIELD.cpp_type = 1
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.name = "orders"
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.full_name = ".Act117InfoReply.orders"
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.number = 3
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.index = 2
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.label = 3
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.has_default_value = false
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.default_value = {}
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.message_type = Activity117Module_pb.ACT117ORDER_MSG
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.type = 11
Activity117Module_pb.ACT117INFOREPLYORDERSFIELD.cpp_type = 10
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.full_name = ".Act117InfoReply.hasGetBonusIds"
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.number = 4
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.index = 3
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.label = 3
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.has_default_value = false
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.default_value = {}
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.type = 5
Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD.cpp_type = 1
Activity117Module_pb.ACT117INFOREPLY_MSG.name = "Act117InfoReply"
Activity117Module_pb.ACT117INFOREPLY_MSG.full_name = ".Act117InfoReply"
Activity117Module_pb.ACT117INFOREPLY_MSG.nested_types = {}
Activity117Module_pb.ACT117INFOREPLY_MSG.enum_types = {}
Activity117Module_pb.ACT117INFOREPLY_MSG.fields = {
	Activity117Module_pb.ACT117INFOREPLYACTIVITYIDFIELD,
	Activity117Module_pb.ACT117INFOREPLYSCOREFIELD,
	Activity117Module_pb.ACT117INFOREPLYORDERSFIELD,
	Activity117Module_pb.ACT117INFOREPLYHASGETBONUSIDSFIELD
}
Activity117Module_pb.ACT117INFOREPLY_MSG.is_extendable = false
Activity117Module_pb.ACT117INFOREPLY_MSG.extensions = {}
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.full_name = ".Act117OrderPush.activityId"
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.name = "order"
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.full_name = ".Act117OrderPush.order"
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.number = 2
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.index = 1
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.label = 1
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.has_default_value = false
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.default_value = nil
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.message_type = Activity117Module_pb.ACT117ORDER_MSG
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.type = 11
Activity117Module_pb.ACT117ORDERPUSHORDERFIELD.cpp_type = 10
Activity117Module_pb.ACT117ORDERPUSH_MSG.name = "Act117OrderPush"
Activity117Module_pb.ACT117ORDERPUSH_MSG.full_name = ".Act117OrderPush"
Activity117Module_pb.ACT117ORDERPUSH_MSG.nested_types = {}
Activity117Module_pb.ACT117ORDERPUSH_MSG.enum_types = {}
Activity117Module_pb.ACT117ORDERPUSH_MSG.fields = {
	Activity117Module_pb.ACT117ORDERPUSHACTIVITYIDFIELD,
	Activity117Module_pb.ACT117ORDERPUSHORDERFIELD
}
Activity117Module_pb.ACT117ORDERPUSH_MSG.is_extendable = false
Activity117Module_pb.ACT117ORDERPUSH_MSG.extensions = {}
Activity117Module_pb.ACT117ORDERIDFIELD.name = "id"
Activity117Module_pb.ACT117ORDERIDFIELD.full_name = ".Act117Order.id"
Activity117Module_pb.ACT117ORDERIDFIELD.number = 1
Activity117Module_pb.ACT117ORDERIDFIELD.index = 0
Activity117Module_pb.ACT117ORDERIDFIELD.label = 1
Activity117Module_pb.ACT117ORDERIDFIELD.has_default_value = false
Activity117Module_pb.ACT117ORDERIDFIELD.default_value = 0
Activity117Module_pb.ACT117ORDERIDFIELD.type = 5
Activity117Module_pb.ACT117ORDERIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.name = "hasGetBonus"
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.full_name = ".Act117Order.hasGetBonus"
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.number = 2
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.index = 1
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.label = 1
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.has_default_value = false
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.default_value = false
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.type = 8
Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD.cpp_type = 7
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.name = "userDealScores"
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.full_name = ".Act117Order.userDealScores"
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.number = 3
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.index = 2
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.label = 3
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.has_default_value = false
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.default_value = {}
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.type = 5
Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD.cpp_type = 1
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.name = "progress"
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.full_name = ".Act117Order.progress"
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.number = 4
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.index = 3
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.label = 1
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.has_default_value = false
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.default_value = 0
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.type = 5
Activity117Module_pb.ACT117ORDERPROGRESSFIELD.cpp_type = 1
Activity117Module_pb.ACT117ORDER_MSG.name = "Act117Order"
Activity117Module_pb.ACT117ORDER_MSG.full_name = ".Act117Order"
Activity117Module_pb.ACT117ORDER_MSG.nested_types = {}
Activity117Module_pb.ACT117ORDER_MSG.enum_types = {}
Activity117Module_pb.ACT117ORDER_MSG.fields = {
	Activity117Module_pb.ACT117ORDERIDFIELD,
	Activity117Module_pb.ACT117ORDERHASGETBONUSFIELD,
	Activity117Module_pb.ACT117ORDERUSERDEALSCORESFIELD,
	Activity117Module_pb.ACT117ORDERPROGRESSFIELD
}
Activity117Module_pb.ACT117ORDER_MSG.is_extendable = false
Activity117Module_pb.ACT117ORDER_MSG.extensions = {}
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.full_name = ".Act117GetBonusReply.activityId"
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.name = "bonusIds"
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.full_name = ".Act117GetBonusReply.bonusIds"
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.number = 2
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.index = 1
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.label = 3
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.has_default_value = false
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.default_value = {}
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.type = 5
Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD.cpp_type = 1
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.name = "Act117GetBonusReply"
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.full_name = ".Act117GetBonusReply"
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.nested_types = {}
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.enum_types = {}
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.fields = {
	Activity117Module_pb.ACT117GETBONUSREPLYACTIVITYIDFIELD,
	Activity117Module_pb.ACT117GETBONUSREPLYBONUSIDSFIELD
}
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.is_extendable = false
Activity117Module_pb.ACT117GETBONUSREPLY_MSG.extensions = {}
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.full_name = ".Act117DealRequest.activityId"
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.name = "orderId"
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.full_name = ".Act117DealRequest.orderId"
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.number = 2
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.index = 1
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.label = 1
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.has_default_value = false
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.default_value = 0
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.type = 5
Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117DEALREQUEST_MSG.name = "Act117DealRequest"
Activity117Module_pb.ACT117DEALREQUEST_MSG.full_name = ".Act117DealRequest"
Activity117Module_pb.ACT117DEALREQUEST_MSG.nested_types = {}
Activity117Module_pb.ACT117DEALREQUEST_MSG.enum_types = {}
Activity117Module_pb.ACT117DEALREQUEST_MSG.fields = {
	Activity117Module_pb.ACT117DEALREQUESTACTIVITYIDFIELD,
	Activity117Module_pb.ACT117DEALREQUESTORDERIDFIELD
}
Activity117Module_pb.ACT117DEALREQUEST_MSG.is_extendable = false
Activity117Module_pb.ACT117DEALREQUEST_MSG.extensions = {}
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.full_name = ".Act117GetBonusRequest.activityId"
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.name = "bonusIds"
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.full_name = ".Act117GetBonusRequest.bonusIds"
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.number = 2
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.index = 1
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.label = 3
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.has_default_value = false
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.default_value = {}
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.type = 5
Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD.cpp_type = 1
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.name = "Act117GetBonusRequest"
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.full_name = ".Act117GetBonusRequest"
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.nested_types = {}
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.enum_types = {}
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.fields = {
	Activity117Module_pb.ACT117GETBONUSREQUESTACTIVITYIDFIELD,
	Activity117Module_pb.ACT117GETBONUSREQUESTBONUSIDSFIELD
}
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.is_extendable = false
Activity117Module_pb.ACT117GETBONUSREQUEST_MSG.extensions = {}
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.full_name = ".Act117NegotiateReply.activityId"
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.name = "order"
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.full_name = ".Act117NegotiateReply.order"
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.number = 2
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.index = 1
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.label = 1
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.has_default_value = false
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.default_value = nil
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.message_type = Activity117Module_pb.ACT117ORDER_MSG
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.type = 11
Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD.cpp_type = 10
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.name = "Act117NegotiateReply"
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.full_name = ".Act117NegotiateReply"
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.nested_types = {}
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.enum_types = {}
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.fields = {
	Activity117Module_pb.ACT117NEGOTIATEREPLYACTIVITYIDFIELD,
	Activity117Module_pb.ACT117NEGOTIATEREPLYORDERFIELD
}
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.is_extendable = false
Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG.extensions = {}
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.name = "activityId"
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.full_name = ".Act117DealReply.activityId"
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.number = 1
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.index = 0
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.label = 1
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.has_default_value = false
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.default_value = 0
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.type = 5
Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD.cpp_type = 1
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.name = "order"
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.full_name = ".Act117DealReply.order"
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.number = 2
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.index = 1
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.label = 1
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.has_default_value = false
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.default_value = nil
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.message_type = Activity117Module_pb.ACT117ORDER_MSG
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.type = 11
Activity117Module_pb.ACT117DEALREPLYORDERFIELD.cpp_type = 10
Activity117Module_pb.ACT117DEALREPLY_MSG.name = "Act117DealReply"
Activity117Module_pb.ACT117DEALREPLY_MSG.full_name = ".Act117DealReply"
Activity117Module_pb.ACT117DEALREPLY_MSG.nested_types = {}
Activity117Module_pb.ACT117DEALREPLY_MSG.enum_types = {}
Activity117Module_pb.ACT117DEALREPLY_MSG.fields = {
	Activity117Module_pb.ACT117DEALREPLYACTIVITYIDFIELD,
	Activity117Module_pb.ACT117DEALREPLYORDERFIELD
}
Activity117Module_pb.ACT117DEALREPLY_MSG.is_extendable = false
Activity117Module_pb.ACT117DEALREPLY_MSG.extensions = {}
Activity117Module_pb.Act117DealReply = protobuf.Message(Activity117Module_pb.ACT117DEALREPLY_MSG)
Activity117Module_pb.Act117DealRequest = protobuf.Message(Activity117Module_pb.ACT117DEALREQUEST_MSG)
Activity117Module_pb.Act117GetBonusReply = protobuf.Message(Activity117Module_pb.ACT117GETBONUSREPLY_MSG)
Activity117Module_pb.Act117GetBonusRequest = protobuf.Message(Activity117Module_pb.ACT117GETBONUSREQUEST_MSG)
Activity117Module_pb.Act117InfoReply = protobuf.Message(Activity117Module_pb.ACT117INFOREPLY_MSG)
Activity117Module_pb.Act117InfoRequest = protobuf.Message(Activity117Module_pb.ACT117INFOREQUEST_MSG)
Activity117Module_pb.Act117NegotiateReply = protobuf.Message(Activity117Module_pb.ACT117NEGOTIATEREPLY_MSG)
Activity117Module_pb.Act117NegotiateRequest = protobuf.Message(Activity117Module_pb.ACT117NEGOTIATEREQUEST_MSG)
Activity117Module_pb.Act117Order = protobuf.Message(Activity117Module_pb.ACT117ORDER_MSG)
Activity117Module_pb.Act117OrderPush = protobuf.Message(Activity117Module_pb.ACT117ORDERPUSH_MSG)

return Activity117Module_pb

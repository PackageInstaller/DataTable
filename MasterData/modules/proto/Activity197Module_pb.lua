-- chunkname: @modules/proto/Activity197Module_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.Activity197Module_pb", package.seeall)

local Activity197Module_pb = {}

Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG = protobuf.Descriptor()
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197EXPLOREREPLY_MSG = protobuf.Descriptor()
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG = protobuf.Descriptor()
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197GAININFO_MSG = protobuf.Descriptor()
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.GET197INFOREPLY_MSG = protobuf.Descriptor()
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.GET197INFOREQUEST_MSG = protobuf.Descriptor()
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG = protobuf.Descriptor()
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD = protobuf.FieldDescriptor()
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.name = "activityId"
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.full_name = ".Act197RummageRequest.activityId"
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.number = 1
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.index = 0
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.label = 1
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.has_default_value = false
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.default_value = 0
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.type = 5
Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.name = "poolId"
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.full_name = ".Act197RummageRequest.poolId"
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.number = 2
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.index = 1
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.label = 1
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.has_default_value = false
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.default_value = 0
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.type = 5
Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.name = "Act197RummageRequest"
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.full_name = ".Act197RummageRequest"
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.nested_types = {}
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.enum_types = {}
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.fields = {
	Activity197Module_pb.ACT197RUMMAGEREQUESTACTIVITYIDFIELD,
	Activity197Module_pb.ACT197RUMMAGEREQUESTPOOLIDFIELD
}
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.is_extendable = false
Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG.extensions = {}
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.name = "activityId"
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.full_name = ".Act197ExploreReply.activityId"
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.number = 1
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.index = 0
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.label = 1
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.has_default_value = false
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.default_value = 0
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.type = 5
Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.name = "Act197ExploreReply"
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.full_name = ".Act197ExploreReply"
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.nested_types = {}
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.enum_types = {}
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.fields = {
	Activity197Module_pb.ACT197EXPLOREREPLYACTIVITYIDFIELD
}
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.is_extendable = false
Activity197Module_pb.ACT197EXPLOREREPLY_MSG.extensions = {}
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.name = "activityId"
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.full_name = ".Act197ExploreRequest.activityId"
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.number = 1
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.index = 0
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.label = 1
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.has_default_value = false
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.default_value = 0
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.type = 5
Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.name = "type"
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.full_name = ".Act197ExploreRequest.type"
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.number = 2
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.index = 1
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.label = 1
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.has_default_value = false
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.default_value = 0
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.type = 5
Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD.cpp_type = 1
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.name = "Act197ExploreRequest"
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.full_name = ".Act197ExploreRequest"
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.nested_types = {}
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.enum_types = {}
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.fields = {
	Activity197Module_pb.ACT197EXPLOREREQUESTACTIVITYIDFIELD,
	Activity197Module_pb.ACT197EXPLOREREQUESTTYPEFIELD
}
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.is_extendable = false
Activity197Module_pb.ACT197EXPLOREREQUEST_MSG.extensions = {}
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.name = "poolId"
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.full_name = ".Act197GainInfo.poolId"
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.number = 1
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.index = 0
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.label = 1
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.has_default_value = false
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.default_value = 0
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.type = 5
Activity197Module_pb.ACT197GAININFOPOOLIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.name = "gainIds"
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.full_name = ".Act197GainInfo.gainIds"
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.number = 2
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.index = 1
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.label = 3
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.has_default_value = false
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.default_value = {}
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.type = 5
Activity197Module_pb.ACT197GAININFOGAINIDSFIELD.cpp_type = 1
Activity197Module_pb.ACT197GAININFO_MSG.name = "Act197GainInfo"
Activity197Module_pb.ACT197GAININFO_MSG.full_name = ".Act197GainInfo"
Activity197Module_pb.ACT197GAININFO_MSG.nested_types = {}
Activity197Module_pb.ACT197GAININFO_MSG.enum_types = {}
Activity197Module_pb.ACT197GAININFO_MSG.fields = {
	Activity197Module_pb.ACT197GAININFOPOOLIDFIELD,
	Activity197Module_pb.ACT197GAININFOGAINIDSFIELD
}
Activity197Module_pb.ACT197GAININFO_MSG.is_extendable = false
Activity197Module_pb.ACT197GAININFO_MSG.extensions = {}
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.name = "activityId"
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.full_name = ".Get197InfoReply.activityId"
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.number = 1
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.index = 0
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.label = 1
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.has_default_value = false
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.default_value = 0
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.type = 5
Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD.cpp_type = 1
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.name = "hasGain"
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.full_name = ".Get197InfoReply.hasGain"
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.number = 2
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.index = 1
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.label = 3
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.has_default_value = false
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.default_value = {}
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.message_type = Activity197Module_pb.ACT197GAININFO_MSG
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.type = 11
Activity197Module_pb.GET197INFOREPLYHASGAINFIELD.cpp_type = 10
Activity197Module_pb.GET197INFOREPLY_MSG.name = "Get197InfoReply"
Activity197Module_pb.GET197INFOREPLY_MSG.full_name = ".Get197InfoReply"
Activity197Module_pb.GET197INFOREPLY_MSG.nested_types = {}
Activity197Module_pb.GET197INFOREPLY_MSG.enum_types = {}
Activity197Module_pb.GET197INFOREPLY_MSG.fields = {
	Activity197Module_pb.GET197INFOREPLYACTIVITYIDFIELD,
	Activity197Module_pb.GET197INFOREPLYHASGAINFIELD
}
Activity197Module_pb.GET197INFOREPLY_MSG.is_extendable = false
Activity197Module_pb.GET197INFOREPLY_MSG.extensions = {}
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.name = "activityId"
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.full_name = ".Get197InfoRequest.activityId"
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.number = 1
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.index = 0
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.label = 1
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.has_default_value = false
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.default_value = 0
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.type = 5
Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
Activity197Module_pb.GET197INFOREQUEST_MSG.name = "Get197InfoRequest"
Activity197Module_pb.GET197INFOREQUEST_MSG.full_name = ".Get197InfoRequest"
Activity197Module_pb.GET197INFOREQUEST_MSG.nested_types = {}
Activity197Module_pb.GET197INFOREQUEST_MSG.enum_types = {}
Activity197Module_pb.GET197INFOREQUEST_MSG.fields = {
	Activity197Module_pb.GET197INFOREQUESTACTIVITYIDFIELD
}
Activity197Module_pb.GET197INFOREQUEST_MSG.is_extendable = false
Activity197Module_pb.GET197INFOREQUEST_MSG.extensions = {}
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.name = "activityId"
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.full_name = ".Act197RummageReply.activityId"
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.number = 1
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.index = 0
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.label = 1
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.has_default_value = false
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.default_value = 0
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.type = 5
Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.name = "poolId"
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.full_name = ".Act197RummageReply.poolId"
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.number = 2
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.index = 1
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.label = 1
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.has_default_value = false
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.default_value = 0
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.type = 5
Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.name = "id"
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.full_name = ".Act197RummageReply.id"
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.number = 3
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.index = 2
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.label = 1
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.has_default_value = false
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.default_value = 0
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.type = 5
Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD.cpp_type = 1
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.name = "Act197RummageReply"
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.full_name = ".Act197RummageReply"
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.nested_types = {}
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.enum_types = {}
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.fields = {
	Activity197Module_pb.ACT197RUMMAGEREPLYACTIVITYIDFIELD,
	Activity197Module_pb.ACT197RUMMAGEREPLYPOOLIDFIELD,
	Activity197Module_pb.ACT197RUMMAGEREPLYIDFIELD
}
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.is_extendable = false
Activity197Module_pb.ACT197RUMMAGEREPLY_MSG.extensions = {}
Activity197Module_pb.Act197ExploreReply = protobuf.Message(Activity197Module_pb.ACT197EXPLOREREPLY_MSG)
Activity197Module_pb.Act197ExploreRequest = protobuf.Message(Activity197Module_pb.ACT197EXPLOREREQUEST_MSG)
Activity197Module_pb.Act197GainInfo = protobuf.Message(Activity197Module_pb.ACT197GAININFO_MSG)
Activity197Module_pb.Act197RummageReply = protobuf.Message(Activity197Module_pb.ACT197RUMMAGEREPLY_MSG)
Activity197Module_pb.Act197RummageRequest = protobuf.Message(Activity197Module_pb.ACT197RUMMAGEREQUEST_MSG)
Activity197Module_pb.Get197InfoReply = protobuf.Message(Activity197Module_pb.GET197INFOREPLY_MSG)
Activity197Module_pb.Get197InfoRequest = protobuf.Message(Activity197Module_pb.GET197INFOREQUEST_MSG)

return Activity197Module_pb

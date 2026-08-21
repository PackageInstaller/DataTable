-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/LotteryExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.LotteryExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.LotteryFeature = protobuf.EnumDescriptor()
enum_item_descriptors.LotteryFeature_NORMAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.LotteryFeature_NEWBIE = protobuf.EnumValueDescriptor()
enum_item_descriptors.LotteryFeature_WISH = protobuf.EnumValueDescriptor()
type_descriptors.LotteryEchoReply = protobuf.Descriptor()
field_descriptors.LotteryEchoReply_items = protobuf.FieldDescriptor()
field_descriptors.LotteryEchoReply_nextGuaranteeA = protobuf.FieldDescriptor()
field_descriptors.LotteryEchoReply_nextGuaranteeS = protobuf.FieldDescriptor()
type_descriptors.PickLotteryItemReply = protobuf.Descriptor()
type_descriptors.GetPoolInfoReply = protobuf.Descriptor()
field_descriptors.GetPoolInfoReply_pools = protobuf.FieldDescriptor()
field_descriptors.GetPoolInfoReply_mojitu = protobuf.FieldDescriptor()
type_descriptors.GetPoolInfoRequest = protobuf.Descriptor()
field_descriptors.GetPoolInfoRequest_code = protobuf.FieldDescriptor()
type_descriptors.LotteryEchoRequest = protobuf.Descriptor()
field_descriptors.LotteryEchoRequest_pool = protobuf.FieldDescriptor()
field_descriptors.LotteryEchoRequest_num = protobuf.FieldDescriptor()
type_descriptors.LotteryItemNO = protobuf.Descriptor()
field_descriptors.LotteryItemNO_itemCode = protobuf.FieldDescriptor()
field_descriptors.LotteryItemNO_extra = protobuf.FieldDescriptor()
field_descriptors.LotteryItemNO_newly = protobuf.FieldDescriptor()
type_descriptors.PoolNO = protobuf.Descriptor()
field_descriptors.PoolNO_code = protobuf.FieldDescriptor()
field_descriptors.PoolNO_dailyRemain = protobuf.FieldDescriptor()
field_descriptors.PoolNO_sRate = protobuf.FieldDescriptor()
field_descriptors.PoolNO_upRates = protobuf.FieldDescriptor()
field_descriptors.PoolNO_basicRates = protobuf.FieldDescriptor()
field_descriptors.PoolNO_syntheticalRates = protobuf.FieldDescriptor()
field_descriptors.PoolNO_picked = protobuf.FieldDescriptor()
field_descriptors.PoolNO_guaranteeWish = protobuf.FieldDescriptor()
field_descriptors.PoolNO_nextGuaranteeA = protobuf.FieldDescriptor()
field_descriptors.PoolNO_guaranteeAbsolute = protobuf.FieldDescriptor()
field_descriptors.PoolNO_nextGuaranteeS = protobuf.FieldDescriptor()
type_descriptors.GetLotteryLogRequest = protobuf.Descriptor()
type_descriptors.GetLotteryLogReply = protobuf.Descriptor()
field_descriptors.GetLotteryLogReply_logs = protobuf.FieldDescriptor()
type_descriptors.PickLotteryItemRequest = protobuf.Descriptor()
field_descriptors.PickLotteryItemRequest_pool = protobuf.FieldDescriptor()
field_descriptors.PickLotteryItemRequest_item = protobuf.FieldDescriptor()
type_descriptors.LotteryLogNO = protobuf.Descriptor()
field_descriptors.LotteryLogNO_itemCode = protobuf.FieldDescriptor()
field_descriptors.LotteryLogNO_time = protobuf.FieldDescriptor()
field_descriptors.LotteryLogNO_poolCode = protobuf.FieldDescriptor()
type_descriptors.LotteryRequest = protobuf.Descriptor()
field_descriptors.LotteryRequest_pool = protobuf.FieldDescriptor()
field_descriptors.LotteryRequest_num = protobuf.FieldDescriptor()
type_descriptors.LotteryReply = protobuf.Descriptor()
field_descriptors.LotteryReply_items = protobuf.FieldDescriptor()
type_descriptors.ExtraItemNO = protobuf.Descriptor()
field_descriptors.ExtraItemNO_code = protobuf.FieldDescriptor()
field_descriptors.ExtraItemNO_num = protobuf.FieldDescriptor()
field_descriptors.ExtraItemNO_conversion = protobuf.FieldDescriptor()
enum_item_descriptors.LotteryFeature_NORMAL.name = "NORMAL"
enum_item_descriptors.LotteryFeature_NORMAL.index = 0
enum_item_descriptors.LotteryFeature_NORMAL.number = 0
enum_item_descriptors.LotteryFeature_NEWBIE.name = "NEWBIE"
enum_item_descriptors.LotteryFeature_NEWBIE.index = 1
enum_item_descriptors.LotteryFeature_NEWBIE.number = 1
enum_item_descriptors.LotteryFeature_WISH.name = "WISH"
enum_item_descriptors.LotteryFeature_WISH.index = 2
enum_item_descriptors.LotteryFeature_WISH.number = 2
type_descriptors.LotteryFeature.name = "LotteryFeature"
type_descriptors.LotteryFeature.full_name = ".LotteryFeature"
type_descriptors.LotteryFeature.values = {
	enum_item_descriptors.LotteryFeature_NORMAL,
	enum_item_descriptors.LotteryFeature_NEWBIE,
	enum_item_descriptors.LotteryFeature_WISH
}
field_descriptors.LotteryEchoReply_items.name = "items"
field_descriptors.LotteryEchoReply_items.full_name = ".LotteryEchoReply.items"
field_descriptors.LotteryEchoReply_items.number = 1
field_descriptors.LotteryEchoReply_items.index = 0
field_descriptors.LotteryEchoReply_items.label = 3
field_descriptors.LotteryEchoReply_items.has_default_value = false
field_descriptors.LotteryEchoReply_items.default_value = {}
field_descriptors.LotteryEchoReply_items.message_type = type_descriptors.LotteryItemNO
field_descriptors.LotteryEchoReply_items.type = 11
field_descriptors.LotteryEchoReply_items.cpp_type = 10
field_descriptors.LotteryEchoReply_nextGuaranteeA.name = "nextGuaranteeA"
field_descriptors.LotteryEchoReply_nextGuaranteeA.full_name = ".LotteryEchoReply.nextGuaranteeA"
field_descriptors.LotteryEchoReply_nextGuaranteeA.number = 2
field_descriptors.LotteryEchoReply_nextGuaranteeA.index = 1
field_descriptors.LotteryEchoReply_nextGuaranteeA.label = 1
field_descriptors.LotteryEchoReply_nextGuaranteeA.has_default_value = false
field_descriptors.LotteryEchoReply_nextGuaranteeA.default_value = 0
field_descriptors.LotteryEchoReply_nextGuaranteeA.type = 5
field_descriptors.LotteryEchoReply_nextGuaranteeA.cpp_type = 1
field_descriptors.LotteryEchoReply_nextGuaranteeS.name = "nextGuaranteeS"
field_descriptors.LotteryEchoReply_nextGuaranteeS.full_name = ".LotteryEchoReply.nextGuaranteeS"
field_descriptors.LotteryEchoReply_nextGuaranteeS.number = 3
field_descriptors.LotteryEchoReply_nextGuaranteeS.index = 2
field_descriptors.LotteryEchoReply_nextGuaranteeS.label = 1
field_descriptors.LotteryEchoReply_nextGuaranteeS.has_default_value = false
field_descriptors.LotteryEchoReply_nextGuaranteeS.default_value = 0
field_descriptors.LotteryEchoReply_nextGuaranteeS.type = 5
field_descriptors.LotteryEchoReply_nextGuaranteeS.cpp_type = 1
type_descriptors.LotteryEchoReply.name = "LotteryEchoReply"
type_descriptors.LotteryEchoReply.full_name = ".LotteryEchoReply"
type_descriptors.LotteryEchoReply.nested_types = {}
type_descriptors.LotteryEchoReply.enum_types = {}
type_descriptors.LotteryEchoReply.fields = {
	field_descriptors.LotteryEchoReply_items,
	field_descriptors.LotteryEchoReply_nextGuaranteeA,
	field_descriptors.LotteryEchoReply_nextGuaranteeS
}
type_descriptors.LotteryEchoReply.is_extendable = false
type_descriptors.LotteryEchoReply.extensions = {}
type_descriptors.PickLotteryItemReply.name = "PickLotteryItemReply"
type_descriptors.PickLotteryItemReply.full_name = ".PickLotteryItemReply"
type_descriptors.PickLotteryItemReply.nested_types = {}
type_descriptors.PickLotteryItemReply.enum_types = {}
type_descriptors.PickLotteryItemReply.fields = {}
type_descriptors.PickLotteryItemReply.is_extendable = false
type_descriptors.PickLotteryItemReply.extensions = {}
field_descriptors.GetPoolInfoReply_pools.name = "pools"
field_descriptors.GetPoolInfoReply_pools.full_name = ".GetPoolInfoReply.pools"
field_descriptors.GetPoolInfoReply_pools.number = 1
field_descriptors.GetPoolInfoReply_pools.index = 0
field_descriptors.GetPoolInfoReply_pools.label = 3
field_descriptors.GetPoolInfoReply_pools.has_default_value = false
field_descriptors.GetPoolInfoReply_pools.default_value = {}
field_descriptors.GetPoolInfoReply_pools.message_type = type_descriptors.PoolNO
field_descriptors.GetPoolInfoReply_pools.type = 11
field_descriptors.GetPoolInfoReply_pools.cpp_type = 10
field_descriptors.GetPoolInfoReply_mojitu.name = "mojitu"
field_descriptors.GetPoolInfoReply_mojitu.full_name = ".GetPoolInfoReply.mojitu"
field_descriptors.GetPoolInfoReply_mojitu.number = 2
field_descriptors.GetPoolInfoReply_mojitu.index = 1
field_descriptors.GetPoolInfoReply_mojitu.label = 1
field_descriptors.GetPoolInfoReply_mojitu.has_default_value = false
field_descriptors.GetPoolInfoReply_mojitu.default_value = 0
field_descriptors.GetPoolInfoReply_mojitu.type = 5
field_descriptors.GetPoolInfoReply_mojitu.cpp_type = 1
type_descriptors.GetPoolInfoReply.name = "GetPoolInfoReply"
type_descriptors.GetPoolInfoReply.full_name = ".GetPoolInfoReply"
type_descriptors.GetPoolInfoReply.nested_types = {}
type_descriptors.GetPoolInfoReply.enum_types = {}
type_descriptors.GetPoolInfoReply.fields = {
	field_descriptors.GetPoolInfoReply_pools,
	field_descriptors.GetPoolInfoReply_mojitu
}
type_descriptors.GetPoolInfoReply.is_extendable = false
type_descriptors.GetPoolInfoReply.extensions = {}
field_descriptors.GetPoolInfoRequest_code.name = "code"
field_descriptors.GetPoolInfoRequest_code.full_name = ".GetPoolInfoRequest.code"
field_descriptors.GetPoolInfoRequest_code.number = 1
field_descriptors.GetPoolInfoRequest_code.index = 0
field_descriptors.GetPoolInfoRequest_code.label = 3
field_descriptors.GetPoolInfoRequest_code.has_default_value = false
field_descriptors.GetPoolInfoRequest_code.default_value = {}
field_descriptors.GetPoolInfoRequest_code.type = 5
field_descriptors.GetPoolInfoRequest_code.cpp_type = 1
type_descriptors.GetPoolInfoRequest.name = "GetPoolInfoRequest"
type_descriptors.GetPoolInfoRequest.full_name = ".GetPoolInfoRequest"
type_descriptors.GetPoolInfoRequest.nested_types = {}
type_descriptors.GetPoolInfoRequest.enum_types = {}
type_descriptors.GetPoolInfoRequest.fields = {
	field_descriptors.GetPoolInfoRequest_code
}
type_descriptors.GetPoolInfoRequest.is_extendable = false
type_descriptors.GetPoolInfoRequest.extensions = {}
field_descriptors.LotteryEchoRequest_pool.name = "pool"
field_descriptors.LotteryEchoRequest_pool.full_name = ".LotteryEchoRequest.pool"
field_descriptors.LotteryEchoRequest_pool.number = 1
field_descriptors.LotteryEchoRequest_pool.index = 0
field_descriptors.LotteryEchoRequest_pool.label = 1
field_descriptors.LotteryEchoRequest_pool.has_default_value = false
field_descriptors.LotteryEchoRequest_pool.default_value = 0
field_descriptors.LotteryEchoRequest_pool.type = 5
field_descriptors.LotteryEchoRequest_pool.cpp_type = 1
field_descriptors.LotteryEchoRequest_num.name = "num"
field_descriptors.LotteryEchoRequest_num.full_name = ".LotteryEchoRequest.num"
field_descriptors.LotteryEchoRequest_num.number = 2
field_descriptors.LotteryEchoRequest_num.index = 1
field_descriptors.LotteryEchoRequest_num.label = 1
field_descriptors.LotteryEchoRequest_num.has_default_value = false
field_descriptors.LotteryEchoRequest_num.default_value = 0
field_descriptors.LotteryEchoRequest_num.type = 5
field_descriptors.LotteryEchoRequest_num.cpp_type = 1
type_descriptors.LotteryEchoRequest.name = "LotteryEchoRequest"
type_descriptors.LotteryEchoRequest.full_name = ".LotteryEchoRequest"
type_descriptors.LotteryEchoRequest.nested_types = {}
type_descriptors.LotteryEchoRequest.enum_types = {}
type_descriptors.LotteryEchoRequest.fields = {
	field_descriptors.LotteryEchoRequest_pool,
	field_descriptors.LotteryEchoRequest_num
}
type_descriptors.LotteryEchoRequest.is_extendable = false
type_descriptors.LotteryEchoRequest.extensions = {}
field_descriptors.LotteryItemNO_itemCode.name = "itemCode"
field_descriptors.LotteryItemNO_itemCode.full_name = ".LotteryItemNO.itemCode"
field_descriptors.LotteryItemNO_itemCode.number = 1
field_descriptors.LotteryItemNO_itemCode.index = 0
field_descriptors.LotteryItemNO_itemCode.label = 1
field_descriptors.LotteryItemNO_itemCode.has_default_value = false
field_descriptors.LotteryItemNO_itemCode.default_value = 0
field_descriptors.LotteryItemNO_itemCode.type = 5
field_descriptors.LotteryItemNO_itemCode.cpp_type = 1
field_descriptors.LotteryItemNO_extra.name = "extra"
field_descriptors.LotteryItemNO_extra.full_name = ".LotteryItemNO.extra"
field_descriptors.LotteryItemNO_extra.number = 4
field_descriptors.LotteryItemNO_extra.index = 1
field_descriptors.LotteryItemNO_extra.label = 3
field_descriptors.LotteryItemNO_extra.has_default_value = false
field_descriptors.LotteryItemNO_extra.default_value = {}
field_descriptors.LotteryItemNO_extra.message_type = type_descriptors.ExtraItemNO
field_descriptors.LotteryItemNO_extra.type = 11
field_descriptors.LotteryItemNO_extra.cpp_type = 10
field_descriptors.LotteryItemNO_newly.name = "newly"
field_descriptors.LotteryItemNO_newly.full_name = ".LotteryItemNO.newly"
field_descriptors.LotteryItemNO_newly.number = 5
field_descriptors.LotteryItemNO_newly.index = 2
field_descriptors.LotteryItemNO_newly.label = 1
field_descriptors.LotteryItemNO_newly.has_default_value = false
field_descriptors.LotteryItemNO_newly.default_value = false
field_descriptors.LotteryItemNO_newly.type = 8
field_descriptors.LotteryItemNO_newly.cpp_type = 7
type_descriptors.LotteryItemNO.name = "LotteryItemNO"
type_descriptors.LotteryItemNO.full_name = ".LotteryItemNO"
type_descriptors.LotteryItemNO.nested_types = {}
type_descriptors.LotteryItemNO.enum_types = {}
type_descriptors.LotteryItemNO.fields = {
	field_descriptors.LotteryItemNO_itemCode,
	field_descriptors.LotteryItemNO_extra,
	field_descriptors.LotteryItemNO_newly
}
type_descriptors.LotteryItemNO.is_extendable = false
type_descriptors.LotteryItemNO.extensions = {}
field_descriptors.PoolNO_code.name = "code"
field_descriptors.PoolNO_code.full_name = ".PoolNO.code"
field_descriptors.PoolNO_code.number = 1
field_descriptors.PoolNO_code.index = 0
field_descriptors.PoolNO_code.label = 1
field_descriptors.PoolNO_code.has_default_value = false
field_descriptors.PoolNO_code.default_value = 0
field_descriptors.PoolNO_code.type = 5
field_descriptors.PoolNO_code.cpp_type = 1
field_descriptors.PoolNO_dailyRemain.name = "dailyRemain"
field_descriptors.PoolNO_dailyRemain.full_name = ".PoolNO.dailyRemain"
field_descriptors.PoolNO_dailyRemain.number = 4
field_descriptors.PoolNO_dailyRemain.index = 1
field_descriptors.PoolNO_dailyRemain.label = 1
field_descriptors.PoolNO_dailyRemain.has_default_value = false
field_descriptors.PoolNO_dailyRemain.default_value = 0
field_descriptors.PoolNO_dailyRemain.type = 5
field_descriptors.PoolNO_dailyRemain.cpp_type = 1
field_descriptors.PoolNO_sRate.name = "sRate"
field_descriptors.PoolNO_sRate.full_name = ".PoolNO.sRate"
field_descriptors.PoolNO_sRate.number = 5
field_descriptors.PoolNO_sRate.index = 2
field_descriptors.PoolNO_sRate.label = 1
field_descriptors.PoolNO_sRate.has_default_value = false
field_descriptors.PoolNO_sRate.default_value = 0
field_descriptors.PoolNO_sRate.type = 5
field_descriptors.PoolNO_sRate.cpp_type = 1
field_descriptors.PoolNO_upRates.name = "upRates"
field_descriptors.PoolNO_upRates.full_name = ".PoolNO.upRates"
field_descriptors.PoolNO_upRates.number = 7
field_descriptors.PoolNO_upRates.index = 3
field_descriptors.PoolNO_upRates.label = 3
field_descriptors.PoolNO_upRates.has_default_value = false
field_descriptors.PoolNO_upRates.default_value = {}
field_descriptors.PoolNO_upRates.type = 9
field_descriptors.PoolNO_upRates.cpp_type = 9
field_descriptors.PoolNO_basicRates.name = "basicRates"
field_descriptors.PoolNO_basicRates.full_name = ".PoolNO.basicRates"
field_descriptors.PoolNO_basicRates.number = 8
field_descriptors.PoolNO_basicRates.index = 4
field_descriptors.PoolNO_basicRates.label = 3
field_descriptors.PoolNO_basicRates.has_default_value = false
field_descriptors.PoolNO_basicRates.default_value = {}
field_descriptors.PoolNO_basicRates.type = 9
field_descriptors.PoolNO_basicRates.cpp_type = 9
field_descriptors.PoolNO_syntheticalRates.name = "syntheticalRates"
field_descriptors.PoolNO_syntheticalRates.full_name = ".PoolNO.syntheticalRates"
field_descriptors.PoolNO_syntheticalRates.number = 9
field_descriptors.PoolNO_syntheticalRates.index = 5
field_descriptors.PoolNO_syntheticalRates.label = 3
field_descriptors.PoolNO_syntheticalRates.has_default_value = false
field_descriptors.PoolNO_syntheticalRates.default_value = {}
field_descriptors.PoolNO_syntheticalRates.type = 9
field_descriptors.PoolNO_syntheticalRates.cpp_type = 9
field_descriptors.PoolNO_picked.name = "picked"
field_descriptors.PoolNO_picked.full_name = ".PoolNO.picked"
field_descriptors.PoolNO_picked.number = 10
field_descriptors.PoolNO_picked.index = 6
field_descriptors.PoolNO_picked.label = 1
field_descriptors.PoolNO_picked.has_default_value = false
field_descriptors.PoolNO_picked.default_value = 0
field_descriptors.PoolNO_picked.type = 5
field_descriptors.PoolNO_picked.cpp_type = 1
field_descriptors.PoolNO_guaranteeWish.name = "guaranteeWish"
field_descriptors.PoolNO_guaranteeWish.full_name = ".PoolNO.guaranteeWish"
field_descriptors.PoolNO_guaranteeWish.number = 11
field_descriptors.PoolNO_guaranteeWish.index = 7
field_descriptors.PoolNO_guaranteeWish.label = 1
field_descriptors.PoolNO_guaranteeWish.has_default_value = false
field_descriptors.PoolNO_guaranteeWish.default_value = 0
field_descriptors.PoolNO_guaranteeWish.type = 5
field_descriptors.PoolNO_guaranteeWish.cpp_type = 1
field_descriptors.PoolNO_nextGuaranteeA.name = "nextGuaranteeA"
field_descriptors.PoolNO_nextGuaranteeA.full_name = ".PoolNO.nextGuaranteeA"
field_descriptors.PoolNO_nextGuaranteeA.number = 12
field_descriptors.PoolNO_nextGuaranteeA.index = 8
field_descriptors.PoolNO_nextGuaranteeA.label = 1
field_descriptors.PoolNO_nextGuaranteeA.has_default_value = false
field_descriptors.PoolNO_nextGuaranteeA.default_value = 0
field_descriptors.PoolNO_nextGuaranteeA.type = 5
field_descriptors.PoolNO_nextGuaranteeA.cpp_type = 1
field_descriptors.PoolNO_guaranteeAbsolute.name = "guaranteeAbsolute"
field_descriptors.PoolNO_guaranteeAbsolute.full_name = ".PoolNO.guaranteeAbsolute"
field_descriptors.PoolNO_guaranteeAbsolute.number = 13
field_descriptors.PoolNO_guaranteeAbsolute.index = 9
field_descriptors.PoolNO_guaranteeAbsolute.label = 1
field_descriptors.PoolNO_guaranteeAbsolute.has_default_value = false
field_descriptors.PoolNO_guaranteeAbsolute.default_value = 0
field_descriptors.PoolNO_guaranteeAbsolute.type = 5
field_descriptors.PoolNO_guaranteeAbsolute.cpp_type = 1
field_descriptors.PoolNO_nextGuaranteeS.name = "nextGuaranteeS"
field_descriptors.PoolNO_nextGuaranteeS.full_name = ".PoolNO.nextGuaranteeS"
field_descriptors.PoolNO_nextGuaranteeS.number = 14
field_descriptors.PoolNO_nextGuaranteeS.index = 10
field_descriptors.PoolNO_nextGuaranteeS.label = 1
field_descriptors.PoolNO_nextGuaranteeS.has_default_value = false
field_descriptors.PoolNO_nextGuaranteeS.default_value = 0
field_descriptors.PoolNO_nextGuaranteeS.type = 5
field_descriptors.PoolNO_nextGuaranteeS.cpp_type = 1
type_descriptors.PoolNO.name = "PoolNO"
type_descriptors.PoolNO.full_name = ".PoolNO"
type_descriptors.PoolNO.nested_types = {}
type_descriptors.PoolNO.enum_types = {}
type_descriptors.PoolNO.fields = {
	field_descriptors.PoolNO_code,
	field_descriptors.PoolNO_dailyRemain,
	field_descriptors.PoolNO_sRate,
	field_descriptors.PoolNO_upRates,
	field_descriptors.PoolNO_basicRates,
	field_descriptors.PoolNO_syntheticalRates,
	field_descriptors.PoolNO_picked,
	field_descriptors.PoolNO_guaranteeWish,
	field_descriptors.PoolNO_nextGuaranteeA,
	field_descriptors.PoolNO_guaranteeAbsolute,
	field_descriptors.PoolNO_nextGuaranteeS
}
type_descriptors.PoolNO.is_extendable = false
type_descriptors.PoolNO.extensions = {}
type_descriptors.GetLotteryLogRequest.name = "GetLotteryLogRequest"
type_descriptors.GetLotteryLogRequest.full_name = ".GetLotteryLogRequest"
type_descriptors.GetLotteryLogRequest.nested_types = {}
type_descriptors.GetLotteryLogRequest.enum_types = {}
type_descriptors.GetLotteryLogRequest.fields = {}
type_descriptors.GetLotteryLogRequest.is_extendable = false
type_descriptors.GetLotteryLogRequest.extensions = {}
field_descriptors.GetLotteryLogReply_logs.name = "logs"
field_descriptors.GetLotteryLogReply_logs.full_name = ".GetLotteryLogReply.logs"
field_descriptors.GetLotteryLogReply_logs.number = 1
field_descriptors.GetLotteryLogReply_logs.index = 0
field_descriptors.GetLotteryLogReply_logs.label = 3
field_descriptors.GetLotteryLogReply_logs.has_default_value = false
field_descriptors.GetLotteryLogReply_logs.default_value = {}
field_descriptors.GetLotteryLogReply_logs.message_type = type_descriptors.LotteryLogNO
field_descriptors.GetLotteryLogReply_logs.type = 11
field_descriptors.GetLotteryLogReply_logs.cpp_type = 10
type_descriptors.GetLotteryLogReply.name = "GetLotteryLogReply"
type_descriptors.GetLotteryLogReply.full_name = ".GetLotteryLogReply"
type_descriptors.GetLotteryLogReply.nested_types = {}
type_descriptors.GetLotteryLogReply.enum_types = {}
type_descriptors.GetLotteryLogReply.fields = {
	field_descriptors.GetLotteryLogReply_logs
}
type_descriptors.GetLotteryLogReply.is_extendable = false
type_descriptors.GetLotteryLogReply.extensions = {}
field_descriptors.PickLotteryItemRequest_pool.name = "pool"
field_descriptors.PickLotteryItemRequest_pool.full_name = ".PickLotteryItemRequest.pool"
field_descriptors.PickLotteryItemRequest_pool.number = 1
field_descriptors.PickLotteryItemRequest_pool.index = 0
field_descriptors.PickLotteryItemRequest_pool.label = 1
field_descriptors.PickLotteryItemRequest_pool.has_default_value = false
field_descriptors.PickLotteryItemRequest_pool.default_value = 0
field_descriptors.PickLotteryItemRequest_pool.type = 5
field_descriptors.PickLotteryItemRequest_pool.cpp_type = 1
field_descriptors.PickLotteryItemRequest_item.name = "item"
field_descriptors.PickLotteryItemRequest_item.full_name = ".PickLotteryItemRequest.item"
field_descriptors.PickLotteryItemRequest_item.number = 2
field_descriptors.PickLotteryItemRequest_item.index = 1
field_descriptors.PickLotteryItemRequest_item.label = 1
field_descriptors.PickLotteryItemRequest_item.has_default_value = false
field_descriptors.PickLotteryItemRequest_item.default_value = 0
field_descriptors.PickLotteryItemRequest_item.type = 5
field_descriptors.PickLotteryItemRequest_item.cpp_type = 1
type_descriptors.PickLotteryItemRequest.name = "PickLotteryItemRequest"
type_descriptors.PickLotteryItemRequest.full_name = ".PickLotteryItemRequest"
type_descriptors.PickLotteryItemRequest.nested_types = {}
type_descriptors.PickLotteryItemRequest.enum_types = {}
type_descriptors.PickLotteryItemRequest.fields = {
	field_descriptors.PickLotteryItemRequest_pool,
	field_descriptors.PickLotteryItemRequest_item
}
type_descriptors.PickLotteryItemRequest.is_extendable = false
type_descriptors.PickLotteryItemRequest.extensions = {}
field_descriptors.LotteryLogNO_itemCode.name = "itemCode"
field_descriptors.LotteryLogNO_itemCode.full_name = ".LotteryLogNO.itemCode"
field_descriptors.LotteryLogNO_itemCode.number = 1
field_descriptors.LotteryLogNO_itemCode.index = 0
field_descriptors.LotteryLogNO_itemCode.label = 1
field_descriptors.LotteryLogNO_itemCode.has_default_value = false
field_descriptors.LotteryLogNO_itemCode.default_value = 0
field_descriptors.LotteryLogNO_itemCode.type = 5
field_descriptors.LotteryLogNO_itemCode.cpp_type = 1
field_descriptors.LotteryLogNO_time.name = "time"
field_descriptors.LotteryLogNO_time.full_name = ".LotteryLogNO.time"
field_descriptors.LotteryLogNO_time.number = 2
field_descriptors.LotteryLogNO_time.index = 1
field_descriptors.LotteryLogNO_time.label = 1
field_descriptors.LotteryLogNO_time.has_default_value = false
field_descriptors.LotteryLogNO_time.default_value = 0
field_descriptors.LotteryLogNO_time.type = 3
field_descriptors.LotteryLogNO_time.cpp_type = 2
field_descriptors.LotteryLogNO_poolCode.name = "poolCode"
field_descriptors.LotteryLogNO_poolCode.full_name = ".LotteryLogNO.poolCode"
field_descriptors.LotteryLogNO_poolCode.number = 3
field_descriptors.LotteryLogNO_poolCode.index = 2
field_descriptors.LotteryLogNO_poolCode.label = 1
field_descriptors.LotteryLogNO_poolCode.has_default_value = false
field_descriptors.LotteryLogNO_poolCode.default_value = 0
field_descriptors.LotteryLogNO_poolCode.type = 5
field_descriptors.LotteryLogNO_poolCode.cpp_type = 1
type_descriptors.LotteryLogNO.name = "LotteryLogNO"
type_descriptors.LotteryLogNO.full_name = ".LotteryLogNO"
type_descriptors.LotteryLogNO.nested_types = {}
type_descriptors.LotteryLogNO.enum_types = {}
type_descriptors.LotteryLogNO.fields = {
	field_descriptors.LotteryLogNO_itemCode,
	field_descriptors.LotteryLogNO_time,
	field_descriptors.LotteryLogNO_poolCode
}
type_descriptors.LotteryLogNO.is_extendable = false
type_descriptors.LotteryLogNO.extensions = {}
field_descriptors.LotteryRequest_pool.name = "pool"
field_descriptors.LotteryRequest_pool.full_name = ".LotteryRequest.pool"
field_descriptors.LotteryRequest_pool.number = 1
field_descriptors.LotteryRequest_pool.index = 0
field_descriptors.LotteryRequest_pool.label = 1
field_descriptors.LotteryRequest_pool.has_default_value = false
field_descriptors.LotteryRequest_pool.default_value = 0
field_descriptors.LotteryRequest_pool.type = 5
field_descriptors.LotteryRequest_pool.cpp_type = 1
field_descriptors.LotteryRequest_num.name = "num"
field_descriptors.LotteryRequest_num.full_name = ".LotteryRequest.num"
field_descriptors.LotteryRequest_num.number = 2
field_descriptors.LotteryRequest_num.index = 1
field_descriptors.LotteryRequest_num.label = 1
field_descriptors.LotteryRequest_num.has_default_value = false
field_descriptors.LotteryRequest_num.default_value = 0
field_descriptors.LotteryRequest_num.type = 5
field_descriptors.LotteryRequest_num.cpp_type = 1
type_descriptors.LotteryRequest.name = "LotteryRequest"
type_descriptors.LotteryRequest.full_name = ".LotteryRequest"
type_descriptors.LotteryRequest.nested_types = {}
type_descriptors.LotteryRequest.enum_types = {}
type_descriptors.LotteryRequest.fields = {
	field_descriptors.LotteryRequest_pool,
	field_descriptors.LotteryRequest_num
}
type_descriptors.LotteryRequest.is_extendable = false
type_descriptors.LotteryRequest.extensions = {}
field_descriptors.LotteryReply_items.name = "items"
field_descriptors.LotteryReply_items.full_name = ".LotteryReply.items"
field_descriptors.LotteryReply_items.number = 1
field_descriptors.LotteryReply_items.index = 0
field_descriptors.LotteryReply_items.label = 3
field_descriptors.LotteryReply_items.has_default_value = false
field_descriptors.LotteryReply_items.default_value = {}
field_descriptors.LotteryReply_items.message_type = type_descriptors.LotteryItemNO
field_descriptors.LotteryReply_items.type = 11
field_descriptors.LotteryReply_items.cpp_type = 10
type_descriptors.LotteryReply.name = "LotteryReply"
type_descriptors.LotteryReply.full_name = ".LotteryReply"
type_descriptors.LotteryReply.nested_types = {}
type_descriptors.LotteryReply.enum_types = {}
type_descriptors.LotteryReply.fields = {
	field_descriptors.LotteryReply_items
}
type_descriptors.LotteryReply.is_extendable = false
type_descriptors.LotteryReply.extensions = {}
field_descriptors.ExtraItemNO_code.name = "code"
field_descriptors.ExtraItemNO_code.full_name = ".ExtraItemNO.code"
field_descriptors.ExtraItemNO_code.number = 1
field_descriptors.ExtraItemNO_code.index = 0
field_descriptors.ExtraItemNO_code.label = 1
field_descriptors.ExtraItemNO_code.has_default_value = false
field_descriptors.ExtraItemNO_code.default_value = 0
field_descriptors.ExtraItemNO_code.type = 5
field_descriptors.ExtraItemNO_code.cpp_type = 1
field_descriptors.ExtraItemNO_num.name = "num"
field_descriptors.ExtraItemNO_num.full_name = ".ExtraItemNO.num"
field_descriptors.ExtraItemNO_num.number = 2
field_descriptors.ExtraItemNO_num.index = 1
field_descriptors.ExtraItemNO_num.label = 1
field_descriptors.ExtraItemNO_num.has_default_value = false
field_descriptors.ExtraItemNO_num.default_value = 0
field_descriptors.ExtraItemNO_num.type = 5
field_descriptors.ExtraItemNO_num.cpp_type = 1
field_descriptors.ExtraItemNO_conversion.name = "conversion"
field_descriptors.ExtraItemNO_conversion.full_name = ".ExtraItemNO.conversion"
field_descriptors.ExtraItemNO_conversion.number = 3
field_descriptors.ExtraItemNO_conversion.index = 2
field_descriptors.ExtraItemNO_conversion.label = 1
field_descriptors.ExtraItemNO_conversion.has_default_value = false
field_descriptors.ExtraItemNO_conversion.default_value = false
field_descriptors.ExtraItemNO_conversion.type = 8
field_descriptors.ExtraItemNO_conversion.cpp_type = 7
type_descriptors.ExtraItemNO.name = "ExtraItemNO"
type_descriptors.ExtraItemNO.full_name = ".ExtraItemNO"
type_descriptors.ExtraItemNO.nested_types = {}
type_descriptors.ExtraItemNO.enum_types = {}
type_descriptors.ExtraItemNO.fields = {
	field_descriptors.ExtraItemNO_code,
	field_descriptors.ExtraItemNO_num,
	field_descriptors.ExtraItemNO_conversion
}
type_descriptors.ExtraItemNO.is_extendable = false
type_descriptors.ExtraItemNO.extensions = {}
LotteryFeature = {
	NEWBIE = 1,
	NORMAL = 0,
	WISH = 2
}
ExtraItemNO = protobuf.Message(type_descriptors.ExtraItemNO)
GetLotteryLogReply = protobuf.Message(type_descriptors.GetLotteryLogReply)
GetLotteryLogRequest = protobuf.Message(type_descriptors.GetLotteryLogRequest)
GetPoolInfoReply = protobuf.Message(type_descriptors.GetPoolInfoReply)
GetPoolInfoRequest = protobuf.Message(type_descriptors.GetPoolInfoRequest)
LotteryEchoReply = protobuf.Message(type_descriptors.LotteryEchoReply)
LotteryEchoRequest = protobuf.Message(type_descriptors.LotteryEchoRequest)
LotteryItemNO = protobuf.Message(type_descriptors.LotteryItemNO)
LotteryLogNO = protobuf.Message(type_descriptors.LotteryLogNO)
LotteryReply = protobuf.Message(type_descriptors.LotteryReply)
LotteryRequest = protobuf.Message(type_descriptors.LotteryRequest)
PickLotteryItemReply = protobuf.Message(type_descriptors.PickLotteryItemReply)
PickLotteryItemRequest = protobuf.Message(type_descriptors.PickLotteryItemRequest)
PoolNO = protobuf.Message(type_descriptors.PoolNO)

return _G["logic.proto.LotteryExtension_pb"]

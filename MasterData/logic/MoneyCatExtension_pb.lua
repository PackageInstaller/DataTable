-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/proto/MoneyCatExtension_pb.lua

local protobuf = require("protobuf.protobuf")

module("logic.proto.MoneyCatExtension_pb", package.seeall)

local tb = {}

MONEYCATINFOREQ_MSG = protobuf.Descriptor()
MONEYCATINFORES_MSG = protobuf.Descriptor()
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD = protobuf.FieldDescriptor()
tb.MONEYCATINFORES_TIMES_FIELD = protobuf.FieldDescriptor()
tb.MONEYCATINFORES_GAINNUM_FIELD = protobuf.FieldDescriptor()
MAKEMONEYREQ_MSG = protobuf.Descriptor()
tb.MAKEMONEYREQ_TIMES_FIELD = protobuf.FieldDescriptor()
MAKEMONEYRES_MSG = protobuf.Descriptor()
tb.MAKEMONEYRES_CHANGESETID_FIELD = protobuf.FieldDescriptor()
tb.MAKEMONEYRES_MULTIPLE_FIELD = protobuf.FieldDescriptor()
MONEYCATINFOREQ_MSG.name = "MoneyCatInfoReq"
MONEYCATINFOREQ_MSG.full_name = ".MoneyCatInfoReq"
MONEYCATINFOREQ_MSG.nested_types = {}
MONEYCATINFOREQ_MSG.enum_types = {}
MONEYCATINFOREQ_MSG.fields = {}
MONEYCATINFOREQ_MSG.is_extendable = false
MONEYCATINFOREQ_MSG.extensions = {}
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.name = "dailyFreeTimes"
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.full_name = ".MoneyCatInfoRes.dailyFreeTimes"
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.number = 1
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.index = 0
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.label = 2
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.has_default_value = false
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.default_value = 0
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.type = 5
tb.MONEYCATINFORES_DAILYFREETIMES_FIELD.cpp_type = 1
tb.MONEYCATINFORES_TIMES_FIELD.name = "times"
tb.MONEYCATINFORES_TIMES_FIELD.full_name = ".MoneyCatInfoRes.times"
tb.MONEYCATINFORES_TIMES_FIELD.number = 2
tb.MONEYCATINFORES_TIMES_FIELD.index = 1
tb.MONEYCATINFORES_TIMES_FIELD.label = 2
tb.MONEYCATINFORES_TIMES_FIELD.has_default_value = false
tb.MONEYCATINFORES_TIMES_FIELD.default_value = 0
tb.MONEYCATINFORES_TIMES_FIELD.type = 5
tb.MONEYCATINFORES_TIMES_FIELD.cpp_type = 1
tb.MONEYCATINFORES_GAINNUM_FIELD.name = "gainNum"
tb.MONEYCATINFORES_GAINNUM_FIELD.full_name = ".MoneyCatInfoRes.gainNum"
tb.MONEYCATINFORES_GAINNUM_FIELD.number = 3
tb.MONEYCATINFORES_GAINNUM_FIELD.index = 2
tb.MONEYCATINFORES_GAINNUM_FIELD.label = 2
tb.MONEYCATINFORES_GAINNUM_FIELD.has_default_value = false
tb.MONEYCATINFORES_GAINNUM_FIELD.default_value = 0
tb.MONEYCATINFORES_GAINNUM_FIELD.type = 5
tb.MONEYCATINFORES_GAINNUM_FIELD.cpp_type = 1
MONEYCATINFORES_MSG.name = "MoneyCatInfoRes"
MONEYCATINFORES_MSG.full_name = ".MoneyCatInfoRes"
MONEYCATINFORES_MSG.nested_types = {}
MONEYCATINFORES_MSG.enum_types = {}
MONEYCATINFORES_MSG.fields = {
	tb.MONEYCATINFORES_DAILYFREETIMES_FIELD,
	tb.MONEYCATINFORES_TIMES_FIELD,
	tb.MONEYCATINFORES_GAINNUM_FIELD
}
MONEYCATINFORES_MSG.is_extendable = false
MONEYCATINFORES_MSG.extensions = {}
tb.MAKEMONEYREQ_TIMES_FIELD.name = "times"
tb.MAKEMONEYREQ_TIMES_FIELD.full_name = ".MakeMoneyReq.times"
tb.MAKEMONEYREQ_TIMES_FIELD.number = 1
tb.MAKEMONEYREQ_TIMES_FIELD.index = 0
tb.MAKEMONEYREQ_TIMES_FIELD.label = 2
tb.MAKEMONEYREQ_TIMES_FIELD.has_default_value = false
tb.MAKEMONEYREQ_TIMES_FIELD.default_value = 0
tb.MAKEMONEYREQ_TIMES_FIELD.type = 5
tb.MAKEMONEYREQ_TIMES_FIELD.cpp_type = 1
MAKEMONEYREQ_MSG.name = "MakeMoneyReq"
MAKEMONEYREQ_MSG.full_name = ".MakeMoneyReq"
MAKEMONEYREQ_MSG.nested_types = {}
MAKEMONEYREQ_MSG.enum_types = {}
MAKEMONEYREQ_MSG.fields = {
	tb.MAKEMONEYREQ_TIMES_FIELD
}
MAKEMONEYREQ_MSG.is_extendable = false
MAKEMONEYREQ_MSG.extensions = {}
tb.MAKEMONEYRES_CHANGESETID_FIELD.name = "changeSetId"
tb.MAKEMONEYRES_CHANGESETID_FIELD.full_name = ".MakeMoneyRes.changeSetId"
tb.MAKEMONEYRES_CHANGESETID_FIELD.number = 1
tb.MAKEMONEYRES_CHANGESETID_FIELD.index = 0
tb.MAKEMONEYRES_CHANGESETID_FIELD.label = 2
tb.MAKEMONEYRES_CHANGESETID_FIELD.has_default_value = false
tb.MAKEMONEYRES_CHANGESETID_FIELD.default_value = 0
tb.MAKEMONEYRES_CHANGESETID_FIELD.type = 5
tb.MAKEMONEYRES_CHANGESETID_FIELD.cpp_type = 1
tb.MAKEMONEYRES_MULTIPLE_FIELD.name = "multiple"
tb.MAKEMONEYRES_MULTIPLE_FIELD.full_name = ".MakeMoneyRes.multiple"
tb.MAKEMONEYRES_MULTIPLE_FIELD.number = 2
tb.MAKEMONEYRES_MULTIPLE_FIELD.index = 1
tb.MAKEMONEYRES_MULTIPLE_FIELD.label = 3
tb.MAKEMONEYRES_MULTIPLE_FIELD.has_default_value = false
tb.MAKEMONEYRES_MULTIPLE_FIELD.default_value = {}
tb.MAKEMONEYRES_MULTIPLE_FIELD.type = 5
tb.MAKEMONEYRES_MULTIPLE_FIELD.cpp_type = 1
MAKEMONEYRES_MSG.name = "MakeMoneyRes"
MAKEMONEYRES_MSG.full_name = ".MakeMoneyRes"
MAKEMONEYRES_MSG.nested_types = {}
MAKEMONEYRES_MSG.enum_types = {}
MAKEMONEYRES_MSG.fields = {
	tb.MAKEMONEYRES_CHANGESETID_FIELD,
	tb.MAKEMONEYRES_MULTIPLE_FIELD
}
MAKEMONEYRES_MSG.is_extendable = false
MAKEMONEYRES_MSG.extensions = {}
MakeMoneyReq = protobuf.Message(MAKEMONEYREQ_MSG)
MakeMoneyRes = protobuf.Message(MAKEMONEYRES_MSG)
MoneyCatInfoReq = protobuf.Message(MONEYCATINFOREQ_MSG)
MoneyCatInfoRes = protobuf.Message(MONEYCATINFORES_MSG)

return _G["logic.proto.MoneyCatExtension_pb"]

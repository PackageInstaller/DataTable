-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/proto/StarTeamExtension_pb.lua

local protobuf = require("protobuf.protobuf")

module("logic.proto.StarTeamExtension_pb", package.seeall)

local tb = {}

ST_GETMYSTARTEAMINFOREQ_MSG = protobuf.Descriptor()
ST_GETMYSTARTEAMINFORES_MSG = protobuf.Descriptor()
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD = protobuf.FieldDescriptor()
ST_GAINPRIZEREQ_MSG = protobuf.Descriptor()
tb.ST_GAINPRIZEREQ_INDEX_FIELD = protobuf.FieldDescriptor()
ST_GAINPRIZERES_MSG = protobuf.Descriptor()
tb.ST_GAINPRIZERES_CHANGESETID_FIELD = protobuf.FieldDescriptor()
ST_GETMYSTARTEAMINFOREQ_MSG.name = "ST_GetMyStarTeamInfoReq"
ST_GETMYSTARTEAMINFOREQ_MSG.full_name = ".ST_GetMyStarTeamInfoReq"
ST_GETMYSTARTEAMINFOREQ_MSG.nested_types = {}
ST_GETMYSTARTEAMINFOREQ_MSG.enum_types = {}
ST_GETMYSTARTEAMINFOREQ_MSG.fields = {}
ST_GETMYSTARTEAMINFOREQ_MSG.is_extendable = false
ST_GETMYSTARTEAMINFOREQ_MSG.extensions = {}
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.name = "hasGain"
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.full_name = ".ST_GetMyStarTeamInfoRes.hasGain"
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.number = 1
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.index = 0
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.label = 3
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.has_default_value = false
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.default_value = {}
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.type = 8
tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD.cpp_type = 7
ST_GETMYSTARTEAMINFORES_MSG.name = "ST_GetMyStarTeamInfoRes"
ST_GETMYSTARTEAMINFORES_MSG.full_name = ".ST_GetMyStarTeamInfoRes"
ST_GETMYSTARTEAMINFORES_MSG.nested_types = {}
ST_GETMYSTARTEAMINFORES_MSG.enum_types = {}
ST_GETMYSTARTEAMINFORES_MSG.fields = {
	tb.ST_GETMYSTARTEAMINFORES_HASGAIN_FIELD
}
ST_GETMYSTARTEAMINFORES_MSG.is_extendable = false
ST_GETMYSTARTEAMINFORES_MSG.extensions = {}
tb.ST_GAINPRIZEREQ_INDEX_FIELD.name = "index"
tb.ST_GAINPRIZEREQ_INDEX_FIELD.full_name = ".ST_GainPrizeReq.index"
tb.ST_GAINPRIZEREQ_INDEX_FIELD.number = 1
tb.ST_GAINPRIZEREQ_INDEX_FIELD.index = 0
tb.ST_GAINPRIZEREQ_INDEX_FIELD.label = 2
tb.ST_GAINPRIZEREQ_INDEX_FIELD.has_default_value = false
tb.ST_GAINPRIZEREQ_INDEX_FIELD.default_value = 0
tb.ST_GAINPRIZEREQ_INDEX_FIELD.type = 5
tb.ST_GAINPRIZEREQ_INDEX_FIELD.cpp_type = 1
ST_GAINPRIZEREQ_MSG.name = "ST_GainPrizeReq"
ST_GAINPRIZEREQ_MSG.full_name = ".ST_GainPrizeReq"
ST_GAINPRIZEREQ_MSG.nested_types = {}
ST_GAINPRIZEREQ_MSG.enum_types = {}
ST_GAINPRIZEREQ_MSG.fields = {
	tb.ST_GAINPRIZEREQ_INDEX_FIELD
}
ST_GAINPRIZEREQ_MSG.is_extendable = false
ST_GAINPRIZEREQ_MSG.extensions = {}
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.name = "changeSetId"
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.full_name = ".ST_GainPrizeRes.changeSetId"
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.number = 1
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.index = 0
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.label = 2
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.has_default_value = false
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.default_value = 0
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.type = 5
tb.ST_GAINPRIZERES_CHANGESETID_FIELD.cpp_type = 1
ST_GAINPRIZERES_MSG.name = "ST_GainPrizeRes"
ST_GAINPRIZERES_MSG.full_name = ".ST_GainPrizeRes"
ST_GAINPRIZERES_MSG.nested_types = {}
ST_GAINPRIZERES_MSG.enum_types = {}
ST_GAINPRIZERES_MSG.fields = {
	tb.ST_GAINPRIZERES_CHANGESETID_FIELD
}
ST_GAINPRIZERES_MSG.is_extendable = false
ST_GAINPRIZERES_MSG.extensions = {}
ST_GainPrizeReq = protobuf.Message(ST_GAINPRIZEREQ_MSG)
ST_GainPrizeRes = protobuf.Message(ST_GAINPRIZERES_MSG)
ST_GetMyStarTeamInfoReq = protobuf.Message(ST_GETMYSTARTEAMINFOREQ_MSG)
ST_GetMyStarTeamInfoRes = protobuf.Message(ST_GETMYSTARTEAMINFORES_MSG)

return _G["logic.proto.StarTeamExtension_pb"]

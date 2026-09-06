-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/proto/LongYanXiXiSkinExtension_pb.lua

local protobuf = require("protobuf.protobuf")

module("logic.proto.LongYanXiXiSkinExtension_pb", package.seeall)

local tb = {}

PM_LONGYANXIXISKINGAINRES_MSG = protobuf.Descriptor()
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD = protobuf.FieldDescriptor()
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.name = "changeSetId"
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.full_name = ".PM_LongYanXiXiSkinGainRes.changeSetId"
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.number = 1
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.index = 0
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.label = 2
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.has_default_value = false
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.default_value = 0
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.type = 5
tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD.cpp_type = 1
PM_LONGYANXIXISKINGAINRES_MSG.name = "PM_LongYanXiXiSkinGainRes"
PM_LONGYANXIXISKINGAINRES_MSG.full_name = ".PM_LongYanXiXiSkinGainRes"
PM_LONGYANXIXISKINGAINRES_MSG.nested_types = {}
PM_LONGYANXIXISKINGAINRES_MSG.enum_types = {}
PM_LONGYANXIXISKINGAINRES_MSG.fields = {
	tb.PM_LONGYANXIXISKINGAINRES_CHANGESETID_FIELD
}
PM_LONGYANXIXISKINGAINRES_MSG.is_extendable = false
PM_LONGYANXIXISKINGAINRES_MSG.extensions = {}
PM_LongYanXiXiSkinGainRes = protobuf.Message(PM_LONGYANXIXISKINGAINRES_MSG)

return _G["logic.proto.LongYanXiXiSkinExtension_pb"]

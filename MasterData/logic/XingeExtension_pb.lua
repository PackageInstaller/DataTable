-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/proto/XingeExtension_pb.lua

local protobuf = require("protobuf.protobuf")

module("logic.proto.XingeExtension_pb", package.seeall)

local tb = {}

PM_UNBINDTOKENREQ_MSG = protobuf.Descriptor()
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD = protobuf.FieldDescriptor()
PM_UNBINDTOKENRES_MSG = protobuf.Descriptor()
PM_PUSHTOKENREQ_MSG = protobuf.Descriptor()
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD = protobuf.FieldDescriptor()
tb.PM_PUSHTOKENREQ_TOKEN_FIELD = protobuf.FieldDescriptor()
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD = protobuf.FieldDescriptor()
PM_PUSHTOKENRES_MSG = protobuf.Descriptor()
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.name = "token"
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.full_name = ".PM_UnBindTokenReq.token"
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.number = 1
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.index = 0
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.label = 2
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.has_default_value = false
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.default_value = ""
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.type = 9
tb.PM_UNBINDTOKENREQ_TOKEN_FIELD.cpp_type = 9
PM_UNBINDTOKENREQ_MSG.name = "PM_UnBindTokenReq"
PM_UNBINDTOKENREQ_MSG.full_name = ".PM_UnBindTokenReq"
PM_UNBINDTOKENREQ_MSG.nested_types = {}
PM_UNBINDTOKENREQ_MSG.enum_types = {}
PM_UNBINDTOKENREQ_MSG.fields = {
	tb.PM_UNBINDTOKENREQ_TOKEN_FIELD
}
PM_UNBINDTOKENREQ_MSG.is_extendable = false
PM_UNBINDTOKENREQ_MSG.extensions = {}
PM_UNBINDTOKENRES_MSG.name = "PM_UnBindTokenRes"
PM_UNBINDTOKENRES_MSG.full_name = ".PM_UnBindTokenRes"
PM_UNBINDTOKENRES_MSG.nested_types = {}
PM_UNBINDTOKENRES_MSG.enum_types = {}
PM_UNBINDTOKENRES_MSG.fields = {}
PM_UNBINDTOKENRES_MSG.is_extendable = false
PM_UNBINDTOKENRES_MSG.extensions = {}
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.name = "templateId"
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.full_name = ".PM_PushTokenReq.templateId"
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.number = 1
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.index = 0
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.label = 2
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.has_default_value = false
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.default_value = 0
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.type = 5
tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD.cpp_type = 1
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.name = "token"
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.full_name = ".PM_PushTokenReq.token"
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.number = 2
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.index = 1
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.label = 2
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.has_default_value = false
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.default_value = ""
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.type = 9
tb.PM_PUSHTOKENREQ_TOKEN_FIELD.cpp_type = 9
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.name = "sendTime"
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.full_name = ".PM_PushTokenReq.sendTime"
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.number = 3
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.index = 2
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.label = 2
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.has_default_value = false
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.default_value = 0
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.type = 3
tb.PM_PUSHTOKENREQ_SENDTIME_FIELD.cpp_type = 2
PM_PUSHTOKENREQ_MSG.name = "PM_PushTokenReq"
PM_PUSHTOKENREQ_MSG.full_name = ".PM_PushTokenReq"
PM_PUSHTOKENREQ_MSG.nested_types = {}
PM_PUSHTOKENREQ_MSG.enum_types = {}
PM_PUSHTOKENREQ_MSG.fields = {
	tb.PM_PUSHTOKENREQ_TEMPLATEID_FIELD,
	tb.PM_PUSHTOKENREQ_TOKEN_FIELD,
	tb.PM_PUSHTOKENREQ_SENDTIME_FIELD
}
PM_PUSHTOKENREQ_MSG.is_extendable = false
PM_PUSHTOKENREQ_MSG.extensions = {}
PM_PUSHTOKENRES_MSG.name = "PM_PushTokenRes"
PM_PUSHTOKENRES_MSG.full_name = ".PM_PushTokenRes"
PM_PUSHTOKENRES_MSG.nested_types = {}
PM_PUSHTOKENRES_MSG.enum_types = {}
PM_PUSHTOKENRES_MSG.fields = {}
PM_PUSHTOKENRES_MSG.is_extendable = false
PM_PUSHTOKENRES_MSG.extensions = {}
PM_PushTokenReq = protobuf.Message(PM_PUSHTOKENREQ_MSG)
PM_PushTokenRes = protobuf.Message(PM_PUSHTOKENRES_MSG)
PM_UnBindTokenReq = protobuf.Message(PM_UNBINDTOKENREQ_MSG)
PM_UnBindTokenRes = protobuf.Message(PM_UNBINDTOKENRES_MSG)

return _G["logic.proto.XingeExtension_pb"]

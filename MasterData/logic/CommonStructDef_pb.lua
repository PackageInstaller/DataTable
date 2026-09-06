-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/proto/CommonStructDef_pb.lua

local protobuf = require("protobuf.protobuf")

module("logic.proto.CommonStructDef_pb", package.seeall)

local tb = {}

PM_PAIRINT_MSG = protobuf.Descriptor()
tb.PM_PAIRINT_LEFT_FIELD = protobuf.FieldDescriptor()
tb.PM_PAIRINT_RIGHT_FIELD = protobuf.FieldDescriptor()
PM_TRIPLEINT_MSG = protobuf.Descriptor()
tb.PM_TRIPLEINT_LEFT_FIELD = protobuf.FieldDescriptor()
tb.PM_TRIPLEINT_MID_FIELD = protobuf.FieldDescriptor()
tb.PM_TRIPLEINT_RIGHT_FIELD = protobuf.FieldDescriptor()
PM_LISTINT_MSG = protobuf.Descriptor()
tb.PM_LISTINT_LIST_FIELD = protobuf.FieldDescriptor()
PM_THIRDPARTYRESULT_MSG = protobuf.Descriptor()
tb.PM_THIRDPARTYRESULT_CODE_FIELD = protobuf.FieldDescriptor()
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD = protobuf.FieldDescriptor()
tb.PM_PAIRINT_LEFT_FIELD.name = "left"
tb.PM_PAIRINT_LEFT_FIELD.full_name = ".PM_PairInt.left"
tb.PM_PAIRINT_LEFT_FIELD.number = 1
tb.PM_PAIRINT_LEFT_FIELD.index = 0
tb.PM_PAIRINT_LEFT_FIELD.label = 2
tb.PM_PAIRINT_LEFT_FIELD.has_default_value = false
tb.PM_PAIRINT_LEFT_FIELD.default_value = 0
tb.PM_PAIRINT_LEFT_FIELD.type = 5
tb.PM_PAIRINT_LEFT_FIELD.cpp_type = 1
tb.PM_PAIRINT_RIGHT_FIELD.name = "right"
tb.PM_PAIRINT_RIGHT_FIELD.full_name = ".PM_PairInt.right"
tb.PM_PAIRINT_RIGHT_FIELD.number = 2
tb.PM_PAIRINT_RIGHT_FIELD.index = 1
tb.PM_PAIRINT_RIGHT_FIELD.label = 2
tb.PM_PAIRINT_RIGHT_FIELD.has_default_value = false
tb.PM_PAIRINT_RIGHT_FIELD.default_value = 0
tb.PM_PAIRINT_RIGHT_FIELD.type = 5
tb.PM_PAIRINT_RIGHT_FIELD.cpp_type = 1
PM_PAIRINT_MSG.name = "PM_PairInt"
PM_PAIRINT_MSG.full_name = ".PM_PairInt"
PM_PAIRINT_MSG.nested_types = {}
PM_PAIRINT_MSG.enum_types = {}
PM_PAIRINT_MSG.fields = {
	tb.PM_PAIRINT_LEFT_FIELD,
	tb.PM_PAIRINT_RIGHT_FIELD
}
PM_PAIRINT_MSG.is_extendable = false
PM_PAIRINT_MSG.extensions = {}
tb.PM_TRIPLEINT_LEFT_FIELD.name = "left"
tb.PM_TRIPLEINT_LEFT_FIELD.full_name = ".PM_TripleInt.left"
tb.PM_TRIPLEINT_LEFT_FIELD.number = 1
tb.PM_TRIPLEINT_LEFT_FIELD.index = 0
tb.PM_TRIPLEINT_LEFT_FIELD.label = 2
tb.PM_TRIPLEINT_LEFT_FIELD.has_default_value = false
tb.PM_TRIPLEINT_LEFT_FIELD.default_value = 0
tb.PM_TRIPLEINT_LEFT_FIELD.type = 5
tb.PM_TRIPLEINT_LEFT_FIELD.cpp_type = 1
tb.PM_TRIPLEINT_MID_FIELD.name = "mid"
tb.PM_TRIPLEINT_MID_FIELD.full_name = ".PM_TripleInt.mid"
tb.PM_TRIPLEINT_MID_FIELD.number = 2
tb.PM_TRIPLEINT_MID_FIELD.index = 1
tb.PM_TRIPLEINT_MID_FIELD.label = 2
tb.PM_TRIPLEINT_MID_FIELD.has_default_value = false
tb.PM_TRIPLEINT_MID_FIELD.default_value = 0
tb.PM_TRIPLEINT_MID_FIELD.type = 5
tb.PM_TRIPLEINT_MID_FIELD.cpp_type = 1
tb.PM_TRIPLEINT_RIGHT_FIELD.name = "right"
tb.PM_TRIPLEINT_RIGHT_FIELD.full_name = ".PM_TripleInt.right"
tb.PM_TRIPLEINT_RIGHT_FIELD.number = 3
tb.PM_TRIPLEINT_RIGHT_FIELD.index = 2
tb.PM_TRIPLEINT_RIGHT_FIELD.label = 2
tb.PM_TRIPLEINT_RIGHT_FIELD.has_default_value = false
tb.PM_TRIPLEINT_RIGHT_FIELD.default_value = 0
tb.PM_TRIPLEINT_RIGHT_FIELD.type = 5
tb.PM_TRIPLEINT_RIGHT_FIELD.cpp_type = 1
PM_TRIPLEINT_MSG.name = "PM_TripleInt"
PM_TRIPLEINT_MSG.full_name = ".PM_TripleInt"
PM_TRIPLEINT_MSG.nested_types = {}
PM_TRIPLEINT_MSG.enum_types = {}
PM_TRIPLEINT_MSG.fields = {
	tb.PM_TRIPLEINT_LEFT_FIELD,
	tb.PM_TRIPLEINT_MID_FIELD,
	tb.PM_TRIPLEINT_RIGHT_FIELD
}
PM_TRIPLEINT_MSG.is_extendable = false
PM_TRIPLEINT_MSG.extensions = {}
tb.PM_LISTINT_LIST_FIELD.name = "list"
tb.PM_LISTINT_LIST_FIELD.full_name = ".PM_ListInt.list"
tb.PM_LISTINT_LIST_FIELD.number = 1
tb.PM_LISTINT_LIST_FIELD.index = 0
tb.PM_LISTINT_LIST_FIELD.label = 3
tb.PM_LISTINT_LIST_FIELD.has_default_value = false
tb.PM_LISTINT_LIST_FIELD.default_value = {}
tb.PM_LISTINT_LIST_FIELD.type = 5
tb.PM_LISTINT_LIST_FIELD.cpp_type = 1
PM_LISTINT_MSG.name = "PM_ListInt"
PM_LISTINT_MSG.full_name = ".PM_ListInt"
PM_LISTINT_MSG.nested_types = {}
PM_LISTINT_MSG.enum_types = {}
PM_LISTINT_MSG.fields = {
	tb.PM_LISTINT_LIST_FIELD
}
PM_LISTINT_MSG.is_extendable = false
PM_LISTINT_MSG.extensions = {}
tb.PM_THIRDPARTYRESULT_CODE_FIELD.name = "code"
tb.PM_THIRDPARTYRESULT_CODE_FIELD.full_name = ".PM_ThirdPartyResult.code"
tb.PM_THIRDPARTYRESULT_CODE_FIELD.number = 1
tb.PM_THIRDPARTYRESULT_CODE_FIELD.index = 0
tb.PM_THIRDPARTYRESULT_CODE_FIELD.label = 2
tb.PM_THIRDPARTYRESULT_CODE_FIELD.has_default_value = false
tb.PM_THIRDPARTYRESULT_CODE_FIELD.default_value = 0
tb.PM_THIRDPARTYRESULT_CODE_FIELD.type = 5
tb.PM_THIRDPARTYRESULT_CODE_FIELD.cpp_type = 1
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.name = "message"
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.full_name = ".PM_ThirdPartyResult.message"
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.number = 2
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.index = 1
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.label = 2
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.has_default_value = false
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.default_value = ""
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.type = 9
tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD.cpp_type = 9
PM_THIRDPARTYRESULT_MSG.name = "PM_ThirdPartyResult"
PM_THIRDPARTYRESULT_MSG.full_name = ".PM_ThirdPartyResult"
PM_THIRDPARTYRESULT_MSG.nested_types = {}
PM_THIRDPARTYRESULT_MSG.enum_types = {}
PM_THIRDPARTYRESULT_MSG.fields = {
	tb.PM_THIRDPARTYRESULT_CODE_FIELD,
	tb.PM_THIRDPARTYRESULT_MESSAGE_FIELD
}
PM_THIRDPARTYRESULT_MSG.is_extendable = false
PM_THIRDPARTYRESULT_MSG.extensions = {}
PM_ListInt = protobuf.Message(PM_LISTINT_MSG)
PM_PairInt = protobuf.Message(PM_PAIRINT_MSG)
PM_ThirdPartyResult = protobuf.Message(PM_THIRDPARTYRESULT_MSG)
PM_TripleInt = protobuf.Message(PM_TRIPLEINT_MSG)

return _G["logic.proto.CommonStructDef_pb"]

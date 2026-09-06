-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/proto/SuitDef_pb.lua

local protobuf = require("protobuf.protobuf")

module("logic.proto.SuitDef_pb", package.seeall)

local tb = {}

PM_SUITGROUPINFO_MSG = protobuf.Descriptor()
tb.PM_SUITGROUPINFO_GROUPID_FIELD = protobuf.FieldDescriptor()
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD = protobuf.FieldDescriptor()
PM_SUITINFO_MSG = protobuf.Descriptor()
tb.PM_SUITINFO_SUITID_FIELD = protobuf.FieldDescriptor()
tb.PM_SUITINFO_SUITNAME_FIELD = protobuf.FieldDescriptor()
tb.PM_SUITINFO_GROUPID_FIELD = protobuf.FieldDescriptor()
tb.PM_SUITINFO_WEARITEMIDS_FIELD = protobuf.FieldDescriptor()
tb.PM_SUITGROUPINFO_GROUPID_FIELD.name = "groupId"
tb.PM_SUITGROUPINFO_GROUPID_FIELD.full_name = ".PM_SuitGroupInfo.groupId"
tb.PM_SUITGROUPINFO_GROUPID_FIELD.number = 1
tb.PM_SUITGROUPINFO_GROUPID_FIELD.index = 0
tb.PM_SUITGROUPINFO_GROUPID_FIELD.label = 2
tb.PM_SUITGROUPINFO_GROUPID_FIELD.has_default_value = false
tb.PM_SUITGROUPINFO_GROUPID_FIELD.default_value = 0
tb.PM_SUITGROUPINFO_GROUPID_FIELD.type = 5
tb.PM_SUITGROUPINFO_GROUPID_FIELD.cpp_type = 1
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.name = "groupName"
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.full_name = ".PM_SuitGroupInfo.groupName"
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.number = 2
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.index = 1
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.label = 2
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.has_default_value = false
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.default_value = ""
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.type = 9
tb.PM_SUITGROUPINFO_GROUPNAME_FIELD.cpp_type = 9
PM_SUITGROUPINFO_MSG.name = "PM_SuitGroupInfo"
PM_SUITGROUPINFO_MSG.full_name = ".PM_SuitGroupInfo"
PM_SUITGROUPINFO_MSG.nested_types = {}
PM_SUITGROUPINFO_MSG.enum_types = {}
PM_SUITGROUPINFO_MSG.fields = {
	tb.PM_SUITGROUPINFO_GROUPID_FIELD,
	tb.PM_SUITGROUPINFO_GROUPNAME_FIELD
}
PM_SUITGROUPINFO_MSG.is_extendable = false
PM_SUITGROUPINFO_MSG.extensions = {}
tb.PM_SUITINFO_SUITID_FIELD.name = "suitId"
tb.PM_SUITINFO_SUITID_FIELD.full_name = ".PM_SuitInfo.suitId"
tb.PM_SUITINFO_SUITID_FIELD.number = 1
tb.PM_SUITINFO_SUITID_FIELD.index = 0
tb.PM_SUITINFO_SUITID_FIELD.label = 2
tb.PM_SUITINFO_SUITID_FIELD.has_default_value = false
tb.PM_SUITINFO_SUITID_FIELD.default_value = 0
tb.PM_SUITINFO_SUITID_FIELD.type = 5
tb.PM_SUITINFO_SUITID_FIELD.cpp_type = 1
tb.PM_SUITINFO_SUITNAME_FIELD.name = "suitName"
tb.PM_SUITINFO_SUITNAME_FIELD.full_name = ".PM_SuitInfo.suitName"
tb.PM_SUITINFO_SUITNAME_FIELD.number = 2
tb.PM_SUITINFO_SUITNAME_FIELD.index = 1
tb.PM_SUITINFO_SUITNAME_FIELD.label = 2
tb.PM_SUITINFO_SUITNAME_FIELD.has_default_value = false
tb.PM_SUITINFO_SUITNAME_FIELD.default_value = ""
tb.PM_SUITINFO_SUITNAME_FIELD.type = 9
tb.PM_SUITINFO_SUITNAME_FIELD.cpp_type = 9
tb.PM_SUITINFO_GROUPID_FIELD.name = "groupId"
tb.PM_SUITINFO_GROUPID_FIELD.full_name = ".PM_SuitInfo.groupId"
tb.PM_SUITINFO_GROUPID_FIELD.number = 3
tb.PM_SUITINFO_GROUPID_FIELD.index = 2
tb.PM_SUITINFO_GROUPID_FIELD.label = 2
tb.PM_SUITINFO_GROUPID_FIELD.has_default_value = false
tb.PM_SUITINFO_GROUPID_FIELD.default_value = 0
tb.PM_SUITINFO_GROUPID_FIELD.type = 5
tb.PM_SUITINFO_GROUPID_FIELD.cpp_type = 1
tb.PM_SUITINFO_WEARITEMIDS_FIELD.name = "wearItemIds"
tb.PM_SUITINFO_WEARITEMIDS_FIELD.full_name = ".PM_SuitInfo.wearItemIds"
tb.PM_SUITINFO_WEARITEMIDS_FIELD.number = 4
tb.PM_SUITINFO_WEARITEMIDS_FIELD.index = 3
tb.PM_SUITINFO_WEARITEMIDS_FIELD.label = 3
tb.PM_SUITINFO_WEARITEMIDS_FIELD.has_default_value = false
tb.PM_SUITINFO_WEARITEMIDS_FIELD.default_value = {}
tb.PM_SUITINFO_WEARITEMIDS_FIELD.type = 5
tb.PM_SUITINFO_WEARITEMIDS_FIELD.cpp_type = 1
PM_SUITINFO_MSG.name = "PM_SuitInfo"
PM_SUITINFO_MSG.full_name = ".PM_SuitInfo"
PM_SUITINFO_MSG.nested_types = {}
PM_SUITINFO_MSG.enum_types = {}
PM_SUITINFO_MSG.fields = {
	tb.PM_SUITINFO_SUITID_FIELD,
	tb.PM_SUITINFO_SUITNAME_FIELD,
	tb.PM_SUITINFO_GROUPID_FIELD,
	tb.PM_SUITINFO_WEARITEMIDS_FIELD
}
PM_SUITINFO_MSG.is_extendable = false
PM_SUITINFO_MSG.extensions = {}
PM_SuitGroupInfo = protobuf.Message(PM_SUITGROUPINFO_MSG)
PM_SuitInfo = protobuf.Message(PM_SUITINFO_MSG)

return _G["logic.proto.SuitDef_pb"]

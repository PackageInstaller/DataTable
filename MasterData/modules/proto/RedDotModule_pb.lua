-- chunkname: @modules/proto/RedDotModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.RedDotModule_pb", package.seeall)

local RedDotModule_pb = {}

RedDotModule_pb.REDDOTINFO_MSG = protobuf.Descriptor()
RedDotModule_pb.REDDOTINFOIDFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTINFOVALUEFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTINFOTIMEFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTINFOEXTFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.SHOWREDDOTREPLY_MSG = protobuf.Descriptor()
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG = protobuf.Descriptor()
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.SHOWREDDOTREQUEST_MSG = protobuf.Descriptor()
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG = protobuf.Descriptor()
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTGROUP_MSG = protobuf.Descriptor()
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTGROUPINFOSFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.UPDATEREDDOTPUSH_MSG = protobuf.Descriptor()
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD = protobuf.FieldDescriptor()
RedDotModule_pb.REDDOTINFOIDFIELD.name = "id"
RedDotModule_pb.REDDOTINFOIDFIELD.full_name = ".RedDotInfo.id"
RedDotModule_pb.REDDOTINFOIDFIELD.number = 1
RedDotModule_pb.REDDOTINFOIDFIELD.index = 0
RedDotModule_pb.REDDOTINFOIDFIELD.label = 2
RedDotModule_pb.REDDOTINFOIDFIELD.has_default_value = false
RedDotModule_pb.REDDOTINFOIDFIELD.default_value = 0
RedDotModule_pb.REDDOTINFOIDFIELD.type = 3
RedDotModule_pb.REDDOTINFOIDFIELD.cpp_type = 2
RedDotModule_pb.REDDOTINFOVALUEFIELD.name = "value"
RedDotModule_pb.REDDOTINFOVALUEFIELD.full_name = ".RedDotInfo.value"
RedDotModule_pb.REDDOTINFOVALUEFIELD.number = 2
RedDotModule_pb.REDDOTINFOVALUEFIELD.index = 1
RedDotModule_pb.REDDOTINFOVALUEFIELD.label = 2
RedDotModule_pb.REDDOTINFOVALUEFIELD.has_default_value = false
RedDotModule_pb.REDDOTINFOVALUEFIELD.default_value = 0
RedDotModule_pb.REDDOTINFOVALUEFIELD.type = 5
RedDotModule_pb.REDDOTINFOVALUEFIELD.cpp_type = 1
RedDotModule_pb.REDDOTINFOTIMEFIELD.name = "time"
RedDotModule_pb.REDDOTINFOTIMEFIELD.full_name = ".RedDotInfo.time"
RedDotModule_pb.REDDOTINFOTIMEFIELD.number = 3
RedDotModule_pb.REDDOTINFOTIMEFIELD.index = 2
RedDotModule_pb.REDDOTINFOTIMEFIELD.label = 1
RedDotModule_pb.REDDOTINFOTIMEFIELD.has_default_value = false
RedDotModule_pb.REDDOTINFOTIMEFIELD.default_value = 0
RedDotModule_pb.REDDOTINFOTIMEFIELD.type = 5
RedDotModule_pb.REDDOTINFOTIMEFIELD.cpp_type = 1
RedDotModule_pb.REDDOTINFOEXTFIELD.name = "ext"
RedDotModule_pb.REDDOTINFOEXTFIELD.full_name = ".RedDotInfo.ext"
RedDotModule_pb.REDDOTINFOEXTFIELD.number = 4
RedDotModule_pb.REDDOTINFOEXTFIELD.index = 3
RedDotModule_pb.REDDOTINFOEXTFIELD.label = 1
RedDotModule_pb.REDDOTINFOEXTFIELD.has_default_value = false
RedDotModule_pb.REDDOTINFOEXTFIELD.default_value = ""
RedDotModule_pb.REDDOTINFOEXTFIELD.type = 9
RedDotModule_pb.REDDOTINFOEXTFIELD.cpp_type = 9
RedDotModule_pb.REDDOTINFO_MSG.name = "RedDotInfo"
RedDotModule_pb.REDDOTINFO_MSG.full_name = ".RedDotInfo"
RedDotModule_pb.REDDOTINFO_MSG.nested_types = {}
RedDotModule_pb.REDDOTINFO_MSG.enum_types = {}
RedDotModule_pb.REDDOTINFO_MSG.fields = {
	RedDotModule_pb.REDDOTINFOIDFIELD,
	RedDotModule_pb.REDDOTINFOVALUEFIELD,
	RedDotModule_pb.REDDOTINFOTIMEFIELD,
	RedDotModule_pb.REDDOTINFOEXTFIELD
}
RedDotModule_pb.REDDOTINFO_MSG.is_extendable = false
RedDotModule_pb.REDDOTINFO_MSG.extensions = {}
RedDotModule_pb.SHOWREDDOTREPLY_MSG.name = "ShowRedDotReply"
RedDotModule_pb.SHOWREDDOTREPLY_MSG.full_name = ".ShowRedDotReply"
RedDotModule_pb.SHOWREDDOTREPLY_MSG.nested_types = {}
RedDotModule_pb.SHOWREDDOTREPLY_MSG.enum_types = {}
RedDotModule_pb.SHOWREDDOTREPLY_MSG.fields = {}
RedDotModule_pb.SHOWREDDOTREPLY_MSG.is_extendable = false
RedDotModule_pb.SHOWREDDOTREPLY_MSG.extensions = {}
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.name = "ids"
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.full_name = ".GetRedDotInfosRequest.ids"
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.number = 1
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.index = 0
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.label = 3
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.has_default_value = false
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.default_value = {}
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.type = 5
RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD.cpp_type = 1
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.name = "GetRedDotInfosRequest"
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.full_name = ".GetRedDotInfosRequest"
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.nested_types = {}
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.enum_types = {}
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.fields = {
	RedDotModule_pb.GETREDDOTINFOSREQUESTIDSFIELD
}
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.is_extendable = false
RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG.extensions = {}
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.name = "defineId"
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.full_name = ".ShowRedDotRequest.defineId"
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.number = 1
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.index = 0
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.label = 1
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.has_default_value = false
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.default_value = 0
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.type = 5
RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD.cpp_type = 1
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.name = "isVisible"
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.full_name = ".ShowRedDotRequest.isVisible"
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.number = 2
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.index = 1
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.label = 1
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.has_default_value = false
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.default_value = false
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.type = 8
RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD.cpp_type = 7
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.name = "ShowRedDotRequest"
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.full_name = ".ShowRedDotRequest"
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.nested_types = {}
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.enum_types = {}
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.fields = {
	RedDotModule_pb.SHOWREDDOTREQUESTDEFINEIDFIELD,
	RedDotModule_pb.SHOWREDDOTREQUESTISVISIBLEFIELD
}
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.is_extendable = false
RedDotModule_pb.SHOWREDDOTREQUEST_MSG.extensions = {}
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.name = "redDotInfos"
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.full_name = ".GetRedDotInfosReply.redDotInfos"
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.number = 1
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.index = 0
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.label = 3
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.has_default_value = false
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.default_value = {}
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.message_type = RedDotModule_pb.REDDOTGROUP_MSG
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.type = 11
RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.cpp_type = 10
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.name = "GetRedDotInfosReply"
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.full_name = ".GetRedDotInfosReply"
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.nested_types = {}
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.enum_types = {}
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.fields = {
	RedDotModule_pb.GETREDDOTINFOSREPLYREDDOTINFOSFIELD
}
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.is_extendable = false
RedDotModule_pb.GETREDDOTINFOSREPLY_MSG.extensions = {}
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.name = "defineId"
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.full_name = ".RedDotGroup.defineId"
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.number = 1
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.index = 0
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.label = 2
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.has_default_value = false
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.default_value = 0
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.type = 5
RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD.cpp_type = 1
RedDotModule_pb.REDDOTGROUPINFOSFIELD.name = "infos"
RedDotModule_pb.REDDOTGROUPINFOSFIELD.full_name = ".RedDotGroup.infos"
RedDotModule_pb.REDDOTGROUPINFOSFIELD.number = 2
RedDotModule_pb.REDDOTGROUPINFOSFIELD.index = 1
RedDotModule_pb.REDDOTGROUPINFOSFIELD.label = 3
RedDotModule_pb.REDDOTGROUPINFOSFIELD.has_default_value = false
RedDotModule_pb.REDDOTGROUPINFOSFIELD.default_value = {}
RedDotModule_pb.REDDOTGROUPINFOSFIELD.message_type = RedDotModule_pb.REDDOTINFO_MSG
RedDotModule_pb.REDDOTGROUPINFOSFIELD.type = 11
RedDotModule_pb.REDDOTGROUPINFOSFIELD.cpp_type = 10
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.name = "replaceAll"
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.full_name = ".RedDotGroup.replaceAll"
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.number = 3
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.index = 2
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.label = 1
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.has_default_value = false
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.default_value = false
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.type = 8
RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD.cpp_type = 7
RedDotModule_pb.REDDOTGROUP_MSG.name = "RedDotGroup"
RedDotModule_pb.REDDOTGROUP_MSG.full_name = ".RedDotGroup"
RedDotModule_pb.REDDOTGROUP_MSG.nested_types = {}
RedDotModule_pb.REDDOTGROUP_MSG.enum_types = {}
RedDotModule_pb.REDDOTGROUP_MSG.fields = {
	RedDotModule_pb.REDDOTGROUPDEFINEIDFIELD,
	RedDotModule_pb.REDDOTGROUPINFOSFIELD,
	RedDotModule_pb.REDDOTGROUPREPLACEALLFIELD
}
RedDotModule_pb.REDDOTGROUP_MSG.is_extendable = false
RedDotModule_pb.REDDOTGROUP_MSG.extensions = {}
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.name = "redDotInfos"
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.full_name = ".UpdateRedDotPush.redDotInfos"
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.number = 1
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.index = 0
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.label = 3
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.has_default_value = false
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.default_value = {}
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.message_type = RedDotModule_pb.REDDOTGROUP_MSG
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.type = 11
RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD.cpp_type = 10
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.name = "replaceAll"
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.full_name = ".UpdateRedDotPush.replaceAll"
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.number = 2
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.index = 1
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.label = 1
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.has_default_value = false
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.default_value = false
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.type = 8
RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD.cpp_type = 7
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.name = "UpdateRedDotPush"
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.full_name = ".UpdateRedDotPush"
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.nested_types = {}
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.enum_types = {}
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.fields = {
	RedDotModule_pb.UPDATEREDDOTPUSHREDDOTINFOSFIELD,
	RedDotModule_pb.UPDATEREDDOTPUSHREPLACEALLFIELD
}
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.is_extendable = false
RedDotModule_pb.UPDATEREDDOTPUSH_MSG.extensions = {}
RedDotModule_pb.GetRedDotInfosReply = protobuf.Message(RedDotModule_pb.GETREDDOTINFOSREPLY_MSG)
RedDotModule_pb.GetRedDotInfosRequest = protobuf.Message(RedDotModule_pb.GETREDDOTINFOSREQUEST_MSG)
RedDotModule_pb.RedDotGroup = protobuf.Message(RedDotModule_pb.REDDOTGROUP_MSG)
RedDotModule_pb.RedDotInfo = protobuf.Message(RedDotModule_pb.REDDOTINFO_MSG)
RedDotModule_pb.ShowRedDotReply = protobuf.Message(RedDotModule_pb.SHOWREDDOTREPLY_MSG)
RedDotModule_pb.ShowRedDotRequest = protobuf.Message(RedDotModule_pb.SHOWREDDOTREQUEST_MSG)
RedDotModule_pb.UpdateRedDotPush = protobuf.Message(RedDotModule_pb.UPDATEREDDOTPUSH_MSG)

return RedDotModule_pb

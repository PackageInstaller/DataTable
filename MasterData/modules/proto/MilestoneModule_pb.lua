-- chunkname: @modules/proto/MilestoneModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.MilestoneModule_pb", package.seeall)

local MilestoneModule_pb = {}

MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG = protobuf.Descriptor()
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG = protobuf.Descriptor()
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.MILESTONEINFO_MSG = protobuf.Descriptor()
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG = protobuf.Descriptor()
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG = protobuf.Descriptor()
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD = protobuf.FieldDescriptor()
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.name = "milestoneIds"
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.full_name = ".GetMilestoneInfoRequest.milestoneIds"
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.number = 1
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.index = 0
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.label = 3
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.has_default_value = false
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.default_value = {}
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.type = 5
MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD.cpp_type = 1
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.name = "GetMilestoneInfoRequest"
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.full_name = ".GetMilestoneInfoRequest"
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.nested_types = {}
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.enum_types = {}
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.fields = {
	MilestoneModule_pb.GETMILESTONEINFOREQUESTMILESTONEIDSFIELD
}
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.is_extendable = false
MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG.extensions = {}
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.name = "milestoneId"
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.full_name = ".GetMilestoneBonusReply.milestoneId"
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.number = 1
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.index = 0
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.label = 1
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.has_default_value = false
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.default_value = 0
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.type = 5
MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD.cpp_type = 1
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.name = "getBonusId"
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.full_name = ".GetMilestoneBonusReply.getBonusId"
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.number = 2
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.index = 1
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.label = 1
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.has_default_value = false
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.default_value = 0
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.type = 5
MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD.cpp_type = 1
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.name = "GetMilestoneBonusReply"
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.full_name = ".GetMilestoneBonusReply"
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.nested_types = {}
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.enum_types = {}
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.fields = {
	MilestoneModule_pb.GETMILESTONEBONUSREPLYMILESTONEIDFIELD,
	MilestoneModule_pb.GETMILESTONEBONUSREPLYGETBONUSIDFIELD
}
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.is_extendable = false
MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG.extensions = {}
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.name = "milestoneId"
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.full_name = ".MilestoneInfo.milestoneId"
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.number = 1
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.index = 0
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.label = 1
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.has_default_value = false
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.default_value = 0
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.type = 5
MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD.cpp_type = 1
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.name = "getBonusId"
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.full_name = ".MilestoneInfo.getBonusId"
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.number = 2
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.index = 1
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.label = 1
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.has_default_value = false
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.default_value = 0
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.type = 5
MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD.cpp_type = 1
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.name = "progress"
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.full_name = ".MilestoneInfo.progress"
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.number = 3
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.index = 2
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.label = 1
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.has_default_value = false
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.default_value = 0
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.type = 5
MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD.cpp_type = 1
MilestoneModule_pb.MILESTONEINFO_MSG.name = "MilestoneInfo"
MilestoneModule_pb.MILESTONEINFO_MSG.full_name = ".MilestoneInfo"
MilestoneModule_pb.MILESTONEINFO_MSG.nested_types = {}
MilestoneModule_pb.MILESTONEINFO_MSG.enum_types = {}
MilestoneModule_pb.MILESTONEINFO_MSG.fields = {
	MilestoneModule_pb.MILESTONEINFOMILESTONEIDFIELD,
	MilestoneModule_pb.MILESTONEINFOGETBONUSIDFIELD,
	MilestoneModule_pb.MILESTONEINFOPROGRESSFIELD
}
MilestoneModule_pb.MILESTONEINFO_MSG.is_extendable = false
MilestoneModule_pb.MILESTONEINFO_MSG.extensions = {}
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.name = "milestoneInfos"
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.full_name = ".GetMilestoneInfoReply.milestoneInfos"
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.number = 1
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.index = 0
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.label = 3
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.has_default_value = false
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.default_value = {}
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.message_type = MilestoneModule_pb.MILESTONEINFO_MSG
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.type = 11
MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD.cpp_type = 10
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.name = "GetMilestoneInfoReply"
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.full_name = ".GetMilestoneInfoReply"
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.nested_types = {}
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.enum_types = {}
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.fields = {
	MilestoneModule_pb.GETMILESTONEINFOREPLYMILESTONEINFOSFIELD
}
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.is_extendable = false
MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG.extensions = {}
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.name = "milestoneId"
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.full_name = ".GetMilestoneBonusRequest.milestoneId"
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.number = 1
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.index = 0
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.label = 1
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.has_default_value = false
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.default_value = 0
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.type = 5
MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD.cpp_type = 1
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.name = "GetMilestoneBonusRequest"
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.full_name = ".GetMilestoneBonusRequest"
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.nested_types = {}
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.enum_types = {}
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.fields = {
	MilestoneModule_pb.GETMILESTONEBONUSREQUESTMILESTONEIDFIELD
}
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.is_extendable = false
MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG.extensions = {}
MilestoneModule_pb.GetMilestoneBonusReply = protobuf.Message(MilestoneModule_pb.GETMILESTONEBONUSREPLY_MSG)
MilestoneModule_pb.GetMilestoneBonusRequest = protobuf.Message(MilestoneModule_pb.GETMILESTONEBONUSREQUEST_MSG)
MilestoneModule_pb.GetMilestoneInfoReply = protobuf.Message(MilestoneModule_pb.GETMILESTONEINFOREPLY_MSG)
MilestoneModule_pb.GetMilestoneInfoRequest = protobuf.Message(MilestoneModule_pb.GETMILESTONEINFOREQUEST_MSG)
MilestoneModule_pb.MilestoneInfo = protobuf.Message(MilestoneModule_pb.MILESTONEINFO_MSG)

return MilestoneModule_pb

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/ThinkingExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.ThinkingExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.UnlockThinkingReply = protobuf.Descriptor()
type_descriptors.GetHeroThinkingRequest = protobuf.Descriptor()
type_descriptors.ThinkingSkillUpgradeRequest = protobuf.Descriptor()
field_descriptors.ThinkingSkillUpgradeRequest_id = protobuf.FieldDescriptor()
field_descriptors.ThinkingSkillUpgradeRequest_skill = protobuf.FieldDescriptor()
type_descriptors.GetHeroThinkingReply = protobuf.Descriptor()
field_descriptors.GetHeroThinkingReply_infos = protobuf.FieldDescriptor()
type_descriptors.ChangeThinkingPush = protobuf.Descriptor()
field_descriptors.ChangeThinkingPush_infos = protobuf.FieldDescriptor()
type_descriptors.ChangeThinkingWearInfoPush = protobuf.Descriptor()
field_descriptors.ChangeThinkingWearInfoPush_infos = protobuf.FieldDescriptor()
type_descriptors.ThinkingSkillUpgradeReply = protobuf.Descriptor()
type_descriptors.ThinkingNO = protobuf.Descriptor()
field_descriptors.ThinkingNO_id = protobuf.FieldDescriptor()
field_descriptors.ThinkingNO_skills = protobuf.FieldDescriptor()
type_descriptors.WearThinkingRequest = protobuf.Descriptor()
field_descriptors.WearThinkingRequest_hero = protobuf.FieldDescriptor()
field_descriptors.WearThinkingRequest_thinking = protobuf.FieldDescriptor()
field_descriptors.WearThinkingRequest_skill = protobuf.FieldDescriptor()
type_descriptors.WearInfoNO = protobuf.Descriptor()
field_descriptors.WearInfoNO_hero = protobuf.FieldDescriptor()
field_descriptors.WearInfoNO_thinking = protobuf.FieldDescriptor()
field_descriptors.WearInfoNO_skill = protobuf.FieldDescriptor()
field_descriptors.WearInfoNO_unlocked = protobuf.FieldDescriptor()
type_descriptors.UnlockThinkingRequest = protobuf.Descriptor()
field_descriptors.UnlockThinkingRequest_hero = protobuf.FieldDescriptor()
field_descriptors.UnlockThinkingRequest_id = protobuf.FieldDescriptor()
type_descriptors.GetAllThinkingRequest = protobuf.Descriptor()
type_descriptors.WearThinkingReply = protobuf.Descriptor()
type_descriptors.ThinkingSkillNO = protobuf.Descriptor()
field_descriptors.ThinkingSkillNO_id = protobuf.FieldDescriptor()
field_descriptors.ThinkingSkillNO_level = protobuf.FieldDescriptor()
type_descriptors.GetAllThinkingReply = protobuf.Descriptor()
field_descriptors.GetAllThinkingReply_infos = protobuf.FieldDescriptor()
type_descriptors.UnlockThinkingReply.name = "UnlockThinkingReply"
type_descriptors.UnlockThinkingReply.full_name = ".UnlockThinkingReply"
type_descriptors.UnlockThinkingReply.nested_types = {}
type_descriptors.UnlockThinkingReply.enum_types = {}
type_descriptors.UnlockThinkingReply.fields = {}
type_descriptors.UnlockThinkingReply.is_extendable = false
type_descriptors.UnlockThinkingReply.extensions = {}
type_descriptors.GetHeroThinkingRequest.name = "GetHeroThinkingRequest"
type_descriptors.GetHeroThinkingRequest.full_name = ".GetHeroThinkingRequest"
type_descriptors.GetHeroThinkingRequest.nested_types = {}
type_descriptors.GetHeroThinkingRequest.enum_types = {}
type_descriptors.GetHeroThinkingRequest.fields = {}
type_descriptors.GetHeroThinkingRequest.is_extendable = false
type_descriptors.GetHeroThinkingRequest.extensions = {}
field_descriptors.ThinkingSkillUpgradeRequest_id.name = "id"
field_descriptors.ThinkingSkillUpgradeRequest_id.full_name = ".ThinkingSkillUpgradeRequest.id"
field_descriptors.ThinkingSkillUpgradeRequest_id.number = 1
field_descriptors.ThinkingSkillUpgradeRequest_id.index = 0
field_descriptors.ThinkingSkillUpgradeRequest_id.label = 1
field_descriptors.ThinkingSkillUpgradeRequest_id.has_default_value = false
field_descriptors.ThinkingSkillUpgradeRequest_id.default_value = 0
field_descriptors.ThinkingSkillUpgradeRequest_id.type = 5
field_descriptors.ThinkingSkillUpgradeRequest_id.cpp_type = 1
field_descriptors.ThinkingSkillUpgradeRequest_skill.name = "skill"
field_descriptors.ThinkingSkillUpgradeRequest_skill.full_name = ".ThinkingSkillUpgradeRequest.skill"
field_descriptors.ThinkingSkillUpgradeRequest_skill.number = 2
field_descriptors.ThinkingSkillUpgradeRequest_skill.index = 1
field_descriptors.ThinkingSkillUpgradeRequest_skill.label = 1
field_descriptors.ThinkingSkillUpgradeRequest_skill.has_default_value = false
field_descriptors.ThinkingSkillUpgradeRequest_skill.default_value = 0
field_descriptors.ThinkingSkillUpgradeRequest_skill.type = 5
field_descriptors.ThinkingSkillUpgradeRequest_skill.cpp_type = 1
type_descriptors.ThinkingSkillUpgradeRequest.name = "ThinkingSkillUpgradeRequest"
type_descriptors.ThinkingSkillUpgradeRequest.full_name = ".ThinkingSkillUpgradeRequest"
type_descriptors.ThinkingSkillUpgradeRequest.nested_types = {}
type_descriptors.ThinkingSkillUpgradeRequest.enum_types = {}
type_descriptors.ThinkingSkillUpgradeRequest.fields = {
	field_descriptors.ThinkingSkillUpgradeRequest_id,
	field_descriptors.ThinkingSkillUpgradeRequest_skill
}
type_descriptors.ThinkingSkillUpgradeRequest.is_extendable = false
type_descriptors.ThinkingSkillUpgradeRequest.extensions = {}
field_descriptors.GetHeroThinkingReply_infos.name = "infos"
field_descriptors.GetHeroThinkingReply_infos.full_name = ".GetHeroThinkingReply.infos"
field_descriptors.GetHeroThinkingReply_infos.number = 1
field_descriptors.GetHeroThinkingReply_infos.index = 0
field_descriptors.GetHeroThinkingReply_infos.label = 3
field_descriptors.GetHeroThinkingReply_infos.has_default_value = false
field_descriptors.GetHeroThinkingReply_infos.default_value = {}
field_descriptors.GetHeroThinkingReply_infos.message_type = type_descriptors.WearInfoNO
field_descriptors.GetHeroThinkingReply_infos.type = 11
field_descriptors.GetHeroThinkingReply_infos.cpp_type = 10
type_descriptors.GetHeroThinkingReply.name = "GetHeroThinkingReply"
type_descriptors.GetHeroThinkingReply.full_name = ".GetHeroThinkingReply"
type_descriptors.GetHeroThinkingReply.nested_types = {}
type_descriptors.GetHeroThinkingReply.enum_types = {}
type_descriptors.GetHeroThinkingReply.fields = {
	field_descriptors.GetHeroThinkingReply_infos
}
type_descriptors.GetHeroThinkingReply.is_extendable = false
type_descriptors.GetHeroThinkingReply.extensions = {}
field_descriptors.ChangeThinkingPush_infos.name = "infos"
field_descriptors.ChangeThinkingPush_infos.full_name = ".ChangeThinkingPush.infos"
field_descriptors.ChangeThinkingPush_infos.number = 1
field_descriptors.ChangeThinkingPush_infos.index = 0
field_descriptors.ChangeThinkingPush_infos.label = 3
field_descriptors.ChangeThinkingPush_infos.has_default_value = false
field_descriptors.ChangeThinkingPush_infos.default_value = {}
field_descriptors.ChangeThinkingPush_infos.message_type = type_descriptors.ThinkingNO
field_descriptors.ChangeThinkingPush_infos.type = 11
field_descriptors.ChangeThinkingPush_infos.cpp_type = 10
type_descriptors.ChangeThinkingPush.name = "ChangeThinkingPush"
type_descriptors.ChangeThinkingPush.full_name = ".ChangeThinkingPush"
type_descriptors.ChangeThinkingPush.nested_types = {}
type_descriptors.ChangeThinkingPush.enum_types = {}
type_descriptors.ChangeThinkingPush.fields = {
	field_descriptors.ChangeThinkingPush_infos
}
type_descriptors.ChangeThinkingPush.is_extendable = false
type_descriptors.ChangeThinkingPush.extensions = {}
field_descriptors.ChangeThinkingWearInfoPush_infos.name = "infos"
field_descriptors.ChangeThinkingWearInfoPush_infos.full_name = ".ChangeThinkingWearInfoPush.infos"
field_descriptors.ChangeThinkingWearInfoPush_infos.number = 1
field_descriptors.ChangeThinkingWearInfoPush_infos.index = 0
field_descriptors.ChangeThinkingWearInfoPush_infos.label = 3
field_descriptors.ChangeThinkingWearInfoPush_infos.has_default_value = false
field_descriptors.ChangeThinkingWearInfoPush_infos.default_value = {}
field_descriptors.ChangeThinkingWearInfoPush_infos.message_type = type_descriptors.WearInfoNO
field_descriptors.ChangeThinkingWearInfoPush_infos.type = 11
field_descriptors.ChangeThinkingWearInfoPush_infos.cpp_type = 10
type_descriptors.ChangeThinkingWearInfoPush.name = "ChangeThinkingWearInfoPush"
type_descriptors.ChangeThinkingWearInfoPush.full_name = ".ChangeThinkingWearInfoPush"
type_descriptors.ChangeThinkingWearInfoPush.nested_types = {}
type_descriptors.ChangeThinkingWearInfoPush.enum_types = {}
type_descriptors.ChangeThinkingWearInfoPush.fields = {
	field_descriptors.ChangeThinkingWearInfoPush_infos
}
type_descriptors.ChangeThinkingWearInfoPush.is_extendable = false
type_descriptors.ChangeThinkingWearInfoPush.extensions = {}
type_descriptors.ThinkingSkillUpgradeReply.name = "ThinkingSkillUpgradeReply"
type_descriptors.ThinkingSkillUpgradeReply.full_name = ".ThinkingSkillUpgradeReply"
type_descriptors.ThinkingSkillUpgradeReply.nested_types = {}
type_descriptors.ThinkingSkillUpgradeReply.enum_types = {}
type_descriptors.ThinkingSkillUpgradeReply.fields = {}
type_descriptors.ThinkingSkillUpgradeReply.is_extendable = false
type_descriptors.ThinkingSkillUpgradeReply.extensions = {}
field_descriptors.ThinkingNO_id.name = "id"
field_descriptors.ThinkingNO_id.full_name = ".ThinkingNO.id"
field_descriptors.ThinkingNO_id.number = 1
field_descriptors.ThinkingNO_id.index = 0
field_descriptors.ThinkingNO_id.label = 1
field_descriptors.ThinkingNO_id.has_default_value = false
field_descriptors.ThinkingNO_id.default_value = 0
field_descriptors.ThinkingNO_id.type = 5
field_descriptors.ThinkingNO_id.cpp_type = 1
field_descriptors.ThinkingNO_skills.name = "skills"
field_descriptors.ThinkingNO_skills.full_name = ".ThinkingNO.skills"
field_descriptors.ThinkingNO_skills.number = 4
field_descriptors.ThinkingNO_skills.index = 1
field_descriptors.ThinkingNO_skills.label = 3
field_descriptors.ThinkingNO_skills.has_default_value = false
field_descriptors.ThinkingNO_skills.default_value = {}
field_descriptors.ThinkingNO_skills.message_type = type_descriptors.ThinkingSkillNO
field_descriptors.ThinkingNO_skills.type = 11
field_descriptors.ThinkingNO_skills.cpp_type = 10
type_descriptors.ThinkingNO.name = "ThinkingNO"
type_descriptors.ThinkingNO.full_name = ".ThinkingNO"
type_descriptors.ThinkingNO.nested_types = {}
type_descriptors.ThinkingNO.enum_types = {}
type_descriptors.ThinkingNO.fields = {
	field_descriptors.ThinkingNO_id,
	field_descriptors.ThinkingNO_skills
}
type_descriptors.ThinkingNO.is_extendable = false
type_descriptors.ThinkingNO.extensions = {}
field_descriptors.WearThinkingRequest_hero.name = "hero"
field_descriptors.WearThinkingRequest_hero.full_name = ".WearThinkingRequest.hero"
field_descriptors.WearThinkingRequest_hero.number = 1
field_descriptors.WearThinkingRequest_hero.index = 0
field_descriptors.WearThinkingRequest_hero.label = 1
field_descriptors.WearThinkingRequest_hero.has_default_value = false
field_descriptors.WearThinkingRequest_hero.default_value = 0
field_descriptors.WearThinkingRequest_hero.type = 5
field_descriptors.WearThinkingRequest_hero.cpp_type = 1
field_descriptors.WearThinkingRequest_thinking.name = "thinking"
field_descriptors.WearThinkingRequest_thinking.full_name = ".WearThinkingRequest.thinking"
field_descriptors.WearThinkingRequest_thinking.number = 2
field_descriptors.WearThinkingRequest_thinking.index = 1
field_descriptors.WearThinkingRequest_thinking.label = 1
field_descriptors.WearThinkingRequest_thinking.has_default_value = false
field_descriptors.WearThinkingRequest_thinking.default_value = 0
field_descriptors.WearThinkingRequest_thinking.type = 5
field_descriptors.WearThinkingRequest_thinking.cpp_type = 1
field_descriptors.WearThinkingRequest_skill.name = "skill"
field_descriptors.WearThinkingRequest_skill.full_name = ".WearThinkingRequest.skill"
field_descriptors.WearThinkingRequest_skill.number = 3
field_descriptors.WearThinkingRequest_skill.index = 2
field_descriptors.WearThinkingRequest_skill.label = 1
field_descriptors.WearThinkingRequest_skill.has_default_value = false
field_descriptors.WearThinkingRequest_skill.default_value = 0
field_descriptors.WearThinkingRequest_skill.type = 5
field_descriptors.WearThinkingRequest_skill.cpp_type = 1
type_descriptors.WearThinkingRequest.name = "WearThinkingRequest"
type_descriptors.WearThinkingRequest.full_name = ".WearThinkingRequest"
type_descriptors.WearThinkingRequest.nested_types = {}
type_descriptors.WearThinkingRequest.enum_types = {}
type_descriptors.WearThinkingRequest.fields = {
	field_descriptors.WearThinkingRequest_hero,
	field_descriptors.WearThinkingRequest_thinking,
	field_descriptors.WearThinkingRequest_skill
}
type_descriptors.WearThinkingRequest.is_extendable = false
type_descriptors.WearThinkingRequest.extensions = {}
field_descriptors.WearInfoNO_hero.name = "hero"
field_descriptors.WearInfoNO_hero.full_name = ".WearInfoNO.hero"
field_descriptors.WearInfoNO_hero.number = 1
field_descriptors.WearInfoNO_hero.index = 0
field_descriptors.WearInfoNO_hero.label = 1
field_descriptors.WearInfoNO_hero.has_default_value = false
field_descriptors.WearInfoNO_hero.default_value = 0
field_descriptors.WearInfoNO_hero.type = 5
field_descriptors.WearInfoNO_hero.cpp_type = 1
field_descriptors.WearInfoNO_thinking.name = "thinking"
field_descriptors.WearInfoNO_thinking.full_name = ".WearInfoNO.thinking"
field_descriptors.WearInfoNO_thinking.number = 2
field_descriptors.WearInfoNO_thinking.index = 1
field_descriptors.WearInfoNO_thinking.label = 1
field_descriptors.WearInfoNO_thinking.has_default_value = false
field_descriptors.WearInfoNO_thinking.default_value = 0
field_descriptors.WearInfoNO_thinking.type = 5
field_descriptors.WearInfoNO_thinking.cpp_type = 1
field_descriptors.WearInfoNO_skill.name = "skill"
field_descriptors.WearInfoNO_skill.full_name = ".WearInfoNO.skill"
field_descriptors.WearInfoNO_skill.number = 3
field_descriptors.WearInfoNO_skill.index = 2
field_descriptors.WearInfoNO_skill.label = 1
field_descriptors.WearInfoNO_skill.has_default_value = false
field_descriptors.WearInfoNO_skill.default_value = 0
field_descriptors.WearInfoNO_skill.type = 5
field_descriptors.WearInfoNO_skill.cpp_type = 1
field_descriptors.WearInfoNO_unlocked.name = "unlocked"
field_descriptors.WearInfoNO_unlocked.full_name = ".WearInfoNO.unlocked"
field_descriptors.WearInfoNO_unlocked.number = 4
field_descriptors.WearInfoNO_unlocked.index = 3
field_descriptors.WearInfoNO_unlocked.label = 3
field_descriptors.WearInfoNO_unlocked.has_default_value = false
field_descriptors.WearInfoNO_unlocked.default_value = {}
field_descriptors.WearInfoNO_unlocked.type = 5
field_descriptors.WearInfoNO_unlocked.cpp_type = 1
type_descriptors.WearInfoNO.name = "WearInfoNO"
type_descriptors.WearInfoNO.full_name = ".WearInfoNO"
type_descriptors.WearInfoNO.nested_types = {}
type_descriptors.WearInfoNO.enum_types = {}
type_descriptors.WearInfoNO.fields = {
	field_descriptors.WearInfoNO_hero,
	field_descriptors.WearInfoNO_thinking,
	field_descriptors.WearInfoNO_skill,
	field_descriptors.WearInfoNO_unlocked
}
type_descriptors.WearInfoNO.is_extendable = false
type_descriptors.WearInfoNO.extensions = {}
field_descriptors.UnlockThinkingRequest_hero.name = "hero"
field_descriptors.UnlockThinkingRequest_hero.full_name = ".UnlockThinkingRequest.hero"
field_descriptors.UnlockThinkingRequest_hero.number = 1
field_descriptors.UnlockThinkingRequest_hero.index = 0
field_descriptors.UnlockThinkingRequest_hero.label = 1
field_descriptors.UnlockThinkingRequest_hero.has_default_value = false
field_descriptors.UnlockThinkingRequest_hero.default_value = 0
field_descriptors.UnlockThinkingRequest_hero.type = 5
field_descriptors.UnlockThinkingRequest_hero.cpp_type = 1
field_descriptors.UnlockThinkingRequest_id.name = "id"
field_descriptors.UnlockThinkingRequest_id.full_name = ".UnlockThinkingRequest.id"
field_descriptors.UnlockThinkingRequest_id.number = 2
field_descriptors.UnlockThinkingRequest_id.index = 1
field_descriptors.UnlockThinkingRequest_id.label = 1
field_descriptors.UnlockThinkingRequest_id.has_default_value = false
field_descriptors.UnlockThinkingRequest_id.default_value = 0
field_descriptors.UnlockThinkingRequest_id.type = 5
field_descriptors.UnlockThinkingRequest_id.cpp_type = 1
type_descriptors.UnlockThinkingRequest.name = "UnlockThinkingRequest"
type_descriptors.UnlockThinkingRequest.full_name = ".UnlockThinkingRequest"
type_descriptors.UnlockThinkingRequest.nested_types = {}
type_descriptors.UnlockThinkingRequest.enum_types = {}
type_descriptors.UnlockThinkingRequest.fields = {
	field_descriptors.UnlockThinkingRequest_hero,
	field_descriptors.UnlockThinkingRequest_id
}
type_descriptors.UnlockThinkingRequest.is_extendable = false
type_descriptors.UnlockThinkingRequest.extensions = {}
type_descriptors.GetAllThinkingRequest.name = "GetAllThinkingRequest"
type_descriptors.GetAllThinkingRequest.full_name = ".GetAllThinkingRequest"
type_descriptors.GetAllThinkingRequest.nested_types = {}
type_descriptors.GetAllThinkingRequest.enum_types = {}
type_descriptors.GetAllThinkingRequest.fields = {}
type_descriptors.GetAllThinkingRequest.is_extendable = false
type_descriptors.GetAllThinkingRequest.extensions = {}
type_descriptors.WearThinkingReply.name = "WearThinkingReply"
type_descriptors.WearThinkingReply.full_name = ".WearThinkingReply"
type_descriptors.WearThinkingReply.nested_types = {}
type_descriptors.WearThinkingReply.enum_types = {}
type_descriptors.WearThinkingReply.fields = {}
type_descriptors.WearThinkingReply.is_extendable = false
type_descriptors.WearThinkingReply.extensions = {}
field_descriptors.ThinkingSkillNO_id.name = "id"
field_descriptors.ThinkingSkillNO_id.full_name = ".ThinkingSkillNO.id"
field_descriptors.ThinkingSkillNO_id.number = 1
field_descriptors.ThinkingSkillNO_id.index = 0
field_descriptors.ThinkingSkillNO_id.label = 1
field_descriptors.ThinkingSkillNO_id.has_default_value = false
field_descriptors.ThinkingSkillNO_id.default_value = 0
field_descriptors.ThinkingSkillNO_id.type = 5
field_descriptors.ThinkingSkillNO_id.cpp_type = 1
field_descriptors.ThinkingSkillNO_level.name = "level"
field_descriptors.ThinkingSkillNO_level.full_name = ".ThinkingSkillNO.level"
field_descriptors.ThinkingSkillNO_level.number = 2
field_descriptors.ThinkingSkillNO_level.index = 1
field_descriptors.ThinkingSkillNO_level.label = 1
field_descriptors.ThinkingSkillNO_level.has_default_value = false
field_descriptors.ThinkingSkillNO_level.default_value = 0
field_descriptors.ThinkingSkillNO_level.type = 5
field_descriptors.ThinkingSkillNO_level.cpp_type = 1
type_descriptors.ThinkingSkillNO.name = "ThinkingSkillNO"
type_descriptors.ThinkingSkillNO.full_name = ".ThinkingSkillNO"
type_descriptors.ThinkingSkillNO.nested_types = {}
type_descriptors.ThinkingSkillNO.enum_types = {}
type_descriptors.ThinkingSkillNO.fields = {
	field_descriptors.ThinkingSkillNO_id,
	field_descriptors.ThinkingSkillNO_level
}
type_descriptors.ThinkingSkillNO.is_extendable = false
type_descriptors.ThinkingSkillNO.extensions = {}
field_descriptors.GetAllThinkingReply_infos.name = "infos"
field_descriptors.GetAllThinkingReply_infos.full_name = ".GetAllThinkingReply.infos"
field_descriptors.GetAllThinkingReply_infos.number = 1
field_descriptors.GetAllThinkingReply_infos.index = 0
field_descriptors.GetAllThinkingReply_infos.label = 3
field_descriptors.GetAllThinkingReply_infos.has_default_value = false
field_descriptors.GetAllThinkingReply_infos.default_value = {}
field_descriptors.GetAllThinkingReply_infos.message_type = type_descriptors.ThinkingNO
field_descriptors.GetAllThinkingReply_infos.type = 11
field_descriptors.GetAllThinkingReply_infos.cpp_type = 10
type_descriptors.GetAllThinkingReply.name = "GetAllThinkingReply"
type_descriptors.GetAllThinkingReply.full_name = ".GetAllThinkingReply"
type_descriptors.GetAllThinkingReply.nested_types = {}
type_descriptors.GetAllThinkingReply.enum_types = {}
type_descriptors.GetAllThinkingReply.fields = {
	field_descriptors.GetAllThinkingReply_infos
}
type_descriptors.GetAllThinkingReply.is_extendable = false
type_descriptors.GetAllThinkingReply.extensions = {}
ChangeThinkingPush = protobuf.Message(type_descriptors.ChangeThinkingPush)
ChangeThinkingWearInfoPush = protobuf.Message(type_descriptors.ChangeThinkingWearInfoPush)
GetAllThinkingReply = protobuf.Message(type_descriptors.GetAllThinkingReply)
GetAllThinkingRequest = protobuf.Message(type_descriptors.GetAllThinkingRequest)
GetHeroThinkingReply = protobuf.Message(type_descriptors.GetHeroThinkingReply)
GetHeroThinkingRequest = protobuf.Message(type_descriptors.GetHeroThinkingRequest)
ThinkingNO = protobuf.Message(type_descriptors.ThinkingNO)
ThinkingSkillNO = protobuf.Message(type_descriptors.ThinkingSkillNO)
ThinkingSkillUpgradeReply = protobuf.Message(type_descriptors.ThinkingSkillUpgradeReply)
ThinkingSkillUpgradeRequest = protobuf.Message(type_descriptors.ThinkingSkillUpgradeRequest)
UnlockThinkingReply = protobuf.Message(type_descriptors.UnlockThinkingReply)
UnlockThinkingRequest = protobuf.Message(type_descriptors.UnlockThinkingRequest)
WearInfoNO = protobuf.Message(type_descriptors.WearInfoNO)
WearThinkingReply = protobuf.Message(type_descriptors.WearThinkingReply)
WearThinkingRequest = protobuf.Message(type_descriptors.WearThinkingRequest)

return _G["logic.proto.ThinkingExtension_pb"]

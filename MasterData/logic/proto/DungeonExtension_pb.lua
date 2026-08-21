-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/DungeonExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.BattleExtension = require("logic.proto.BattleExtension_pb")
dependencies.BackpackExtension = require("logic.proto.BackpackExtension_pb")

module("logic.proto.DungeonExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.DungeonType = protobuf.EnumDescriptor()
enum_item_descriptors.DungeonType_MAINLINE = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_TACIT = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_MATERIAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_PROLOGUE = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_TRAINING = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_EQUIPMENT = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_GOLD = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_EXP = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_LIGHT_TOWER = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_DARK_TOWER = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_BRANCHLINE = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_CONTROL_ACTION = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_CONTROL_ACTION_GUIDE = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_HERO_EARLY_ACCESS = protobuf.EnumValueDescriptor()
enum_item_descriptors.DungeonType_POWER_CHALLENGE = protobuf.EnumValueDescriptor()
type_descriptors.BattleTeamType = protobuf.EnumDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MAINLINE = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1001 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1002 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1003 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1004 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1005 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1006 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1007 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1008 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2001 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2002 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2003 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2004 = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_CONTROL_ACTION = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_LIGHT_TOWER = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_DARK_TOWER = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleTeamType_TEAM_AIR = protobuf.EnumValueDescriptor()
type_descriptors.EndingDungeonStatHeroNO = protobuf.Descriptor()
field_descriptors.EndingDungeonStatHeroNO_code = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonStatHeroNO_hpDecrement = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonStatHeroNO_enemyKilled = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonStatHeroNO_phyDamage = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonStatHeroNO_magDamage = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonStatHeroNO_cured = protobuf.FieldDescriptor()
type_descriptors.FinishPostwarPlotRequest = protobuf.Descriptor()
type_descriptors.ViewVideoRequest = protobuf.Descriptor()
field_descriptors.ViewVideoRequest_videoId = protobuf.FieldDescriptor()
field_descriptors.ViewVideoRequest_skipped = protobuf.FieldDescriptor()
field_descriptors.ViewVideoRequest_time = protobuf.FieldDescriptor()
type_descriptors.TakeMainlineStarRewardRequest = protobuf.Descriptor()
field_descriptors.TakeMainlineStarRewardRequest_chapter = protobuf.FieldDescriptor()
field_descriptors.TakeMainlineStarRewardRequest_difficulty = protobuf.FieldDescriptor()
field_descriptors.TakeMainlineStarRewardRequest_index = protobuf.FieldDescriptor()
type_descriptors.TakeMainlineStarRewardReply = protobuf.Descriptor()
type_descriptors.EndingDungeonRewardNO = protobuf.Descriptor()
field_descriptors.EndingDungeonRewardNO_reward = protobuf.FieldDescriptor()
field_descriptors.EndingDungeonRewardNO_rewardTag = protobuf.FieldDescriptor()
type_descriptors.TakeTrainingRewardReply = protobuf.Descriptor()
type_descriptors.DungeonNO = protobuf.Descriptor()
field_descriptors.DungeonNO_code = protobuf.FieldDescriptor()
field_descriptors.DungeonNO_stars = protobuf.FieldDescriptor()
field_descriptors.DungeonNO_multipliable = protobuf.FieldDescriptor()
field_descriptors.DungeonNO_hasRecord = protobuf.FieldDescriptor()
type_descriptors.SaveLastRecordReply = protobuf.Descriptor()
type_descriptors.GetConsecutiveInfoRequest = protobuf.Descriptor()
type_descriptors.GetDungeonInfoRequest = protobuf.Descriptor()
type_descriptors.ConsecutiveRewardNO = protobuf.Descriptor()
field_descriptors.ConsecutiveRewardNO_times = protobuf.FieldDescriptor()
field_descriptors.ConsecutiveRewardNO_rewards = protobuf.FieldDescriptor()
type_descriptors.LastBattleTeamNO = protobuf.Descriptor()
field_descriptors.LastBattleTeamNO_type = protobuf.FieldDescriptor()
field_descriptors.LastBattleTeamNO_heroes = protobuf.FieldDescriptor()
type_descriptors.ViewVideoReply = protobuf.Descriptor()
type_descriptors.StartDungeonReply = protobuf.Descriptor()
field_descriptors.StartDungeonReply_info = protobuf.FieldDescriptor()
type_descriptors.GetConsecutiveInfoReply = protobuf.Descriptor()
field_descriptors.GetConsecutiveInfoReply_times = protobuf.FieldDescriptor()
field_descriptors.GetConsecutiveInfoReply_rewards = protobuf.FieldDescriptor()
type_descriptors.StarTakenMainlineNO = protobuf.Descriptor()
field_descriptors.StarTakenMainlineNO_chapter = protobuf.FieldDescriptor()
field_descriptors.StarTakenMainlineNO_difficulty = protobuf.FieldDescriptor()
field_descriptors.StarTakenMainlineNO_stars = protobuf.FieldDescriptor()
type_descriptors.GetDungeonInfoReply = protobuf.Descriptor()
field_descriptors.GetDungeonInfoReply_dungeons = protobuf.FieldDescriptor()
field_descriptors.GetDungeonInfoReply_starTakenMainlines = protobuf.FieldDescriptor()
field_descriptors.GetDungeonInfoReply_lastBattleTeam = protobuf.FieldDescriptor()
field_descriptors.GetDungeonInfoReply_takenTrainings = protobuf.FieldDescriptor()
field_descriptors.GetDungeonInfoReply_unlockedTrainings = protobuf.FieldDescriptor()
field_descriptors.GetDungeonInfoReply_darkRound = protobuf.FieldDescriptor()
type_descriptors.PassPlotDungeonReply = protobuf.Descriptor()
type_descriptors.ChangeLastBattleTeamPush = protobuf.Descriptor()
field_descriptors.ChangeLastBattleTeamPush_type = protobuf.FieldDescriptor()
field_descriptors.ChangeLastBattleTeamPush_heroes = protobuf.FieldDescriptor()
type_descriptors.TakeTrainingRewardRequest = protobuf.Descriptor()
field_descriptors.TakeTrainingRewardRequest_chapter = protobuf.FieldDescriptor()
field_descriptors.TakeTrainingRewardRequest_index = protobuf.FieldDescriptor()
type_descriptors.EndDungeonWithStarsPush = protobuf.Descriptor()
field_descriptors.EndDungeonWithStarsPush_currentStars = protobuf.FieldDescriptor()
field_descriptors.EndDungeonWithStarsPush_mergedStars = protobuf.FieldDescriptor()
field_descriptors.EndDungeonWithStarsPush_rewards = protobuf.FieldDescriptor()
field_descriptors.EndDungeonWithStarsPush_statHeroes = protobuf.FieldDescriptor()
field_descriptors.EndDungeonWithStarsPush_result = protobuf.FieldDescriptor()
field_descriptors.EndDungeonWithStarsPush_heroCount = protobuf.FieldDescriptor()
field_descriptors.EndDungeonWithStarsPush_first = protobuf.FieldDescriptor()
type_descriptors.SaveLastRecordRequest = protobuf.Descriptor()
type_descriptors.PassPlotDungeonRequest = protobuf.Descriptor()
field_descriptors.PassPlotDungeonRequest_code = protobuf.FieldDescriptor()
type_descriptors.FinishPostwarPlotReply = protobuf.Descriptor()
type_descriptors.StartDungeonRequest = protobuf.Descriptor()
field_descriptors.StartDungeonRequest_code = protobuf.FieldDescriptor()
field_descriptors.StartDungeonRequest_multiplied = protobuf.FieldDescriptor()
field_descriptors.StartDungeonRequest_restart = protobuf.FieldDescriptor()
field_descriptors.StartDungeonRequest_gameplay = protobuf.FieldDescriptor()
enum_item_descriptors.DungeonType_MAINLINE.name = "MAINLINE"
enum_item_descriptors.DungeonType_MAINLINE.index = 0
enum_item_descriptors.DungeonType_MAINLINE.number = 1
enum_item_descriptors.DungeonType_TACIT.name = "TACIT"
enum_item_descriptors.DungeonType_TACIT.index = 1
enum_item_descriptors.DungeonType_TACIT.number = 2
enum_item_descriptors.DungeonType_MATERIAL.name = "MATERIAL"
enum_item_descriptors.DungeonType_MATERIAL.index = 2
enum_item_descriptors.DungeonType_MATERIAL.number = 4
enum_item_descriptors.DungeonType_PROLOGUE.name = "PROLOGUE"
enum_item_descriptors.DungeonType_PROLOGUE.index = 3
enum_item_descriptors.DungeonType_PROLOGUE.number = 5
enum_item_descriptors.DungeonType_TRAINING.name = "TRAINING"
enum_item_descriptors.DungeonType_TRAINING.index = 4
enum_item_descriptors.DungeonType_TRAINING.number = 6
enum_item_descriptors.DungeonType_EQUIPMENT.name = "EQUIPMENT"
enum_item_descriptors.DungeonType_EQUIPMENT.index = 5
enum_item_descriptors.DungeonType_EQUIPMENT.number = 7
enum_item_descriptors.DungeonType_GOLD.name = "GOLD"
enum_item_descriptors.DungeonType_GOLD.index = 6
enum_item_descriptors.DungeonType_GOLD.number = 8
enum_item_descriptors.DungeonType_EXP.name = "EXP"
enum_item_descriptors.DungeonType_EXP.index = 7
enum_item_descriptors.DungeonType_EXP.number = 9
enum_item_descriptors.DungeonType_LIGHT_TOWER.name = "LIGHT_TOWER"
enum_item_descriptors.DungeonType_LIGHT_TOWER.index = 8
enum_item_descriptors.DungeonType_LIGHT_TOWER.number = 10
enum_item_descriptors.DungeonType_DARK_TOWER.name = "DARK_TOWER"
enum_item_descriptors.DungeonType_DARK_TOWER.index = 9
enum_item_descriptors.DungeonType_DARK_TOWER.number = 11
enum_item_descriptors.DungeonType_BRANCHLINE.name = "BRANCHLINE"
enum_item_descriptors.DungeonType_BRANCHLINE.index = 10
enum_item_descriptors.DungeonType_BRANCHLINE.number = 12
enum_item_descriptors.DungeonType_CONTROL_ACTION.name = "CONTROL_ACTION"
enum_item_descriptors.DungeonType_CONTROL_ACTION.index = 11
enum_item_descriptors.DungeonType_CONTROL_ACTION.number = 13
enum_item_descriptors.DungeonType_CONTROL_ACTION_GUIDE.name = "CONTROL_ACTION_GUIDE"
enum_item_descriptors.DungeonType_CONTROL_ACTION_GUIDE.index = 12
enum_item_descriptors.DungeonType_CONTROL_ACTION_GUIDE.number = 14
enum_item_descriptors.DungeonType_HERO_EARLY_ACCESS.name = "HERO_EARLY_ACCESS"
enum_item_descriptors.DungeonType_HERO_EARLY_ACCESS.index = 13
enum_item_descriptors.DungeonType_HERO_EARLY_ACCESS.number = 16
enum_item_descriptors.DungeonType_POWER_CHALLENGE.name = "POWER_CHALLENGE"
enum_item_descriptors.DungeonType_POWER_CHALLENGE.index = 14
enum_item_descriptors.DungeonType_POWER_CHALLENGE.number = 17
type_descriptors.DungeonType.name = "DungeonType"
type_descriptors.DungeonType.full_name = ".DungeonType"
type_descriptors.DungeonType.values = {
	enum_item_descriptors.DungeonType_MAINLINE,
	enum_item_descriptors.DungeonType_TACIT,
	enum_item_descriptors.DungeonType_MATERIAL,
	enum_item_descriptors.DungeonType_PROLOGUE,
	enum_item_descriptors.DungeonType_TRAINING,
	enum_item_descriptors.DungeonType_EQUIPMENT,
	enum_item_descriptors.DungeonType_GOLD,
	enum_item_descriptors.DungeonType_EXP,
	enum_item_descriptors.DungeonType_LIGHT_TOWER,
	enum_item_descriptors.DungeonType_DARK_TOWER,
	enum_item_descriptors.DungeonType_BRANCHLINE,
	enum_item_descriptors.DungeonType_CONTROL_ACTION,
	enum_item_descriptors.DungeonType_CONTROL_ACTION_GUIDE,
	enum_item_descriptors.DungeonType_HERO_EARLY_ACCESS,
	enum_item_descriptors.DungeonType_POWER_CHALLENGE
}
enum_item_descriptors.BattleTeamType_TEAM_MAINLINE.name = "TEAM_MAINLINE"
enum_item_descriptors.BattleTeamType_TEAM_MAINLINE.index = 0
enum_item_descriptors.BattleTeamType_TEAM_MAINLINE.number = 1
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1001.name = "TEAM_MATERIAL_1001"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1001.index = 1
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1001.number = 1001
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1002.name = "TEAM_MATERIAL_1002"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1002.index = 2
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1002.number = 1002
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1003.name = "TEAM_MATERIAL_1003"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1003.index = 3
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1003.number = 1003
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1004.name = "TEAM_MATERIAL_1004"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1004.index = 4
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1004.number = 1004
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1005.name = "TEAM_MATERIAL_1005"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1005.index = 5
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1005.number = 1005
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1006.name = "TEAM_MATERIAL_1006"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1006.index = 6
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1006.number = 1006
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1007.name = "TEAM_MATERIAL_1007"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1007.index = 7
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1007.number = 1007
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1008.name = "TEAM_MATERIAL_1008"
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1008.index = 8
enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1008.number = 1008
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2001.name = "TEAM_EQUIPMENT_2001"
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2001.index = 9
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2001.number = 2001
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2002.name = "TEAM_EQUIPMENT_2002"
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2002.index = 10
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2002.number = 2002
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2003.name = "TEAM_EQUIPMENT_2003"
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2003.index = 11
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2003.number = 2003
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2004.name = "TEAM_EQUIPMENT_2004"
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2004.index = 12
enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2004.number = 2004
enum_item_descriptors.BattleTeamType_TEAM_CONTROL_ACTION.name = "TEAM_CONTROL_ACTION"
enum_item_descriptors.BattleTeamType_TEAM_CONTROL_ACTION.index = 13
enum_item_descriptors.BattleTeamType_TEAM_CONTROL_ACTION.number = 3
enum_item_descriptors.BattleTeamType_TEAM_LIGHT_TOWER.name = "TEAM_LIGHT_TOWER"
enum_item_descriptors.BattleTeamType_TEAM_LIGHT_TOWER.index = 14
enum_item_descriptors.BattleTeamType_TEAM_LIGHT_TOWER.number = 4
enum_item_descriptors.BattleTeamType_TEAM_DARK_TOWER.name = "TEAM_DARK_TOWER"
enum_item_descriptors.BattleTeamType_TEAM_DARK_TOWER.index = 15
enum_item_descriptors.BattleTeamType_TEAM_DARK_TOWER.number = 5
enum_item_descriptors.BattleTeamType_TEAM_AIR.name = "TEAM_AIR"
enum_item_descriptors.BattleTeamType_TEAM_AIR.index = 16
enum_item_descriptors.BattleTeamType_TEAM_AIR.number = 6
type_descriptors.BattleTeamType.name = "BattleTeamType"
type_descriptors.BattleTeamType.full_name = ".BattleTeamType"
type_descriptors.BattleTeamType.values = {
	enum_item_descriptors.BattleTeamType_TEAM_MAINLINE,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1001,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1002,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1003,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1004,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1005,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1006,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1007,
	enum_item_descriptors.BattleTeamType_TEAM_MATERIAL_1008,
	enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2001,
	enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2002,
	enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2003,
	enum_item_descriptors.BattleTeamType_TEAM_EQUIPMENT_2004,
	enum_item_descriptors.BattleTeamType_TEAM_CONTROL_ACTION,
	enum_item_descriptors.BattleTeamType_TEAM_LIGHT_TOWER,
	enum_item_descriptors.BattleTeamType_TEAM_DARK_TOWER,
	enum_item_descriptors.BattleTeamType_TEAM_AIR
}
field_descriptors.EndingDungeonStatHeroNO_code.name = "code"
field_descriptors.EndingDungeonStatHeroNO_code.full_name = ".EndingDungeonStatHeroNO.code"
field_descriptors.EndingDungeonStatHeroNO_code.number = 1
field_descriptors.EndingDungeonStatHeroNO_code.index = 0
field_descriptors.EndingDungeonStatHeroNO_code.label = 1
field_descriptors.EndingDungeonStatHeroNO_code.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_code.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_code.type = 5
field_descriptors.EndingDungeonStatHeroNO_code.cpp_type = 1
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.name = "hpDecrement"
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.full_name = ".EndingDungeonStatHeroNO.hpDecrement"
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.number = 2
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.index = 1
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.label = 1
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.type = 5
field_descriptors.EndingDungeonStatHeroNO_hpDecrement.cpp_type = 1
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.name = "sanityDecrement"
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.full_name = ".EndingDungeonStatHeroNO.sanityDecrement"
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.number = 3
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.index = 2
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.label = 1
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.type = 5
field_descriptors.EndingDungeonStatHeroNO_sanityDecrement.cpp_type = 1
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.name = "enemyKilled"
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.full_name = ".EndingDungeonStatHeroNO.enemyKilled"
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.number = 4
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.index = 3
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.label = 1
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.type = 5
field_descriptors.EndingDungeonStatHeroNO_enemyKilled.cpp_type = 1
field_descriptors.EndingDungeonStatHeroNO_phyDamage.name = "phyDamage"
field_descriptors.EndingDungeonStatHeroNO_phyDamage.full_name = ".EndingDungeonStatHeroNO.phyDamage"
field_descriptors.EndingDungeonStatHeroNO_phyDamage.number = 5
field_descriptors.EndingDungeonStatHeroNO_phyDamage.index = 4
field_descriptors.EndingDungeonStatHeroNO_phyDamage.label = 1
field_descriptors.EndingDungeonStatHeroNO_phyDamage.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_phyDamage.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_phyDamage.type = 5
field_descriptors.EndingDungeonStatHeroNO_phyDamage.cpp_type = 1
field_descriptors.EndingDungeonStatHeroNO_magDamage.name = "magDamage"
field_descriptors.EndingDungeonStatHeroNO_magDamage.full_name = ".EndingDungeonStatHeroNO.magDamage"
field_descriptors.EndingDungeonStatHeroNO_magDamage.number = 6
field_descriptors.EndingDungeonStatHeroNO_magDamage.index = 5
field_descriptors.EndingDungeonStatHeroNO_magDamage.label = 1
field_descriptors.EndingDungeonStatHeroNO_magDamage.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_magDamage.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_magDamage.type = 5
field_descriptors.EndingDungeonStatHeroNO_magDamage.cpp_type = 1
field_descriptors.EndingDungeonStatHeroNO_cured.name = "cured"
field_descriptors.EndingDungeonStatHeroNO_cured.full_name = ".EndingDungeonStatHeroNO.cured"
field_descriptors.EndingDungeonStatHeroNO_cured.number = 7
field_descriptors.EndingDungeonStatHeroNO_cured.index = 6
field_descriptors.EndingDungeonStatHeroNO_cured.label = 1
field_descriptors.EndingDungeonStatHeroNO_cured.has_default_value = false
field_descriptors.EndingDungeonStatHeroNO_cured.default_value = 0
field_descriptors.EndingDungeonStatHeroNO_cured.type = 5
field_descriptors.EndingDungeonStatHeroNO_cured.cpp_type = 1
type_descriptors.EndingDungeonStatHeroNO.name = "EndingDungeonStatHeroNO"
type_descriptors.EndingDungeonStatHeroNO.full_name = ".EndingDungeonStatHeroNO"
type_descriptors.EndingDungeonStatHeroNO.nested_types = {}
type_descriptors.EndingDungeonStatHeroNO.enum_types = {}
type_descriptors.EndingDungeonStatHeroNO.fields = {
	field_descriptors.EndingDungeonStatHeroNO_code,
	field_descriptors.EndingDungeonStatHeroNO_hpDecrement,
	field_descriptors.EndingDungeonStatHeroNO_sanityDecrement,
	field_descriptors.EndingDungeonStatHeroNO_enemyKilled,
	field_descriptors.EndingDungeonStatHeroNO_phyDamage,
	field_descriptors.EndingDungeonStatHeroNO_magDamage,
	field_descriptors.EndingDungeonStatHeroNO_cured
}
type_descriptors.EndingDungeonStatHeroNO.is_extendable = false
type_descriptors.EndingDungeonStatHeroNO.extensions = {}
type_descriptors.FinishPostwarPlotRequest.name = "FinishPostwarPlotRequest"
type_descriptors.FinishPostwarPlotRequest.full_name = ".FinishPostwarPlotRequest"
type_descriptors.FinishPostwarPlotRequest.nested_types = {}
type_descriptors.FinishPostwarPlotRequest.enum_types = {}
type_descriptors.FinishPostwarPlotRequest.fields = {}
type_descriptors.FinishPostwarPlotRequest.is_extendable = false
type_descriptors.FinishPostwarPlotRequest.extensions = {}
field_descriptors.ViewVideoRequest_videoId.name = "videoId"
field_descriptors.ViewVideoRequest_videoId.full_name = ".ViewVideoRequest.videoId"
field_descriptors.ViewVideoRequest_videoId.number = 1
field_descriptors.ViewVideoRequest_videoId.index = 0
field_descriptors.ViewVideoRequest_videoId.label = 2
field_descriptors.ViewVideoRequest_videoId.has_default_value = false
field_descriptors.ViewVideoRequest_videoId.default_value = 0
field_descriptors.ViewVideoRequest_videoId.type = 5
field_descriptors.ViewVideoRequest_videoId.cpp_type = 1
field_descriptors.ViewVideoRequest_skipped.name = "skipped"
field_descriptors.ViewVideoRequest_skipped.full_name = ".ViewVideoRequest.skipped"
field_descriptors.ViewVideoRequest_skipped.number = 2
field_descriptors.ViewVideoRequest_skipped.index = 1
field_descriptors.ViewVideoRequest_skipped.label = 2
field_descriptors.ViewVideoRequest_skipped.has_default_value = false
field_descriptors.ViewVideoRequest_skipped.default_value = false
field_descriptors.ViewVideoRequest_skipped.type = 8
field_descriptors.ViewVideoRequest_skipped.cpp_type = 7
field_descriptors.ViewVideoRequest_time.name = "time"
field_descriptors.ViewVideoRequest_time.full_name = ".ViewVideoRequest.time"
field_descriptors.ViewVideoRequest_time.number = 3
field_descriptors.ViewVideoRequest_time.index = 2
field_descriptors.ViewVideoRequest_time.label = 2
field_descriptors.ViewVideoRequest_time.has_default_value = false
field_descriptors.ViewVideoRequest_time.default_value = 0
field_descriptors.ViewVideoRequest_time.type = 5
field_descriptors.ViewVideoRequest_time.cpp_type = 1
type_descriptors.ViewVideoRequest.name = "ViewVideoRequest"
type_descriptors.ViewVideoRequest.full_name = ".ViewVideoRequest"
type_descriptors.ViewVideoRequest.nested_types = {}
type_descriptors.ViewVideoRequest.enum_types = {}
type_descriptors.ViewVideoRequest.fields = {
	field_descriptors.ViewVideoRequest_videoId,
	field_descriptors.ViewVideoRequest_skipped,
	field_descriptors.ViewVideoRequest_time
}
type_descriptors.ViewVideoRequest.is_extendable = false
type_descriptors.ViewVideoRequest.extensions = {}
field_descriptors.TakeMainlineStarRewardRequest_chapter.name = "chapter"
field_descriptors.TakeMainlineStarRewardRequest_chapter.full_name = ".TakeMainlineStarRewardRequest.chapter"
field_descriptors.TakeMainlineStarRewardRequest_chapter.number = 1
field_descriptors.TakeMainlineStarRewardRequest_chapter.index = 0
field_descriptors.TakeMainlineStarRewardRequest_chapter.label = 1
field_descriptors.TakeMainlineStarRewardRequest_chapter.has_default_value = false
field_descriptors.TakeMainlineStarRewardRequest_chapter.default_value = 0
field_descriptors.TakeMainlineStarRewardRequest_chapter.type = 5
field_descriptors.TakeMainlineStarRewardRequest_chapter.cpp_type = 1
field_descriptors.TakeMainlineStarRewardRequest_difficulty.name = "difficulty"
field_descriptors.TakeMainlineStarRewardRequest_difficulty.full_name = ".TakeMainlineStarRewardRequest.difficulty"
field_descriptors.TakeMainlineStarRewardRequest_difficulty.number = 2
field_descriptors.TakeMainlineStarRewardRequest_difficulty.index = 1
field_descriptors.TakeMainlineStarRewardRequest_difficulty.label = 1
field_descriptors.TakeMainlineStarRewardRequest_difficulty.has_default_value = false
field_descriptors.TakeMainlineStarRewardRequest_difficulty.default_value = 0
field_descriptors.TakeMainlineStarRewardRequest_difficulty.type = 5
field_descriptors.TakeMainlineStarRewardRequest_difficulty.cpp_type = 1
field_descriptors.TakeMainlineStarRewardRequest_index.name = "index"
field_descriptors.TakeMainlineStarRewardRequest_index.full_name = ".TakeMainlineStarRewardRequest.index"
field_descriptors.TakeMainlineStarRewardRequest_index.number = 3
field_descriptors.TakeMainlineStarRewardRequest_index.index = 2
field_descriptors.TakeMainlineStarRewardRequest_index.label = 1
field_descriptors.TakeMainlineStarRewardRequest_index.has_default_value = false
field_descriptors.TakeMainlineStarRewardRequest_index.default_value = 0
field_descriptors.TakeMainlineStarRewardRequest_index.type = 5
field_descriptors.TakeMainlineStarRewardRequest_index.cpp_type = 1
type_descriptors.TakeMainlineStarRewardRequest.name = "TakeMainlineStarRewardRequest"
type_descriptors.TakeMainlineStarRewardRequest.full_name = ".TakeMainlineStarRewardRequest"
type_descriptors.TakeMainlineStarRewardRequest.nested_types = {}
type_descriptors.TakeMainlineStarRewardRequest.enum_types = {}
type_descriptors.TakeMainlineStarRewardRequest.fields = {
	field_descriptors.TakeMainlineStarRewardRequest_chapter,
	field_descriptors.TakeMainlineStarRewardRequest_difficulty,
	field_descriptors.TakeMainlineStarRewardRequest_index
}
type_descriptors.TakeMainlineStarRewardRequest.is_extendable = false
type_descriptors.TakeMainlineStarRewardRequest.extensions = {}
type_descriptors.TakeMainlineStarRewardReply.name = "TakeMainlineStarRewardReply"
type_descriptors.TakeMainlineStarRewardReply.full_name = ".TakeMainlineStarRewardReply"
type_descriptors.TakeMainlineStarRewardReply.nested_types = {}
type_descriptors.TakeMainlineStarRewardReply.enum_types = {}
type_descriptors.TakeMainlineStarRewardReply.fields = {}
type_descriptors.TakeMainlineStarRewardReply.is_extendable = false
type_descriptors.TakeMainlineStarRewardReply.extensions = {}
field_descriptors.EndingDungeonRewardNO_reward.name = "reward"
field_descriptors.EndingDungeonRewardNO_reward.full_name = ".EndingDungeonRewardNO.reward"
field_descriptors.EndingDungeonRewardNO_reward.number = 1
field_descriptors.EndingDungeonRewardNO_reward.index = 0
field_descriptors.EndingDungeonRewardNO_reward.label = 1
field_descriptors.EndingDungeonRewardNO_reward.has_default_value = false
field_descriptors.EndingDungeonRewardNO_reward.default_value = nil
field_descriptors.EndingDungeonRewardNO_reward.message_type = dependencies.BackpackExtension.type_descriptors.ItemNO
field_descriptors.EndingDungeonRewardNO_reward.type = 11
field_descriptors.EndingDungeonRewardNO_reward.cpp_type = 10
field_descriptors.EndingDungeonRewardNO_rewardTag.name = "rewardTag"
field_descriptors.EndingDungeonRewardNO_rewardTag.full_name = ".EndingDungeonRewardNO.rewardTag"
field_descriptors.EndingDungeonRewardNO_rewardTag.number = 2
field_descriptors.EndingDungeonRewardNO_rewardTag.index = 1
field_descriptors.EndingDungeonRewardNO_rewardTag.label = 1
field_descriptors.EndingDungeonRewardNO_rewardTag.has_default_value = false
field_descriptors.EndingDungeonRewardNO_rewardTag.default_value = 0
field_descriptors.EndingDungeonRewardNO_rewardTag.type = 5
field_descriptors.EndingDungeonRewardNO_rewardTag.cpp_type = 1
type_descriptors.EndingDungeonRewardNO.name = "EndingDungeonRewardNO"
type_descriptors.EndingDungeonRewardNO.full_name = ".EndingDungeonRewardNO"
type_descriptors.EndingDungeonRewardNO.nested_types = {}
type_descriptors.EndingDungeonRewardNO.enum_types = {}
type_descriptors.EndingDungeonRewardNO.fields = {
	field_descriptors.EndingDungeonRewardNO_reward,
	field_descriptors.EndingDungeonRewardNO_rewardTag
}
type_descriptors.EndingDungeonRewardNO.is_extendable = false
type_descriptors.EndingDungeonRewardNO.extensions = {}
type_descriptors.TakeTrainingRewardReply.name = "TakeTrainingRewardReply"
type_descriptors.TakeTrainingRewardReply.full_name = ".TakeTrainingRewardReply"
type_descriptors.TakeTrainingRewardReply.nested_types = {}
type_descriptors.TakeTrainingRewardReply.enum_types = {}
type_descriptors.TakeTrainingRewardReply.fields = {}
type_descriptors.TakeTrainingRewardReply.is_extendable = false
type_descriptors.TakeTrainingRewardReply.extensions = {}
field_descriptors.DungeonNO_code.name = "code"
field_descriptors.DungeonNO_code.full_name = ".DungeonNO.code"
field_descriptors.DungeonNO_code.number = 1
field_descriptors.DungeonNO_code.index = 0
field_descriptors.DungeonNO_code.label = 1
field_descriptors.DungeonNO_code.has_default_value = false
field_descriptors.DungeonNO_code.default_value = 0
field_descriptors.DungeonNO_code.type = 5
field_descriptors.DungeonNO_code.cpp_type = 1
field_descriptors.DungeonNO_stars.name = "stars"
field_descriptors.DungeonNO_stars.full_name = ".DungeonNO.stars"
field_descriptors.DungeonNO_stars.number = 2
field_descriptors.DungeonNO_stars.index = 1
field_descriptors.DungeonNO_stars.label = 1
field_descriptors.DungeonNO_stars.has_default_value = false
field_descriptors.DungeonNO_stars.default_value = 0
field_descriptors.DungeonNO_stars.type = 5
field_descriptors.DungeonNO_stars.cpp_type = 1
field_descriptors.DungeonNO_multipliable.name = "multipliable"
field_descriptors.DungeonNO_multipliable.full_name = ".DungeonNO.multipliable"
field_descriptors.DungeonNO_multipliable.number = 3
field_descriptors.DungeonNO_multipliable.index = 2
field_descriptors.DungeonNO_multipliable.label = 1
field_descriptors.DungeonNO_multipliable.has_default_value = false
field_descriptors.DungeonNO_multipliable.default_value = false
field_descriptors.DungeonNO_multipliable.type = 8
field_descriptors.DungeonNO_multipliable.cpp_type = 7
field_descriptors.DungeonNO_hasRecord.name = "hasRecord"
field_descriptors.DungeonNO_hasRecord.full_name = ".DungeonNO.hasRecord"
field_descriptors.DungeonNO_hasRecord.number = 4
field_descriptors.DungeonNO_hasRecord.index = 3
field_descriptors.DungeonNO_hasRecord.label = 1
field_descriptors.DungeonNO_hasRecord.has_default_value = false
field_descriptors.DungeonNO_hasRecord.default_value = false
field_descriptors.DungeonNO_hasRecord.type = 8
field_descriptors.DungeonNO_hasRecord.cpp_type = 7
type_descriptors.DungeonNO.name = "DungeonNO"
type_descriptors.DungeonNO.full_name = ".DungeonNO"
type_descriptors.DungeonNO.nested_types = {}
type_descriptors.DungeonNO.enum_types = {}
type_descriptors.DungeonNO.fields = {
	field_descriptors.DungeonNO_code,
	field_descriptors.DungeonNO_stars,
	field_descriptors.DungeonNO_multipliable,
	field_descriptors.DungeonNO_hasRecord
}
type_descriptors.DungeonNO.is_extendable = false
type_descriptors.DungeonNO.extensions = {}
type_descriptors.SaveLastRecordReply.name = "SaveLastRecordReply"
type_descriptors.SaveLastRecordReply.full_name = ".SaveLastRecordReply"
type_descriptors.SaveLastRecordReply.nested_types = {}
type_descriptors.SaveLastRecordReply.enum_types = {}
type_descriptors.SaveLastRecordReply.fields = {}
type_descriptors.SaveLastRecordReply.is_extendable = false
type_descriptors.SaveLastRecordReply.extensions = {}
type_descriptors.GetConsecutiveInfoRequest.name = "GetConsecutiveInfoRequest"
type_descriptors.GetConsecutiveInfoRequest.full_name = ".GetConsecutiveInfoRequest"
type_descriptors.GetConsecutiveInfoRequest.nested_types = {}
type_descriptors.GetConsecutiveInfoRequest.enum_types = {}
type_descriptors.GetConsecutiveInfoRequest.fields = {}
type_descriptors.GetConsecutiveInfoRequest.is_extendable = false
type_descriptors.GetConsecutiveInfoRequest.extensions = {}
type_descriptors.GetDungeonInfoRequest.name = "GetDungeonInfoRequest"
type_descriptors.GetDungeonInfoRequest.full_name = ".GetDungeonInfoRequest"
type_descriptors.GetDungeonInfoRequest.nested_types = {}
type_descriptors.GetDungeonInfoRequest.enum_types = {}
type_descriptors.GetDungeonInfoRequest.fields = {}
type_descriptors.GetDungeonInfoRequest.is_extendable = false
type_descriptors.GetDungeonInfoRequest.extensions = {}
field_descriptors.ConsecutiveRewardNO_times.name = "times"
field_descriptors.ConsecutiveRewardNO_times.full_name = ".ConsecutiveRewardNO.times"
field_descriptors.ConsecutiveRewardNO_times.number = 1
field_descriptors.ConsecutiveRewardNO_times.index = 0
field_descriptors.ConsecutiveRewardNO_times.label = 1
field_descriptors.ConsecutiveRewardNO_times.has_default_value = false
field_descriptors.ConsecutiveRewardNO_times.default_value = 0
field_descriptors.ConsecutiveRewardNO_times.type = 5
field_descriptors.ConsecutiveRewardNO_times.cpp_type = 1
field_descriptors.ConsecutiveRewardNO_rewards.name = "rewards"
field_descriptors.ConsecutiveRewardNO_rewards.full_name = ".ConsecutiveRewardNO.rewards"
field_descriptors.ConsecutiveRewardNO_rewards.number = 2
field_descriptors.ConsecutiveRewardNO_rewards.index = 1
field_descriptors.ConsecutiveRewardNO_rewards.label = 3
field_descriptors.ConsecutiveRewardNO_rewards.has_default_value = false
field_descriptors.ConsecutiveRewardNO_rewards.default_value = {}
field_descriptors.ConsecutiveRewardNO_rewards.message_type = type_descriptors.EndingDungeonRewardNO
field_descriptors.ConsecutiveRewardNO_rewards.type = 11
field_descriptors.ConsecutiveRewardNO_rewards.cpp_type = 10
type_descriptors.ConsecutiveRewardNO.name = "ConsecutiveRewardNO"
type_descriptors.ConsecutiveRewardNO.full_name = ".ConsecutiveRewardNO"
type_descriptors.ConsecutiveRewardNO.nested_types = {}
type_descriptors.ConsecutiveRewardNO.enum_types = {}
type_descriptors.ConsecutiveRewardNO.fields = {
	field_descriptors.ConsecutiveRewardNO_times,
	field_descriptors.ConsecutiveRewardNO_rewards
}
type_descriptors.ConsecutiveRewardNO.is_extendable = false
type_descriptors.ConsecutiveRewardNO.extensions = {}
field_descriptors.LastBattleTeamNO_type.name = "type"
field_descriptors.LastBattleTeamNO_type.full_name = ".LastBattleTeamNO.type"
field_descriptors.LastBattleTeamNO_type.number = 1
field_descriptors.LastBattleTeamNO_type.index = 0
field_descriptors.LastBattleTeamNO_type.label = 1
field_descriptors.LastBattleTeamNO_type.has_default_value = false
field_descriptors.LastBattleTeamNO_type.default_value = nil
field_descriptors.LastBattleTeamNO_type.enum_type = type_descriptors.BattleTeamType
field_descriptors.LastBattleTeamNO_type.type = 14
field_descriptors.LastBattleTeamNO_type.cpp_type = 8
field_descriptors.LastBattleTeamNO_heroes.name = "heroes"
field_descriptors.LastBattleTeamNO_heroes.full_name = ".LastBattleTeamNO.heroes"
field_descriptors.LastBattleTeamNO_heroes.number = 2
field_descriptors.LastBattleTeamNO_heroes.index = 1
field_descriptors.LastBattleTeamNO_heroes.label = 3
field_descriptors.LastBattleTeamNO_heroes.has_default_value = false
field_descriptors.LastBattleTeamNO_heroes.default_value = {}
field_descriptors.LastBattleTeamNO_heroes.type = 5
field_descriptors.LastBattleTeamNO_heroes.cpp_type = 1
type_descriptors.LastBattleTeamNO.name = "LastBattleTeamNO"
type_descriptors.LastBattleTeamNO.full_name = ".LastBattleTeamNO"
type_descriptors.LastBattleTeamNO.nested_types = {}
type_descriptors.LastBattleTeamNO.enum_types = {}
type_descriptors.LastBattleTeamNO.fields = {
	field_descriptors.LastBattleTeamNO_type,
	field_descriptors.LastBattleTeamNO_heroes
}
type_descriptors.LastBattleTeamNO.is_extendable = false
type_descriptors.LastBattleTeamNO.extensions = {}
type_descriptors.ViewVideoReply.name = "ViewVideoReply"
type_descriptors.ViewVideoReply.full_name = ".ViewVideoReply"
type_descriptors.ViewVideoReply.nested_types = {}
type_descriptors.ViewVideoReply.enum_types = {}
type_descriptors.ViewVideoReply.fields = {}
type_descriptors.ViewVideoReply.is_extendable = false
type_descriptors.ViewVideoReply.extensions = {}
field_descriptors.StartDungeonReply_info.name = "info"
field_descriptors.StartDungeonReply_info.full_name = ".StartDungeonReply.info"
field_descriptors.StartDungeonReply_info.number = 1
field_descriptors.StartDungeonReply_info.index = 0
field_descriptors.StartDungeonReply_info.label = 1
field_descriptors.StartDungeonReply_info.has_default_value = false
field_descriptors.StartDungeonReply_info.default_value = nil
field_descriptors.StartDungeonReply_info.message_type = dependencies.BattleExtension.type_descriptors.BattleInfoNO
field_descriptors.StartDungeonReply_info.type = 11
field_descriptors.StartDungeonReply_info.cpp_type = 10
type_descriptors.StartDungeonReply.name = "StartDungeonReply"
type_descriptors.StartDungeonReply.full_name = ".StartDungeonReply"
type_descriptors.StartDungeonReply.nested_types = {}
type_descriptors.StartDungeonReply.enum_types = {}
type_descriptors.StartDungeonReply.fields = {
	field_descriptors.StartDungeonReply_info
}
type_descriptors.StartDungeonReply.is_extendable = false
type_descriptors.StartDungeonReply.extensions = {}
field_descriptors.GetConsecutiveInfoReply_times.name = "times"
field_descriptors.GetConsecutiveInfoReply_times.full_name = ".GetConsecutiveInfoReply.times"
field_descriptors.GetConsecutiveInfoReply_times.number = 1
field_descriptors.GetConsecutiveInfoReply_times.index = 0
field_descriptors.GetConsecutiveInfoReply_times.label = 1
field_descriptors.GetConsecutiveInfoReply_times.has_default_value = false
field_descriptors.GetConsecutiveInfoReply_times.default_value = 0
field_descriptors.GetConsecutiveInfoReply_times.type = 5
field_descriptors.GetConsecutiveInfoReply_times.cpp_type = 1
field_descriptors.GetConsecutiveInfoReply_rewards.name = "rewards"
field_descriptors.GetConsecutiveInfoReply_rewards.full_name = ".GetConsecutiveInfoReply.rewards"
field_descriptors.GetConsecutiveInfoReply_rewards.number = 2
field_descriptors.GetConsecutiveInfoReply_rewards.index = 1
field_descriptors.GetConsecutiveInfoReply_rewards.label = 3
field_descriptors.GetConsecutiveInfoReply_rewards.has_default_value = false
field_descriptors.GetConsecutiveInfoReply_rewards.default_value = {}
field_descriptors.GetConsecutiveInfoReply_rewards.message_type = type_descriptors.ConsecutiveRewardNO
field_descriptors.GetConsecutiveInfoReply_rewards.type = 11
field_descriptors.GetConsecutiveInfoReply_rewards.cpp_type = 10
type_descriptors.GetConsecutiveInfoReply.name = "GetConsecutiveInfoReply"
type_descriptors.GetConsecutiveInfoReply.full_name = ".GetConsecutiveInfoReply"
type_descriptors.GetConsecutiveInfoReply.nested_types = {}
type_descriptors.GetConsecutiveInfoReply.enum_types = {}
type_descriptors.GetConsecutiveInfoReply.fields = {
	field_descriptors.GetConsecutiveInfoReply_times,
	field_descriptors.GetConsecutiveInfoReply_rewards
}
type_descriptors.GetConsecutiveInfoReply.is_extendable = false
type_descriptors.GetConsecutiveInfoReply.extensions = {}
field_descriptors.StarTakenMainlineNO_chapter.name = "chapter"
field_descriptors.StarTakenMainlineNO_chapter.full_name = ".StarTakenMainlineNO.chapter"
field_descriptors.StarTakenMainlineNO_chapter.number = 1
field_descriptors.StarTakenMainlineNO_chapter.index = 0
field_descriptors.StarTakenMainlineNO_chapter.label = 1
field_descriptors.StarTakenMainlineNO_chapter.has_default_value = false
field_descriptors.StarTakenMainlineNO_chapter.default_value = 0
field_descriptors.StarTakenMainlineNO_chapter.type = 5
field_descriptors.StarTakenMainlineNO_chapter.cpp_type = 1
field_descriptors.StarTakenMainlineNO_difficulty.name = "difficulty"
field_descriptors.StarTakenMainlineNO_difficulty.full_name = ".StarTakenMainlineNO.difficulty"
field_descriptors.StarTakenMainlineNO_difficulty.number = 2
field_descriptors.StarTakenMainlineNO_difficulty.index = 1
field_descriptors.StarTakenMainlineNO_difficulty.label = 1
field_descriptors.StarTakenMainlineNO_difficulty.has_default_value = false
field_descriptors.StarTakenMainlineNO_difficulty.default_value = 0
field_descriptors.StarTakenMainlineNO_difficulty.type = 5
field_descriptors.StarTakenMainlineNO_difficulty.cpp_type = 1
field_descriptors.StarTakenMainlineNO_stars.name = "stars"
field_descriptors.StarTakenMainlineNO_stars.full_name = ".StarTakenMainlineNO.stars"
field_descriptors.StarTakenMainlineNO_stars.number = 3
field_descriptors.StarTakenMainlineNO_stars.index = 2
field_descriptors.StarTakenMainlineNO_stars.label = 1
field_descriptors.StarTakenMainlineNO_stars.has_default_value = false
field_descriptors.StarTakenMainlineNO_stars.default_value = 0
field_descriptors.StarTakenMainlineNO_stars.type = 5
field_descriptors.StarTakenMainlineNO_stars.cpp_type = 1
type_descriptors.StarTakenMainlineNO.name = "StarTakenMainlineNO"
type_descriptors.StarTakenMainlineNO.full_name = ".StarTakenMainlineNO"
type_descriptors.StarTakenMainlineNO.nested_types = {}
type_descriptors.StarTakenMainlineNO.enum_types = {}
type_descriptors.StarTakenMainlineNO.fields = {
	field_descriptors.StarTakenMainlineNO_chapter,
	field_descriptors.StarTakenMainlineNO_difficulty,
	field_descriptors.StarTakenMainlineNO_stars
}
type_descriptors.StarTakenMainlineNO.is_extendable = false
type_descriptors.StarTakenMainlineNO.extensions = {}
field_descriptors.GetDungeonInfoReply_dungeons.name = "dungeons"
field_descriptors.GetDungeonInfoReply_dungeons.full_name = ".GetDungeonInfoReply.dungeons"
field_descriptors.GetDungeonInfoReply_dungeons.number = 1
field_descriptors.GetDungeonInfoReply_dungeons.index = 0
field_descriptors.GetDungeonInfoReply_dungeons.label = 3
field_descriptors.GetDungeonInfoReply_dungeons.has_default_value = false
field_descriptors.GetDungeonInfoReply_dungeons.default_value = {}
field_descriptors.GetDungeonInfoReply_dungeons.message_type = type_descriptors.DungeonNO
field_descriptors.GetDungeonInfoReply_dungeons.type = 11
field_descriptors.GetDungeonInfoReply_dungeons.cpp_type = 10
field_descriptors.GetDungeonInfoReply_starTakenMainlines.name = "starTakenMainlines"
field_descriptors.GetDungeonInfoReply_starTakenMainlines.full_name = ".GetDungeonInfoReply.starTakenMainlines"
field_descriptors.GetDungeonInfoReply_starTakenMainlines.number = 2
field_descriptors.GetDungeonInfoReply_starTakenMainlines.index = 1
field_descriptors.GetDungeonInfoReply_starTakenMainlines.label = 3
field_descriptors.GetDungeonInfoReply_starTakenMainlines.has_default_value = false
field_descriptors.GetDungeonInfoReply_starTakenMainlines.default_value = {}
field_descriptors.GetDungeonInfoReply_starTakenMainlines.message_type = type_descriptors.StarTakenMainlineNO
field_descriptors.GetDungeonInfoReply_starTakenMainlines.type = 11
field_descriptors.GetDungeonInfoReply_starTakenMainlines.cpp_type = 10
field_descriptors.GetDungeonInfoReply_lastBattleTeam.name = "lastBattleTeam"
field_descriptors.GetDungeonInfoReply_lastBattleTeam.full_name = ".GetDungeonInfoReply.lastBattleTeam"
field_descriptors.GetDungeonInfoReply_lastBattleTeam.number = 4
field_descriptors.GetDungeonInfoReply_lastBattleTeam.index = 2
field_descriptors.GetDungeonInfoReply_lastBattleTeam.label = 3
field_descriptors.GetDungeonInfoReply_lastBattleTeam.has_default_value = false
field_descriptors.GetDungeonInfoReply_lastBattleTeam.default_value = {}
field_descriptors.GetDungeonInfoReply_lastBattleTeam.message_type = type_descriptors.LastBattleTeamNO
field_descriptors.GetDungeonInfoReply_lastBattleTeam.type = 11
field_descriptors.GetDungeonInfoReply_lastBattleTeam.cpp_type = 10
field_descriptors.GetDungeonInfoReply_takenTrainings.name = "takenTrainings"
field_descriptors.GetDungeonInfoReply_takenTrainings.full_name = ".GetDungeonInfoReply.takenTrainings"
field_descriptors.GetDungeonInfoReply_takenTrainings.number = 5
field_descriptors.GetDungeonInfoReply_takenTrainings.index = 3
field_descriptors.GetDungeonInfoReply_takenTrainings.label = 3
field_descriptors.GetDungeonInfoReply_takenTrainings.has_default_value = false
field_descriptors.GetDungeonInfoReply_takenTrainings.default_value = {}
field_descriptors.GetDungeonInfoReply_takenTrainings.message_type = type_descriptors.StarTakenMainlineNO
field_descriptors.GetDungeonInfoReply_takenTrainings.type = 11
field_descriptors.GetDungeonInfoReply_takenTrainings.cpp_type = 10
field_descriptors.GetDungeonInfoReply_unlockedTrainings.name = "unlockedTrainings"
field_descriptors.GetDungeonInfoReply_unlockedTrainings.full_name = ".GetDungeonInfoReply.unlockedTrainings"
field_descriptors.GetDungeonInfoReply_unlockedTrainings.number = 6
field_descriptors.GetDungeonInfoReply_unlockedTrainings.index = 4
field_descriptors.GetDungeonInfoReply_unlockedTrainings.label = 3
field_descriptors.GetDungeonInfoReply_unlockedTrainings.has_default_value = false
field_descriptors.GetDungeonInfoReply_unlockedTrainings.default_value = {}
field_descriptors.GetDungeonInfoReply_unlockedTrainings.type = 5
field_descriptors.GetDungeonInfoReply_unlockedTrainings.cpp_type = 1
field_descriptors.GetDungeonInfoReply_darkRound.name = "darkRound"
field_descriptors.GetDungeonInfoReply_darkRound.full_name = ".GetDungeonInfoReply.darkRound"
field_descriptors.GetDungeonInfoReply_darkRound.number = 7
field_descriptors.GetDungeonInfoReply_darkRound.index = 5
field_descriptors.GetDungeonInfoReply_darkRound.label = 1
field_descriptors.GetDungeonInfoReply_darkRound.has_default_value = false
field_descriptors.GetDungeonInfoReply_darkRound.default_value = 0
field_descriptors.GetDungeonInfoReply_darkRound.type = 5
field_descriptors.GetDungeonInfoReply_darkRound.cpp_type = 1
type_descriptors.GetDungeonInfoReply.name = "GetDungeonInfoReply"
type_descriptors.GetDungeonInfoReply.full_name = ".GetDungeonInfoReply"
type_descriptors.GetDungeonInfoReply.nested_types = {}
type_descriptors.GetDungeonInfoReply.enum_types = {}
type_descriptors.GetDungeonInfoReply.fields = {
	field_descriptors.GetDungeonInfoReply_dungeons,
	field_descriptors.GetDungeonInfoReply_starTakenMainlines,
	field_descriptors.GetDungeonInfoReply_lastBattleTeam,
	field_descriptors.GetDungeonInfoReply_takenTrainings,
	field_descriptors.GetDungeonInfoReply_unlockedTrainings,
	field_descriptors.GetDungeonInfoReply_darkRound
}
type_descriptors.GetDungeonInfoReply.is_extendable = false
type_descriptors.GetDungeonInfoReply.extensions = {}
type_descriptors.PassPlotDungeonReply.name = "PassPlotDungeonReply"
type_descriptors.PassPlotDungeonReply.full_name = ".PassPlotDungeonReply"
type_descriptors.PassPlotDungeonReply.nested_types = {}
type_descriptors.PassPlotDungeonReply.enum_types = {}
type_descriptors.PassPlotDungeonReply.fields = {}
type_descriptors.PassPlotDungeonReply.is_extendable = false
type_descriptors.PassPlotDungeonReply.extensions = {}
field_descriptors.ChangeLastBattleTeamPush_type.name = "type"
field_descriptors.ChangeLastBattleTeamPush_type.full_name = ".ChangeLastBattleTeamPush.type"
field_descriptors.ChangeLastBattleTeamPush_type.number = 1
field_descriptors.ChangeLastBattleTeamPush_type.index = 0
field_descriptors.ChangeLastBattleTeamPush_type.label = 1
field_descriptors.ChangeLastBattleTeamPush_type.has_default_value = false
field_descriptors.ChangeLastBattleTeamPush_type.default_value = nil
field_descriptors.ChangeLastBattleTeamPush_type.enum_type = type_descriptors.BattleTeamType
field_descriptors.ChangeLastBattleTeamPush_type.type = 14
field_descriptors.ChangeLastBattleTeamPush_type.cpp_type = 8
field_descriptors.ChangeLastBattleTeamPush_heroes.name = "heroes"
field_descriptors.ChangeLastBattleTeamPush_heroes.full_name = ".ChangeLastBattleTeamPush.heroes"
field_descriptors.ChangeLastBattleTeamPush_heroes.number = 2
field_descriptors.ChangeLastBattleTeamPush_heroes.index = 1
field_descriptors.ChangeLastBattleTeamPush_heroes.label = 3
field_descriptors.ChangeLastBattleTeamPush_heroes.has_default_value = false
field_descriptors.ChangeLastBattleTeamPush_heroes.default_value = {}
field_descriptors.ChangeLastBattleTeamPush_heroes.type = 5
field_descriptors.ChangeLastBattleTeamPush_heroes.cpp_type = 1
type_descriptors.ChangeLastBattleTeamPush.name = "ChangeLastBattleTeamPush"
type_descriptors.ChangeLastBattleTeamPush.full_name = ".ChangeLastBattleTeamPush"
type_descriptors.ChangeLastBattleTeamPush.nested_types = {}
type_descriptors.ChangeLastBattleTeamPush.enum_types = {}
type_descriptors.ChangeLastBattleTeamPush.fields = {
	field_descriptors.ChangeLastBattleTeamPush_type,
	field_descriptors.ChangeLastBattleTeamPush_heroes
}
type_descriptors.ChangeLastBattleTeamPush.is_extendable = false
type_descriptors.ChangeLastBattleTeamPush.extensions = {}
field_descriptors.TakeTrainingRewardRequest_chapter.name = "chapter"
field_descriptors.TakeTrainingRewardRequest_chapter.full_name = ".TakeTrainingRewardRequest.chapter"
field_descriptors.TakeTrainingRewardRequest_chapter.number = 1
field_descriptors.TakeTrainingRewardRequest_chapter.index = 0
field_descriptors.TakeTrainingRewardRequest_chapter.label = 1
field_descriptors.TakeTrainingRewardRequest_chapter.has_default_value = false
field_descriptors.TakeTrainingRewardRequest_chapter.default_value = 0
field_descriptors.TakeTrainingRewardRequest_chapter.type = 5
field_descriptors.TakeTrainingRewardRequest_chapter.cpp_type = 1
field_descriptors.TakeTrainingRewardRequest_index.name = "index"
field_descriptors.TakeTrainingRewardRequest_index.full_name = ".TakeTrainingRewardRequest.index"
field_descriptors.TakeTrainingRewardRequest_index.number = 2
field_descriptors.TakeTrainingRewardRequest_index.index = 1
field_descriptors.TakeTrainingRewardRequest_index.label = 1
field_descriptors.TakeTrainingRewardRequest_index.has_default_value = false
field_descriptors.TakeTrainingRewardRequest_index.default_value = 0
field_descriptors.TakeTrainingRewardRequest_index.type = 5
field_descriptors.TakeTrainingRewardRequest_index.cpp_type = 1
type_descriptors.TakeTrainingRewardRequest.name = "TakeTrainingRewardRequest"
type_descriptors.TakeTrainingRewardRequest.full_name = ".TakeTrainingRewardRequest"
type_descriptors.TakeTrainingRewardRequest.nested_types = {}
type_descriptors.TakeTrainingRewardRequest.enum_types = {}
type_descriptors.TakeTrainingRewardRequest.fields = {
	field_descriptors.TakeTrainingRewardRequest_chapter,
	field_descriptors.TakeTrainingRewardRequest_index
}
type_descriptors.TakeTrainingRewardRequest.is_extendable = false
type_descriptors.TakeTrainingRewardRequest.extensions = {}
field_descriptors.EndDungeonWithStarsPush_currentStars.name = "currentStars"
field_descriptors.EndDungeonWithStarsPush_currentStars.full_name = ".EndDungeonWithStarsPush.currentStars"
field_descriptors.EndDungeonWithStarsPush_currentStars.number = 1
field_descriptors.EndDungeonWithStarsPush_currentStars.index = 0
field_descriptors.EndDungeonWithStarsPush_currentStars.label = 1
field_descriptors.EndDungeonWithStarsPush_currentStars.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_currentStars.default_value = 0
field_descriptors.EndDungeonWithStarsPush_currentStars.type = 5
field_descriptors.EndDungeonWithStarsPush_currentStars.cpp_type = 1
field_descriptors.EndDungeonWithStarsPush_mergedStars.name = "mergedStars"
field_descriptors.EndDungeonWithStarsPush_mergedStars.full_name = ".EndDungeonWithStarsPush.mergedStars"
field_descriptors.EndDungeonWithStarsPush_mergedStars.number = 2
field_descriptors.EndDungeonWithStarsPush_mergedStars.index = 1
field_descriptors.EndDungeonWithStarsPush_mergedStars.label = 1
field_descriptors.EndDungeonWithStarsPush_mergedStars.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_mergedStars.default_value = 0
field_descriptors.EndDungeonWithStarsPush_mergedStars.type = 5
field_descriptors.EndDungeonWithStarsPush_mergedStars.cpp_type = 1
field_descriptors.EndDungeonWithStarsPush_rewards.name = "rewards"
field_descriptors.EndDungeonWithStarsPush_rewards.full_name = ".EndDungeonWithStarsPush.rewards"
field_descriptors.EndDungeonWithStarsPush_rewards.number = 3
field_descriptors.EndDungeonWithStarsPush_rewards.index = 2
field_descriptors.EndDungeonWithStarsPush_rewards.label = 3
field_descriptors.EndDungeonWithStarsPush_rewards.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_rewards.default_value = {}
field_descriptors.EndDungeonWithStarsPush_rewards.message_type = type_descriptors.EndingDungeonRewardNO
field_descriptors.EndDungeonWithStarsPush_rewards.type = 11
field_descriptors.EndDungeonWithStarsPush_rewards.cpp_type = 10
field_descriptors.EndDungeonWithStarsPush_statHeroes.name = "statHeroes"
field_descriptors.EndDungeonWithStarsPush_statHeroes.full_name = ".EndDungeonWithStarsPush.statHeroes"
field_descriptors.EndDungeonWithStarsPush_statHeroes.number = 4
field_descriptors.EndDungeonWithStarsPush_statHeroes.index = 3
field_descriptors.EndDungeonWithStarsPush_statHeroes.label = 3
field_descriptors.EndDungeonWithStarsPush_statHeroes.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_statHeroes.default_value = {}
field_descriptors.EndDungeonWithStarsPush_statHeroes.message_type = type_descriptors.EndingDungeonStatHeroNO
field_descriptors.EndDungeonWithStarsPush_statHeroes.type = 11
field_descriptors.EndDungeonWithStarsPush_statHeroes.cpp_type = 10
field_descriptors.EndDungeonWithStarsPush_result.name = "result"
field_descriptors.EndDungeonWithStarsPush_result.full_name = ".EndDungeonWithStarsPush.result"
field_descriptors.EndDungeonWithStarsPush_result.number = 5
field_descriptors.EndDungeonWithStarsPush_result.index = 4
field_descriptors.EndDungeonWithStarsPush_result.label = 2
field_descriptors.EndDungeonWithStarsPush_result.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_result.default_value = 0
field_descriptors.EndDungeonWithStarsPush_result.type = 5
field_descriptors.EndDungeonWithStarsPush_result.cpp_type = 1
field_descriptors.EndDungeonWithStarsPush_heroCount.name = "heroCount"
field_descriptors.EndDungeonWithStarsPush_heroCount.full_name = ".EndDungeonWithStarsPush.heroCount"
field_descriptors.EndDungeonWithStarsPush_heroCount.number = 6
field_descriptors.EndDungeonWithStarsPush_heroCount.index = 5
field_descriptors.EndDungeonWithStarsPush_heroCount.label = 1
field_descriptors.EndDungeonWithStarsPush_heroCount.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_heroCount.default_value = 0
field_descriptors.EndDungeonWithStarsPush_heroCount.type = 5
field_descriptors.EndDungeonWithStarsPush_heroCount.cpp_type = 1
field_descriptors.EndDungeonWithStarsPush_first.name = "first"
field_descriptors.EndDungeonWithStarsPush_first.full_name = ".EndDungeonWithStarsPush.first"
field_descriptors.EndDungeonWithStarsPush_first.number = 7
field_descriptors.EndDungeonWithStarsPush_first.index = 6
field_descriptors.EndDungeonWithStarsPush_first.label = 1
field_descriptors.EndDungeonWithStarsPush_first.has_default_value = false
field_descriptors.EndDungeonWithStarsPush_first.default_value = false
field_descriptors.EndDungeonWithStarsPush_first.type = 8
field_descriptors.EndDungeonWithStarsPush_first.cpp_type = 7
type_descriptors.EndDungeonWithStarsPush.name = "EndDungeonWithStarsPush"
type_descriptors.EndDungeonWithStarsPush.full_name = ".EndDungeonWithStarsPush"
type_descriptors.EndDungeonWithStarsPush.nested_types = {}
type_descriptors.EndDungeonWithStarsPush.enum_types = {}
type_descriptors.EndDungeonWithStarsPush.fields = {
	field_descriptors.EndDungeonWithStarsPush_currentStars,
	field_descriptors.EndDungeonWithStarsPush_mergedStars,
	field_descriptors.EndDungeonWithStarsPush_rewards,
	field_descriptors.EndDungeonWithStarsPush_statHeroes,
	field_descriptors.EndDungeonWithStarsPush_result,
	field_descriptors.EndDungeonWithStarsPush_heroCount,
	field_descriptors.EndDungeonWithStarsPush_first
}
type_descriptors.EndDungeonWithStarsPush.is_extendable = false
type_descriptors.EndDungeonWithStarsPush.extensions = {}
type_descriptors.SaveLastRecordRequest.name = "SaveLastRecordRequest"
type_descriptors.SaveLastRecordRequest.full_name = ".SaveLastRecordRequest"
type_descriptors.SaveLastRecordRequest.nested_types = {}
type_descriptors.SaveLastRecordRequest.enum_types = {}
type_descriptors.SaveLastRecordRequest.fields = {}
type_descriptors.SaveLastRecordRequest.is_extendable = false
type_descriptors.SaveLastRecordRequest.extensions = {}
field_descriptors.PassPlotDungeonRequest_code.name = "code"
field_descriptors.PassPlotDungeonRequest_code.full_name = ".PassPlotDungeonRequest.code"
field_descriptors.PassPlotDungeonRequest_code.number = 1
field_descriptors.PassPlotDungeonRequest_code.index = 0
field_descriptors.PassPlotDungeonRequest_code.label = 1
field_descriptors.PassPlotDungeonRequest_code.has_default_value = false
field_descriptors.PassPlotDungeonRequest_code.default_value = 0
field_descriptors.PassPlotDungeonRequest_code.type = 5
field_descriptors.PassPlotDungeonRequest_code.cpp_type = 1
type_descriptors.PassPlotDungeonRequest.name = "PassPlotDungeonRequest"
type_descriptors.PassPlotDungeonRequest.full_name = ".PassPlotDungeonRequest"
type_descriptors.PassPlotDungeonRequest.nested_types = {}
type_descriptors.PassPlotDungeonRequest.enum_types = {}
type_descriptors.PassPlotDungeonRequest.fields = {
	field_descriptors.PassPlotDungeonRequest_code
}
type_descriptors.PassPlotDungeonRequest.is_extendable = false
type_descriptors.PassPlotDungeonRequest.extensions = {}
type_descriptors.FinishPostwarPlotReply.name = "FinishPostwarPlotReply"
type_descriptors.FinishPostwarPlotReply.full_name = ".FinishPostwarPlotReply"
type_descriptors.FinishPostwarPlotReply.nested_types = {}
type_descriptors.FinishPostwarPlotReply.enum_types = {}
type_descriptors.FinishPostwarPlotReply.fields = {}
type_descriptors.FinishPostwarPlotReply.is_extendable = false
type_descriptors.FinishPostwarPlotReply.extensions = {}
field_descriptors.StartDungeonRequest_code.name = "code"
field_descriptors.StartDungeonRequest_code.full_name = ".StartDungeonRequest.code"
field_descriptors.StartDungeonRequest_code.number = 1
field_descriptors.StartDungeonRequest_code.index = 0
field_descriptors.StartDungeonRequest_code.label = 1
field_descriptors.StartDungeonRequest_code.has_default_value = false
field_descriptors.StartDungeonRequest_code.default_value = 0
field_descriptors.StartDungeonRequest_code.type = 5
field_descriptors.StartDungeonRequest_code.cpp_type = 1
field_descriptors.StartDungeonRequest_multiplied.name = "multiplied"
field_descriptors.StartDungeonRequest_multiplied.full_name = ".StartDungeonRequest.multiplied"
field_descriptors.StartDungeonRequest_multiplied.number = 2
field_descriptors.StartDungeonRequest_multiplied.index = 1
field_descriptors.StartDungeonRequest_multiplied.label = 1
field_descriptors.StartDungeonRequest_multiplied.has_default_value = false
field_descriptors.StartDungeonRequest_multiplied.default_value = 0
field_descriptors.StartDungeonRequest_multiplied.type = 5
field_descriptors.StartDungeonRequest_multiplied.cpp_type = 1
field_descriptors.StartDungeonRequest_restart.name = "restart"
field_descriptors.StartDungeonRequest_restart.full_name = ".StartDungeonRequest.restart"
field_descriptors.StartDungeonRequest_restart.number = 3
field_descriptors.StartDungeonRequest_restart.index = 2
field_descriptors.StartDungeonRequest_restart.label = 1
field_descriptors.StartDungeonRequest_restart.has_default_value = false
field_descriptors.StartDungeonRequest_restart.default_value = false
field_descriptors.StartDungeonRequest_restart.type = 8
field_descriptors.StartDungeonRequest_restart.cpp_type = 7
field_descriptors.StartDungeonRequest_gameplay.name = "gameplay"
field_descriptors.StartDungeonRequest_gameplay.full_name = ".StartDungeonRequest.gameplay"
field_descriptors.StartDungeonRequest_gameplay.number = 4
field_descriptors.StartDungeonRequest_gameplay.index = 3
field_descriptors.StartDungeonRequest_gameplay.label = 1
field_descriptors.StartDungeonRequest_gameplay.has_default_value = false
field_descriptors.StartDungeonRequest_gameplay.default_value = nil
field_descriptors.StartDungeonRequest_gameplay.enum_type = dependencies.BattleExtension.type_descriptors.Gameplay
field_descriptors.StartDungeonRequest_gameplay.type = 14
field_descriptors.StartDungeonRequest_gameplay.cpp_type = 8
type_descriptors.StartDungeonRequest.name = "StartDungeonRequest"
type_descriptors.StartDungeonRequest.full_name = ".StartDungeonRequest"
type_descriptors.StartDungeonRequest.nested_types = {}
type_descriptors.StartDungeonRequest.enum_types = {}
type_descriptors.StartDungeonRequest.fields = {
	field_descriptors.StartDungeonRequest_code,
	field_descriptors.StartDungeonRequest_multiplied,
	field_descriptors.StartDungeonRequest_restart,
	field_descriptors.StartDungeonRequest_gameplay
}
type_descriptors.StartDungeonRequest.is_extendable = false
type_descriptors.StartDungeonRequest.extensions = {}
BattleTeamType = {
	TEAM_MATERIAL_1006 = 1006,
	TEAM_EQUIPMENT_2001 = 2001,
	TEAM_MATERIAL_1005 = 1005,
	TEAM_AIR = 6,
	TEAM_EQUIPMENT_2003 = 2003,
	TEAM_LIGHT_TOWER = 4,
	TEAM_DARK_TOWER = 5,
	TEAM_EQUIPMENT_2004 = 2004,
	TEAM_EQUIPMENT_2002 = 2002,
	TEAM_CONTROL_ACTION = 3,
	TEAM_MATERIAL_1004 = 1004,
	TEAM_MATERIAL_1003 = 1003,
	TEAM_MAINLINE = 1,
	TEAM_MATERIAL_1002 = 1002,
	TEAM_MATERIAL_1001 = 1001,
	TEAM_MATERIAL_1008 = 1008,
	TEAM_MATERIAL_1007 = 1007
}
DungeonType = {
	EQUIPMENT = 7,
	MAINLINE = 1,
	TACIT = 2,
	LIGHT_TOWER = 10,
	PROLOGUE = 5,
	TRAINING = 6,
	DARK_TOWER = 11,
	CONTROL_ACTION_GUIDE = 14,
	HERO_EARLY_ACCESS = 16,
	POWER_CHALLENGE = 17,
	BRANCHLINE = 12,
	EXP = 9,
	GOLD = 8,
	MATERIAL = 4,
	CONTROL_ACTION = 13
}
ChangeLastBattleTeamPush = protobuf.Message(type_descriptors.ChangeLastBattleTeamPush)
ConsecutiveRewardNO = protobuf.Message(type_descriptors.ConsecutiveRewardNO)
DungeonNO = protobuf.Message(type_descriptors.DungeonNO)
EndDungeonWithStarsPush = protobuf.Message(type_descriptors.EndDungeonWithStarsPush)
EndingDungeonRewardNO = protobuf.Message(type_descriptors.EndingDungeonRewardNO)
EndingDungeonStatHeroNO = protobuf.Message(type_descriptors.EndingDungeonStatHeroNO)
FinishPostwarPlotReply = protobuf.Message(type_descriptors.FinishPostwarPlotReply)
FinishPostwarPlotRequest = protobuf.Message(type_descriptors.FinishPostwarPlotRequest)
GetConsecutiveInfoReply = protobuf.Message(type_descriptors.GetConsecutiveInfoReply)
GetConsecutiveInfoRequest = protobuf.Message(type_descriptors.GetConsecutiveInfoRequest)
GetDungeonInfoReply = protobuf.Message(type_descriptors.GetDungeonInfoReply)
GetDungeonInfoRequest = protobuf.Message(type_descriptors.GetDungeonInfoRequest)
LastBattleTeamNO = protobuf.Message(type_descriptors.LastBattleTeamNO)
PassPlotDungeonReply = protobuf.Message(type_descriptors.PassPlotDungeonReply)
PassPlotDungeonRequest = protobuf.Message(type_descriptors.PassPlotDungeonRequest)
SaveLastRecordReply = protobuf.Message(type_descriptors.SaveLastRecordReply)
SaveLastRecordRequest = protobuf.Message(type_descriptors.SaveLastRecordRequest)
StarTakenMainlineNO = protobuf.Message(type_descriptors.StarTakenMainlineNO)
StartDungeonReply = protobuf.Message(type_descriptors.StartDungeonReply)
StartDungeonRequest = protobuf.Message(type_descriptors.StartDungeonRequest)
TakeMainlineStarRewardReply = protobuf.Message(type_descriptors.TakeMainlineStarRewardReply)
TakeMainlineStarRewardRequest = protobuf.Message(type_descriptors.TakeMainlineStarRewardRequest)
TakeTrainingRewardReply = protobuf.Message(type_descriptors.TakeTrainingRewardReply)
TakeTrainingRewardRequest = protobuf.Message(type_descriptors.TakeTrainingRewardRequest)
ViewVideoReply = protobuf.Message(type_descriptors.ViewVideoReply)
ViewVideoRequest = protobuf.Message(type_descriptors.ViewVideoRequest)

return _G["logic.proto.DungeonExtension_pb"]

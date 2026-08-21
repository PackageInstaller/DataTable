-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/ActivityExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.ActivityExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.ActivityLogic = protobuf.EnumDescriptor()
enum_item_descriptors.ActivityLogic_LOTTERY = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_SIGN_IN_HISTORY = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_FOOTBALL = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_SURVEY = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_SEASON = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_HERO_EARLY_ACCESS = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_SCORE = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_CLIP_DOLL = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_DUNGEON_REWARD_UP = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_REWARD_TASK = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_WEEKEND_SUPPLIES = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_POWER_CHALLENGE = protobuf.EnumValueDescriptor()
enum_item_descriptors.ActivityLogic_SUBSCRIBE_GIFTS = protobuf.EnumValueDescriptor()
type_descriptors.Day = protobuf.EnumDescriptor()
enum_item_descriptors.Day_SATURDAY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Day_SUNDAY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Day_MONDAY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Day_EXTRA = protobuf.EnumValueDescriptor()
type_descriptors.ScoreActivityInfoNO = protobuf.Descriptor()
field_descriptors.ScoreActivityInfoNO_activity = protobuf.FieldDescriptor()
field_descriptors.ScoreActivityInfoNO_rewardBits = protobuf.FieldDescriptor()
type_descriptors.GainScoreActivityRewardReply = protobuf.Descriptor()
type_descriptors.GetHeroEarlyAccessRewardRequest = protobuf.Descriptor()
field_descriptors.GetHeroEarlyAccessRewardRequest_actId = protobuf.FieldDescriptor()
type_descriptors.UseGiftCodeReply = protobuf.Descriptor()
type_descriptors.GetHeroEarlyAccessRewardReply = protobuf.Descriptor()
field_descriptors.GetHeroEarlyAccessRewardReply_actId = protobuf.FieldDescriptor()
type_descriptors.DungeonRewardUpCountPush = protobuf.Descriptor()
field_descriptors.DungeonRewardUpCountPush_actConfigId = protobuf.FieldDescriptor()
field_descriptors.DungeonRewardUpCountPush_count = protobuf.FieldDescriptor()
type_descriptors.TakeWeekendSuppliesRequest = protobuf.Descriptor()
field_descriptors.TakeWeekendSuppliesRequest_actConfigId = protobuf.FieldDescriptor()
field_descriptors.TakeWeekendSuppliesRequest_day = protobuf.FieldDescriptor()
type_descriptors.GetScoreActivityInfoRequest = protobuf.Descriptor()
type_descriptors.GetScoreActivityInfoReply = protobuf.Descriptor()
field_descriptors.GetScoreActivityInfoReply_infos = protobuf.FieldDescriptor()
type_descriptors.GetActivityInfoReply = protobuf.Descriptor()
field_descriptors.GetActivityInfoReply_activities = protobuf.FieldDescriptor()
type_descriptors.TakeSignInRewardRequest = protobuf.Descriptor()
field_descriptors.TakeSignInRewardRequest_activity = protobuf.FieldDescriptor()
field_descriptors.TakeSignInRewardRequest_day = protobuf.FieldDescriptor()
type_descriptors.ChangeActivityPush = protobuf.Descriptor()
field_descriptors.ChangeActivityPush_opened = protobuf.FieldDescriptor()
field_descriptors.ChangeActivityPush_closed = protobuf.FieldDescriptor()
type_descriptors.UseGiftCodeRequest = protobuf.Descriptor()
field_descriptors.UseGiftCodeRequest_giftCode = protobuf.FieldDescriptor()
type_descriptors.GetSignInInfoReply = protobuf.Descriptor()
field_descriptors.GetSignInInfoReply_infos = protobuf.FieldDescriptor()
type_descriptors.TakeWeekendSuppliesReply = protobuf.Descriptor()
field_descriptors.TakeWeekendSuppliesReply_actConfigId = protobuf.FieldDescriptor()
field_descriptors.TakeWeekendSuppliesReply_day = protobuf.FieldDescriptor()
type_descriptors.SignInInfoNO = protobuf.Descriptor()
field_descriptors.SignInInfoNO_activity = protobuf.FieldDescriptor()
field_descriptors.SignInInfoNO_tokenRewardDays = protobuf.FieldDescriptor()
field_descriptors.SignInInfoNO_totalSigned = protobuf.FieldDescriptor()
type_descriptors.GainScoreActivityRewardRequest = protobuf.Descriptor()
field_descriptors.GainScoreActivityRewardRequest_index = protobuf.FieldDescriptor()
field_descriptors.GainScoreActivityRewardRequest_activity = protobuf.FieldDescriptor()
type_descriptors.ActivityNO = protobuf.Descriptor()
field_descriptors.ActivityNO_id = protobuf.FieldDescriptor()
field_descriptors.ActivityNO_logic = protobuf.FieldDescriptor()
field_descriptors.ActivityNO_config = protobuf.FieldDescriptor()
field_descriptors.ActivityNO_data = protobuf.FieldDescriptor()
field_descriptors.ActivityNO_startedTime = protobuf.FieldDescriptor()
field_descriptors.ActivityNO_endedTime = protobuf.FieldDescriptor()
type_descriptors.TakeSignInRewardReply = protobuf.Descriptor()
field_descriptors.TakeSignInRewardReply_activity = protobuf.FieldDescriptor()
field_descriptors.TakeSignInRewardReply_day = protobuf.FieldDescriptor()
type_descriptors.GetActivityInfoRequest = protobuf.Descriptor()
type_descriptors.GetSignInInfoRequest = protobuf.Descriptor()
enum_item_descriptors.ActivityLogic_LOTTERY.name = "LOTTERY"
enum_item_descriptors.ActivityLogic_LOTTERY.index = 0
enum_item_descriptors.ActivityLogic_LOTTERY.number = 1
enum_item_descriptors.ActivityLogic_SIGN_IN_HISTORY.name = "SIGN_IN_HISTORY"
enum_item_descriptors.ActivityLogic_SIGN_IN_HISTORY.index = 1
enum_item_descriptors.ActivityLogic_SIGN_IN_HISTORY.number = 2
enum_item_descriptors.ActivityLogic_FOOTBALL.name = "FOOTBALL"
enum_item_descriptors.ActivityLogic_FOOTBALL.index = 2
enum_item_descriptors.ActivityLogic_FOOTBALL.number = 3
enum_item_descriptors.ActivityLogic_SURVEY.name = "SURVEY"
enum_item_descriptors.ActivityLogic_SURVEY.index = 3
enum_item_descriptors.ActivityLogic_SURVEY.number = 4
enum_item_descriptors.ActivityLogic_SEASON.name = "SEASON"
enum_item_descriptors.ActivityLogic_SEASON.index = 4
enum_item_descriptors.ActivityLogic_SEASON.number = 5
enum_item_descriptors.ActivityLogic_HERO_EARLY_ACCESS.name = "HERO_EARLY_ACCESS"
enum_item_descriptors.ActivityLogic_HERO_EARLY_ACCESS.index = 5
enum_item_descriptors.ActivityLogic_HERO_EARLY_ACCESS.number = 6
enum_item_descriptors.ActivityLogic_SCORE.name = "SCORE"
enum_item_descriptors.ActivityLogic_SCORE.index = 6
enum_item_descriptors.ActivityLogic_SCORE.number = 7
enum_item_descriptors.ActivityLogic_CLIP_DOLL.name = "CLIP_DOLL"
enum_item_descriptors.ActivityLogic_CLIP_DOLL.index = 7
enum_item_descriptors.ActivityLogic_CLIP_DOLL.number = 8
enum_item_descriptors.ActivityLogic_DUNGEON_REWARD_UP.name = "DUNGEON_REWARD_UP"
enum_item_descriptors.ActivityLogic_DUNGEON_REWARD_UP.index = 8
enum_item_descriptors.ActivityLogic_DUNGEON_REWARD_UP.number = 9
enum_item_descriptors.ActivityLogic_REWARD_TASK.name = "REWARD_TASK"
enum_item_descriptors.ActivityLogic_REWARD_TASK.index = 9
enum_item_descriptors.ActivityLogic_REWARD_TASK.number = 10
enum_item_descriptors.ActivityLogic_WEEKEND_SUPPLIES.name = "WEEKEND_SUPPLIES"
enum_item_descriptors.ActivityLogic_WEEKEND_SUPPLIES.index = 10
enum_item_descriptors.ActivityLogic_WEEKEND_SUPPLIES.number = 11
enum_item_descriptors.ActivityLogic_POWER_CHALLENGE.name = "POWER_CHALLENGE"
enum_item_descriptors.ActivityLogic_POWER_CHALLENGE.index = 11
enum_item_descriptors.ActivityLogic_POWER_CHALLENGE.number = 12
enum_item_descriptors.ActivityLogic_SUBSCRIBE_GIFTS.name = "SUBSCRIBE_GIFTS"
enum_item_descriptors.ActivityLogic_SUBSCRIBE_GIFTS.index = 12
enum_item_descriptors.ActivityLogic_SUBSCRIBE_GIFTS.number = 13
type_descriptors.ActivityLogic.name = "ActivityLogic"
type_descriptors.ActivityLogic.full_name = ".ActivityLogic"
type_descriptors.ActivityLogic.values = {
	enum_item_descriptors.ActivityLogic_LOTTERY,
	enum_item_descriptors.ActivityLogic_SIGN_IN_HISTORY,
	enum_item_descriptors.ActivityLogic_FOOTBALL,
	enum_item_descriptors.ActivityLogic_SURVEY,
	enum_item_descriptors.ActivityLogic_SEASON,
	enum_item_descriptors.ActivityLogic_HERO_EARLY_ACCESS,
	enum_item_descriptors.ActivityLogic_SCORE,
	enum_item_descriptors.ActivityLogic_CLIP_DOLL,
	enum_item_descriptors.ActivityLogic_DUNGEON_REWARD_UP,
	enum_item_descriptors.ActivityLogic_REWARD_TASK,
	enum_item_descriptors.ActivityLogic_WEEKEND_SUPPLIES,
	enum_item_descriptors.ActivityLogic_POWER_CHALLENGE,
	enum_item_descriptors.ActivityLogic_SUBSCRIBE_GIFTS
}
enum_item_descriptors.Day_SATURDAY.name = "SATURDAY"
enum_item_descriptors.Day_SATURDAY.index = 0
enum_item_descriptors.Day_SATURDAY.number = 1
enum_item_descriptors.Day_SUNDAY.name = "SUNDAY"
enum_item_descriptors.Day_SUNDAY.index = 1
enum_item_descriptors.Day_SUNDAY.number = 2
enum_item_descriptors.Day_MONDAY.name = "MONDAY"
enum_item_descriptors.Day_MONDAY.index = 2
enum_item_descriptors.Day_MONDAY.number = 3
enum_item_descriptors.Day_EXTRA.name = "EXTRA"
enum_item_descriptors.Day_EXTRA.index = 3
enum_item_descriptors.Day_EXTRA.number = 4
type_descriptors.Day.name = "Day"
type_descriptors.Day.full_name = ".Day"
type_descriptors.Day.values = {
	enum_item_descriptors.Day_SATURDAY,
	enum_item_descriptors.Day_SUNDAY,
	enum_item_descriptors.Day_MONDAY,
	enum_item_descriptors.Day_EXTRA
}
field_descriptors.ScoreActivityInfoNO_activity.name = "activity"
field_descriptors.ScoreActivityInfoNO_activity.full_name = ".ScoreActivityInfoNO.activity"
field_descriptors.ScoreActivityInfoNO_activity.number = 1
field_descriptors.ScoreActivityInfoNO_activity.index = 0
field_descriptors.ScoreActivityInfoNO_activity.label = 1
field_descriptors.ScoreActivityInfoNO_activity.has_default_value = false
field_descriptors.ScoreActivityInfoNO_activity.default_value = 0
field_descriptors.ScoreActivityInfoNO_activity.type = 5
field_descriptors.ScoreActivityInfoNO_activity.cpp_type = 1
field_descriptors.ScoreActivityInfoNO_rewardBits.name = "rewardBits"
field_descriptors.ScoreActivityInfoNO_rewardBits.full_name = ".ScoreActivityInfoNO.rewardBits"
field_descriptors.ScoreActivityInfoNO_rewardBits.number = 2
field_descriptors.ScoreActivityInfoNO_rewardBits.index = 1
field_descriptors.ScoreActivityInfoNO_rewardBits.label = 1
field_descriptors.ScoreActivityInfoNO_rewardBits.has_default_value = false
field_descriptors.ScoreActivityInfoNO_rewardBits.default_value = 0
field_descriptors.ScoreActivityInfoNO_rewardBits.type = 5
field_descriptors.ScoreActivityInfoNO_rewardBits.cpp_type = 1
type_descriptors.ScoreActivityInfoNO.name = "ScoreActivityInfoNO"
type_descriptors.ScoreActivityInfoNO.full_name = ".ScoreActivityInfoNO"
type_descriptors.ScoreActivityInfoNO.nested_types = {}
type_descriptors.ScoreActivityInfoNO.enum_types = {}
type_descriptors.ScoreActivityInfoNO.fields = {
	field_descriptors.ScoreActivityInfoNO_activity,
	field_descriptors.ScoreActivityInfoNO_rewardBits
}
type_descriptors.ScoreActivityInfoNO.is_extendable = false
type_descriptors.ScoreActivityInfoNO.extensions = {}
type_descriptors.GainScoreActivityRewardReply.name = "GainScoreActivityRewardReply"
type_descriptors.GainScoreActivityRewardReply.full_name = ".GainScoreActivityRewardReply"
type_descriptors.GainScoreActivityRewardReply.nested_types = {}
type_descriptors.GainScoreActivityRewardReply.enum_types = {}
type_descriptors.GainScoreActivityRewardReply.fields = {}
type_descriptors.GainScoreActivityRewardReply.is_extendable = false
type_descriptors.GainScoreActivityRewardReply.extensions = {}
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.name = "actId"
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.full_name = ".GetHeroEarlyAccessRewardRequest.actId"
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.number = 1
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.index = 0
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.label = 2
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.has_default_value = false
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.default_value = 0
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.type = 5
field_descriptors.GetHeroEarlyAccessRewardRequest_actId.cpp_type = 1
type_descriptors.GetHeroEarlyAccessRewardRequest.name = "GetHeroEarlyAccessRewardRequest"
type_descriptors.GetHeroEarlyAccessRewardRequest.full_name = ".GetHeroEarlyAccessRewardRequest"
type_descriptors.GetHeroEarlyAccessRewardRequest.nested_types = {}
type_descriptors.GetHeroEarlyAccessRewardRequest.enum_types = {}
type_descriptors.GetHeroEarlyAccessRewardRequest.fields = {
	field_descriptors.GetHeroEarlyAccessRewardRequest_actId
}
type_descriptors.GetHeroEarlyAccessRewardRequest.is_extendable = false
type_descriptors.GetHeroEarlyAccessRewardRequest.extensions = {}
type_descriptors.UseGiftCodeReply.name = "UseGiftCodeReply"
type_descriptors.UseGiftCodeReply.full_name = ".UseGiftCodeReply"
type_descriptors.UseGiftCodeReply.nested_types = {}
type_descriptors.UseGiftCodeReply.enum_types = {}
type_descriptors.UseGiftCodeReply.fields = {}
type_descriptors.UseGiftCodeReply.is_extendable = false
type_descriptors.UseGiftCodeReply.extensions = {}
field_descriptors.GetHeroEarlyAccessRewardReply_actId.name = "actId"
field_descriptors.GetHeroEarlyAccessRewardReply_actId.full_name = ".GetHeroEarlyAccessRewardReply.actId"
field_descriptors.GetHeroEarlyAccessRewardReply_actId.number = 1
field_descriptors.GetHeroEarlyAccessRewardReply_actId.index = 0
field_descriptors.GetHeroEarlyAccessRewardReply_actId.label = 2
field_descriptors.GetHeroEarlyAccessRewardReply_actId.has_default_value = false
field_descriptors.GetHeroEarlyAccessRewardReply_actId.default_value = 0
field_descriptors.GetHeroEarlyAccessRewardReply_actId.type = 5
field_descriptors.GetHeroEarlyAccessRewardReply_actId.cpp_type = 1
type_descriptors.GetHeroEarlyAccessRewardReply.name = "GetHeroEarlyAccessRewardReply"
type_descriptors.GetHeroEarlyAccessRewardReply.full_name = ".GetHeroEarlyAccessRewardReply"
type_descriptors.GetHeroEarlyAccessRewardReply.nested_types = {}
type_descriptors.GetHeroEarlyAccessRewardReply.enum_types = {}
type_descriptors.GetHeroEarlyAccessRewardReply.fields = {
	field_descriptors.GetHeroEarlyAccessRewardReply_actId
}
type_descriptors.GetHeroEarlyAccessRewardReply.is_extendable = false
type_descriptors.GetHeroEarlyAccessRewardReply.extensions = {}
field_descriptors.DungeonRewardUpCountPush_actConfigId.name = "actConfigId"
field_descriptors.DungeonRewardUpCountPush_actConfigId.full_name = ".DungeonRewardUpCountPush.actConfigId"
field_descriptors.DungeonRewardUpCountPush_actConfigId.number = 1
field_descriptors.DungeonRewardUpCountPush_actConfigId.index = 0
field_descriptors.DungeonRewardUpCountPush_actConfigId.label = 2
field_descriptors.DungeonRewardUpCountPush_actConfigId.has_default_value = false
field_descriptors.DungeonRewardUpCountPush_actConfigId.default_value = 0
field_descriptors.DungeonRewardUpCountPush_actConfigId.type = 5
field_descriptors.DungeonRewardUpCountPush_actConfigId.cpp_type = 1
field_descriptors.DungeonRewardUpCountPush_count.name = "count"
field_descriptors.DungeonRewardUpCountPush_count.full_name = ".DungeonRewardUpCountPush.count"
field_descriptors.DungeonRewardUpCountPush_count.number = 2
field_descriptors.DungeonRewardUpCountPush_count.index = 1
field_descriptors.DungeonRewardUpCountPush_count.label = 2
field_descriptors.DungeonRewardUpCountPush_count.has_default_value = false
field_descriptors.DungeonRewardUpCountPush_count.default_value = 0
field_descriptors.DungeonRewardUpCountPush_count.type = 5
field_descriptors.DungeonRewardUpCountPush_count.cpp_type = 1
type_descriptors.DungeonRewardUpCountPush.name = "DungeonRewardUpCountPush"
type_descriptors.DungeonRewardUpCountPush.full_name = ".DungeonRewardUpCountPush"
type_descriptors.DungeonRewardUpCountPush.nested_types = {}
type_descriptors.DungeonRewardUpCountPush.enum_types = {}
type_descriptors.DungeonRewardUpCountPush.fields = {
	field_descriptors.DungeonRewardUpCountPush_actConfigId,
	field_descriptors.DungeonRewardUpCountPush_count
}
type_descriptors.DungeonRewardUpCountPush.is_extendable = false
type_descriptors.DungeonRewardUpCountPush.extensions = {}
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.name = "actConfigId"
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.full_name = ".TakeWeekendSuppliesRequest.actConfigId"
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.number = 1
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.index = 0
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.label = 2
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.has_default_value = false
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.default_value = 0
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.type = 5
field_descriptors.TakeWeekendSuppliesRequest_actConfigId.cpp_type = 1
field_descriptors.TakeWeekendSuppliesRequest_day.name = "day"
field_descriptors.TakeWeekendSuppliesRequest_day.full_name = ".TakeWeekendSuppliesRequest.day"
field_descriptors.TakeWeekendSuppliesRequest_day.number = 2
field_descriptors.TakeWeekendSuppliesRequest_day.index = 1
field_descriptors.TakeWeekendSuppliesRequest_day.label = 2
field_descriptors.TakeWeekendSuppliesRequest_day.has_default_value = false
field_descriptors.TakeWeekendSuppliesRequest_day.default_value = nil
field_descriptors.TakeWeekendSuppliesRequest_day.enum_type = type_descriptors.Day
field_descriptors.TakeWeekendSuppliesRequest_day.type = 14
field_descriptors.TakeWeekendSuppliesRequest_day.cpp_type = 8
type_descriptors.TakeWeekendSuppliesRequest.name = "TakeWeekendSuppliesRequest"
type_descriptors.TakeWeekendSuppliesRequest.full_name = ".TakeWeekendSuppliesRequest"
type_descriptors.TakeWeekendSuppliesRequest.nested_types = {}
type_descriptors.TakeWeekendSuppliesRequest.enum_types = {}
type_descriptors.TakeWeekendSuppliesRequest.fields = {
	field_descriptors.TakeWeekendSuppliesRequest_actConfigId,
	field_descriptors.TakeWeekendSuppliesRequest_day
}
type_descriptors.TakeWeekendSuppliesRequest.is_extendable = false
type_descriptors.TakeWeekendSuppliesRequest.extensions = {}
type_descriptors.GetScoreActivityInfoRequest.name = "GetScoreActivityInfoRequest"
type_descriptors.GetScoreActivityInfoRequest.full_name = ".GetScoreActivityInfoRequest"
type_descriptors.GetScoreActivityInfoRequest.nested_types = {}
type_descriptors.GetScoreActivityInfoRequest.enum_types = {}
type_descriptors.GetScoreActivityInfoRequest.fields = {}
type_descriptors.GetScoreActivityInfoRequest.is_extendable = false
type_descriptors.GetScoreActivityInfoRequest.extensions = {}
field_descriptors.GetScoreActivityInfoReply_infos.name = "infos"
field_descriptors.GetScoreActivityInfoReply_infos.full_name = ".GetScoreActivityInfoReply.infos"
field_descriptors.GetScoreActivityInfoReply_infos.number = 2
field_descriptors.GetScoreActivityInfoReply_infos.index = 0
field_descriptors.GetScoreActivityInfoReply_infos.label = 3
field_descriptors.GetScoreActivityInfoReply_infos.has_default_value = false
field_descriptors.GetScoreActivityInfoReply_infos.default_value = {}
field_descriptors.GetScoreActivityInfoReply_infos.message_type = type_descriptors.ScoreActivityInfoNO
field_descriptors.GetScoreActivityInfoReply_infos.type = 11
field_descriptors.GetScoreActivityInfoReply_infos.cpp_type = 10
type_descriptors.GetScoreActivityInfoReply.name = "GetScoreActivityInfoReply"
type_descriptors.GetScoreActivityInfoReply.full_name = ".GetScoreActivityInfoReply"
type_descriptors.GetScoreActivityInfoReply.nested_types = {}
type_descriptors.GetScoreActivityInfoReply.enum_types = {}
type_descriptors.GetScoreActivityInfoReply.fields = {
	field_descriptors.GetScoreActivityInfoReply_infos
}
type_descriptors.GetScoreActivityInfoReply.is_extendable = false
type_descriptors.GetScoreActivityInfoReply.extensions = {}
field_descriptors.GetActivityInfoReply_activities.name = "activities"
field_descriptors.GetActivityInfoReply_activities.full_name = ".GetActivityInfoReply.activities"
field_descriptors.GetActivityInfoReply_activities.number = 1
field_descriptors.GetActivityInfoReply_activities.index = 0
field_descriptors.GetActivityInfoReply_activities.label = 3
field_descriptors.GetActivityInfoReply_activities.has_default_value = false
field_descriptors.GetActivityInfoReply_activities.default_value = {}
field_descriptors.GetActivityInfoReply_activities.message_type = type_descriptors.ActivityNO
field_descriptors.GetActivityInfoReply_activities.type = 11
field_descriptors.GetActivityInfoReply_activities.cpp_type = 10
type_descriptors.GetActivityInfoReply.name = "GetActivityInfoReply"
type_descriptors.GetActivityInfoReply.full_name = ".GetActivityInfoReply"
type_descriptors.GetActivityInfoReply.nested_types = {}
type_descriptors.GetActivityInfoReply.enum_types = {}
type_descriptors.GetActivityInfoReply.fields = {
	field_descriptors.GetActivityInfoReply_activities
}
type_descriptors.GetActivityInfoReply.is_extendable = false
type_descriptors.GetActivityInfoReply.extensions = {}
field_descriptors.TakeSignInRewardRequest_activity.name = "activity"
field_descriptors.TakeSignInRewardRequest_activity.full_name = ".TakeSignInRewardRequest.activity"
field_descriptors.TakeSignInRewardRequest_activity.number = 1
field_descriptors.TakeSignInRewardRequest_activity.index = 0
field_descriptors.TakeSignInRewardRequest_activity.label = 2
field_descriptors.TakeSignInRewardRequest_activity.has_default_value = false
field_descriptors.TakeSignInRewardRequest_activity.default_value = 0
field_descriptors.TakeSignInRewardRequest_activity.type = 5
field_descriptors.TakeSignInRewardRequest_activity.cpp_type = 1
field_descriptors.TakeSignInRewardRequest_day.name = "day"
field_descriptors.TakeSignInRewardRequest_day.full_name = ".TakeSignInRewardRequest.day"
field_descriptors.TakeSignInRewardRequest_day.number = 2
field_descriptors.TakeSignInRewardRequest_day.index = 1
field_descriptors.TakeSignInRewardRequest_day.label = 2
field_descriptors.TakeSignInRewardRequest_day.has_default_value = false
field_descriptors.TakeSignInRewardRequest_day.default_value = 0
field_descriptors.TakeSignInRewardRequest_day.type = 5
field_descriptors.TakeSignInRewardRequest_day.cpp_type = 1
type_descriptors.TakeSignInRewardRequest.name = "TakeSignInRewardRequest"
type_descriptors.TakeSignInRewardRequest.full_name = ".TakeSignInRewardRequest"
type_descriptors.TakeSignInRewardRequest.nested_types = {}
type_descriptors.TakeSignInRewardRequest.enum_types = {}
type_descriptors.TakeSignInRewardRequest.fields = {
	field_descriptors.TakeSignInRewardRequest_activity,
	field_descriptors.TakeSignInRewardRequest_day
}
type_descriptors.TakeSignInRewardRequest.is_extendable = false
type_descriptors.TakeSignInRewardRequest.extensions = {}
field_descriptors.ChangeActivityPush_opened.name = "opened"
field_descriptors.ChangeActivityPush_opened.full_name = ".ChangeActivityPush.opened"
field_descriptors.ChangeActivityPush_opened.number = 1
field_descriptors.ChangeActivityPush_opened.index = 0
field_descriptors.ChangeActivityPush_opened.label = 3
field_descriptors.ChangeActivityPush_opened.has_default_value = false
field_descriptors.ChangeActivityPush_opened.default_value = {}
field_descriptors.ChangeActivityPush_opened.message_type = type_descriptors.ActivityNO
field_descriptors.ChangeActivityPush_opened.type = 11
field_descriptors.ChangeActivityPush_opened.cpp_type = 10
field_descriptors.ChangeActivityPush_closed.name = "closed"
field_descriptors.ChangeActivityPush_closed.full_name = ".ChangeActivityPush.closed"
field_descriptors.ChangeActivityPush_closed.number = 2
field_descriptors.ChangeActivityPush_closed.index = 1
field_descriptors.ChangeActivityPush_closed.label = 3
field_descriptors.ChangeActivityPush_closed.has_default_value = false
field_descriptors.ChangeActivityPush_closed.default_value = {}
field_descriptors.ChangeActivityPush_closed.type = 5
field_descriptors.ChangeActivityPush_closed.cpp_type = 1
type_descriptors.ChangeActivityPush.name = "ChangeActivityPush"
type_descriptors.ChangeActivityPush.full_name = ".ChangeActivityPush"
type_descriptors.ChangeActivityPush.nested_types = {}
type_descriptors.ChangeActivityPush.enum_types = {}
type_descriptors.ChangeActivityPush.fields = {
	field_descriptors.ChangeActivityPush_opened,
	field_descriptors.ChangeActivityPush_closed
}
type_descriptors.ChangeActivityPush.is_extendable = false
type_descriptors.ChangeActivityPush.extensions = {}
field_descriptors.UseGiftCodeRequest_giftCode.name = "giftCode"
field_descriptors.UseGiftCodeRequest_giftCode.full_name = ".UseGiftCodeRequest.giftCode"
field_descriptors.UseGiftCodeRequest_giftCode.number = 1
field_descriptors.UseGiftCodeRequest_giftCode.index = 0
field_descriptors.UseGiftCodeRequest_giftCode.label = 2
field_descriptors.UseGiftCodeRequest_giftCode.has_default_value = false
field_descriptors.UseGiftCodeRequest_giftCode.default_value = ""
field_descriptors.UseGiftCodeRequest_giftCode.type = 9
field_descriptors.UseGiftCodeRequest_giftCode.cpp_type = 9
type_descriptors.UseGiftCodeRequest.name = "UseGiftCodeRequest"
type_descriptors.UseGiftCodeRequest.full_name = ".UseGiftCodeRequest"
type_descriptors.UseGiftCodeRequest.nested_types = {}
type_descriptors.UseGiftCodeRequest.enum_types = {}
type_descriptors.UseGiftCodeRequest.fields = {
	field_descriptors.UseGiftCodeRequest_giftCode
}
type_descriptors.UseGiftCodeRequest.is_extendable = false
type_descriptors.UseGiftCodeRequest.extensions = {}
field_descriptors.GetSignInInfoReply_infos.name = "infos"
field_descriptors.GetSignInInfoReply_infos.full_name = ".GetSignInInfoReply.infos"
field_descriptors.GetSignInInfoReply_infos.number = 1
field_descriptors.GetSignInInfoReply_infos.index = 0
field_descriptors.GetSignInInfoReply_infos.label = 3
field_descriptors.GetSignInInfoReply_infos.has_default_value = false
field_descriptors.GetSignInInfoReply_infos.default_value = {}
field_descriptors.GetSignInInfoReply_infos.message_type = type_descriptors.SignInInfoNO
field_descriptors.GetSignInInfoReply_infos.type = 11
field_descriptors.GetSignInInfoReply_infos.cpp_type = 10
type_descriptors.GetSignInInfoReply.name = "GetSignInInfoReply"
type_descriptors.GetSignInInfoReply.full_name = ".GetSignInInfoReply"
type_descriptors.GetSignInInfoReply.nested_types = {}
type_descriptors.GetSignInInfoReply.enum_types = {}
type_descriptors.GetSignInInfoReply.fields = {
	field_descriptors.GetSignInInfoReply_infos
}
type_descriptors.GetSignInInfoReply.is_extendable = false
type_descriptors.GetSignInInfoReply.extensions = {}
field_descriptors.TakeWeekendSuppliesReply_actConfigId.name = "actConfigId"
field_descriptors.TakeWeekendSuppliesReply_actConfigId.full_name = ".TakeWeekendSuppliesReply.actConfigId"
field_descriptors.TakeWeekendSuppliesReply_actConfigId.number = 1
field_descriptors.TakeWeekendSuppliesReply_actConfigId.index = 0
field_descriptors.TakeWeekendSuppliesReply_actConfigId.label = 2
field_descriptors.TakeWeekendSuppliesReply_actConfigId.has_default_value = false
field_descriptors.TakeWeekendSuppliesReply_actConfigId.default_value = 0
field_descriptors.TakeWeekendSuppliesReply_actConfigId.type = 5
field_descriptors.TakeWeekendSuppliesReply_actConfigId.cpp_type = 1
field_descriptors.TakeWeekendSuppliesReply_day.name = "day"
field_descriptors.TakeWeekendSuppliesReply_day.full_name = ".TakeWeekendSuppliesReply.day"
field_descriptors.TakeWeekendSuppliesReply_day.number = 2
field_descriptors.TakeWeekendSuppliesReply_day.index = 1
field_descriptors.TakeWeekendSuppliesReply_day.label = 2
field_descriptors.TakeWeekendSuppliesReply_day.has_default_value = false
field_descriptors.TakeWeekendSuppliesReply_day.default_value = nil
field_descriptors.TakeWeekendSuppliesReply_day.enum_type = type_descriptors.Day
field_descriptors.TakeWeekendSuppliesReply_day.type = 14
field_descriptors.TakeWeekendSuppliesReply_day.cpp_type = 8
type_descriptors.TakeWeekendSuppliesReply.name = "TakeWeekendSuppliesReply"
type_descriptors.TakeWeekendSuppliesReply.full_name = ".TakeWeekendSuppliesReply"
type_descriptors.TakeWeekendSuppliesReply.nested_types = {}
type_descriptors.TakeWeekendSuppliesReply.enum_types = {}
type_descriptors.TakeWeekendSuppliesReply.fields = {
	field_descriptors.TakeWeekendSuppliesReply_actConfigId,
	field_descriptors.TakeWeekendSuppliesReply_day
}
type_descriptors.TakeWeekendSuppliesReply.is_extendable = false
type_descriptors.TakeWeekendSuppliesReply.extensions = {}
field_descriptors.SignInInfoNO_activity.name = "activity"
field_descriptors.SignInInfoNO_activity.full_name = ".SignInInfoNO.activity"
field_descriptors.SignInInfoNO_activity.number = 1
field_descriptors.SignInInfoNO_activity.index = 0
field_descriptors.SignInInfoNO_activity.label = 2
field_descriptors.SignInInfoNO_activity.has_default_value = false
field_descriptors.SignInInfoNO_activity.default_value = 0
field_descriptors.SignInInfoNO_activity.type = 5
field_descriptors.SignInInfoNO_activity.cpp_type = 1
field_descriptors.SignInInfoNO_tokenRewardDays.name = "tokenRewardDays"
field_descriptors.SignInInfoNO_tokenRewardDays.full_name = ".SignInInfoNO.tokenRewardDays"
field_descriptors.SignInInfoNO_tokenRewardDays.number = 2
field_descriptors.SignInInfoNO_tokenRewardDays.index = 1
field_descriptors.SignInInfoNO_tokenRewardDays.label = 3
field_descriptors.SignInInfoNO_tokenRewardDays.has_default_value = false
field_descriptors.SignInInfoNO_tokenRewardDays.default_value = {}
field_descriptors.SignInInfoNO_tokenRewardDays.type = 5
field_descriptors.SignInInfoNO_tokenRewardDays.cpp_type = 1
field_descriptors.SignInInfoNO_totalSigned.name = "totalSigned"
field_descriptors.SignInInfoNO_totalSigned.full_name = ".SignInInfoNO.totalSigned"
field_descriptors.SignInInfoNO_totalSigned.number = 3
field_descriptors.SignInInfoNO_totalSigned.index = 2
field_descriptors.SignInInfoNO_totalSigned.label = 2
field_descriptors.SignInInfoNO_totalSigned.has_default_value = false
field_descriptors.SignInInfoNO_totalSigned.default_value = 0
field_descriptors.SignInInfoNO_totalSigned.type = 5
field_descriptors.SignInInfoNO_totalSigned.cpp_type = 1
type_descriptors.SignInInfoNO.name = "SignInInfoNO"
type_descriptors.SignInInfoNO.full_name = ".SignInInfoNO"
type_descriptors.SignInInfoNO.nested_types = {}
type_descriptors.SignInInfoNO.enum_types = {}
type_descriptors.SignInInfoNO.fields = {
	field_descriptors.SignInInfoNO_activity,
	field_descriptors.SignInInfoNO_tokenRewardDays,
	field_descriptors.SignInInfoNO_totalSigned
}
type_descriptors.SignInInfoNO.is_extendable = false
type_descriptors.SignInInfoNO.extensions = {}
field_descriptors.GainScoreActivityRewardRequest_index.name = "index"
field_descriptors.GainScoreActivityRewardRequest_index.full_name = ".GainScoreActivityRewardRequest.index"
field_descriptors.GainScoreActivityRewardRequest_index.number = 1
field_descriptors.GainScoreActivityRewardRequest_index.index = 0
field_descriptors.GainScoreActivityRewardRequest_index.label = 1
field_descriptors.GainScoreActivityRewardRequest_index.has_default_value = false
field_descriptors.GainScoreActivityRewardRequest_index.default_value = 0
field_descriptors.GainScoreActivityRewardRequest_index.type = 5
field_descriptors.GainScoreActivityRewardRequest_index.cpp_type = 1
field_descriptors.GainScoreActivityRewardRequest_activity.name = "activity"
field_descriptors.GainScoreActivityRewardRequest_activity.full_name = ".GainScoreActivityRewardRequest.activity"
field_descriptors.GainScoreActivityRewardRequest_activity.number = 2
field_descriptors.GainScoreActivityRewardRequest_activity.index = 1
field_descriptors.GainScoreActivityRewardRequest_activity.label = 1
field_descriptors.GainScoreActivityRewardRequest_activity.has_default_value = false
field_descriptors.GainScoreActivityRewardRequest_activity.default_value = 0
field_descriptors.GainScoreActivityRewardRequest_activity.type = 5
field_descriptors.GainScoreActivityRewardRequest_activity.cpp_type = 1
type_descriptors.GainScoreActivityRewardRequest.name = "GainScoreActivityRewardRequest"
type_descriptors.GainScoreActivityRewardRequest.full_name = ".GainScoreActivityRewardRequest"
type_descriptors.GainScoreActivityRewardRequest.nested_types = {}
type_descriptors.GainScoreActivityRewardRequest.enum_types = {}
type_descriptors.GainScoreActivityRewardRequest.fields = {
	field_descriptors.GainScoreActivityRewardRequest_index,
	field_descriptors.GainScoreActivityRewardRequest_activity
}
type_descriptors.GainScoreActivityRewardRequest.is_extendable = false
type_descriptors.GainScoreActivityRewardRequest.extensions = {}
field_descriptors.ActivityNO_id.name = "id"
field_descriptors.ActivityNO_id.full_name = ".ActivityNO.id"
field_descriptors.ActivityNO_id.number = 1
field_descriptors.ActivityNO_id.index = 0
field_descriptors.ActivityNO_id.label = 1
field_descriptors.ActivityNO_id.has_default_value = false
field_descriptors.ActivityNO_id.default_value = 0
field_descriptors.ActivityNO_id.type = 5
field_descriptors.ActivityNO_id.cpp_type = 1
field_descriptors.ActivityNO_logic.name = "logic"
field_descriptors.ActivityNO_logic.full_name = ".ActivityNO.logic"
field_descriptors.ActivityNO_logic.number = 2
field_descriptors.ActivityNO_logic.index = 1
field_descriptors.ActivityNO_logic.label = 1
field_descriptors.ActivityNO_logic.has_default_value = false
field_descriptors.ActivityNO_logic.default_value = nil
field_descriptors.ActivityNO_logic.enum_type = type_descriptors.ActivityLogic
field_descriptors.ActivityNO_logic.type = 14
field_descriptors.ActivityNO_logic.cpp_type = 8
field_descriptors.ActivityNO_config.name = "config"
field_descriptors.ActivityNO_config.full_name = ".ActivityNO.config"
field_descriptors.ActivityNO_config.number = 3
field_descriptors.ActivityNO_config.index = 2
field_descriptors.ActivityNO_config.label = 1
field_descriptors.ActivityNO_config.has_default_value = false
field_descriptors.ActivityNO_config.default_value = 0
field_descriptors.ActivityNO_config.type = 5
field_descriptors.ActivityNO_config.cpp_type = 1
field_descriptors.ActivityNO_data.name = "data"
field_descriptors.ActivityNO_data.full_name = ".ActivityNO.data"
field_descriptors.ActivityNO_data.number = 4
field_descriptors.ActivityNO_data.index = 3
field_descriptors.ActivityNO_data.label = 1
field_descriptors.ActivityNO_data.has_default_value = false
field_descriptors.ActivityNO_data.default_value = ""
field_descriptors.ActivityNO_data.type = 9
field_descriptors.ActivityNO_data.cpp_type = 9
field_descriptors.ActivityNO_startedTime.name = "startedTime"
field_descriptors.ActivityNO_startedTime.full_name = ".ActivityNO.startedTime"
field_descriptors.ActivityNO_startedTime.number = 5
field_descriptors.ActivityNO_startedTime.index = 4
field_descriptors.ActivityNO_startedTime.label = 1
field_descriptors.ActivityNO_startedTime.has_default_value = false
field_descriptors.ActivityNO_startedTime.default_value = 0
field_descriptors.ActivityNO_startedTime.type = 3
field_descriptors.ActivityNO_startedTime.cpp_type = 2
field_descriptors.ActivityNO_endedTime.name = "endedTime"
field_descriptors.ActivityNO_endedTime.full_name = ".ActivityNO.endedTime"
field_descriptors.ActivityNO_endedTime.number = 6
field_descriptors.ActivityNO_endedTime.index = 5
field_descriptors.ActivityNO_endedTime.label = 1
field_descriptors.ActivityNO_endedTime.has_default_value = false
field_descriptors.ActivityNO_endedTime.default_value = 0
field_descriptors.ActivityNO_endedTime.type = 3
field_descriptors.ActivityNO_endedTime.cpp_type = 2
type_descriptors.ActivityNO.name = "ActivityNO"
type_descriptors.ActivityNO.full_name = ".ActivityNO"
type_descriptors.ActivityNO.nested_types = {}
type_descriptors.ActivityNO.enum_types = {}
type_descriptors.ActivityNO.fields = {
	field_descriptors.ActivityNO_id,
	field_descriptors.ActivityNO_logic,
	field_descriptors.ActivityNO_config,
	field_descriptors.ActivityNO_data,
	field_descriptors.ActivityNO_startedTime,
	field_descriptors.ActivityNO_endedTime
}
type_descriptors.ActivityNO.is_extendable = false
type_descriptors.ActivityNO.extensions = {}
field_descriptors.TakeSignInRewardReply_activity.name = "activity"
field_descriptors.TakeSignInRewardReply_activity.full_name = ".TakeSignInRewardReply.activity"
field_descriptors.TakeSignInRewardReply_activity.number = 1
field_descriptors.TakeSignInRewardReply_activity.index = 0
field_descriptors.TakeSignInRewardReply_activity.label = 2
field_descriptors.TakeSignInRewardReply_activity.has_default_value = false
field_descriptors.TakeSignInRewardReply_activity.default_value = 0
field_descriptors.TakeSignInRewardReply_activity.type = 5
field_descriptors.TakeSignInRewardReply_activity.cpp_type = 1
field_descriptors.TakeSignInRewardReply_day.name = "day"
field_descriptors.TakeSignInRewardReply_day.full_name = ".TakeSignInRewardReply.day"
field_descriptors.TakeSignInRewardReply_day.number = 2
field_descriptors.TakeSignInRewardReply_day.index = 1
field_descriptors.TakeSignInRewardReply_day.label = 2
field_descriptors.TakeSignInRewardReply_day.has_default_value = false
field_descriptors.TakeSignInRewardReply_day.default_value = 0
field_descriptors.TakeSignInRewardReply_day.type = 5
field_descriptors.TakeSignInRewardReply_day.cpp_type = 1
type_descriptors.TakeSignInRewardReply.name = "TakeSignInRewardReply"
type_descriptors.TakeSignInRewardReply.full_name = ".TakeSignInRewardReply"
type_descriptors.TakeSignInRewardReply.nested_types = {}
type_descriptors.TakeSignInRewardReply.enum_types = {}
type_descriptors.TakeSignInRewardReply.fields = {
	field_descriptors.TakeSignInRewardReply_activity,
	field_descriptors.TakeSignInRewardReply_day
}
type_descriptors.TakeSignInRewardReply.is_extendable = false
type_descriptors.TakeSignInRewardReply.extensions = {}
type_descriptors.GetActivityInfoRequest.name = "GetActivityInfoRequest"
type_descriptors.GetActivityInfoRequest.full_name = ".GetActivityInfoRequest"
type_descriptors.GetActivityInfoRequest.nested_types = {}
type_descriptors.GetActivityInfoRequest.enum_types = {}
type_descriptors.GetActivityInfoRequest.fields = {}
type_descriptors.GetActivityInfoRequest.is_extendable = false
type_descriptors.GetActivityInfoRequest.extensions = {}
type_descriptors.GetSignInInfoRequest.name = "GetSignInInfoRequest"
type_descriptors.GetSignInInfoRequest.full_name = ".GetSignInInfoRequest"
type_descriptors.GetSignInInfoRequest.nested_types = {}
type_descriptors.GetSignInInfoRequest.enum_types = {}
type_descriptors.GetSignInInfoRequest.fields = {}
type_descriptors.GetSignInInfoRequest.is_extendable = false
type_descriptors.GetSignInInfoRequest.extensions = {}
ActivityLogic = {
	SURVEY = 4,
	DUNGEON_REWARD_UP = 9,
	CLIP_DOLL = 8,
	SIGN_IN_HISTORY = 2,
	FOOTBALL = 3,
	SUBSCRIBE_GIFTS = 13,
	LOTTERY = 1,
	POWER_CHALLENGE = 12,
	SCORE = 7,
	REWARD_TASK = 10,
	HERO_EARLY_ACCESS = 6,
	WEEKEND_SUPPLIES = 11,
	SEASON = 5
}
Day = {
	SATURDAY = 1,
	MONDAY = 3,
	EXTRA = 4,
	SUNDAY = 2
}
ActivityNO = protobuf.Message(type_descriptors.ActivityNO)
ChangeActivityPush = protobuf.Message(type_descriptors.ChangeActivityPush)
DungeonRewardUpCountPush = protobuf.Message(type_descriptors.DungeonRewardUpCountPush)
GainScoreActivityRewardReply = protobuf.Message(type_descriptors.GainScoreActivityRewardReply)
GainScoreActivityRewardRequest = protobuf.Message(type_descriptors.GainScoreActivityRewardRequest)
GetActivityInfoReply = protobuf.Message(type_descriptors.GetActivityInfoReply)
GetActivityInfoRequest = protobuf.Message(type_descriptors.GetActivityInfoRequest)
GetHeroEarlyAccessRewardReply = protobuf.Message(type_descriptors.GetHeroEarlyAccessRewardReply)
GetHeroEarlyAccessRewardRequest = protobuf.Message(type_descriptors.GetHeroEarlyAccessRewardRequest)
GetScoreActivityInfoReply = protobuf.Message(type_descriptors.GetScoreActivityInfoReply)
GetScoreActivityInfoRequest = protobuf.Message(type_descriptors.GetScoreActivityInfoRequest)
GetSignInInfoReply = protobuf.Message(type_descriptors.GetSignInInfoReply)
GetSignInInfoRequest = protobuf.Message(type_descriptors.GetSignInInfoRequest)
ScoreActivityInfoNO = protobuf.Message(type_descriptors.ScoreActivityInfoNO)
SignInInfoNO = protobuf.Message(type_descriptors.SignInInfoNO)
TakeSignInRewardReply = protobuf.Message(type_descriptors.TakeSignInRewardReply)
TakeSignInRewardRequest = protobuf.Message(type_descriptors.TakeSignInRewardRequest)
TakeWeekendSuppliesReply = protobuf.Message(type_descriptors.TakeWeekendSuppliesReply)
TakeWeekendSuppliesRequest = protobuf.Message(type_descriptors.TakeWeekendSuppliesRequest)
UseGiftCodeReply = protobuf.Message(type_descriptors.UseGiftCodeReply)
UseGiftCodeRequest = protobuf.Message(type_descriptors.UseGiftCodeRequest)

return _G["logic.proto.ActivityExtension_pb"]

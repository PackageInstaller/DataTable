-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/RankExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.PlayerExtension = require("logic.proto.PlayerExtension_pb")

module("logic.proto.RankExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.AirEndlessNO = protobuf.Descriptor()
field_descriptors.AirEndlessNO_winNum = protobuf.FieldDescriptor()
field_descriptors.AirEndlessNO_time = protobuf.FieldDescriptor()
type_descriptors.DungeonTeamNO = protobuf.Descriptor()
field_descriptors.DungeonTeamNO_heros = protobuf.FieldDescriptor()
type_descriptors.GetRankListReply = protobuf.Descriptor()
field_descriptors.GetRankListReply_entry = protobuf.FieldDescriptor()
field_descriptors.GetRankListReply_myEntry = protobuf.FieldDescriptor()
type_descriptors.GetRankListRequest = protobuf.Descriptor()
field_descriptors.GetRankListRequest_rankId = protobuf.FieldDescriptor()
field_descriptors.GetRankListRequest_startIndex = protobuf.FieldDescriptor()
field_descriptors.GetRankListRequest_endIndex = protobuf.FieldDescriptor()
type_descriptors.DungeonNO = protobuf.Descriptor()
field_descriptors.DungeonNO_dungeonId = protobuf.FieldDescriptor()
field_descriptors.DungeonNO_round = protobuf.FieldDescriptor()
field_descriptors.DungeonNO_step = protobuf.FieldDescriptor()
field_descriptors.DungeonNO_heros = protobuf.FieldDescriptor()
type_descriptors.RankEntryNO = protobuf.Descriptor()
field_descriptors.RankEntryNO_userId = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_rank = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_nickname = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_playerLv = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_portrait = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_displayCard = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_football = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_collect = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_dungeon = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_level = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_airRodeo = protobuf.FieldDescriptor()
field_descriptors.RankEntryNO_airEndless = protobuf.FieldDescriptor()
type_descriptors.GetDungeonTeamReply = protobuf.Descriptor()
field_descriptors.GetDungeonTeamReply_team = protobuf.FieldDescriptor()
type_descriptors.FootballNO = protobuf.Descriptor()
field_descriptors.FootballNO_score = protobuf.FieldDescriptor()
field_descriptors.FootballNO_win = protobuf.FieldDescriptor()
field_descriptors.FootballNO_draw = protobuf.FieldDescriptor()
field_descriptors.FootballNO_fail = protobuf.FieldDescriptor()
type_descriptors.PlayerLvNO = protobuf.Descriptor()
field_descriptors.PlayerLvNO_level = protobuf.FieldDescriptor()
type_descriptors.GetRankInfoRequest = protobuf.Descriptor()
type_descriptors.GetRankInfoReply = protobuf.Descriptor()
field_descriptors.GetRankInfoReply_validRanks = protobuf.FieldDescriptor()
type_descriptors.HeroDetailNO = protobuf.Descriptor()
field_descriptors.HeroDetailNO_code = protobuf.FieldDescriptor()
field_descriptors.HeroDetailNO_lv = protobuf.FieldDescriptor()
type_descriptors.CollectNO = protobuf.Descriptor()
field_descriptors.CollectNO_ratio = protobuf.FieldDescriptor()
type_descriptors.AirRodeoNO = protobuf.Descriptor()
field_descriptors.AirRodeoNO_lv = protobuf.FieldDescriptor()
field_descriptors.AirRodeoNO_score = protobuf.FieldDescriptor()
type_descriptors.GetDungeonTeamRequest = protobuf.Descriptor()
field_descriptors.GetDungeonTeamRequest_rankId = protobuf.FieldDescriptor()
field_descriptors.GetDungeonTeamRequest_userId = protobuf.FieldDescriptor()
field_descriptors.AirEndlessNO_winNum.name = "winNum"
field_descriptors.AirEndlessNO_winNum.full_name = ".AirEndlessNO.winNum"
field_descriptors.AirEndlessNO_winNum.number = 1
field_descriptors.AirEndlessNO_winNum.index = 0
field_descriptors.AirEndlessNO_winNum.label = 2
field_descriptors.AirEndlessNO_winNum.has_default_value = false
field_descriptors.AirEndlessNO_winNum.default_value = 0
field_descriptors.AirEndlessNO_winNum.type = 5
field_descriptors.AirEndlessNO_winNum.cpp_type = 1
field_descriptors.AirEndlessNO_time.name = "time"
field_descriptors.AirEndlessNO_time.full_name = ".AirEndlessNO.time"
field_descriptors.AirEndlessNO_time.number = 2
field_descriptors.AirEndlessNO_time.index = 1
field_descriptors.AirEndlessNO_time.label = 2
field_descriptors.AirEndlessNO_time.has_default_value = false
field_descriptors.AirEndlessNO_time.default_value = 0
field_descriptors.AirEndlessNO_time.type = 3
field_descriptors.AirEndlessNO_time.cpp_type = 2
type_descriptors.AirEndlessNO.name = "AirEndlessNO"
type_descriptors.AirEndlessNO.full_name = ".AirEndlessNO"
type_descriptors.AirEndlessNO.nested_types = {}
type_descriptors.AirEndlessNO.enum_types = {}
type_descriptors.AirEndlessNO.fields = {
	field_descriptors.AirEndlessNO_winNum,
	field_descriptors.AirEndlessNO_time
}
type_descriptors.AirEndlessNO.is_extendable = false
type_descriptors.AirEndlessNO.extensions = {}
field_descriptors.DungeonTeamNO_heros.name = "heros"
field_descriptors.DungeonTeamNO_heros.full_name = ".DungeonTeamNO.heros"
field_descriptors.DungeonTeamNO_heros.number = 1
field_descriptors.DungeonTeamNO_heros.index = 0
field_descriptors.DungeonTeamNO_heros.label = 3
field_descriptors.DungeonTeamNO_heros.has_default_value = false
field_descriptors.DungeonTeamNO_heros.default_value = {}
field_descriptors.DungeonTeamNO_heros.message_type = dependencies.PlayerExtension.type_descriptors.HeroDetailInfo
field_descriptors.DungeonTeamNO_heros.type = 11
field_descriptors.DungeonTeamNO_heros.cpp_type = 10
type_descriptors.DungeonTeamNO.name = "DungeonTeamNO"
type_descriptors.DungeonTeamNO.full_name = ".DungeonTeamNO"
type_descriptors.DungeonTeamNO.nested_types = {}
type_descriptors.DungeonTeamNO.enum_types = {}
type_descriptors.DungeonTeamNO.fields = {
	field_descriptors.DungeonTeamNO_heros
}
type_descriptors.DungeonTeamNO.is_extendable = false
type_descriptors.DungeonTeamNO.extensions = {}
field_descriptors.GetRankListReply_entry.name = "entry"
field_descriptors.GetRankListReply_entry.full_name = ".GetRankListReply.entry"
field_descriptors.GetRankListReply_entry.number = 1
field_descriptors.GetRankListReply_entry.index = 0
field_descriptors.GetRankListReply_entry.label = 3
field_descriptors.GetRankListReply_entry.has_default_value = false
field_descriptors.GetRankListReply_entry.default_value = {}
field_descriptors.GetRankListReply_entry.message_type = type_descriptors.RankEntryNO
field_descriptors.GetRankListReply_entry.type = 11
field_descriptors.GetRankListReply_entry.cpp_type = 10
field_descriptors.GetRankListReply_myEntry.name = "myEntry"
field_descriptors.GetRankListReply_myEntry.full_name = ".GetRankListReply.myEntry"
field_descriptors.GetRankListReply_myEntry.number = 2
field_descriptors.GetRankListReply_myEntry.index = 1
field_descriptors.GetRankListReply_myEntry.label = 2
field_descriptors.GetRankListReply_myEntry.has_default_value = false
field_descriptors.GetRankListReply_myEntry.default_value = nil
field_descriptors.GetRankListReply_myEntry.message_type = type_descriptors.RankEntryNO
field_descriptors.GetRankListReply_myEntry.type = 11
field_descriptors.GetRankListReply_myEntry.cpp_type = 10
type_descriptors.GetRankListReply.name = "GetRankListReply"
type_descriptors.GetRankListReply.full_name = ".GetRankListReply"
type_descriptors.GetRankListReply.nested_types = {}
type_descriptors.GetRankListReply.enum_types = {}
type_descriptors.GetRankListReply.fields = {
	field_descriptors.GetRankListReply_entry,
	field_descriptors.GetRankListReply_myEntry
}
type_descriptors.GetRankListReply.is_extendable = false
type_descriptors.GetRankListReply.extensions = {}
field_descriptors.GetRankListRequest_rankId.name = "rankId"
field_descriptors.GetRankListRequest_rankId.full_name = ".GetRankListRequest.rankId"
field_descriptors.GetRankListRequest_rankId.number = 1
field_descriptors.GetRankListRequest_rankId.index = 0
field_descriptors.GetRankListRequest_rankId.label = 2
field_descriptors.GetRankListRequest_rankId.has_default_value = false
field_descriptors.GetRankListRequest_rankId.default_value = 0
field_descriptors.GetRankListRequest_rankId.type = 5
field_descriptors.GetRankListRequest_rankId.cpp_type = 1
field_descriptors.GetRankListRequest_startIndex.name = "startIndex"
field_descriptors.GetRankListRequest_startIndex.full_name = ".GetRankListRequest.startIndex"
field_descriptors.GetRankListRequest_startIndex.number = 2
field_descriptors.GetRankListRequest_startIndex.index = 1
field_descriptors.GetRankListRequest_startIndex.label = 2
field_descriptors.GetRankListRequest_startIndex.has_default_value = false
field_descriptors.GetRankListRequest_startIndex.default_value = 0
field_descriptors.GetRankListRequest_startIndex.type = 5
field_descriptors.GetRankListRequest_startIndex.cpp_type = 1
field_descriptors.GetRankListRequest_endIndex.name = "endIndex"
field_descriptors.GetRankListRequest_endIndex.full_name = ".GetRankListRequest.endIndex"
field_descriptors.GetRankListRequest_endIndex.number = 3
field_descriptors.GetRankListRequest_endIndex.index = 2
field_descriptors.GetRankListRequest_endIndex.label = 2
field_descriptors.GetRankListRequest_endIndex.has_default_value = false
field_descriptors.GetRankListRequest_endIndex.default_value = 0
field_descriptors.GetRankListRequest_endIndex.type = 5
field_descriptors.GetRankListRequest_endIndex.cpp_type = 1
type_descriptors.GetRankListRequest.name = "GetRankListRequest"
type_descriptors.GetRankListRequest.full_name = ".GetRankListRequest"
type_descriptors.GetRankListRequest.nested_types = {}
type_descriptors.GetRankListRequest.enum_types = {}
type_descriptors.GetRankListRequest.fields = {
	field_descriptors.GetRankListRequest_rankId,
	field_descriptors.GetRankListRequest_startIndex,
	field_descriptors.GetRankListRequest_endIndex
}
type_descriptors.GetRankListRequest.is_extendable = false
type_descriptors.GetRankListRequest.extensions = {}
field_descriptors.DungeonNO_dungeonId.name = "dungeonId"
field_descriptors.DungeonNO_dungeonId.full_name = ".DungeonNO.dungeonId"
field_descriptors.DungeonNO_dungeonId.number = 1
field_descriptors.DungeonNO_dungeonId.index = 0
field_descriptors.DungeonNO_dungeonId.label = 2
field_descriptors.DungeonNO_dungeonId.has_default_value = false
field_descriptors.DungeonNO_dungeonId.default_value = 0
field_descriptors.DungeonNO_dungeonId.type = 5
field_descriptors.DungeonNO_dungeonId.cpp_type = 1
field_descriptors.DungeonNO_round.name = "round"
field_descriptors.DungeonNO_round.full_name = ".DungeonNO.round"
field_descriptors.DungeonNO_round.number = 2
field_descriptors.DungeonNO_round.index = 1
field_descriptors.DungeonNO_round.label = 2
field_descriptors.DungeonNO_round.has_default_value = false
field_descriptors.DungeonNO_round.default_value = 0
field_descriptors.DungeonNO_round.type = 5
field_descriptors.DungeonNO_round.cpp_type = 1
field_descriptors.DungeonNO_step.name = "step"
field_descriptors.DungeonNO_step.full_name = ".DungeonNO.step"
field_descriptors.DungeonNO_step.number = 3
field_descriptors.DungeonNO_step.index = 2
field_descriptors.DungeonNO_step.label = 2
field_descriptors.DungeonNO_step.has_default_value = false
field_descriptors.DungeonNO_step.default_value = 0
field_descriptors.DungeonNO_step.type = 5
field_descriptors.DungeonNO_step.cpp_type = 1
field_descriptors.DungeonNO_heros.name = "heros"
field_descriptors.DungeonNO_heros.full_name = ".DungeonNO.heros"
field_descriptors.DungeonNO_heros.number = 4
field_descriptors.DungeonNO_heros.index = 3
field_descriptors.DungeonNO_heros.label = 3
field_descriptors.DungeonNO_heros.has_default_value = false
field_descriptors.DungeonNO_heros.default_value = {}
field_descriptors.DungeonNO_heros.message_type = type_descriptors.HeroDetailNO
field_descriptors.DungeonNO_heros.type = 11
field_descriptors.DungeonNO_heros.cpp_type = 10
type_descriptors.DungeonNO.name = "DungeonNO"
type_descriptors.DungeonNO.full_name = ".DungeonNO"
type_descriptors.DungeonNO.nested_types = {}
type_descriptors.DungeonNO.enum_types = {}
type_descriptors.DungeonNO.fields = {
	field_descriptors.DungeonNO_dungeonId,
	field_descriptors.DungeonNO_round,
	field_descriptors.DungeonNO_step,
	field_descriptors.DungeonNO_heros
}
type_descriptors.DungeonNO.is_extendable = false
type_descriptors.DungeonNO.extensions = {}
field_descriptors.RankEntryNO_userId.name = "userId"
field_descriptors.RankEntryNO_userId.full_name = ".RankEntryNO.userId"
field_descriptors.RankEntryNO_userId.number = 1
field_descriptors.RankEntryNO_userId.index = 0
field_descriptors.RankEntryNO_userId.label = 2
field_descriptors.RankEntryNO_userId.has_default_value = false
field_descriptors.RankEntryNO_userId.default_value = 0
field_descriptors.RankEntryNO_userId.type = 3
field_descriptors.RankEntryNO_userId.cpp_type = 2
field_descriptors.RankEntryNO_rank.name = "rank"
field_descriptors.RankEntryNO_rank.full_name = ".RankEntryNO.rank"
field_descriptors.RankEntryNO_rank.number = 2
field_descriptors.RankEntryNO_rank.index = 1
field_descriptors.RankEntryNO_rank.label = 2
field_descriptors.RankEntryNO_rank.has_default_value = false
field_descriptors.RankEntryNO_rank.default_value = 0
field_descriptors.RankEntryNO_rank.type = 5
field_descriptors.RankEntryNO_rank.cpp_type = 1
field_descriptors.RankEntryNO_nickname.name = "nickname"
field_descriptors.RankEntryNO_nickname.full_name = ".RankEntryNO.nickname"
field_descriptors.RankEntryNO_nickname.number = 3
field_descriptors.RankEntryNO_nickname.index = 2
field_descriptors.RankEntryNO_nickname.label = 1
field_descriptors.RankEntryNO_nickname.has_default_value = false
field_descriptors.RankEntryNO_nickname.default_value = ""
field_descriptors.RankEntryNO_nickname.type = 9
field_descriptors.RankEntryNO_nickname.cpp_type = 9
field_descriptors.RankEntryNO_playerLv.name = "playerLv"
field_descriptors.RankEntryNO_playerLv.full_name = ".RankEntryNO.playerLv"
field_descriptors.RankEntryNO_playerLv.number = 4
field_descriptors.RankEntryNO_playerLv.index = 3
field_descriptors.RankEntryNO_playerLv.label = 1
field_descriptors.RankEntryNO_playerLv.has_default_value = false
field_descriptors.RankEntryNO_playerLv.default_value = 0
field_descriptors.RankEntryNO_playerLv.type = 5
field_descriptors.RankEntryNO_playerLv.cpp_type = 1
field_descriptors.RankEntryNO_portrait.name = "portrait"
field_descriptors.RankEntryNO_portrait.full_name = ".RankEntryNO.portrait"
field_descriptors.RankEntryNO_portrait.number = 5
field_descriptors.RankEntryNO_portrait.index = 4
field_descriptors.RankEntryNO_portrait.label = 1
field_descriptors.RankEntryNO_portrait.has_default_value = false
field_descriptors.RankEntryNO_portrait.default_value = 0
field_descriptors.RankEntryNO_portrait.type = 5
field_descriptors.RankEntryNO_portrait.cpp_type = 1
field_descriptors.RankEntryNO_displayCard.name = "displayCard"
field_descriptors.RankEntryNO_displayCard.full_name = ".RankEntryNO.displayCard"
field_descriptors.RankEntryNO_displayCard.number = 6
field_descriptors.RankEntryNO_displayCard.index = 5
field_descriptors.RankEntryNO_displayCard.label = 3
field_descriptors.RankEntryNO_displayCard.has_default_value = false
field_descriptors.RankEntryNO_displayCard.default_value = {}
field_descriptors.RankEntryNO_displayCard.type = 5
field_descriptors.RankEntryNO_displayCard.cpp_type = 1
field_descriptors.RankEntryNO_football.name = "football"
field_descriptors.RankEntryNO_football.full_name = ".RankEntryNO.football"
field_descriptors.RankEntryNO_football.number = 7
field_descriptors.RankEntryNO_football.index = 6
field_descriptors.RankEntryNO_football.label = 1
field_descriptors.RankEntryNO_football.has_default_value = false
field_descriptors.RankEntryNO_football.default_value = nil
field_descriptors.RankEntryNO_football.message_type = type_descriptors.FootballNO
field_descriptors.RankEntryNO_football.type = 11
field_descriptors.RankEntryNO_football.cpp_type = 10
field_descriptors.RankEntryNO_collect.name = "collect"
field_descriptors.RankEntryNO_collect.full_name = ".RankEntryNO.collect"
field_descriptors.RankEntryNO_collect.number = 8
field_descriptors.RankEntryNO_collect.index = 7
field_descriptors.RankEntryNO_collect.label = 1
field_descriptors.RankEntryNO_collect.has_default_value = false
field_descriptors.RankEntryNO_collect.default_value = nil
field_descriptors.RankEntryNO_collect.message_type = type_descriptors.CollectNO
field_descriptors.RankEntryNO_collect.type = 11
field_descriptors.RankEntryNO_collect.cpp_type = 10
field_descriptors.RankEntryNO_dungeon.name = "dungeon"
field_descriptors.RankEntryNO_dungeon.full_name = ".RankEntryNO.dungeon"
field_descriptors.RankEntryNO_dungeon.number = 9
field_descriptors.RankEntryNO_dungeon.index = 8
field_descriptors.RankEntryNO_dungeon.label = 1
field_descriptors.RankEntryNO_dungeon.has_default_value = false
field_descriptors.RankEntryNO_dungeon.default_value = nil
field_descriptors.RankEntryNO_dungeon.message_type = type_descriptors.DungeonNO
field_descriptors.RankEntryNO_dungeon.type = 11
field_descriptors.RankEntryNO_dungeon.cpp_type = 10
field_descriptors.RankEntryNO_level.name = "level"
field_descriptors.RankEntryNO_level.full_name = ".RankEntryNO.level"
field_descriptors.RankEntryNO_level.number = 10
field_descriptors.RankEntryNO_level.index = 9
field_descriptors.RankEntryNO_level.label = 1
field_descriptors.RankEntryNO_level.has_default_value = false
field_descriptors.RankEntryNO_level.default_value = nil
field_descriptors.RankEntryNO_level.message_type = type_descriptors.PlayerLvNO
field_descriptors.RankEntryNO_level.type = 11
field_descriptors.RankEntryNO_level.cpp_type = 10
field_descriptors.RankEntryNO_airRodeo.name = "airRodeo"
field_descriptors.RankEntryNO_airRodeo.full_name = ".RankEntryNO.airRodeo"
field_descriptors.RankEntryNO_airRodeo.number = 11
field_descriptors.RankEntryNO_airRodeo.index = 10
field_descriptors.RankEntryNO_airRodeo.label = 1
field_descriptors.RankEntryNO_airRodeo.has_default_value = false
field_descriptors.RankEntryNO_airRodeo.default_value = nil
field_descriptors.RankEntryNO_airRodeo.message_type = type_descriptors.AirRodeoNO
field_descriptors.RankEntryNO_airRodeo.type = 11
field_descriptors.RankEntryNO_airRodeo.cpp_type = 10
field_descriptors.RankEntryNO_airEndless.name = "airEndless"
field_descriptors.RankEntryNO_airEndless.full_name = ".RankEntryNO.airEndless"
field_descriptors.RankEntryNO_airEndless.number = 12
field_descriptors.RankEntryNO_airEndless.index = 11
field_descriptors.RankEntryNO_airEndless.label = 1
field_descriptors.RankEntryNO_airEndless.has_default_value = false
field_descriptors.RankEntryNO_airEndless.default_value = nil
field_descriptors.RankEntryNO_airEndless.message_type = type_descriptors.AirEndlessNO
field_descriptors.RankEntryNO_airEndless.type = 11
field_descriptors.RankEntryNO_airEndless.cpp_type = 10
type_descriptors.RankEntryNO.name = "RankEntryNO"
type_descriptors.RankEntryNO.full_name = ".RankEntryNO"
type_descriptors.RankEntryNO.nested_types = {}
type_descriptors.RankEntryNO.enum_types = {}
type_descriptors.RankEntryNO.fields = {
	field_descriptors.RankEntryNO_userId,
	field_descriptors.RankEntryNO_rank,
	field_descriptors.RankEntryNO_nickname,
	field_descriptors.RankEntryNO_playerLv,
	field_descriptors.RankEntryNO_portrait,
	field_descriptors.RankEntryNO_displayCard,
	field_descriptors.RankEntryNO_football,
	field_descriptors.RankEntryNO_collect,
	field_descriptors.RankEntryNO_dungeon,
	field_descriptors.RankEntryNO_level,
	field_descriptors.RankEntryNO_airRodeo,
	field_descriptors.RankEntryNO_airEndless
}
type_descriptors.RankEntryNO.is_extendable = false
type_descriptors.RankEntryNO.extensions = {}
field_descriptors.GetDungeonTeamReply_team.name = "team"
field_descriptors.GetDungeonTeamReply_team.full_name = ".GetDungeonTeamReply.team"
field_descriptors.GetDungeonTeamReply_team.number = 1
field_descriptors.GetDungeonTeamReply_team.index = 0
field_descriptors.GetDungeonTeamReply_team.label = 1
field_descriptors.GetDungeonTeamReply_team.has_default_value = false
field_descriptors.GetDungeonTeamReply_team.default_value = nil
field_descriptors.GetDungeonTeamReply_team.message_type = type_descriptors.DungeonTeamNO
field_descriptors.GetDungeonTeamReply_team.type = 11
field_descriptors.GetDungeonTeamReply_team.cpp_type = 10
type_descriptors.GetDungeonTeamReply.name = "GetDungeonTeamReply"
type_descriptors.GetDungeonTeamReply.full_name = ".GetDungeonTeamReply"
type_descriptors.GetDungeonTeamReply.nested_types = {}
type_descriptors.GetDungeonTeamReply.enum_types = {}
type_descriptors.GetDungeonTeamReply.fields = {
	field_descriptors.GetDungeonTeamReply_team
}
type_descriptors.GetDungeonTeamReply.is_extendable = false
type_descriptors.GetDungeonTeamReply.extensions = {}
field_descriptors.FootballNO_score.name = "score"
field_descriptors.FootballNO_score.full_name = ".FootballNO.score"
field_descriptors.FootballNO_score.number = 1
field_descriptors.FootballNO_score.index = 0
field_descriptors.FootballNO_score.label = 1
field_descriptors.FootballNO_score.has_default_value = false
field_descriptors.FootballNO_score.default_value = 0
field_descriptors.FootballNO_score.type = 5
field_descriptors.FootballNO_score.cpp_type = 1
field_descriptors.FootballNO_win.name = "win"
field_descriptors.FootballNO_win.full_name = ".FootballNO.win"
field_descriptors.FootballNO_win.number = 2
field_descriptors.FootballNO_win.index = 1
field_descriptors.FootballNO_win.label = 1
field_descriptors.FootballNO_win.has_default_value = false
field_descriptors.FootballNO_win.default_value = 0
field_descriptors.FootballNO_win.type = 5
field_descriptors.FootballNO_win.cpp_type = 1
field_descriptors.FootballNO_draw.name = "draw"
field_descriptors.FootballNO_draw.full_name = ".FootballNO.draw"
field_descriptors.FootballNO_draw.number = 3
field_descriptors.FootballNO_draw.index = 2
field_descriptors.FootballNO_draw.label = 1
field_descriptors.FootballNO_draw.has_default_value = false
field_descriptors.FootballNO_draw.default_value = 0
field_descriptors.FootballNO_draw.type = 5
field_descriptors.FootballNO_draw.cpp_type = 1
field_descriptors.FootballNO_fail.name = "fail"
field_descriptors.FootballNO_fail.full_name = ".FootballNO.fail"
field_descriptors.FootballNO_fail.number = 4
field_descriptors.FootballNO_fail.index = 3
field_descriptors.FootballNO_fail.label = 1
field_descriptors.FootballNO_fail.has_default_value = false
field_descriptors.FootballNO_fail.default_value = 0
field_descriptors.FootballNO_fail.type = 5
field_descriptors.FootballNO_fail.cpp_type = 1
type_descriptors.FootballNO.name = "FootballNO"
type_descriptors.FootballNO.full_name = ".FootballNO"
type_descriptors.FootballNO.nested_types = {}
type_descriptors.FootballNO.enum_types = {}
type_descriptors.FootballNO.fields = {
	field_descriptors.FootballNO_score,
	field_descriptors.FootballNO_win,
	field_descriptors.FootballNO_draw,
	field_descriptors.FootballNO_fail
}
type_descriptors.FootballNO.is_extendable = false
type_descriptors.FootballNO.extensions = {}
field_descriptors.PlayerLvNO_level.name = "level"
field_descriptors.PlayerLvNO_level.full_name = ".PlayerLvNO.level"
field_descriptors.PlayerLvNO_level.number = 1
field_descriptors.PlayerLvNO_level.index = 0
field_descriptors.PlayerLvNO_level.label = 2
field_descriptors.PlayerLvNO_level.has_default_value = false
field_descriptors.PlayerLvNO_level.default_value = 0
field_descriptors.PlayerLvNO_level.type = 5
field_descriptors.PlayerLvNO_level.cpp_type = 1
type_descriptors.PlayerLvNO.name = "PlayerLvNO"
type_descriptors.PlayerLvNO.full_name = ".PlayerLvNO"
type_descriptors.PlayerLvNO.nested_types = {}
type_descriptors.PlayerLvNO.enum_types = {}
type_descriptors.PlayerLvNO.fields = {
	field_descriptors.PlayerLvNO_level
}
type_descriptors.PlayerLvNO.is_extendable = false
type_descriptors.PlayerLvNO.extensions = {}
type_descriptors.GetRankInfoRequest.name = "GetRankInfoRequest"
type_descriptors.GetRankInfoRequest.full_name = ".GetRankInfoRequest"
type_descriptors.GetRankInfoRequest.nested_types = {}
type_descriptors.GetRankInfoRequest.enum_types = {}
type_descriptors.GetRankInfoRequest.fields = {}
type_descriptors.GetRankInfoRequest.is_extendable = false
type_descriptors.GetRankInfoRequest.extensions = {}
field_descriptors.GetRankInfoReply_validRanks.name = "validRanks"
field_descriptors.GetRankInfoReply_validRanks.full_name = ".GetRankInfoReply.validRanks"
field_descriptors.GetRankInfoReply_validRanks.number = 1
field_descriptors.GetRankInfoReply_validRanks.index = 0
field_descriptors.GetRankInfoReply_validRanks.label = 3
field_descriptors.GetRankInfoReply_validRanks.has_default_value = false
field_descriptors.GetRankInfoReply_validRanks.default_value = {}
field_descriptors.GetRankInfoReply_validRanks.type = 5
field_descriptors.GetRankInfoReply_validRanks.cpp_type = 1
type_descriptors.GetRankInfoReply.name = "GetRankInfoReply"
type_descriptors.GetRankInfoReply.full_name = ".GetRankInfoReply"
type_descriptors.GetRankInfoReply.nested_types = {}
type_descriptors.GetRankInfoReply.enum_types = {}
type_descriptors.GetRankInfoReply.fields = {
	field_descriptors.GetRankInfoReply_validRanks
}
type_descriptors.GetRankInfoReply.is_extendable = false
type_descriptors.GetRankInfoReply.extensions = {}
field_descriptors.HeroDetailNO_code.name = "code"
field_descriptors.HeroDetailNO_code.full_name = ".HeroDetailNO.code"
field_descriptors.HeroDetailNO_code.number = 1
field_descriptors.HeroDetailNO_code.index = 0
field_descriptors.HeroDetailNO_code.label = 2
field_descriptors.HeroDetailNO_code.has_default_value = false
field_descriptors.HeroDetailNO_code.default_value = 0
field_descriptors.HeroDetailNO_code.type = 5
field_descriptors.HeroDetailNO_code.cpp_type = 1
field_descriptors.HeroDetailNO_lv.name = "lv"
field_descriptors.HeroDetailNO_lv.full_name = ".HeroDetailNO.lv"
field_descriptors.HeroDetailNO_lv.number = 2
field_descriptors.HeroDetailNO_lv.index = 1
field_descriptors.HeroDetailNO_lv.label = 2
field_descriptors.HeroDetailNO_lv.has_default_value = false
field_descriptors.HeroDetailNO_lv.default_value = 0
field_descriptors.HeroDetailNO_lv.type = 5
field_descriptors.HeroDetailNO_lv.cpp_type = 1
type_descriptors.HeroDetailNO.name = "HeroDetailNO"
type_descriptors.HeroDetailNO.full_name = ".HeroDetailNO"
type_descriptors.HeroDetailNO.nested_types = {}
type_descriptors.HeroDetailNO.enum_types = {}
type_descriptors.HeroDetailNO.fields = {
	field_descriptors.HeroDetailNO_code,
	field_descriptors.HeroDetailNO_lv
}
type_descriptors.HeroDetailNO.is_extendable = false
type_descriptors.HeroDetailNO.extensions = {}
field_descriptors.CollectNO_ratio.name = "ratio"
field_descriptors.CollectNO_ratio.full_name = ".CollectNO.ratio"
field_descriptors.CollectNO_ratio.number = 1
field_descriptors.CollectNO_ratio.index = 0
field_descriptors.CollectNO_ratio.label = 2
field_descriptors.CollectNO_ratio.has_default_value = false
field_descriptors.CollectNO_ratio.default_value = 0
field_descriptors.CollectNO_ratio.type = 1
field_descriptors.CollectNO_ratio.cpp_type = 5
type_descriptors.CollectNO.name = "CollectNO"
type_descriptors.CollectNO.full_name = ".CollectNO"
type_descriptors.CollectNO.nested_types = {}
type_descriptors.CollectNO.enum_types = {}
type_descriptors.CollectNO.fields = {
	field_descriptors.CollectNO_ratio
}
type_descriptors.CollectNO.is_extendable = false
type_descriptors.CollectNO.extensions = {}
field_descriptors.AirRodeoNO_lv.name = "lv"
field_descriptors.AirRodeoNO_lv.full_name = ".AirRodeoNO.lv"
field_descriptors.AirRodeoNO_lv.number = 1
field_descriptors.AirRodeoNO_lv.index = 0
field_descriptors.AirRodeoNO_lv.label = 2
field_descriptors.AirRodeoNO_lv.has_default_value = false
field_descriptors.AirRodeoNO_lv.default_value = 0
field_descriptors.AirRodeoNO_lv.type = 5
field_descriptors.AirRodeoNO_lv.cpp_type = 1
field_descriptors.AirRodeoNO_score.name = "score"
field_descriptors.AirRodeoNO_score.full_name = ".AirRodeoNO.score"
field_descriptors.AirRodeoNO_score.number = 2
field_descriptors.AirRodeoNO_score.index = 1
field_descriptors.AirRodeoNO_score.label = 2
field_descriptors.AirRodeoNO_score.has_default_value = false
field_descriptors.AirRodeoNO_score.default_value = 0
field_descriptors.AirRodeoNO_score.type = 5
field_descriptors.AirRodeoNO_score.cpp_type = 1
type_descriptors.AirRodeoNO.name = "AirRodeoNO"
type_descriptors.AirRodeoNO.full_name = ".AirRodeoNO"
type_descriptors.AirRodeoNO.nested_types = {}
type_descriptors.AirRodeoNO.enum_types = {}
type_descriptors.AirRodeoNO.fields = {
	field_descriptors.AirRodeoNO_lv,
	field_descriptors.AirRodeoNO_score
}
type_descriptors.AirRodeoNO.is_extendable = false
type_descriptors.AirRodeoNO.extensions = {}
field_descriptors.GetDungeonTeamRequest_rankId.name = "rankId"
field_descriptors.GetDungeonTeamRequest_rankId.full_name = ".GetDungeonTeamRequest.rankId"
field_descriptors.GetDungeonTeamRequest_rankId.number = 1
field_descriptors.GetDungeonTeamRequest_rankId.index = 0
field_descriptors.GetDungeonTeamRequest_rankId.label = 2
field_descriptors.GetDungeonTeamRequest_rankId.has_default_value = false
field_descriptors.GetDungeonTeamRequest_rankId.default_value = 0
field_descriptors.GetDungeonTeamRequest_rankId.type = 5
field_descriptors.GetDungeonTeamRequest_rankId.cpp_type = 1
field_descriptors.GetDungeonTeamRequest_userId.name = "userId"
field_descriptors.GetDungeonTeamRequest_userId.full_name = ".GetDungeonTeamRequest.userId"
field_descriptors.GetDungeonTeamRequest_userId.number = 2
field_descriptors.GetDungeonTeamRequest_userId.index = 1
field_descriptors.GetDungeonTeamRequest_userId.label = 2
field_descriptors.GetDungeonTeamRequest_userId.has_default_value = false
field_descriptors.GetDungeonTeamRequest_userId.default_value = 0
field_descriptors.GetDungeonTeamRequest_userId.type = 3
field_descriptors.GetDungeonTeamRequest_userId.cpp_type = 2
type_descriptors.GetDungeonTeamRequest.name = "GetDungeonTeamRequest"
type_descriptors.GetDungeonTeamRequest.full_name = ".GetDungeonTeamRequest"
type_descriptors.GetDungeonTeamRequest.nested_types = {}
type_descriptors.GetDungeonTeamRequest.enum_types = {}
type_descriptors.GetDungeonTeamRequest.fields = {
	field_descriptors.GetDungeonTeamRequest_rankId,
	field_descriptors.GetDungeonTeamRequest_userId
}
type_descriptors.GetDungeonTeamRequest.is_extendable = false
type_descriptors.GetDungeonTeamRequest.extensions = {}
AirEndlessNO = protobuf.Message(type_descriptors.AirEndlessNO)
AirRodeoNO = protobuf.Message(type_descriptors.AirRodeoNO)
CollectNO = protobuf.Message(type_descriptors.CollectNO)
DungeonNO = protobuf.Message(type_descriptors.DungeonNO)
DungeonTeamNO = protobuf.Message(type_descriptors.DungeonTeamNO)
FootballNO = protobuf.Message(type_descriptors.FootballNO)
GetDungeonTeamReply = protobuf.Message(type_descriptors.GetDungeonTeamReply)
GetDungeonTeamRequest = protobuf.Message(type_descriptors.GetDungeonTeamRequest)
GetRankInfoReply = protobuf.Message(type_descriptors.GetRankInfoReply)
GetRankInfoRequest = protobuf.Message(type_descriptors.GetRankInfoRequest)
GetRankListReply = protobuf.Message(type_descriptors.GetRankListReply)
GetRankListRequest = protobuf.Message(type_descriptors.GetRankListRequest)
HeroDetailNO = protobuf.Message(type_descriptors.HeroDetailNO)
PlayerLvNO = protobuf.Message(type_descriptors.PlayerLvNO)
RankEntryNO = protobuf.Message(type_descriptors.RankEntryNO)

return _G["logic.proto.RankExtension_pb"]

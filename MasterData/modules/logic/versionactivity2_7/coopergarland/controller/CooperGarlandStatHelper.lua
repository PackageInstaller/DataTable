-- chunkname: @modules/logic/versionactivity2_7/coopergarland/controller/CooperGarlandStatHelper.lua

module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandStatHelper", package.seeall)

local CooperGarlandStatHelper = class("CooperGarlandStatHelper")

function CooperGarlandStatHelper:ctor()
	self.episodeId = "0"
	self.failCount = 0
	self.resetCount = 0
	self.mapResetCount = 0
	self.episodeStartTime = 0
	self.gameStartTime = 0
	self.mapStartTime = 0
	self.resetStartTime = 0
end

function CooperGarlandStatHelper:enterEpisode(episodeId)
	self.episodeId = tostring(episodeId)
	self.episodeStartTime = UnityEngine.Time.realtimeSinceStartup
end

function CooperGarlandStatHelper:enterGame()
	self.failCount = 0
	self.resetCount = 0
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function CooperGarlandStatHelper:setupMap()
	self.mapResetCount = 0
	self.mapStartTime = UnityEngine.Time.realtimeSinceStartup
	self.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

function CooperGarlandStatHelper:sendEpisodeFinish()
	StatController.instance:track(StatEnum.EventName.Act192DungeonFinish, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = self.episodeId,
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.episodeStartTime
	})
end

function CooperGarlandStatHelper:sendGameFinish()
	StatController.instance:track(StatEnum.EventName.Act192GameFinish, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = self.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_FailTimes] = self.failCount,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = self.resetCount
	})
end

function CooperGarlandStatHelper:sendGameExit(from)
	StatController.instance:track(StatEnum.EventName.Act192GameExit, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = self.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_BrowseTime] = UnityEngine.Time.realtimeSinceStartup - self.episodeStartTime,
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_FailTimes] = self.failCount,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = self.resetCount,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - self.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_MapId] = tostring(CooperGarlandGameModel.instance:getMapId()),
		[StatEnum.EventProperties.CooperGarland_From] = from
	})
end

function CooperGarlandStatHelper:sendMapArrive()
	StatController.instance:track(StatEnum.EventName.Act192MapArrive, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = self.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_MapId] = tostring(CooperGarlandGameModel.instance:getMapId()),
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - self.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList(),
		[StatEnum.EventProperties.CooperGarland_MapResetTimes] = self.mapResetCount
	})
end

function CooperGarlandStatHelper:sendMapFail(componentId)
	self.failCount = self.failCount + 1

	StatController.instance:track(StatEnum.EventName.Act192MapFail, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = self.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_CompId] = componentId,
		[StatEnum.EventProperties.CooperGarland_MapId] = tostring(CooperGarlandGameModel.instance:getMapId()),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - self.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_ResetUseTime] = UnityEngine.Time.realtimeSinceStartup - self.resetStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList()
	})
end

function CooperGarlandStatHelper:sendMapReset(from)
	self.resetCount = self.resetCount + 1
	self.mapResetCount = self.mapResetCount + 1

	StatController.instance:track(StatEnum.EventName.Act192MapReset, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = self.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_MapId] = tostring(CooperGarlandGameModel.instance:getMapId()),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - self.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_ResetUseTime] = UnityEngine.Time.realtimeSinceStartup - self.resetStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList(),
		[StatEnum.EventProperties.CooperGarland_From] = from
	})

	self.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

CooperGarlandStatHelper.instance = CooperGarlandStatHelper.New()

return CooperGarlandStatHelper

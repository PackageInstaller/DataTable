-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/controller/FeiLinShiDuoStatHelper.lua

module("modules.logic.versionactivity2_5.feilinshiduo.controller.FeiLinShiDuoStatHelper", package.seeall)

local FeiLinShiDuoStatHelper = class("FeiLinShiDuoStatHelper")

function FeiLinShiDuoStatHelper:ctor()
	self.gameStartTime = 0
	self.resetStartTime = 0
	self.episodeStartTime = 0
	self.curEpisodeId = 0
end

function FeiLinShiDuoStatHelper:initGameStartTime()
	self.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function FeiLinShiDuoStatHelper:initResetStartTime()
	self.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

function FeiLinShiDuoStatHelper:initEpisodeStartTime(episodeId)
	self.curEpisodeId = episodeId
	self.episodeStartTime = UnityEngine.Time.realtimeSinceStartup
end

function FeiLinShiDuoStatHelper:setSceneInfo(playerGO)
	local sceneInfo = {}
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()
	local boxItemTab = elementMap[FeiLinShiDuoEnum.ObjectType.Box]
	local playerInfo = {}

	playerInfo.id = 0
	playerInfo.x = playerGO.transform.localPosition.x
	playerInfo.y = playerGO.transform.localPosition.y

	table.insert(sceneInfo, playerInfo)

	for _, boxItemInfo in pairs(boxItemTab) do
		local itemInfo = {}

		itemInfo.id = boxItemInfo.id
		itemInfo.x = boxItemInfo.pos[1]
		itemInfo.y = boxItemInfo.pos[2]

		table.insert(sceneInfo, itemInfo)
	end

	table.sort(sceneInfo, function(a, b)
		return a.id < b.id
	end)

	return sceneInfo
end

function FeiLinShiDuoStatHelper:sendExitGameMap(playerGO)
	if not playerGO then
		return
	end

	local sceneInfo = self:setSceneInfo(playerGO)

	StatController.instance:track(StatEnum.EventName.Act185MapExit, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = sceneInfo
	})
end

function FeiLinShiDuoStatHelper:sendResetGameMap(playerGO)
	if not playerGO then
		return
	end

	local sceneInfo = self:setSceneInfo(playerGO)

	StatController.instance:track(StatEnum.EventName.Act185MapReset, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.resetStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = sceneInfo
	})
	self:initResetStartTime()
end

function FeiLinShiDuoStatHelper:sendMapFinish(playerGO)
	if not playerGO then
		return
	end

	local sceneInfo = self:setSceneInfo(playerGO)

	StatController.instance:track(StatEnum.EventName.Act185MapFinish, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - self.gameStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = sceneInfo
	})
end

function FeiLinShiDuoStatHelper:sendDungeonFinish()
	StatController.instance:track(StatEnum.EventName.Act185DungeonFinish, {
		[StatEnum.EventProperties.FeiLinShiDuo_EpisodeId] = tostring(self.curEpisodeId),
		[StatEnum.EventProperties.FeiLinShiDuo_EpisodeUseTime] = UnityEngine.Time.realtimeSinceStartup - self.episodeStartTime
	})
end

FeiLinShiDuoStatHelper.instance = FeiLinShiDuoStatHelper.New()

return FeiLinShiDuoStatHelper

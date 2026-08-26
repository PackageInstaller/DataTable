-- chunkname: @modules/logic/sp02/dungeon/controller/VersionActivity3_10DungeonController.lua

module("modules.logic.sp02.dungeon.controller.VersionActivity3_10DungeonController", package.seeall)

local VersionActivity3_10DungeonController = class("VersionActivity3_10DungeonController", VersionActivityFixedDungeonController)

function VersionActivity3_10DungeonController:reInit()
	self._hasUnlockEpisodeDict = nil
end

function VersionActivity3_10DungeonController:getUnlockEpisodeCount(chapterId)
	local unlockEpisodeCount = 0
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	for _, config in ipairs(episodeList) do
		local dungeonMo = config and DungeonModel.instance:getEpisodeInfo(config.id) or nil

		if dungeonMo then
			unlockEpisodeCount = unlockEpisodeCount + 1
		end
	end

	return unlockEpisodeCount
end

function VersionActivity3_10DungeonController:setHasUnlockEpisode(episodeId)
	self:initEpisodeUnlockData()

	if self:isHasUnlockEpisode(episodeId) then
		return
	end

	self._hasUnlockEpisodeDict[tostring(episodeId)] = 1

	local prefsKey = VersionActivity3_10DungeonEnum.PlayerPrefsKey.HasUnlockEpisode
	local strValue = cjson.encode(self._hasUnlockEpisodeDict)

	self:savePlayerPrefs(prefsKey, strValue)
end

function VersionActivity3_10DungeonController:setHasUnlockAnimEpisode(episodeId)
	self:initEpisodeUnlockData()

	if self:isHasUnlockAnimEpisode(episodeId) then
		return
	end

	self._hasUnlockEpisodeDict[tostring(episodeId)] = 2

	local prefsKey = VersionActivity3_10DungeonEnum.PlayerPrefsKey.HasUnlockEpisode
	local strValue = cjson.encode(self._hasUnlockEpisodeDict)

	self:savePlayerPrefs(prefsKey, strValue)
end

function VersionActivity3_10DungeonController:getEpisodeStatus(episodeId)
	self:initEpisodeUnlockData()

	local value = self._hasUnlockEpisodeDict[tostring(episodeId)]

	return value or 0
end

function VersionActivity3_10DungeonController:isHasUnlockEpisode(episodeId)
	local value = self:getEpisodeStatus(episodeId)

	return value > 0
end

function VersionActivity3_10DungeonController:isHasUnlockAnimEpisode(episodeId)
	local value = self:getEpisodeStatus(episodeId)

	return value > 1
end

function VersionActivity3_10DungeonController:initEpisodeUnlockData()
	if self._hasUnlockEpisodeDict then
		return
	end

	local prefsKey = VersionActivity3_10DungeonEnum.PlayerPrefsKey.HasUnlockEpisode
	local strValue = self:getPlayerPrefs(prefsKey, "")

	self._hasUnlockEpisodeDict = self:loadDictFromStr(strValue)
end

function VersionActivity3_10DungeonController:openFightSuccView(params, isImmediate)
	ViewMgr.instance:openView(ViewName.V3A10_FightSuccView, params, isImmediate)
end

VersionActivity3_10DungeonController.instance = VersionActivity3_10DungeonController.New()

LuaEventSystem.addEventMechanism(VersionActivity3_10DungeonController.instance)

return VersionActivity3_10DungeonController

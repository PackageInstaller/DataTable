-- chunkname: @modules/versionactivitybase/dungeon/controller/VersionActivityDungeonBaseController.lua

module("modules.versionactivitybase.dungeon.controller.VersionActivityDungeonBaseController", package.seeall)

local VersionActivityDungeonBaseController = class("VersionActivityDungeonBaseController", BaseController)

function VersionActivityDungeonBaseController:onInit()
	return
end

function VersionActivityDungeonBaseController:addConstEvents()
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self.updateIsFirstPassEpisodeByDungeonInfo, self)
end

function VersionActivityDungeonBaseController:getChapterLastSelectEpisode(chapterId)
	if not self.chapterIdLastSelectEpisodeIdDict then
		self:initChapterIdLastSelectEpisodeIdDict()
	end

	if not self.chapterIdLastSelectEpisodeIdDict[chapterId] then
		return DungeonConfig.instance:getChapterEpisodeCOList(chapterId)[1].id
	end

	return self.chapterIdLastSelectEpisodeIdDict[chapterId]
end

function VersionActivityDungeonBaseController:getKey()
	return PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.VersionActivityChapterLastSelectEpisodeId)
end

function VersionActivityDungeonBaseController:initChapterIdLastSelectEpisodeIdDict()
	self.chapterIdLastSelectEpisodeIdDict = {}

	local lastSelectEpisodeStr = PlayerPrefsHelper.getString(self:getKey(), "")

	if string.nilorempty(lastSelectEpisodeStr) then
		return
	end

	local arr

	for _, tempStr in ipairs(string.split(lastSelectEpisodeStr, ";")) do
		arr = string.splitToNumber(tempStr, ":")

		if arr and #arr == 2 then
			self.chapterIdLastSelectEpisodeIdDict[arr[1]] = arr[2]
		end
	end
end

function VersionActivityDungeonBaseController:setChapterIdLastSelectEpisodeId(chapterId, episodeId)
	if not self.chapterIdLastSelectEpisodeIdDict then
		self:initChapterIdLastSelectEpisodeIdDict()
	end

	if self.chapterIdLastSelectEpisodeIdDict[chapterId] == episodeId then
		return
	end

	self.chapterIdLastSelectEpisodeIdDict[chapterId] = episodeId

	local arr = {}

	for k, v in pairs(self.chapterIdLastSelectEpisodeIdDict) do
		table.insert(arr, string.format("%s:%s", k, v))
	end

	PlayerPrefsHelper.setString(self:getKey(), table.concat(arr, ";"))
end

function VersionActivityDungeonBaseController:clearChapterIdLastSelectEpisodeId()
	self.chapterIdLastSelectEpisodeIdDict = nil
end

function VersionActivityDungeonBaseController:getIsFirstPassEpisode()
	return self.checkIsFirstPass, self.checkEpisodeId
end

function VersionActivityDungeonBaseController:resetIsFirstPassEpisode(episodeId)
	self.checkEpisodeId = episodeId
	self.checkIsFirstPass = false

	if not episodeId then
		self.hasPassEpisode = true

		return
	end

	self.hasPassEpisode = DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function VersionActivityDungeonBaseController:updateIsFirstPassEpisodeByDungeonInfo(dungeonInfo)
	if dungeonInfo and dungeonInfo.episodeId then
		self:updateIsFirstPassEpisode(dungeonInfo.episodeId)
	end
end

function VersionActivityDungeonBaseController:updateIsFirstPassEpisode(episodeId)
	if self.checkEpisodeId ~= episodeId then
		return
	end

	if self.hasPassEpisode then
		self.checkIsFirstPass = false

		return
	end

	self.checkIsFirstPass = DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function VersionActivityDungeonBaseController:isOpenActivityHardDungeonChapter(actId)
	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)

	if not activityDungeonConfig then
		logError("act Id : " .. actId .. " not exist activity dungeon config, please check!!!")

		return false
	end

	local isTimeOpen = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(activityDungeonConfig.hardChapterId)

	if not isTimeOpen then
		return false
	end

	return DungeonModel.instance:chapterIsUnLock(activityDungeonConfig.hardChapterId)
end

function VersionActivityDungeonBaseController:isOpenActivityHardDungeonChapterAndGetToast(actId)
	local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)

	if not activityDungeonConfig then
		logError("act Id : " .. actId .. " not exist activity dungeon config, please check!!!")

		return false, 10301
	end

	local isTimeOpen = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(activityDungeonConfig.hardChapterId)

	if not isTimeOpen then
		return false, 10301
	end

	local isUnlock = DungeonModel.instance:chapterIsUnLock(activityDungeonConfig.hardChapterId)

	if not isUnlock then
		return false, 10302
	end

	return true
end

VersionActivityDungeonBaseController.instance = VersionActivityDungeonBaseController.New()

LuaEventSystem.addEventMechanism(VersionActivityDungeonBaseController.instance)
VersionActivityDungeonBaseController.instance:addConstEvents()

return VersionActivityDungeonBaseController

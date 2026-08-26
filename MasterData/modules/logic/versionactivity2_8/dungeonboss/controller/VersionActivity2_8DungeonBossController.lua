-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/controller/VersionActivity2_8DungeonBossController.lua

module("modules.logic.versionactivity2_8.dungeonboss.controller.VersionActivity2_8DungeonBossController", package.seeall)

local VersionActivity2_8DungeonBossController = class("VersionActivity2_8DungeonBossController", BaseController)

function VersionActivity2_8DungeonBossController:onInit()
	return
end

function VersionActivity2_8DungeonBossController:reInit()
	TaskDispatcher.cancelTask(self._delayFinishElement, self)
	TaskDispatcher.cancelTask(self._delayCheckBassActReddot, self)

	self._needFinishElement = nil
end

function VersionActivity2_8DungeonBossController:addConstEvents()
	DungeonController.instance:registerCallback(DungeonMapElementEvent.OnElementAdd, self._onElementAdd, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function VersionActivity2_8DungeonBossController:_onElementAdd(elementId)
	if elementId == VersionActivity2_8BossEnum.ElementId and not DungeonMapModel.instance:elementIsFinished(elementId) and DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) then
		self._needFinishElement = true

		if ViewMgr.instance:isOpen(ViewName.VersionActivity2_8BossStoryLoadingView) then
			return
		end

		self:_startDelayFinishElement(1)
	end
end

function VersionActivity2_8DungeonBossController:_onUpdateDungeonInfo(dungeonInfo)
	if dungeonInfo and dungeonInfo.chapterId == DungeonEnum.ChapterId.BossAct then
		self:checkBossActReddot()
	end
end

function VersionActivity2_8DungeonBossController:forceFinishElement()
	self:_startDelayFinishElement(1)
end

function VersionActivity2_8DungeonBossController:_startDelayFinishElement(time)
	UIBlockHelper.instance:startBlock("VersionActivity2_8DungeonBossController:_delayFinishElement", time)
	TaskDispatcher.runDelay(self._delayFinishElement, self, time)
end

function VersionActivity2_8DungeonBossController:_delayFinishElement()
	DungeonRpc.instance:sendMapElementRequest(VersionActivity2_8BossEnum.ElementId, nil, self._onMapElementFinish, self)
end

function VersionActivity2_8DungeonBossController:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity2_8BossStoryLoadingView and self._needFinishElement then
		self._needFinishElement = false

		self:_startDelayFinishElement(1)
	end
end

function VersionActivity2_8DungeonBossController:_onMapElementFinish(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.EndShowRewardView)
end

function VersionActivity2_8DungeonBossController:_onOpenView(viewName)
	if viewName == ViewName.MainView then
		self:checkBossActReddot()
	end
end

function VersionActivity2_8DungeonBossController:openVersionActivity2_8BossStoryEyeView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8BossStoryEyeView, param, isImmediate)
end

function VersionActivity2_8DungeonBossController:openVersionActivity2_8BossStoryEnterView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.VersionActivity2_8BossStoryEnterView, param, isImmediate)

	return ViewName.VersionActivity2_8BossStoryEnterView
end

function VersionActivity2_8DungeonBossController:checkBossActReddot()
	TaskDispatcher.cancelTask(self._delayCheckBassActReddot, self)

	local status = ActivityHelper.getActivityStatus(VersionActivity2_8Enum.ActivityId.DungeonBoss)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	if not isNormal then
		return
	end

	local actStartTime = ActivityModel.instance:getActStartTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000
	local actEndTime = ActivityModel.instance:getActEndTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000
	local firstOpenDay = 0
	local secondOpenDay = firstOpenDay + tonumber(lua_boss_fight_mode_const.configDict[1].value)
	local thirdOpenDay = firstOpenDay + tonumber(lua_boss_fight_mode_const.configDict[2].value)
	local list = {
		firstOpenDay,
		actStartTime + secondOpenDay * TimeUtil.OneDaySecond,
		actStartTime + thirdOpenDay * TimeUtil.OneDaySecond
	}
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity2_8BossEnum.BossActChapterId)
	local nextOpenTime = 0
	local showReddot = false

	for i, v in ipairs(episodeList) do
		local time = list[i]

		if time <= ServerTime.now() then
			showReddot = showReddot or DungeonModel.instance:hasPassLevel(v.preEpisode) and not DungeonModel.instance:hasPassLevel(v.id)
		else
			nextOpenTime = time

			break
		end
	end

	local reddotItemInfo = {
		replaceAll = true,
		defineId = RedDotEnum.DotNode.V2a8DungeonBossAct,
		infos = {
			{
				id = 0,
				time = 0,
				value = showReddot and 1 or 0
			}
		}
	}
	local redDotInfos = {
		reddotItemInfo
	}

	RedDotModel.instance:updateRedDotInfo(redDotInfos)
	self:_updateReddot(redDotInfos)

	if nextOpenTime > 0 then
		TaskDispatcher.runDelay(self._delayCheckBassActReddot, self, nextOpenTime - ServerTime.now() + 1)
	end
end

function VersionActivity2_8DungeonBossController:_updateReddot(redDotInfos)
	local refreshlist = {}

	for _, v in ipairs(redDotInfos) do
		local ids = RedDotModel.instance:_getAssociateRedDots(v.defineId)

		for _, id in pairs(ids) do
			refreshlist[id] = true
		end
	end

	RedDotController.instance:CheckExpireDot()
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
	RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
end

function VersionActivity2_8DungeonBossController:_delayCheckBassActReddot()
	self:checkBossActReddot()
end

function VersionActivity2_8DungeonBossController.hasOnceActionKey(type, id)
	local key = VersionActivity2_8DungeonBossController._getKey(type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function VersionActivity2_8DungeonBossController.setOnceActionKey(type, id)
	local key = VersionActivity2_8DungeonBossController._getKey(type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function VersionActivity2_8DungeonBossController.getPrefsString(type, defaultValue)
	local key = VersionActivity2_8DungeonBossController._getKey(type, type)

	return (PlayerPrefsHelper.getString(key, defaultValue or ""))
end

function VersionActivity2_8DungeonBossController.setPrefsString(type, value)
	local key = VersionActivity2_8DungeonBossController._getKey(type, type)

	return PlayerPrefsHelper.setString(key, value)
end

function VersionActivity2_8DungeonBossController._getKey(type, id)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.V2a8DungeonBossOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id))
end

VersionActivity2_8DungeonBossController.instance = VersionActivity2_8DungeonBossController.New()

return VersionActivity2_8DungeonBossController

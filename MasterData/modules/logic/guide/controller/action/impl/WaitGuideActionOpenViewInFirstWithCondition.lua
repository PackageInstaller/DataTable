-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionOpenViewInFirstWithCondition.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewInFirstWithCondition", package.seeall)

local WaitGuideActionOpenViewInFirstWithCondition = class("WaitGuideActionOpenViewInFirstWithCondition", BaseGuideAction)

function WaitGuideActionOpenViewInFirstWithCondition:onStart(context)
	WaitGuideActionOpenViewInFirstWithCondition.super.onStart(self, context)

	local paramList = string.split(self.actionParam, "#")

	self._viewName = ViewName[paramList[1]]

	local funcName = paramList[2]

	self._conditionParam = paramList[3]
	self._delayTime = paramList[4] and tonumber(paramList[4]) or 0.2
	self._conditionCheckFun = self[funcName]

	if self:checkDone() then
		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._checkOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._checkOpenView, self)
end

function WaitGuideActionOpenViewInFirstWithCondition:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._checkOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, self._checkOpenView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._checkOpenView, self)
end

function WaitGuideActionOpenViewInFirstWithCondition:_checkOpenView(viewName, viewParam)
	if viewName == ViewName.CharacterView then
		WaitGuideActionOpenViewInFirstWithCondition.heroMo = viewParam
	end

	self:checkDone()
end

function WaitGuideActionOpenViewInFirstWithCondition:checkDone()
	TaskDispatcher.cancelTask(self._delayDone, self)

	local result = self:_check()

	if result then
		if self._delayTime and self._delayTime > 0 then
			TaskDispatcher.runDelay(self._delayDone, self, self._delayTime)
		else
			self:onDone(true)
		end
	end

	return result
end

function WaitGuideActionOpenViewInFirstWithCondition:_delayDone()
	self:onDone(true)
end

function WaitGuideActionOpenViewInFirstWithCondition:_check()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	if #openViewNameList > 0 then
		return self:isFirstView(openViewNameList, self._viewName) and (self._conditionCheckFun == nil or self._conditionCheckFun(self._conditionParam, self))
	else
		return false
	end
end

function WaitGuideActionOpenViewInFirstWithCondition:isFirstView(openViewNameList, viewName)
	WaitGuideActionOpenViewInFirstWithCondition.excludeView = WaitGuideActionOpenViewInFirstWithCondition.excludeView or {
		[ViewName.GMGuideStatusView] = 1,
		[ViewName.GMToolView2] = 1,
		[ViewName.GMToolView] = 1,
		[ViewName.ToastView] = 1
	}

	local result = false
	local curView

	for i = #openViewNameList, 1, -1 do
		if not WaitGuideActionOpenViewInFirstWithCondition.excludeView[openViewNameList[i]] then
			result = openViewNameList[i] == viewName

			break
		end
	end

	if not result then
		logNormal(string.format("<color=#FFA500>guide_%d_%d %s not is first view! %s</color>", self.guideId, self.stepId, viewName, table.concat(openViewNameList, "#")))
	end

	return result
end

local Activity109EpisodeId = 8

function WaitGuideActionOpenViewInFirstWithCondition.activity109ChessOpenNextStage()
	local actId = Activity109ChessModel.instance:getActId()

	if actId then
		::label_8_0::

		local episodeCO = Activity109Config.instance:getEpisodeCo(actId, Activity109EpisodeId)

		if not episodeCO then
			return false
		end

		local activityInfos = ActivityModel.instance:getActivityInfo()

		if not activityInfos then
			return false
		end

		local activityData = activityInfos[actId]

		if not activityData then
			return false
		end

		local openTime = activityData:getRealStartTimeStamp() + (episodeCO.openDay - 1) * 24 * 60 * 60

		if openTime > ServerTime.now() then
			return false
		end

		return true
	end
end

function WaitGuideActionOpenViewInFirstWithCondition.checkDestinyStone()
	local heroMo = WaitGuideActionOpenViewInFirstWithCondition.heroMo

	if heroMo and heroMo:isOwnHero() and heroMo:isCanOpenDestinySystem() then
		return true
	end
end

function WaitGuideActionOpenViewInFirstWithCondition.checkTowerLimitGuideTrigger()
	return GuideTriggerOpenViewCondition.checkTowerLimitOpen()
end

function WaitGuideActionOpenViewInFirstWithCondition.NoOtherGuideExecute(param, instance)
	if not DungeonModel.instance:chapterListIsNormalType() then
		return false
	end

	local list = DungeonMainStoryModel.instance:getConflictGuides()

	for i, v in ipairs(list) do
		local mo = GuideModel.instance:getById(v)

		if mo and not mo.isFinish and mo.clientStepId ~= 0 then
			if SLFramework.FrameworkSettings.IsEditor then
				logWarn("有其它引导在跑 id:", tostring(v), tostring(mo.isFinish), tostring(mo.clientStepId))
			end

			return false
		end
	end

	local chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()

	if instance.guideId == DungeonMainStoryEnum.Guide.PreviouslyOn then
		return not DungeonMainStoryModel.instance:showPreviewChapterFlag(chapterId)
	end

	if instance.guideId == DungeonMainStoryEnum.Guide.EarlyAccess then
		return DungeonMainStoryModel.instance:showPreviewChapterFlag(chapterId)
	end

	return false
end

function WaitGuideActionOpenViewInFirstWithCondition.checkNecrologistReviewOpen(param)
	local storyId = tonumber(param)

	return NecrologistStoryModel.instance:isReviewCanShow(storyId)
end

function WaitGuideActionOpenViewInFirstWithCondition.checkV3A1NecrologistBaseFinish(param)
	local baseId = tonumber(param)
	local storyId = NecrologistStoryEnum.RoleStoryId.V3A1
	local mo = NecrologistStoryModel.instance:getGameMO(storyId)

	if not mo then
		return false
	end

	return mo:isBaseFinish(baseId)
end

function WaitGuideActionOpenViewInFirstWithCondition.checkV3A2NecrologistItemUnlock(param)
	local itemId = tonumber(param)
	local storyId = NecrologistStoryEnum.RoleStoryId.V3A2
	local mo = NecrologistStoryModel.instance:getGameMO(storyId)

	if not mo then
		return false
	end

	return mo:isItemUnlock(itemId)
end

function WaitGuideActionOpenViewInFirstWithCondition.checkV3a9RacingCarFinish(param)
	local episodeId = tonumber(param)
	local info = V3a9RacingCarEpisodeModel.instance:getEpisodeInfo(episodeId)

	return info and info.isFinished
end

function WaitGuideActionOpenViewInFirstWithCondition.checkEnterV3a9RacingCarGame(param)
	local episodeId = tonumber(param)
	local episodeConfig = V3a9RacingCarModel.instance:getEpisodeConfig()

	return episodeConfig and episodeConfig.episodeId == episodeId
end

return WaitGuideActionOpenViewInFirstWithCondition

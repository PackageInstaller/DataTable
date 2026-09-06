-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/controller/StorySummaryController.lua

module("logic.extensions.storysummary.controller.StorySummaryController", package.seeall)

local StorySummaryController = class("StorySummaryController", BaseController)

StorySummaryController.AnimType = {
	lastAnim = "StorySummaryStoryAnimIdTypeLastAnim",
	pureAnim = "StorySummaryStoryAnimIdTypePureAnim",
	preAnim = "StorySummaryStoryAnimIdTypePreAnim"
}
StorySummaryController.ChapterIntro = "StorySummaryChapterIntro"

function StorySummaryController:ctor()
	return
end

function StorySummaryController:onInit()
	self:onReset()
end

function StorySummaryController:onReset()
	return
end

function StorySummaryController:onSendStorySummaryInfoReq()
	StorySummaryAgent.instance:sendPM_StorySummaryInfoReq()
end

function StorySummaryController:onHandleStorySummaryInfoRes(msg)
	StorySummaryModel.instance:onHandleStorySummaryInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.StorySummaryInfoRes)
end

function StorySummaryController:onSendStorySummaryFightOrViewReq(chapterId, stageId)
	chapterId = checknumber(chapterId)
	stageId = checknumber(stageId)

	if chapterId == 0 or stageId == 0 then
		printError("发送协议失败,检查 chapterId 与 stageId")

		return
	end

	local form

	StorySummaryAgent.instance:sendPM_StorySummaryFightOrViewReq(chapterId, stageId, (not self:isPurePlotStage(chapterId, stageId) or nil) and StorySummaryModel.instance:getCustomFmtMo():getCurSimpleForm())
end

function StorySummaryController:onHandleStorySummaryFightOrViewRes(status, msg)
	if status == 0 then
		StorySummaryModel.instance:onHandleStorySummaryFightOrViewRes(msg)
	end

	self:_onHandleFightOrViewRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.StorySummaryFightOrViewRes, status, msg)
end

function StorySummaryController:onHandleNotifyStorySummaryFightEndRes(status, msg)
	if status == 0 then
		StorySummaryModel.instance:onHandleNotifyStorySummaryFightEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.StorySummaryFightEndRes)
	end
end

function StorySummaryController:dailyRefresh()
	return
end

function StorySummaryController:isStoryInTime(storyPlanId)
	local isInTime = false
	local partCfg = StorySummaryConfig.instance:getSsPartCfg(storyPlanId)

	for _, data in ipairs(partCfg) do
		local partPType = self:getPartPeriodType(storyPlanId, data.partIdx)

		if partPType == GameUtil.inTimePeriod then
			isInTime = true

			break
		end
	end

	return isInTime
end

function StorySummaryController:isStoryUnlock(storyPlanId)
	return (self:isStoryInTime(storyPlanId))
end

function StorySummaryController:isStoryNeedRed(storyPlanId)
	local isStoryNeedRed = false

	if self:isStoryUnlock(storyPlanId) then
		local partCfg = StorySummaryConfig.instance:getSsPartCfg(storyPlanId)

		for _, partData in ipairs(partCfg) do
			if self:isPartNeedRed(partData.storyPlanId, partData.partIdx) then
				isStoryNeedRed = true

				break
			end
		end
	end

	return isStoryNeedRed
end

function StorySummaryController:getPartPeriodType(storyPlanId, partIdx)
	local partData = StorySummaryConfig.instance:getSsPartData(storyPlanId, partIdx)

	return GameUtil.getTimePeriodType(partData.startTime, partData.endTime)
end

function StorySummaryController:isPartNewTagInTime(storyPlanId, partIdx)
	local partData = StorySummaryConfig.instance:getSsPartData(storyPlanId, partIdx)
	local startTimeStamp = GameUtil.string2time(partData.startTime)
	local endTimeStamp = startTimeStamp + partData.newTagExistDay * 24 * 60 * 60
	local perType = GameUtil.getTimePeriodTypeBySec(startTimeStamp, endTimeStamp)

	return perType == GameUtil.inTimePeriod
end

function StorySummaryController:isPartPassPrePartCond(storyPlanId, partIdx)
	local partData = StorySummaryConfig.instance:getSsPartData(storyPlanId, partIdx)

	return (partData.prePartId ~= 0 or nil) and self:isStorySummaryPartPass(partData.prePartId)
end

function StorySummaryController:isPartPassThreadCond(storyPlanId, partIdx)
	local isPassThreadCond = true
	local partData = StorySummaryConfig.instance:getSsPartData(storyPlanId, partIdx)

	if partData.unlockCondition ~= nil then
		local threadChapterId, threadStageId = partData.unlockCondition[1], partData.unlockCondition[2]

		isPassThreadCond = PlotCopyModel.instance:isStagePassedAllCopy(threadChapterId, threadStageId)
	end

	return isPassThreadCond
end

function StorySummaryController:isStorySummaryPartPass(partId)
	local isPartPass = true
	local chapterCfg = StorySummaryConfig.instance:getSsChapterCfg(partId)

	for _, data in ipairs(chapterCfg) do
		local isChapterPass = self:isStorySummaryChapterPassByChapterId(data.chapterId)

		if isChapterPass == false then
			isPartPass = false

			break
		end
	end

	return isPartPass
end

function StorySummaryController:isPartUnlock(storyPlanId, partIdx)
	local perType = StorySummaryController.instance:getPartPeriodType(storyPlanId, partIdx)
	local isInTime = perType == GameUtil.inTimePeriod
	local isPassPrePart = StorySummaryController.instance:isPartPassPrePartCond(storyPlanId, partIdx)
	local isPassThreadCond = StorySummaryController.instance:isPartPassThreadCond(storyPlanId, partIdx)

	return isInTime and isPassPrePart and isPassThreadCond
end

function StorySummaryController:isPartNeedRed(storyPlanId, partIdx)
	if not self:isPartUnlock(storyPlanId, partIdx) then
		return false
	end

	local partData = StorySummaryConfig.instance:getSsPartData(storyPlanId, partIdx)
	local chapterCfg = StorySummaryConfig.instance:getSsChapterCfg(partData.partId)

	for _, chapterData in ipairs(chapterCfg) do
		if self:isChapterNeedRed(chapterData.partId, chapterData.chapterIdx) then
			return true
		end
	end

	local partData = StorySummaryConfig.instance:getSsPartData(storyPlanId, partIdx)

	return RoleRelationshipController.instance:isShipNeedRed(partData.shipActivityId)
end

function StorySummaryController:isStorySummaryPartNeedPrologue(partId)
	local data = StorySummaryConfig.instance:getSsPartDataByPId(partId)
	local isNilName = string.nilorempty(data.prologueName)
	local isNilDesc = string.nilorempty(data.prologueDesc)

	return not isNilName and not isNilDesc
end

function StorySummaryController:getChapterPeriodType(partId, chapterIdx)
	local chapterData = StorySummaryConfig.instance:getSsChapterData(partId, chapterIdx)

	return GameUtil.getTimePeriodType(chapterData.startTime, chapterData.endTime)
end

function StorySummaryController:isChapterNeedRed(partId, chapterIdx)
	local isChapterUnlock = self:isChapterUnlock(partId, chapterIdx)
	local isChapterPass = self:isStorySummaryChapterPass(partId, chapterIdx)

	return isChapterUnlock and not isChapterPass
end

function StorySummaryController:isChapterUnlock(partId, chapterIdx)
	local perType = StorySummaryController.instance:getChapterPeriodType(partId, chapterIdx)
	local isInTime = perType == GameUtil.inTimePeriod
	local isPassPreChapter = StorySummaryController.instance:isChapterPassPreChapterCond(partId, chapterIdx)
	local isPassThreadCond = StorySummaryController.instance:isChapterPassThreadCond(partId, chapterIdx)

	return isInTime and isPassPreChapter and isPassThreadCond
end

function StorySummaryController:isChapterPassPreChapterCond(partId, chapterIdx)
	local chapterData = StorySummaryConfig.instance:getSsChapterData(partId, chapterIdx)

	return (chapterData.preChapterId ~= 0 or nil) and self:isStorySummaryChapterPassByChapterId(chapterData.preChapterId)
end

function StorySummaryController:isChapterPassThreadCond(partId, chapterIdx)
	local isPassThreadCond = true
	local chapterData = StorySummaryConfig.instance:getSsChapterData(partId, chapterIdx)

	if chapterData.unlockCondition ~= nil then
		local threadChapterId, threadStageId = chapterData.unlockCondition[1], chapterData.unlockCondition[2]

		isPassThreadCond = PlotCopyModel.instance:isStagePassedAllCopy(threadChapterId, threadStageId)
	end

	return isPassThreadCond
end

function StorySummaryController:isStorySummaryChapterPass(partId, chapterIdx)
	local chapterData = StorySummaryConfig.instance:getSsChapterData(partId, chapterIdx)

	return self:isStorySummaryChapterPassByChapterId(chapterData.chapterId)
end

function StorySummaryController:isStorySummaryChapterPassByChapterId(chapterId)
	local isChapterPass = true

	if chapterId == 0 then
		return isChapterPass
	end

	local stageCfg = StorySummaryConfig.instance:getSsStageCfg(chapterId)

	for _, data in ipairs(stageCfg) do
		local isStagePass = self:isStorySummaryStagePass(data.chapterId, data.stageId)

		if isStagePass == false then
			isChapterPass = false

			break
		end
	end

	return isChapterPass
end

function StorySummaryController:isStageUnlock(chapterId, stageId)
	local chapterData = StorySummaryConfig.instance:getSsChapterDataByCId(chapterId)
	local isChapterUnlock = self:isChapterUnlock(chapterData.partId, chapterData.chapterIdx)

	isPreStagePass = stageId == 1 and true or self:isStorySummaryStagePass(chapterId, stageId - 1)

	return isChapterUnlock and isPreStagePass
end

function StorySummaryController:isStorySummaryStagePass(chapterId, stageId)
	local stagePassInfo = StorySummaryModel.instance:getStorySummaryStagePassInfo(chapterId, stageId)

	return stagePassInfo == true
end

function StorySummaryController:isPurePlotStage(chapterId, stageId)
	local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

	return stageData.creepsMasterId == 0
end

function StorySummaryController:isStageCanRepeat(chapterId, stageId)
	local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

	return stageData.isCanRepeat
end

function StorySummaryController:isSupportStage(chapterId, stageId)
	local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

	return stageData.supportId ~= 0
end

function StorySummaryController:enterStorySummaryStage(chapterId, stageId)
	local isPass = self:isStorySummaryStagePass(chapterId, stageId)
	local isCanRepeat = self:isStageCanRepeat(chapterId, stageId)

	if isPass and not isCanRepeat then
		FloatWordMgr.instance:show("不可重复挑战")

		return
	end

	local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

	if self:isPurePlotStage(chapterId, stageId) then
		if stageData.pureAnimId == 0 then
			printError("本关卡属纯剧情关卡,但缺失动画id,务必检查配置.(chapterId=%d, stageId=%d)", chapterId, stageId)
		else
			local isSuccess = self:playStoryAnim(stageData.pureAnimId, key)

			self:onSendStorySummaryFightOrViewReq(chapterId, stageId)
		end
	else
		self:playStoryAnim(stageData.preAnimId, key)

		if isPass then
			self:playStoryAnim(stageData.lastAnimId, key)
		else
			self:enterSotrySummaryStageBattle(chapterId, stageId)
		end
	end
end

function StorySummaryController:_onHandleFightOrViewRes(status, msg)
	if status == 0 and msg.requestParams then
		local info = msg.requestParams
		local chapterId = info.chapterId
		local stageId = info.stageId
		local stageData = StorySummaryConfig.instance:getSsStageData(chapterId, stageId)

		local function handler(isWin)
			if isWin and stageData.lastAnimId ~= 0 then
				local key = self:getStoryAnimStateKey(chapterId, stageId, StorySummaryController.AnimType.lastAnim)
				local isStroyAnimHasPlay = self:isStroyAnimHasPlay(key)

				if isStroyAnimHasPlay and isOnlyPlayOne then
					return
				end

				local storyData = {
					storyId = stageData.lastAnimId,
					mode = TaskConst.BattleStoryTrigger_End
				}

				BattleModel.instance:setStoryData(storyData)
			end
		end

		BattleFacade.instance:setBattleEndRoundFromStoryHandler(handler)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function StorySummaryController:enterSotrySummaryStageBattle(chapterId, stageId)
	local customFmtMo = StorySummaryModel.instance:getCustomFmtMo()

	customFmtMo:updateCfg(chapterId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function StorySummaryController:startSotrySummaryStageBattle(chapterId, stageId)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEnd, self)
	self:onSendStorySummaryFightOrViewReq(chapterId, stageId)
end

function StorySummaryController:_handlerBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		local viewInfos = StorySummaryModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		local viewInfos = StorySummaryModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function StorySummaryController:playStoryAnim(AnimId, key)
	if AnimId == 0 then
		return false
	end

	if not string.nilorempty(key) then
		if self:isStroyAnimHasPlay(key) then
			return false
		else
			self:setStroyAnimState(key, true)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, AnimId, StoryModel.StoryType.SCCopy)

	return true
end

function StorySummaryController:isStroyAnimHasPlay(key)
	local value = GameUtil.getUserData(key)

	if value == 1 then
		return true
	elseif value == 0 then
		return false
	else
		return false
	end
end

function StorySummaryController:setStroyAnimState(key, isHasPlay)
	local value

	GameUtil.saveUserData(key, isHasPlay and 1 or 0)
end

function StorySummaryController:getStoryAnimStateKey(chapterId, stageId, AnimType)
	if string.nilorempty(chapterId) or string.nilorempty(stageId) or string.nilorempty(AnimType) then
		printError("获取故事剧情状态关键字失败,key组成参数缺失")

		return nil
	end

	return AnimType .. chapterId .. stageId
end

function StorySummaryController:isChapterIntroHasView(key)
	local value = GameUtil.getUserData(key)

	return value == 1
end

function StorySummaryController:setChapterIntroState(key, isHasView)
	local value = isHasView and 1 or 0

	GameUtil.saveUserData(key, value)
end

function StorySummaryController:getChapterIntroKey(chapterId)
	if string.nilorempty(chapterId) then
		printError("获取章节简介关键字失败,key组成参数缺失")

		return nil
	end

	return StorySummaryController.ChapterIntro .. chapterId
end

StorySummaryController.instance = StorySummaryController.New()

return StorySummaryController

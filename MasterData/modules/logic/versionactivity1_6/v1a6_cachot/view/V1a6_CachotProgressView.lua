-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotProgressView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressView", package.seeall)

local V1a6_CachotProgressView = class("V1a6_CachotProgressView", BaseView)

function V1a6_CachotProgressView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._txtdetail = gohelper.findChildText(self.viewGO, "Left/#txt_detail")
	self._txtscore = gohelper.findChildText(self.viewGO, "Left/#txt_score")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Left/#txt_score/#simage_icon")
	self._goprogress = gohelper.findChild(self.viewGO, "Left/#go_progress")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "Left/#go_progress/#scroll_view")
	self._gofillbg = gohelper.findChild(self.viewGO, "Left/#go_progress/#scroll_view/Viewport/Content/#go_fillbg")
	self._gofill = gohelper.findChild(self.viewGO, "Left/#go_progress/#scroll_view/Viewport/Content/#go_fillbg/#go_fill")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gonextstagetips = gohelper.findChild(self.viewGO, "Left/#go_nextstagetips")
	self._txtnextstageopentime = gohelper.findChildText(self.viewGO, "Left/#go_nextstagetips/nextstage/#txt_nextstageopentime")
	self._txtreamindoulescore = gohelper.findChildText(self.viewGO, "Left/#txt_score/#txt_remaindoublescore")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_back")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotProgressView:addEvents()
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, self.onRogueSateInfoUpdate, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onWeekRefresh, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
end

function V1a6_CachotProgressView:removeEvents()
	self.removeEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueStateInfo, self.onRogueSateInfoUpdate, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onWeekRefresh, self)
	self._btnback:RemoveClickListener()
end

function V1a6_CachotProgressView:_editableInitView()
	return
end

function V1a6_CachotProgressView:onUpdateParam()
	return
end

function V1a6_CachotProgressView:onOpen()
	V1a6_CachotProgressListModel.instance:initDatas()
	self:refreshScoreUI()
end

function V1a6_CachotProgressView:refreshScoreUI()
	self:refreshScoreInfo()
	self:refreshStageInfo()
	self:setProgressBarWidth()
	self:setProgressHorizontalPos()
	self:refreshRedDot()
end

function V1a6_CachotProgressView:refreshStageInfo()
	self:updateUnLockNextStageRemainTime()
end

function V1a6_CachotProgressView:refreshUnLockNextStageTimeUI(remainDay, remainHour)
	self._txtnextstageopentime.text = remainDay > 0 and formatLuaLang("cachotprogressview_remainDay", remainDay) or formatLuaLang("cachotprogressview_remainHour", remainHour)
end

function V1a6_CachotProgressView:refreshScoreInfo()
	local curGetScore = V1a6_CachotProgressListModel.instance:getCurGetTotalScore()
	local weekScoreConstConfig = lua_rogue_const.configDict[V1a6_CachotEnum.Const.DoubleScoreLimit]

	if weekScoreConstConfig then
		local weekScoreRange = tonumber(weekScoreConstConfig.value or 0)
		local weekScore = V1a6_CachotProgressListModel.instance:getWeekScore()
		local isGetWholeDoubleScore = weekScoreRange <= weekScore

		self._txtscore.text = curGetScore or ""

		gohelper.setActive(self._txtreamindoulescore.gameObject, not isGetWholeDoubleScore)

		if not isGetWholeDoubleScore then
			local tag = {
				weekScore,
				weekScoreRange
			}

			self._txtreamindoulescore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cachot_progressview_remaindoublescore"), tag)
		end
	end
end

V1a6_CachotProgressView.SingleRewardtWidth = 240

function V1a6_CachotProgressView:setProgressBarWidth()
	local unlockedRewardCount = V1a6_CachotProgressListModel.instance:getUnLockedRewardCount()

	self:setScrollFillBgWidth(unlockedRewardCount)
	self:setScrollFillWidth()
end

function V1a6_CachotProgressView:setScrollFillBgWidth(unlockRewardNum)
	local unlockRewardCountExceptFirst = unlockRewardNum - 1

	recthelper.setWidth(self._gofillbg.transform, Mathf.Clamp(unlockRewardCountExceptFirst, 0, unlockRewardCountExceptFirst) * V1a6_CachotProgressView.SingleRewardtWidth)
end

function V1a6_CachotProgressView:setScrollFillWidth()
	local curStage = V1a6_CachotProgressListModel.instance:getCurrentStage()

	if curStage <= 0 then
		recthelper.setWidth(self._gofill.transform, 0)

		return
	end

	local finishPartCount = V1a6_CachotProgressListModel.instance:getCurFinishRewardCount()
	local curScore = V1a6_CachotProgressListModel.instance:getCurGetTotalScore()
	local lastRewardId, nextRewardId = V1a6_CachotScoreConfig.instance:getStagePartRange(curScore)
	local lastRewardScore = V1a6_CachotScoreConfig.instance:getStagePartScore(lastRewardId)
	local nextRewardScore = V1a6_CachotScoreConfig.instance:getStagePartScore(nextRewardId)
	local rewardScoreRange = nextRewardScore - lastRewardScore

	if rewardScoreRange > 0 then
		if not ((curScore - lastRewardScore) / rewardScoreRange) then
			local rewardPartProgress = 0

			if rewardPartProgress >= 1 then
				rewardPartProgress = 0
			end

			local totalProgress = finishPartCount + rewardPartProgress
			local fillWidth = Mathf.Clamp(totalProgress - 1, 0, totalProgress) * V1a6_CachotProgressView.SingleRewardtWidth

			recthelper.setWidth(self._gofill.transform, fillWidth)
		end
	end
end

function V1a6_CachotProgressView:setProgressHorizontalPos()
	local csListView = self.viewContainer._scrollView:getCsScroll()
	local finishMoList = V1a6_CachotProgressListModel.instance:getHasFinishedMoList()
	local offset = 0

	if finishMoList and #finishMoList > 0 then
		offset = offset + (self.viewContainer._scrollParam.startSpace or 0)

		for i = 1, #finishMoList - 1 do
			local singleItemWidth = finishMoList[i]:getLineWidth() or 0

			offset = offset + singleItemWidth
		end
	end

	self.viewContainer._scrollView:refreshScroll()

	csListView.HorizontalScrollPixel = math.max(0, offset)
end

function V1a6_CachotProgressView:updateUnLockNextStageRemainTime()
	local isAllRewardUnLocked = V1a6_CachotProgressListModel.instance:isAllRewardUnLocked()

	gohelper.setActive(self._gonextstagetips, not isAllRewardUnLocked)

	if not isAllRewardUnLocked then
		TaskDispatcher.cancelTask(self.onOneMinutesPassCallBack, self)
		TaskDispatcher.runRepeat(self.onOneMinutesPassCallBack, self, TimeUtil.OneMinuteSecond)
		self:checkIsArriveUnLockNextStageTime()
	end
end

function V1a6_CachotProgressView:onOneMinutesPassCallBack()
	V1a6_CachotProgressListModel.instance:updateUnLockNextStageRemainTime(TimeUtil.OneMinuteSecond)
	self:checkIsArriveUnLockNextStageTime()
end

function V1a6_CachotProgressView:checkIsArriveUnLockNextStageTime()
	local unLockNextStageRemainTime = V1a6_CachotProgressListModel.instance:getUnLockNextStageRemainTime()

	if unLockNextStageRemainTime and unLockNextStageRemainTime > 0 then
		local remainDay, remainHour = TimeUtil.secondsToDDHHMMSS(unLockNextStageRemainTime)

		self:refreshUnLockNextStageTimeUI(remainDay, remainHour)
	else
		TaskDispatcher.cancelTask(self.onOneMinutesPassCallBack, self)
		RogueRpc.instance:sendGetRogueStateRequest()
	end
end

function V1a6_CachotProgressView:onRogueSateInfoUpdate()
	V1a6_CachotProgressListModel.instance:initDatas()
	self:refreshScoreUI()
end

function V1a6_CachotProgressView:_onWeekRefresh()
	RogueRpc.instance:sendGetRogueStateRequest()
end

function V1a6_CachotProgressView:refreshRedDot()
	local doublekey = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueDoubleScore
	local stagekey = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueRewardStage
	local time = ServerTime.now()
	local stage = V1a6_CachotProgressListModel.instance:getCurrentStage()

	if V1a6_CachotProgressListModel.instance:checkRewardStageChange() then
		PlayerPrefsHelper.setNumber(stagekey, stage)
		V1a6_CachotProgressListModel.instance:checkRewardStageChangeRed()
	end

	if V1a6_CachotProgressListModel.instance:checkDoubleStoreRefresh() then
		PlayerPrefsHelper.setString(doublekey, time)
		V1a6_CachotProgressListModel.instance:checkDoubleStoreRefreshRed()
	end
end

function V1a6_CachotProgressView:_btnbackOnClick()
	self:closeThis()
end

function V1a6_CachotProgressView:onClose()
	return
end

function V1a6_CachotProgressView:onDestroyView()
	TaskDispatcher.cancelTask(self.onOneMinutesPassCallBack, self)
end

return V1a6_CachotProgressView

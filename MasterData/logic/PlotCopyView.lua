-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotCopyView.lua

module("logic.extensions.plotcopy.view.PlotCopyView", package.seeall)

local PlotCopyView = class("PlotCopyView", ViewComponent)

function PlotCopyView:ctor()
	self._chapterType = 0
	self._curSelectIndex = 1
	self._isPlayingAnimation = false
	self._isFirstUpdateList = true
end

function PlotCopyView:buildUI()
	self._closeButton = self:getBtn("main/btnClose")
	self._txtTitle = self:getGo("main/txtTitle"):GetComponent(goutil.Type_UIText)
	self._btnStory = self:getBtn("main/btnStory")
	self._btnStoryImgRed = self:getGo("main/btnStory/imgRed")
	self._btnStoryImgLock = self:getGo("main/btnStory/imgLock")
	self._btnBoss = self:getBtn("main/btnBoss")
	self._txtBoss = self:getGo("main/btnBoss/bossTimeTxt"):GetComponent(goutil.Type_UIText)
	self._goBoss = self:getGo("main/btnBoss/bossRedGo")
	self._bossMulti = self:getGo("main/btnBoss/multiple")
	self._txtBossMulti = goutil.findChild(self._bossMulti, "txtMulti"):GetComponent(goutil.Type_UIText)
	self._btnRes = self:getBtn("main/btnRes")
	self._tipBtnRes = self:getGo("main/btnRes/tip")
	self._btnTeachingDungeon = self:getBtn("main/btnTeachingDungeon")
	self._btnChallenge = self:getBtn("main/btnChallenge")
	self._btnChallengeLock = self:getGo("main/btnChallenge/imgLock")
	self._imgRedPlot = self:getGo("main/btnPlot/imgRed")
	self._imgRedRes = self:getGo("main/btnRes/imgRed")
	self._imgRedTeach = self:getGo("main/btnTeachingDungeon/imgRed")
	self._plotSelectGo = self:getGo("main/btnPlot/select")
	self._plotDouble = self:getGo("main/btnPlot/double")
	self._resDouble = self:getGo("main/btnRes/double")
	self._imgResLock = self:getGo("main/btnRes/imgLock")
	self._imgTeachingLock = self:getGo("main/btnTeachingDungeon/imgLock")
	self._tableview = self:getGo("main/scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("main/scrollList/item")

	self._tableCell:SetActive(false)

	self._scrollListRect = self:getGo("main/scrollList"):GetComponent(goutil.Type_RectTransform)
	self._mask = self:getGo("main/mask")
	self._txtBoss.text = ""

	self._goBoss:SetActive(false)

	self._goldBarCon = self:getGo("main/goldBarCon")
	self._doubleRewardTip = self:getGo("main/doubleRewardTip")
	self._tip = self:getGo("main/doubleRewardTip/tip")
	self._btnExplainCustomInput = UICustomInput.Get(self:getGo("main/doubleRewardTip/btnExplain"))
	self._txtTime = self:getTxt("main/doubleRewardTip/bg/txtTime")
	self._txtDesc = self:getTxt("main/doubleRewardTip/bg/txt")

	self._doubleRewardTip:SetActive(false)

	self._btnHolyStripe = self:getGo("main/btnHolyStripe")
	self._rpHolyStripe = goutil.findChild(self._btnHolyStripe, "redPoint")
	self._btnQuickPass = self:getGo("main/btnQuickPass")
end

function PlotCopyView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBoss:AddClickListener(function()
		UIStateManager.instance:push(ViewName.ShareTask)
	end, self)
	self._btnRes:AddClickListener(self._onClickBtnRes, self)
	self._btnTeachingDungeon:AddClickListener(self._onClickBtnTeachingDungeon, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnExplainCustomInput:AddListener(self._onClickExplain, self)
	self._btnStory:AddClickListener(function()
		FuncOpenController.instance:openFunc(570)
	end, self)
	GameUtil.addClickHandler(self._btnHolyStripe, self._onClickHolyStripe, self)
	GameUtil.addClickHandler(self._btnQuickPass, self._onClickQuickPass, self)
end

function PlotCopyView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnBoss:RemoveClickListener()
	self._btnRes:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnTeachingDungeon:RemoveClickListener()
	self._btnExplainCustomInput:RemoveListener()
	self._btnStory:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnHolyStripe)
	GameUtil.rmClickHandler(self._btnQuickPass)
end

function PlotCopyView:_onClickClose()
	self:close()
end

function PlotCopyView:_onClickBtnPlot()
	if self._isPlayingAnimation then
		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_PUTONG_FB)
	self:_clickBtn(GameEnum.Chapter.Plot)
end

function PlotCopyView:_onClickBtnRes()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_MAOXIAN_FB)
	FuncOpenController.instance:openFunc(106)
end

function PlotCopyView:_onClickBtnTeachingDungeon()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(68)

	if cfg then
		FuncOpenController.instance:onClickFunc(cfg)
	end
end

function PlotCopyView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CopySelectChapter, self._onSelectChapter, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyCloseMask, self._closeMask, self)
	GlobalDispatcher:addListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._MCLG_GetRewardMultiplyTimesRes, self)
	self.addGEvent(self, GlobalNotify.CopyInfoChange, self._onCopyInfoChange, self)
	self:_initImageDouble()
	self:_SetShareBossTime()

	local isOpen = FuncOpenModel.instance:getFuncIsOpen(169)

	GameUtil.SetActive(self._btnChallengeLock, not isOpen)

	local isResOpen = FuncOpenModel.instance:getFuncIsOpen(106)
	local isTeachingOpen = FuncOpenModel.instance:getFuncIsOpen(68)
	local isStoryOpen = FuncOpenModel.instance:getFuncIsOpen(570)

	self._imgResLock:SetActive(not isResOpen)
	self._imgTeachingLock:SetActive(not isTeachingOpen)
	GameUtil.SetActive(self._btnStoryImgLock, not isStoryOpen)

	if isStoryOpen then
		RedPointController.instance:regRedPoint(self._btnStoryImgRed, 242)
	end

	self:_closeMask()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish, self)

	self._curViewDatas = {}
	self._isPlayingAnimation = false
	self._isFirstLoadPlot = true
	self._isFirstUpdateList = true

	self:_setCurSelectIndex(1)

	self._curType = -1

	local chapterType = self:getFirstParam()

	self._chapterType = PlotCopyModel.instance:getBtnState()

	self:_onClickBtnPlot()
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor)
	self:_initActivityTipState()
	MaterialChallengeController.instance:sendMCLG_GetRewardMultiplyTimesReq()
	self:_initBtnResTip()

	local isCopyOpen = FuncOpenModel.instance:getFuncIsOpen(HolyStripeCopyModel.instance:getFuncOpenId())

	if isCopyOpen then
		RedPointController.instance:regRedPoint(self._rpHolyStripe, RedPointModel.ID_HOLY_STRIPE_COPY_ENTER)
	end

	goutil.setActive(self._btnHolyStripe, isCopyOpen)
end

function PlotCopyView:onExit()
	removetimer(self._CalculationSurplusTime, self)
	removetimer(self._setBossMultiDesc, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopySelectChapter, self._onSelectChapter, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyCloseMask, self._closeMask, self)
	GlobalDispatcher:removeListener(GlobalNotify.MCLG_GetRewardMultiplyTimesRes, self._MCLG_GetRewardMultiplyTimesRes, self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
	self:_resetSwitchAnimation()

	self._isFirstUpdateList = false

	self:_resetImageDouble()
	removetimer(self._updateActivityTipState, self)
	RedPointController.instance:unregRedPoint(self._btnStoryImgRed)
	RedPointController.instance:unregRedPoint(self._rpHolyStripe)
end

function PlotCopyView:_setTitleName(chapterType)
	self._txtTitle.text = "主线剧情"
end

function PlotCopyView:_clickBtn(chapterType)
	if self._curType == chapterType then
		return
	end

	self._chapterType = chapterType
	self._curType = chapterType

	PlotCopyModel.instance:setBtnState(chapterType)
	self._plotSelectGo:SetActive(chapterType == GameEnum.Chapter.Plot)

	self._isFirstLoadPlot = true

	self:_setTitleName(chapterType)

	if GuideController.instance:checkBranchIsGuiding(GuideConst.BRANCH_FIRST_OPEN_FB_36) or GuideController.instance:checkBranchIsGuiding(GuideConst.BRANCH_TASK_START_51) then
		self._isFirstUpdateList = true
	end

	if self._isFirstUpdateList then
		self._isFirstUpdateList = false

		self:_updateChapters(chapterType)
	else
		self:_playSwitchAnimation(chapterType)
	end
end

function PlotCopyView:_updateChapters(chapterType, isSwitch)
	PlotCopyModel.instance:setChapterType(chapterType)
	self:_refreshScrollList(chapterType, isSwitch)
	self:_setRedPoint()
end

function PlotCopyView:_refreshScrollList(chapterType, isSwitch)
	table.clear(self._curViewDatas)

	local chapters = CopyConfig.instance:getChapters(chapterType)

	for i, vCfg in ipairs(chapters) do
		local isUnLock = PlotCopyModel.instance:isChapterUnlock(vCfg.chapterId)
		local element = {}

		element.index = i
		element.cfg = vCfg
		element.isLock = not isUnLock
		element.isShowRedPoint = PlotCopyModel.instance:isChapterRewardCanGet(vCfg.chapterId)
		element.isSelect = i == self:_getInitChapterIndex()

		if element.isSelect then
			self:_setCurSelectIndex(i)
		end

		if isUnLock then
			self._curViewDatas[#self._curViewDatas + 1] = element
		end
	end

	self._tableview:ReloadData()
	GlobalDispatcher:dispatch(GlobalNotify.CopyUpdateMap, chapterType, self._curViewDatas, self:_getInitChapterIndex(), isSwitch)
end

function PlotCopyView:_setRedPoint()
	local isPlotRed = PlotCopyModel.instance:isHaveChapterRewardsGain(GameEnum.Chapter.Plot)
	local isResRed = MaterialChallengeController.instance:isHaveRedPointInAllChapters()

	self._imgRedPlot:SetActive(isPlotRed)
	self._imgRedRes:SetActive(isResRed)
	self._imgRedTeach:SetActive(RedPointModel.instance:isActive(RedPointModel.ID_TEACHING))
end

function PlotCopyView:_numInView()
	return #self._curViewDatas
end

function PlotCopyView:_cellSize(view, idx)
	return 382, 87.6
end

function PlotCopyView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	cell.index = index

	self:_updateCell(view, cell, data)

	return cell
end

function PlotCopyView:_updateCell(view, cell, data)
	local idx = cell.index + 1
	local component = PlotChapterItem.AddOnce(cell.gameObject)

	component:init(idx, data, self)
end

function PlotCopyView:_clearTableview(cell)
	if cell then
		local component = PlotChapterItem.AddOnce(cell.gameObject)

		component:reset()
	end
end

function PlotCopyView:_onReloadFinish()
	if self._isFirstLoadPlot then
		self._isFirstLoadPlot = nil

		local index = 1

		for i, v in ipairs(self._curViewDatas) do
			if v.isSelect then
				index = i
			end
		end

		self._tableview:MoveCellToCebter(index - 1)
	end
end

function PlotCopyView:_onSelectChapter(data)
	local isSame = false

	for i, v in ipairs(self._curViewDatas) do
		if v == data then
			v.isSelect = true

			self._tableview:UpdateCellAtIndex(i - 1)

			isSame = v.index == self:_getCurSelectIndex()

			self:_setCurSelectIndex(v.index)
		elseif v.isSelect == true then
			v.isSelect = false

			self._tableview:UpdateCellAtIndex(i - 1)
		end
	end

	if not isSame then
		self:_openMask()
	end

	GlobalDispatcher:dispatch(GlobalNotify.CopyUpdateMapSelect, self:_getCurSelectIndex(), isSame)
end

function PlotCopyView:_setCurSelectIndex(index)
	self._curSelectIndex = index
end

function PlotCopyView:_getCurSelectIndex()
	return self._curSelectIndex
end

function PlotCopyView:_getInitChapterIndex()
	return (PlotCopyModel.instance:getRecentOpenChapter(self._chapterType))
end

function PlotCopyView:_playSwitchAnimation(chapterType)
	local originPosX = self._scrollListRect.sizeDelta.x
	local endPosX = originPosX + 1000

	self._isPlayingAnimation = true

	local time1 = 0.8
	local time2 = 0.8

	self._playTween1 = self._scrollListRect:DOAnchorPosX(endPosX, time1):SetEase(DG.Tweening.Ease.InBack):OnComplete(function()
		self:_updateChapters(chapterType, true)
	end)
	self._playTween2 = self._scrollListRect:DOAnchorPosX(originPosX, time2):OnComplete(function()
		self._isPlayingAnimation = false
		self._playTween1 = nil
		self._playTween2 = nil
	end):SetDelay(time1 + 0.5):SetEase(DG.Tweening.Ease.OutBack)

	GlobalDispatcher:dispatch(GlobalNotify.CopyHideSelectItem, self:_getCurSelectIndex())
end

function PlotCopyView:_resetSwitchAnimation()
	if self._playTween1 then
		self._playTween1:Kill()
	end

	if self._playTween2 then
		self._playTween2:Kill(true)
	end
end

function PlotCopyView:_openMask()
	goutil.setActive(self._mask, true)
end

function PlotCopyView:_closeMask()
	goutil.setActive(self._mask, false)
end

function PlotCopyView:_initImageDouble()
	self:_updateImageDouble()
	settimer(3, self._updateImageDouble, self)
end

function PlotCopyView:_updateImageDouble()
	local isPlotInTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Plot, GameEnum.Chapter.Plot)
	local isResInTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Material)

	self._plotDouble:SetActive(isPlotInTime)
	self._resDouble:SetActive(isResInTime)
end

function PlotCopyView:_resetImageDouble()
	removetimer(self._updateImageDouble, self)
end

function PlotCopyView:_onClickChallenge()
	FuncOpenController.instance:openFunc(169)
end

function PlotCopyView:_SetShareBossTime()
	self:_initBossMulti()

	self._txtBoss.text = ""

	local openId = ShareTaskConfig.instance:GetFuncOpenId()

	if not FuncOpenModel.instance:getFuncIsOpen(openId) then
		self._goBoss:SetActive(false)
		self._btnBoss.gameObject:SetActive(false)

		return
	end

	local bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

	if bossInfo == nil or not bossInfo.isHaveBoss then
		self._goBoss:SetActive(false)
		self._btnBoss.gameObject:SetActive(false)

		return
	end

	if not self._btnBoss.gameObject.activeSelf then
		self._btnBoss.gameObject:SetActive(true)
	end

	self._goBoss:SetActive(ShareTaskModel.instance:GetShareBossRed())

	if bossInfo.isFleeBoss or bossInfo.isKillBoss then
		return
	end

	local allTime = ShareTaskConfig.instance:GetBossShowTime()

	self.surplusTime = math.floor(bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now()))

	if self.surplusTime <= 0 then
		return
	end

	self:ShowSurplusTime()
	settimer(1, self._CalculationSurplusTime, self, true)
end

function PlotCopyView:_CalculationSurplusTime()
	self.surplusTime = self.surplusTime - 1

	if self.surplusTime < 0 then
		removetimer(self._CalculationSurplusTime, self)

		self._txtBoss.text = ""

		self._goBoss:SetActive(ShareTaskModel.instance:GetShareBossRed())

		return
	end

	self:ShowSurplusTime()
end

function PlotCopyView:ShowSurplusTime()
	local hour = math.floor(self.surplusTime / 3600)
	local min = math.floor((self.surplusTime - hour * 3600) / 60)
	local sec = self.surplusTime - hour * 3600 - min * 60

	self._txtBoss.text = hour > 0 and string.format("怪物逃离 %s时%s分", hour, min) or string.format("怪物逃离 %s分%s秒", min, sec)
end

function PlotCopyView:_initBossMulti()
	goutil.setActive(self._bossMulti, false)

	self._txtBossMulti.text = nil

	self:_setBossMultiDesc()
	settimer(3, self._setBossMultiDesc, self)
end

function PlotCopyView:_setBossMultiDesc()
	local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.ShareTaskCount)
	local mul = 1

	if isInTime and cfg and checknumber(cfg.featureParam) > 0 then
		mul = checknumber(cfg.featureParam)
	end

	local newhandDoubleValue = NewhandwelfareController.instance:getNewhandDoubleValue()

	mul = mul + newhandDoubleValue

	goutil.setActive(self._bossMulti, mul > 1)

	self._txtBossMulti.text = mul > 1 and string.format("限时%s倍", GameUtil.getChineseNumber(checknumber(mul))) or ""
end

function PlotCopyView:_initActivityTipState()
	goutil.setActive(self._tip, false)
	self:_updateActivityTipState()
	settimer(5, self._updateActivityTipState, self)
end

function PlotCopyView:_updateActivityTipState()
	local isInTime, desc, startTime, endTime = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.Plot, GameEnum.Chapter.Plot)
	local isOpen = isInTime

	if isOpen and not self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(true)
		self._tip:SetActive(false)

		self._txtDesc.text = desc

		local startTable = GameUtil.time2date(startTime)
		local endTable = GameUtil.time2date(endTime)

		self._txtTime.text = string.format("(%02d.%02d 5:00-%02d.%02d 5:00)", startTable.month, startTable.day, endTable.month, endTable.day)
	elseif not isOpen and self._doubleRewardTip.activeSelf then
		self._doubleRewardTip:SetActive(false)
		self._tip:SetActive(false)
	end
end

function PlotCopyView:_onClickExplain(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function PlotCopyView:_MCLG_GetRewardMultiplyTimesRes(msg)
	self:_updateImageDouble()
end

function PlotCopyView:_initBtnResTip()
	local startTime = "2022-07-29 05:00:00"
	local endTime = "2022-08-05 05:00:00"

	goutil.setActive(self._tipBtnRes, GameUtil.checkIsInTimePeriod(startTime, endTime))
end

function PlotCopyView:_onClickHolyStripe()
	SurveyController.instance:reportBehavior(201042)
	UIStateManager.instance:push(ViewName.HolyStripeCopyView)
end

function PlotCopyView:_onClickQuickPass()
	local chapterId, stageId = PlotCopyController.instance:getMaxQuickPassStageInfo(self._chapterType)

	if chapterId ~= 0 and stageId ~= 0 then
		local isPass = PlotCopyModel.instance:isStagePassed(chapterId, stageId)

		if isPass == false then
			local cfg = CopyConfig.instance:getStageById(chapterId, stageId)
			local str = langPara("您的实力非常强大\n眼前这些弱小的存在简直不堪一击！\n\n您将直接提升至<color=#EB4642FF>%s</color>", cfg.stageName)

			TipsFacade.instance:openPopupWindow(lang("提示"), str, function()
				PlotChallengeAgent.instance:sendZdlSecKillReq(chapterId, stageId)
			end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
		else
			FloatWordMgr.instance:show(lang("当前已无可秒杀关卡"))
		end
	else
		FloatWordMgr.instance:show(lang("当前已无可秒杀关卡"))
	end
end

function PlotCopyView:_onCopyInfoChange()
	self:_updateChapters(self._chapterType, true)
end

return PlotCopyView

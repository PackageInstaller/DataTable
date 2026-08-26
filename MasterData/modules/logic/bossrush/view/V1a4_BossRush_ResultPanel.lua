-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ResultPanel.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanel", package.seeall)

local V1a4_BossRush_ResultPanel = class("V1a4_BossRush_ResultPanel", BaseView)

function V1a4_BossRush_ResultPanel:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._goDouble = gohelper.findChild(self.viewGO, "Root/Right/#go_Double")
	self._goask = gohelper.findChild(self.viewGO, "Root/Right/#go_Double/#go_ask")
	self._txtDouble = gohelper.findChildText(self.viewGO, "Root/Right/#go_Double/#go_ask/#txt_Double")
	self._btnOK = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#go_Double/#go_ask/#btn_OK")
	self._goconfirm = gohelper.findChild(self.viewGO, "Root/Right/#go_Double/#go_confirm")
	self._btnScore = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/Total/txt_Total/#btn_Score")
	self._goDetailsRootXY = gohelper.findChild(self.viewGO, "Root/Right/Total/txt_Total/#btn_Score/#go_DetailsRootXY")
	self._txtTotalScore = gohelper.findChildText(self.viewGO, "Root/Right/Total/#txt_TotalScore")
	self._goSlider = gohelper.findChild(self.viewGO, "Root/Right/Slider/#go_Slider")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress")
	self._goprefabInst = gohelper.findChild(self.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	self._imageSliderBG = gohelper.findChildImage(self.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	self._imageSliderFG1 = gohelper.findChildImage(self.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	self._imageSliderFG2 = gohelper.findChildImage(self.viewGO, "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	self._goAssessScore = gohelper.findChild(self.viewGO, "Root/#go_AssessScore")
	self._goDetailsRoot = gohelper.findChild(self.viewGO, "Root/#go_DetailsRoot")
	self._btnempty = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#go_DetailsRoot/#btn_empty")
	self._godetails = gohelper.findChild(self.viewGO, "Root/#go_DetailsRoot/#go_details")
	self._scrollscore = gohelper.findChildScrollRect(self.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score")
	self._goscore = gohelper.findChild(self.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score/Viewport/Content/#go_score")
	self._txtscore = gohelper.findChildText(self.viewGO, "Root/#go_DetailsRoot/#go_details/#scroll_score/Viewport/Content/#go_score/#txt_score")
	self._txttotal = gohelper.findChildText(self.viewGO, "Root/#go_DetailsRoot/#go_details/#txt_total")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_ResultPanel:addEvents()
	self._btnOK:AddClickListener(self._btnOKOnClick, self)
	self._btnScore:AddClickListener(self._btnScoreOnClick, self)
	self._btnempty:AddClickListener(self._btnemptyOnClick, self)
end

function V1a4_BossRush_ResultPanel:removeEvents()
	self._btnOK:RemoveClickListener()
	self._btnScore:RemoveClickListener()
	self._btnempty:RemoveClickListener()
end

local sf = string.format
local eAnimEvt = BossRushEnum.AnimEvtResultPanel
local kTweenSecond = 1.5

function V1a4_BossRush_ResultPanel:onClickModalMask()
	self:closeThis()
end

function V1a4_BossRush_ResultPanel:_btnOKOnClick()
	AudioMgr.instance:trigger(AudioEnum.ui_role.play_ui_role_cover_open_1)

	local bossId = self._curStage

	BossRushRpc.instance:sendAct128DoublePointRequest(bossId)
end

function V1a4_BossRush_ResultPanel:_btnScoreOnClick()
	self:_setActiveDetail(true)
end

function V1a4_BossRush_ResultPanel:_btnemptyOnClick()
	self:_setActiveDetail(false)
end

function V1a4_BossRush_ResultPanel:_editableInitView()
	FightController.instance:checkFightQuitTipViewClose()

	self._goDetailsRootTran = self._goDetailsRoot.transform
	self._goDetailsRootXYTran = self._goDetailsRootXY.transform
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._completeAnimEvent = gohelper.findChild(self.viewGO, "Root/Complete"):GetComponent(gohelper.Type_AnimationEventWrap)

	self:_initAssessScore()

	self._imageSliderFG1Tran = self._imageSliderFG1:GetComponent(gohelper.Type_RectTransform)
	self._imageSliderFG2Tran = self._imageSliderFG2:GetComponent(gohelper.Type_RectTransform)
	self._imageSliderBGTran = self._imageSliderBG:GetComponent(gohelper.Type_RectTransform)

	self._simagePanelBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_resultpanelbg"))

	self._txtDouble.text = ""
	self._txtTotalScore.text = ""

	recthelper.setWidth(self._imageSliderFG1Tran, 0)
	recthelper.setWidth(self._imageSliderFG2Tran, 0)
	gohelper.setActive(self._goconfirm, false)
	gohelper.setActive(self._goprefabInst, false)
	self:_setActiveDetail(false)

	self._viewportWidth = recthelper.getWidth(self._scrollprogress.transform)
	self._goprefabInstX = recthelper.getAnchorX(self._goprefabInst.transform)

	self._animEvent:AddEventListener(eAnimEvt.onOpenEnd, self._onOpenEnd, self)
	self._completeAnimEvent:AddEventListener(eAnimEvt.onCompleteOpenStart, self._onCompleteOpenStart, self)
	gohelper.setActive(self._btnScore, false)

	self._scrollprogressContentTran = self._scrollprogress.content
end

function V1a4_BossRush_ResultPanel:_initAssessScore()
	local itemClass = V1a4_BossRush_Assess_Score
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_result_assess, self._goAssessScore, itemClass.__cname)

	self._assessScore = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessScore:setActiveDesc(false)
	self._assessIcon:initData(self, false)
end

function V1a4_BossRush_ResultPanel:onUpdateParam()
	return
end

function V1a4_BossRush_ResultPanel:onOpen()
	self._curStage, self._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	local stage = self._curStage
	local isInfinite = BossRushController.instance:isInBossRushInfiniteFight(true)
	local fightScore = BossRushModel.instance:getFightScore()
	local doubleTimesInfo = BossRushModel.instance:getDoubleTimesInfo(stage)
	local isShowDouble = fightScore > 0 and isInfinite and doubleTimesInfo.cur > 0
	local stagePointInfo = BossRushModel.instance:getStagePointInfo(stage)

	gohelper.setActive(self._goDouble, isShowDouble)
	self._assessScore:setData(stage, fightScore)
	self._assessScore:setActiveNewRecord(BossRushModel.instance:checkIsNewHighestPointRecord(stage))

	local special = BossRushModel.instance:isSpecialLayer(self._curLayer)

	if special then
		if not BossRushEnum.AssessType.Layer4 then
			local type = BossRushEnum.AssessType.Normal
			local _, level = BossRushConfig.instance:getAssessSpriteName(stage, fightScore, type)

			if level > 0 then
				self._anim:Play(BossRushEnum.AnimResultPanel.InNotEmpty)
			else
				self._anim:Play(BossRushEnum.AnimResultPanel.InEmpty)
			end

			self._maxValue = stagePointInfo.max
			self._lastValue = stagePointInfo.cur
			self._firstValue = math.min(stagePointInfo.max, stagePointInfo.cur + fightScore)

			self:_refreshDoubleInfo()
			self:_refreshDetailScore()
			self:_refreshProgressBar(stagePointInfo.cur)
			self:_refreshTxtTotalScore(stagePointInfo.cur, stagePointInfo.max)
			BossRushController.instance:registerCallback(BossRushEvent.OnReceiveAct128DoublePointRequestReply, self._onReceiveAct128DoublePointRequestReply, self)
		end
	end
end

function V1a4_BossRush_ResultPanel:onOpenFinish()
	self:_updateContentPosX()
end

function V1a4_BossRush_ResultPanel:onClose()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnReceiveAct128DoublePointRequestReply, self._onReceiveAct128DoublePointRequestReply, self)
	ViewMgr.instance:openView(ViewName.V1a4_BossRush_ResultView, self.viewParam)
end

function V1a4_BossRush_ResultPanel:onDestroyView()
	self:_setActiveDetail(false)
	self:_deleteTweens()
	self._animEvent:RemoveEventListener(eAnimEvt.onOpenEnd)
	self._completeAnimEvent:RemoveEventListener(eAnimEvt.onCompleteOpenStart)
	self._simagePanelBG:UnLoadImage()
end

function V1a4_BossRush_ResultPanel:_refreshTxtTotalScore(cur, max)
	self._txtTotalScore.text = sf("<color=#FF8640>%s</color>/%s", cur or 0, max or 0)
end

function V1a4_BossRush_ResultPanel:_refresh()
	self:_progressBarTween(self._firstValue)
end

function V1a4_BossRush_ResultPanel:_refreshDoubleInfo()
	local stage = self._curStage
	local info = BossRushModel.instance:getDoubleTimesInfo(stage)
	local tag = {
		info.cur,
		info.max
	}

	self._txtDouble.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrush_resultpanel_txt_double"), tag)
end

function V1a4_BossRush_ResultPanel:_refreshProgressBar(firstValue, secondValue)
	local listScrollParam = self.viewContainer:getListScrollParam()
	local stage = self._curStage
	local maxValue = self._maxValue
	local firstStep = self._goprefabInstX
	local firstWidth, maxWidth = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(stage, firstValue, listScrollParam, firstStep, 0, 0)

	recthelper.setWidth(self._imageSliderBGTran, maxWidth)
	recthelper.setWidth(self._imageSliderFG1Tran, firstWidth)

	if secondValue then
		recthelper.setWidth(self._imageSliderFG2Tran, math.max(0, BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(stage, secondValue, listScrollParam, firstStep, 0, 0) - firstWidth))
	end

	self:_refreshProgressBarPoints(secondValue or firstValue)
	self:_refreshTxtTotalScore(secondValue or firstValue, maxValue)
end

function V1a4_BossRush_ResultPanel:_calcProgressBarWidth(firstValue, secondValue)
	local listScrollParam = self.viewContainer:getListScrollParam()
	local stage = self._curStage
	local firstStep = self._goprefabInstX
	local firstWidth, maxWidth = BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(stage, firstValue, listScrollParam, firstStep, 0, 0)

	return firstWidth, (secondValue or nil) and BossRushConfig.instance:calcStageRewardProgWidthByListScrollParam(stage, secondValue, listScrollParam, firstStep, 0, 0), maxWidth
end

function V1a4_BossRush_ResultPanel:_deleteTweens()
	GameUtil.onDestroyViewMember_TweenId(self, "_progressBar1TweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_progressBar2TweenId")
	GameUtil.onDestroyViewMember_TweenId(self, "_txtTotalScoreTweenId")
end

function V1a4_BossRush_ResultPanel:_progressBarTween(firstValue, secondValue)
	local maxTo = self._maxValue

	self:_deleteTweens()

	local firstWidth, secondWidth, maxWidth = self:_calcProgressBarWidth(firstValue, secondValue)
	local progressBar2To = math.max(0, secondWidth - firstWidth)
	local from, to

	recthelper.setWidth(self._imageSliderBGTran, maxWidth)

	from = recthelper.getWidth(self._imageSliderFG1Tran)
	to = firstWidth

	if math.abs(from - firstWidth) > 0.1 and from < maxTo then
		self._progressBar1TweenId = ZProj.TweenHelper.DOTweenFloat(from, to, kTweenSecond, self._progressBar1TweenUpdateCb, self._progressBar1TweenEndCb, self, nil, EaseType.OutQuad)

		AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_progress_loop)
	end

	if secondValue then
		from = recthelper.getWidth(self._imageSliderFG2Tran)
		to = progressBar2To

		if math.abs(from - progressBar2To) > 0.1 and from < maxTo then
			self._progressBar2TweenId = ZProj.TweenHelper.DOTweenFloat(from, to, kTweenSecond, self._progressBar2TweenUpdateCb, self._progressBar2TweenEndCb, self, nil, EaseType.OutQuad)

			AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_progress_loop)
		end
	end

	if not secondValue then
		from = self._lastValue
		to = firstValue
	else
		from = firstValue
		to = secondValue
	end

	self._txtTotalScoreTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, kTweenSecond, self._txtTotalScoreTweenUpdateCb, nil, self, nil, EaseType.OutQuad)

	self:_refreshProgressBarPoints(secondValue or firstValue)
end

function V1a4_BossRush_ResultPanel:_updateContentPosX()
	local offset = self._viewportWidth * 0.5
	local firstWidth = recthelper.getWidth(self._imageSliderFG1Tran)
	local secondWidth = recthelper.getWidth(self._imageSliderFG2Tran)
	local maxWidth = recthelper.getWidth(self._scrollprogressContentTran)
	local maxPosX = math.max(0, maxWidth - self._viewportWidth)
	local progPosX = firstWidth + secondWidth
	local newPosX = -math.min(maxPosX, progPosX < offset and 0 or progPosX - offset)
	local nowPoxX = recthelper.getAnchorX(self._scrollprogressContentTran)

	if math.abs(newPosX - nowPoxX) < 0.1 then
		return
	end

	recthelper.setAnchorX(self._scrollprogressContentTran, newPosX)
end

function V1a4_BossRush_ResultPanel:_progressBar1TweenUpdateCb(value)
	recthelper.setWidth(self._imageSliderFG1Tran, value)
	self:_updateContentPosX()
end

function V1a4_BossRush_ResultPanel:_progressBar1TweenEndCb()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
end

function V1a4_BossRush_ResultPanel:_progressBar2TweenUpdateCb(value)
	recthelper.setWidth(self._imageSliderFG2Tran, value)
	self:_updateContentPosX()
end

function V1a4_BossRush_ResultPanel:_progressBar2TweenEndCb()
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.stop_ui_qiutu_progress_loop)
end

function V1a4_BossRush_ResultPanel:_txtTotalScoreTweenUpdateCb(value)
	value = math.modf(value)

	self:_refreshTxtTotalScore(value, self._maxValue)
end

function V1a4_BossRush_ResultPanel:_refreshProgressBarPoints(curPoint)
	local stage = self._curStage
	local dataList = BossRushModel.instance:getResultPanelProgressBarPointList(stage, curPoint)

	V1a4_BossRush_ResultPanelListModel.instance:setList(dataList)
end

function V1a4_BossRush_ResultPanel:_onReceiveAct128DoublePointRequestReply(totalPoint)
	gohelper.setActive(self._goconfirm, true)
	gohelper.setActive(self._goask, false)
	self:_progressBarTween(self._firstValue, totalPoint)
end

function V1a4_BossRush_ResultPanel:_refreshDetailScore()
	self._txttotal.text = formatLuaLang("v1a4_bossrush_resultpanel_txt_total", BossRushModel.instance:getFightScore())

	local stageScore = BossRushModel.instance:getStageScore(self._curStage, self._curLayer)
	local stageCount = #stageScore

	self._itemsetailScore = self._itemsetailScore or self:getUserDataTb_()

	for i, v in ipairs(stageScore) do
		if i > #self._itemsetailScore then
			self._itemsetailScore[i] = gohelper.cloneInPlace(self._goscore)
		end

		local txt = gohelper.findChildText(self._itemsetailScore[i], "#txt_score")
		local desc = luaLang("p_v1a4_bossrush_resultpanel_txt_bosslosehp")

		txt.text = string.format(desc, i, v)
	end

	for i, v in ipairs(self._itemsetailScore) do
		gohelper.setActive(v, i <= stageCount)
	end
end

function V1a4_BossRush_ResultPanel:_onCompleteOpenStart()
	AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_win)
end

function V1a4_BossRush_ResultPanel:_onOpenEnd()
	self:_refresh()
end

function V1a4_BossRush_ResultPanel:_setActiveDetail(isActive)
	if isActive then
		local x, y = recthelper.getAnchor(self._goDetailsRootXYTran)

		recthelper.setAnchor(self._goDetailsRootTran, x, y)
	end

	gohelper.setActive(self._goDetailsRoot, isActive)
end

return V1a4_BossRush_ResultPanel

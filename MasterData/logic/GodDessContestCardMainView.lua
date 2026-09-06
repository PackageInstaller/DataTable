-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardMainView.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardMainView", package.seeall)

local GodDessContestCardMainView = class("GodDessContestCardMainView", ViewComponent)

function GodDessContestCardMainView:ctor()
	GodDessContestCardMainView.super.ctor(self)
end

function GodDessContestCardMainView:buildUI()
	GodDessContestCardMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnBag = goutil.findChild(self.mainGO, "btnBag")
	self._tips_txt = goutil.findChildTextComponent(self.mainGO, "tips/txt")

	local cardScrView = goutil.findChild(self.mainGO, "cardCol/cardScrView")
	local cardScrCell = goutil.findChild(self.mainGO, "cardCol/cardScrCell")

	self._cardScrollList = ScrollerList.create(cardScrView, cardScrCell, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._progressBar = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/prizeScrollerview/Viewport/Content/progressBar")
	self._prizeCol_total = goutil.findChild(self.mainGO, "prizeCol/total")
	self._prizeCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "prizeCol/total/txtNum")
	self._prizeCol_total_icon = goutil.findChild(self.mainGO, "prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function GodDessContestCardMainView:bindEvents()
	GodDessContestCardMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBtnBag, self)
end

function GodDessContestCardMainView:unbindEvents()
	GodDessContestCardMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBag)
end

function GodDessContestCardMainView:destroyUI()
	GodDessContestCardMainView.super.destroyUI(self)
end

function GodDessContestCardMainView:onEnter()
	GodDessContestCardMainView.super.onEnter(self)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_GoddessContestCardDayOnceRed)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = GoddessContestController.instance:getActivityId()
	end

	self._activityType = GoddessContestController.instance:getActivityType()

	local isInTime = GoddessContestController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actStepType = GdcCardEnum.ActStepType_Collect
	self._curStepId = GoddessContestController.instance:getCurStepIdInCardStep(self._actStepType, self._activityId)
	self._cardBagMgr = GoddessContestModel.instance:getGdcCardBagMgr(self._activityId)
	self._isNeedNotifyStepChange = false
	self._notifyChangeTickTime = 0

	self.addGEvent(self, GlobalNotify.GoddessContestGetInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestGetCardInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestFlopRes, self._onUpdate, self)
	self:_onTicking()
	settimer(2, self._onTicking, self)
	self:_checkSendInfoReq()
end

function GodDessContestCardMainView:onExit()
	GodDessContestCardMainView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClear()
end

function GodDessContestCardMainView:_onTicking()
	local curStepId = GoddessContestController.instance:getCurStepIdInCardStep(self._actStepType, self._activityId)

	if self._curStepId ~= curStepId then
		self._curStepId = curStepId
		self._isNeedNotifyStepChange = true
	end

	if self._isNeedNotifyStepChange then
		self._notifyChangeTickTime = self._notifyChangeTickTime + 1

		if self._notifyChangeTickTime >= GdcCardEnum.DelayNotifyStepChangeTime then
			self._isNeedNotifyStepChange = false
			self._notifyChangeTickTime = 0

			GlobalDispatcher:dispatch(GlobalNotify.GoddessContestCardStepChange)
			self:_checkSendInfoReq()
		end
	end
end

function GodDessContestCardMainView:_checkSendInfoReq()
	local actStepType = GoddessContestController.instance:getCardActStepType(self._activityId)

	if actStepType ~= self._actStepType then
		local text = string.format("不在塔罗牌收集阶段内")

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	GoddessContestController.instance:sendPM_GoddessContestGetCardInfoReq(self._activityId)
end

function GodDessContestCardMainView:_onUpdate()
	do
		local fields = GdcCardEnum.ActStepTimeFields[self._actStepType]
		local stepData = GoddessContestConfig.instance:getCardStepData(self._activityId, self._curStepId)

		if fields and stepData then
			local startStamp, endStamp = GameUtil.string2time(stepData[fields[1]]), GameUtil.string2time(stepData[fields[2]])

			self._txtOpenTime.text = string.format("第%s轮塔罗牌收集时间：%s", self._curStepId, GameUtil.getFormatTimeByStamp(startStamp, endStamp))
		else
			self._txtOpenTime.text = string.format("第%s轮塔罗牌收集时间", self._curStepId)
		end
	end

	do
		local stepData = GoddessContestConfig.instance:getCardStepData(self._activityId, self._curStepId)

		if stepData then
			local fields = GdcCardEnum.ActStepTimeFields[GdcCardEnum.ActStepType_Contest]
			local startStamp = GameUtil.string2time(stepData[fields[1]])

			self._tips_txt.text = string.format("本周塔罗牌收集（用于%s的塔罗牌比拼）", GameUtil.getFormatTimeByStamp(startStamp, nil))
		else
			self._tips_txt.text = ""
		end
	end

	self:_onUpdateCardColUI()
	self:_onUpdatePrizeCol()
end

function GodDessContestCardMainView:_onClear()
	self:_onClearCardCol()
	self:_onClearPrizeCol()
end

function GodDessContestCardMainView:_onUpdateCardColUI()
	local cfg = GoddessContestConfig.instance:getCardCfg(self._activityId, self._curStepId)

	self._cardScrollList:reloadData(cfg or {})
end

function GodDessContestCardMainView:_onClearCardCol()
	self._cardScrollList:dispose()
end

function GodDessContestCardMainView:_updateCardCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local stepId = self._curStepId
	local cardId = data.cardId
	local cardMo = self._cardBagMgr:getCardMo(stepId, cardId)

	if cardMo == nil then
		printError(string.format("空卡( activityId = %s | stepId = %s | cardId = %s )", self._activityId, stepId, cardId))

		cardMo = self._cardBagMgr:getEmptyCardMo()
	end

	local cardType = cardMo:getCardType()
	local isWith = cardMo:isWith()
	local value = cardMo:getValue()
	local isShowValue = cardMo:isShowValue()
	local imgNum = goutil.findChild(mainGo, "imgNum")
	local imgRandom = goutil.findChild(mainGo, "imgRandom")
	local notGetTag = goutil.findChild(mainGo, "notGetTag")
	local txtTips = goutil.findChildTextComponent(mainGo, "txtTips")

	if value > 9 then
		printError("错误，前端预制暂不支持值大于9的塔罗牌")
	end

	if cardType == GdcCardEnum.CardType_Normal then
		GameUtil.setUIImageSpriteIdx(imgNum, value)
		GameUtil.SetActive(imgNum, true)
		GameUtil.SetActive(imgRandom, false)
		GameUtil.SetActive(txtTips.gameObject, false)
	else
		GameUtil.SetActive(imgNum, false)
		GameUtil.SetActive(imgRandom, true)
		GameUtil.SetActive(txtTips.gameObject, true)
	end

	GameUtil.SetActive(notGetTag, not isWith)

	if not data.randomRange then
		txtTips.text = string.format("比拼阶段副团长翻牌从%s-%s随机1个整数", checknumber(data.randomRange[1]), checknumber(data.randomRange[2]))
	end
end

function GodDessContestCardMainView:_clearCardCell(cell)
	return
end

function GodDessContestCardMainView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		local prizeId = self:_getPrizeIdByData(data)

		if self:_isHasGainPrize(prizeId) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function GodDessContestCardMainView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function GodDessContestCardMainView:_getProgressDataList()
	return GoddessContestConfig.instance:getCardCfg(self._activityId, self._curStepId) or {}
end

function GodDessContestCardMainView:_getSliderComp()
	return self._sliderComp
end

function GodDessContestCardMainView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function GodDessContestCardMainView:_getCurProgress()
	return GoddessContestModel.instance:getStepAddVote(self._activityId, self._curStepId)
end

function GodDessContestCardMainView:_getProgressByData(data)
	return data.needVoteNum
end

function GodDessContestCardMainView:_getPrizeIdByData(data)
	return data.cardId
end

function GodDessContestCardMainView:_getPrizeStrByData(data)
	return nil
end

function GodDessContestCardMainView:_isHasGainPrize(prizeId)
	local data = GoddessContestConfig.instance:getCardData(self._activityId, self._curStepId, prizeId)

	return self:_getCurProgress() >= self:_getProgressByData(data)
end

function GodDessContestCardMainView:_isCanGetPrize(prizeId)
	return false
end

function GodDessContestCardMainView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(prizeId)
	local isCanGet = self:_isCanGetPrize(prizeId)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local img = goutil.findChild(mainGo, "img")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetGray(img, not isHasGain)
end

function GodDessContestCardMainView:_clearPrizeCell(cell)
	return
end

function GodDessContestCardMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("goddesscontestcardmainview_rule")
end

function GodDessContestCardMainView:_onClickBtnBag()
	UIStateManager.instance:push(ViewName.GodDessContestCardBagView, self._activityId)
end

return GodDessContestCardMainView

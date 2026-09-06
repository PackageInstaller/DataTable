-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardBagView.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardBagView", package.seeall)

local GodDessContestCardBagView = class("GodDessContestCardBagView", ViewComponent)

function GodDessContestCardBagView:ctor()
	GodDessContestCardBagView.super.ctor(self)
end

function GodDessContestCardBagView:buildUI()
	GodDessContestCardBagView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._tips_txt = goutil.findChildTextComponent(self.mainGO, "tips/txt")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local cardScrView = goutil.findChild(self.mainGO, "cardCol/cardScrView")
	local cardScrCell = goutil.findChild(self.mainGO, "cardCol/cardScrCell")

	self._cardScrollList = ScrollerList.create(cardScrView, cardScrCell, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))
end

function GodDessContestCardBagView:bindEvents()
	GodDessContestCardBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GodDessContestCardBagView:unbindEvents()
	GodDessContestCardBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodDessContestCardBagView:destroyUI()
	GodDessContestCardBagView.super.destroyUI(self)
end

function GodDessContestCardBagView:onEnter()
	GodDessContestCardBagView.super.onEnter(self)
	GoddessContestController:getActivityId()

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
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

	self._actStepType = GoddessContestController.instance:getCardActStepType(self._activityId)
	self._curStepId = GoddessContestController.instance:getCurStepIdInCardStep(self._actStepType, self._activityId)
	self._cardBagMgr = GoddessContestModel.instance:getGdcCardBagMgr(self._activityId)
	self._curTabIdx = self._curStepId

	self.addGEvent(self, GlobalNotify.GoddessContestGetInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.GoddessContestCardStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestGetCardInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestFlopRes, self._onUpdate, self)
	self:_onUpdate()
end

function GodDessContestCardBagView:onExit()
	GodDessContestCardBagView.super.onExit(self)
	self:_onClear()
end

function GodDessContestCardBagView:_onUpdate()
	self._tabDataList = GoddessContestConfig.instance:getCardStepCfg(self._activityId) or {}
	self._curTabIdx = Mathf.Clamp(self._curTabIdx, 0, #self._tabDataList)

	local tabData = self._tabDataList[self._curTabIdx]

	if tabData then
		self._curStepId = tabData.stepId or 0
	end

	local stepData = GoddessContestConfig.instance:getCardStepData(self._activityId, self._curStepId)

	if stepData then
		local fields = GdcCardEnum.ActStepTimeFields[GdcCardEnum.ActStepType_Contest]
		local startStamp = GameUtil.string2time(stepData[fields[1]])
		local endStamp = GameUtil.string2time(stepData[fields[2]])

		self._tips_txt.text = string.format("下列塔罗牌仅用于%s的塔罗牌比赛", GameUtil.getFormatTimeByStamp(startStamp, endStamp))
	else
		self._tips_txt.text = ""
	end

	self:_updateTabColUI()
	self:_onUpdateCardColUI()
end

function GodDessContestCardBagView:_onClear()
	self:_clearTabColUI()
	self:_onClearCardCol()
end

function GodDessContestCardBagView:_onUpdateCardColUI()
	local cfg = GoddessContestConfig.instance:getCardCfg(self._activityId, self._curStepId)

	self._cardScrollList:reloadData(cfg or {})
end

function GodDessContestCardBagView:_onClearCardCol()
	self._cardScrollList:dispose()
end

function GodDessContestCardBagView:_updateCardCell(view, cell, data, tag)
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
	local result, tips = GoddessContestController.instance:getTryFlopCardResultAndTips(self._activityId, stepId)
	local imgNum = goutil.findChild(mainGo, "imgNum")
	local imgRandom = goutil.findChild(mainGo, "imgRandom")
	local notGetTag = goutil.findChild(mainGo, "notGetTag")
	local btnTurn = goutil.findChild(mainGo, "btnTurn")
	local txtTips = goutil.findChildTextComponent(mainGo, "txtTips")

	if value > 9 then
		printError("错误，前端预制暂不支持值大于9的塔罗牌")
	end

	if cardType == GdcCardEnum.CardType_Normal or isShowValue then
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

		GameUtil.SetActive(btnTurn, result == GameEnum.ResultCode.Success and not isShowValue and isWith)
		GameUtil.addClickHandler(btnTurn, GameUtil.handler(self._onClickCardCellBtnTurn, self, stepId, cardId))
	end
end

function GodDessContestCardBagView:_clearCardCell(cell)
	local mainGo = cell.gameObject
	local btnTurn = goutil.findChild(mainGo, "btnTurn")

	GameUtil.rmClickHandler(btnTurn)
end

function GodDessContestCardBagView:_onClickCardCellBtnTurn(stepId, cardId)
	local result, tips = GoddessContestController.instance:getTryFlopCardResultAndTips(self._activityId, stepId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	GoddessContestController.instance:sendPM_GoddessContestFlopReq(self._activityId, stepId, cardId)
end

function GodDessContestCardBagView:_updateTabColUI()
	self._tabScrollList:reloadData(self._tabDataList)
end

function GodDessContestCardBagView:_clearTabColUI()
	self._tabScrollList:dispose()
end

function GodDessContestCardBagView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local UIChangeGroup = mainGo:GetComponent(typeof(UIChangeGroup))

	txtName.text = string.format("第%s周", tabIdx)

	UIChangeGroup:SetState(self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function GodDessContestCardBagView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GodDessContestCardBagView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdate()
end

return GodDessContestCardBagView

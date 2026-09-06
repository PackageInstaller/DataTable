-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/view/SettlementRecommend.lua

module("logic.extensions.battlesettlement.view.SettlementRecommend", package.seeall)

local SettlementRecommend = class("SettlementRecommend", BSAnimPlay)

function SettlementRecommend:buildUI(parent)
	SettlementRecommend.super.buildUI(self, parent)

	self._imgBgTarget = goutil.findChild(parent, "imgBgTarget"):GetComponent(goutil.Type_RectTransform)
	self._tran = goutil.findChild(parent, "tran"):GetComponent(goutil.Type_RectTransform)
	self._btnTask = Framework.ButtonAdapter.GetFrom(parent, "tran/btnTask")
	self._btnPetUp = Framework.ButtonAdapter.GetFrom(parent, "tran/btnPetUp")
	self._btnEquip = Framework.ButtonAdapter.GetFrom(parent, "tran/btnEquip")
	self._btnFmtRecommend = Framework.ButtonAdapter.GetFrom(parent, "tran/btnFmtRecommend")
	self._txtDesc = {}
	self._elementTran = {}

	for i = 1, 3 do
		self._txtDesc[i] = goutil.findChild(parent, string.format("element%d/txtDesc", i)):GetComponent(goutil.Type_UIText)
		self._elementTran[i] = goutil.findChild(parent, "element" .. i):GetComponent(goutil.Type_RectTransform)
	end
end

function SettlementRecommend:bindEvents()
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnPetUp:AddClickListener(self._onClickPetUp, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
	self._btnFmtRecommend:AddClickListener(self._onClickFmtRecommend, self)
end

function SettlementRecommend:unbindEvents()
	self._btnTask:RemoveClickListener()
	self._btnPetUp:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
	self._btnFmtRecommend:RemoveClickListener()
end

function SettlementRecommend:onEnter(totalHeight, curPosY, delayTime, onClickClose)
	SettlementRecommend.super.onEnter(self, totalHeight, curPosY, delayTime)

	if self._isEntered then
		return self:_getDefault()
	end

	self._isEntered = true

	goutil.setActive(self._parent, true)

	self._onClickClose = onClickClose

	local isTaskOpen = FuncOpenModel.instance:getFuncIsOpen(5)
	local isPetUpOpen = FuncOpenModel.instance:getFuncIsOpen(9)
	local isEquipOpen = FuncOpenModel.instance:getFuncIsOpen(50)
	local isFmtRecOpen = FuncOpenModel.instance:getFuncIsOpen(33)

	self._btnTask.gameObject:SetActive(false)
	self._btnPetUp.gameObject:SetActive(isPetUpOpen)
	self._btnEquip.gameObject:SetActive(isEquipOpen)
	self._btnFmtRecommend.gameObject:SetActive(isFmtRecOpen)

	for i = 1, 3 do
		self._txtDesc[i].text = lang(string.format("settlement_tip%d", i))
	end

	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.DragonAwaken then
		goutil.setActive(self._parent, false)
	end

	return self:getNextData()
end

function SettlementRecommend:onExit()
	self._isEntered = false

	self:doKillTween()

	self._onClickClose = nil

	goutil.setActive(self._parent, false)
end

function SettlementRecommend:_setHeight()
	self.height = self._parentRectTrans.rect.height

	Framework.TransformUtil.SetAnchoredPos(self._parentRectTrans, 0, self:_getCurPosY())
end

function SettlementRecommend:getMaxHeight()
	return self._parentRectTrans.rect.height
end

function SettlementRecommend:_setAnimCostTime()
	self.animCostTime = self._delayTime1 * 5
end

function SettlementRecommend:doTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 1500, 0)
	Framework.TransformUtil.SetAnchoredPos(self._elementTran[1], 1500, self._elementTran[1].anchoredPosition.y)
	Framework.TransformUtil.SetAnchoredPos(self._elementTran[2], 1500, self._elementTran[2].anchoredPosition.y)
	Framework.TransformUtil.SetAnchoredPos(self._elementTran[3], 1500, self._elementTran[3].anchoredPosition.y)
	Framework.TransformUtil.SetAnchoredPos(self._tran, 1500, self._tran.anchoredPosition.y)

	local curTime = self._time1
	local curDelay = self._delayTime1 + self:_getCurTimePoint()

	self._imgBgTarget:DOAnchorPosX(0, curTime):SetDelay(curDelay)

	curDelay = curDelay + self._delayTime1

	for i = 1, 3 do
		self._elementTran[i]:DOAnchorPosX(0, curTime):SetDelay(curDelay)

		curDelay = curDelay + self._delayTime1
	end

	self._tran:DOAnchorPosX(0, curTime):SetDelay(curDelay)
end

function SettlementRecommend:doKillTween()
	SettlementRecommend.super.doKillTween(self)
	self._imgBgTarget:DOKill(true)
	self._tran:DOKill(true)

	for i = 1, 3 do
		self._elementTran[i]:DOKill(true)
	end
end

function SettlementRecommend:doCompleteTween()
	self:doKillTween()
	Framework.TransformUtil.SetAnchoredPos(self._imgBgTarget, 0, 0)
	Framework.TransformUtil.SetAnchoredPos(self._elementTran[1], 0, self._elementTran[1].anchoredPosition.y)
	Framework.TransformUtil.SetAnchoredPos(self._elementTran[2], 0, self._elementTran[2].anchoredPosition.y)
	Framework.TransformUtil.SetAnchoredPos(self._elementTran[3], 0, self._elementTran[3].anchoredPosition.y)
	Framework.TransformUtil.SetAnchoredPos(self._tran, 0, self._tran.anchoredPosition.y)
end

function SettlementRecommend:_onClickTask()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGot0DailyTaskPanel)
	UIJumper.instance:pushClearCurStack(ViewName.diamondtask, true, GameEnum.TaskViewTab.Daily)
	self._onClickClose()
end

function SettlementRecommend:_onClickPetUp()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGotoAwaken)
	UIJumper.instance:pushClearCurStack(ViewName.PetShowView, true, 1)
	self._onClickClose()
end

function SettlementRecommend:_onClickEquip()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickGotoEquip)
	UIJumper.instance:pushClearCurStack(ViewName.PetShowView, true, 4)
	self._onClickClose()
end

function SettlementRecommend:_onClickFmtRecommend()
	UIJumper.instance:pushClearCurStack(ViewName.PetNoticeView, true, 5)
	self._onClickClose()
end

return SettlementRecommend

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatAdjustView.lua

module("logic.extensions.tips.view.PopupCostMatAdjustView", package.seeall)

local PopupCostMatAdjustView = class("PopupCostMatAdjustView", ViewComponent)

function PopupCostMatAdjustView:buildUI()
	PopupCostMatAdjustView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._content = MaterialMgr.findGraphicText(self.mainGO, "content")
	self._iconCurOwn = self:getGo("curOwn/icon")
	self._txtNumCurOwn = self:getTxt("curOwn/txtNum")
	self._iconCurCost = self:getGo("curCost/icon")
	self._txtNumCurCost = self:getTxt("curCost/txtNum")
	self._inputNum = self:getInput("inputNum")
	self._btnAdd = self:getGo("adjust/BtnAdd")
	self._btnMs = self:getGo("adjust/BtnMs")
	self._btnA10 = self:getGo("adjust/BtnA10")
	self._btnM10 = self:getGo("adjust/BtnM10")
	self._goToggle = self:getGo("toggle")
	self._btnToggle = goutil.findChild(self._goToggle, "btnToggle")
	self._txtToggle = goutil.findChildTextComponent(self._goToggle, "txtToggle", "Text")
	self._imgGou = goutil.findChild(self._btnToggle, "imgGou")
end

function PopupCostMatAdjustView:bindEvents()
	PopupCostMatAdjustView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._changeNumText, self, 1))
	GameUtil.addClickHandler(self._btnMs, GameUtil.handler(self._changeNumText, self, -1))
	GameUtil.addClickHandler(self._btnA10, GameUtil.handler(self._changeNumText, self, 10))
	GameUtil.addClickHandler(self._btnM10, GameUtil.handler(self._changeNumText, self, -10))
	self._inputNum:AddOnValueChanged(self._onValueChanged, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickToggle, self)
end

function PopupCostMatAdjustView:unbindEvents()
	PopupCostMatAdjustView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMs)
	GameUtil.rmClickHandler(self._btnA10)
	GameUtil.rmClickHandler(self._btnM10)
	GameUtil.rmClickHandler(self._btnToggle)
	self._inputNum:RemoveOnValueChanged()
end

function PopupCostMatAdjustView:onEnter()
	PopupCostMatAdjustView.super.onEnter(self)

	local param = self._viewPresentor:getFirstParam()
	local matType = param.matType
	local matId = param.matId
	local matNum = param.matNum
	local content = param.content
	local alignment = param.alignment
	local maxNum = param.maxNum

	self.matType = checknumber(matType)
	self.matId = checknumber(matId)
	self.costNum = checknumber(matNum)
	self._content.text = content

	MaterialMgr.setIcon(self._iconCurOwn, matType, matId)
	MaterialMgr.setIcon(self._iconCurCost, matType, matId)

	local count = 0

	count = (matType == MatType.Diamond or matType == MatType.PayDiamond) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond() or MaterialModel.instance:getMaterialsNumber(matType, matId)
	self._myMatNums = maxNum == nil and checknumber(count) or math.min(count, checknumber(maxNum))
	self._txtNumCurOwn.text = count
	self._numMax = math.max(self._myMatNums, 1)
	self._successCallBack = param.successCallBack
	self._otherCallBack = param.otherCallBack
	self._autoOpenSource = param.autoOpenSource ~= false
	self._toggleCall = param.toggleFunc

	goutil.setActive(self._goToggle, self._toggleCall ~= nil)
	goutil.setActive(self._imgGou, false)

	if alignment then
		self._content.alignment = alignment
	else
		local height = self._content.preferredHeight

		if height > 40 then
			self._content.alignment = UnityEngine.TextAnchor.MiddleLeft or UnityEngine.TextAnchor.MiddleCenter
		end
	end

	self.costNum = math.max(self.costNum, 1)

	self._inputNum:SetText(tostring(self.costNum))

	self._txtNumCurCost.text = tostring(self.costNum)
end

function PopupCostMatAdjustView:onExit()
	PopupCostMatAdjustView.super.onExit(self)

	self._successCallBack = nil
	self._toggleCall = nil
	self._otherCallBack = nil

	MaterialMgr.resetAll(self._iconCurOwn)
end

function PopupCostMatAdjustView:_onClickClose()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_CANCEL)
	self:close()
end

function PopupCostMatAdjustView:_onClickSure()
	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_OK)

	if not MaterialFacade.instance:checkMatEnough(self.matType, self.matId, self.costNum, nil, self._autoOpenSource) then
		self:close()
		GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_FAIL)

		return
	end

	GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_SUCCESS)
	GameUtil.callBack(self._successCallBack, self.costNum, self)
	self:close()
end

function PopupCostMatAdjustView:_changeNumText(delta)
	local num = checknumber(self._inputNum:GetText()) + delta

	num = Mathf.Clamp(num, 1, self._numMax)
	self.costNum = num

	self._inputNum:SetText(tostring(num))

	self._txtNumCurCost.text = tostring(num)

	local str = GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_NUM_CHANGE, self.costNum)

	if str then
		self._content.text = str
	end
end

function PopupCostMatAdjustView:_onValueChanged(strNum)
	local num = checknumber(strNum)

	num = Mathf.Clamp(num, 1, self._numMax)
	self.costNum = num

	self._inputNum:SetText(tostring(num))

	self._txtNumCurCost.text = tostring(num)

	local str = GameUtil.callBack(self._otherCallBack, TipsFacade.STATE_NUM_CHANGE, self.costNum)

	if str then
		self._content.text = str
	end
end

function PopupCostMatAdjustView:_onClickToggle()
	goutil.setActive(self._imgGou, not self._imgGou.activeSelf)

	if self._toggleCall then
		self._toggleCall(not self._imgGou.activeSelf)
	end
end

return PopupCostMatAdjustView

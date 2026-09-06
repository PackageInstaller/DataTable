-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteEnlistCostView.lua

module("logic.extensions.kindergarten.view.KindergarteEnlistCostView", package.seeall)

local KindergarteEnlistCostView = class("KindergarteEnlistCostView", ViewComponent)

function KindergarteEnlistCostView:ctor()
	KindergarteEnlistCostView.super.ctor(self)
end

function KindergarteEnlistCostView:buildUI()
	KindergarteEnlistCostView.super.buildUI(self)

	self._imgItem = goutil.findChild(self.mainGO, "imgItem")
	self._txtMatName = goutil.findChildTextComponent(self.mainGO, "matName/txt")
	self._txtMatCount = goutil.findChildTextComponent(self.mainGO, "txtMatCount")
	self._btnLessTen = goutil.findChild(self.mainGO, "adjust/btnLessTen")
	self._btnLess = goutil.findChild(self.mainGO, "adjust/btnLess")
	self._btnAdd = goutil.findChild(self.mainGO, "adjust/btnAdd")
	self._btnAddTen = goutil.findChild(self.mainGO, "adjust/btnAddTen")
	self._btnMax = goutil.findChild(self.mainGO, "adjust/btnMax")
	self._inputField = self:getInput("adjust/inputField")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function KindergarteEnlistCostView:bindEvents()
	KindergarteEnlistCostView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnLessTen, function()
		self:_calcValue(-10)
	end, self)
	GameUtil.addClickHandler(self._btnLess, function()
		self:_calcValue(-1)
	end, self)
	GameUtil.addClickHandler(self._btnAdd, function()
		self:_calcValue(1)
	end, self)
	GameUtil.addClickHandler(self._btnAddTen, function()
		self:_calcValue(10)
	end, self)
	GameUtil.addClickHandler(self._btnMax, function()
		self:_calcValue(self._curInputMaxNum)
	end, self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
end

function KindergarteEnlistCostView:unbindEvents()
	KindergarteEnlistCostView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnLessTen)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnAddTen)
	GameUtil.rmClickHandler(self._btnMax)
	self._inputField:RemoveOnValueChanged()
end

function KindergarteEnlistCostView:onEnter()
	KindergarteEnlistCostView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._enlistId = checknumber(params[2])
	self._enlistData = KindergartenConfig.instance:getEnlistData(self._activityId, self._enlistId)
	self._level = KindergartenController.instance:getGartenLevel(self._activityId)
	self._levelData = KindergartenConfig.instance:getLevelData(self._activityId, self._level)
	self._matStr = self._enlistData.cost
	self._matType, self._matId, self._costNum = MaterialMgr.getMatParams(self._enlistData.cost)
	self._matName = MaterialMgr.getMaterialsName(self._matType, self._matId)
	self._matNum = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)
	self._txtMatName.text = self._matName

	MaterialMgr.setIcon(self._imgItem, self._matType, self._matId, nil, nil)
	self.addGEvent(self, GlobalNotify.KindergartenGetInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function KindergarteEnlistCostView:onExit()
	KindergarteEnlistCostView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgItem)
end

function KindergarteEnlistCostView:destroyUI()
	KindergarteEnlistCostView.super.destroyUI(self)
end

function KindergarteEnlistCostView:_onUpdate()
	self._info = KindergartenModel.instance:getInfo(self._activityId)

	if self._info then
		self._curStuCount = self._info.curStudentCount or 0
	end

	if self._levelData then
		self._maxStuCount = self._levelData.studentLimit or 0
	end

	self._leftEmptyStu = Mathf.Max(self._maxStuCount - self._curStuCount, 0)
	self._curInputNum = 0
	self._curInputMaxNum = self._matNum
	self._maxTargetNum = self._leftEmptyStu
	self._txtMatCount.text = string.format("已拥有:%s", self._matNum)

	self:_onValueChanged(0)
end

function KindergarteEnlistCostView:_onValueChanged(numStr)
	local num = checkint(numStr)

	num = Mathf.Clamp(num, 0, self._curInputMaxNum)

	local targetNum = Mathf.Floor(num / self._costNum)

	if targetNum > self._maxTargetNum then
		FloatWordMgr.instance:show("超过剩余可招募学生数量")
		GameUtil.SetGray(self._btnSure, true)

		num = self._maxTargetNum * self._costNum
	end

	targetNum = Mathf.Floor(num / self._costNum)

	GameUtil.SetGray(self._btnSure, targetNum <= 0 or targetNum > self._maxTargetNum)

	self._curInputNum = num

	self._inputField:SetText(tostring(self._curInputNum))
end

function KindergarteEnlistCostView:_calcValue(delta)
	local num = self._curInputNum + checkint(delta) * self._costNum

	self:_onValueChanged(num)
end

function KindergarteEnlistCostView:_getTargetNum()
	return Mathf.Floor(self._curInputNum / self._costNum)
end

function KindergarteEnlistCostView:_onClickBtnSure()
	local targetNum = self:_getTargetNum()

	if targetNum > 0 then
		KindergartenAgent.instance:sendPM_KindergartenAddStudentReq(self._activityId, self._enlistId, targetNum)
		UIStateManager.instance:push(ViewName.KindergarteEnlistSuccessView, self._activityId, self._enlistId)
		self:close()
	end
end

return KindergarteEnlistCostView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigskinrenameView.lua

module("logic.extensions.pigraise.view.PigskinrenameView", package.seeall)

local PigskinrenameView = class("PigskinrenameView", ViewComponent)
local inputLenLimit = 7
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "宠物名可以由<color=#ffffff>2-7个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-1502] = "宠物名不可为空"
resultCode[-1503] = "宠物名字不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-1504] = "宠物名字太长了"
resultCode[-1505] = "有些字不太合适宠物哦，再想想看？"
resultCode[-1513] = "宠物名字格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"

function PigskinrenameView:ctor()
	PigskinrenameView.super.ctor(self)
end

function PigskinrenameView:buildUI()
	PigskinrenameView.super.buildUI(self)

	self._inputRoleName = self:getInput("inputRoleName")

	self._inputRoleName:SetCharacterLimit(inputLenLimit)

	self._rectTips = self:getGo("imgTips")
	self._txtTips = self:getTxt("imgTips/txtTips")
	self.btnOK = self:getBtn("btnOK")
	self.btnClose = self:getBtn("btnClose")
	self.item = self:getGo("cost/coinIcon")
	self.txtNum = self:getTxt("cost/txt")
	self.cost = self:getGo("cost")
	self.change = self:getGo("cost/txt"):GetComponent("UITextColorChange")
end

function PigskinrenameView:bindEvents()
	PigskinrenameView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self._inputRoleName:AddOnValueChanged(self._onValueChanged, self)
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
	self.btnOK:AddClickListener(self._onClickCreateRole, self)
end

function PigskinrenameView:unbindEvents()
	PigskinrenameView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnOK:RemoveClickListener()
	self._inputRoleName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):RemoveClickListener()
end

function PigskinrenameView:destroyUI()
	PigskinrenameView.super.destroyUI(self)
end

function PigskinrenameView:onEnter()
	PigskinrenameView.super.onEnter(self)

	self._curPetInfo = PigraiseModel.instance:getCurPetInfo()
	self._itemCostStr = PigraiseConfig.instance:getRenameCost()
	self._isFree = self._curPetInfo.hasFreeRenameTimes
	self._isEnough = MaterialMgr.getMatEnough(self._itemCostStr)

	if self._isFree then
		goutil.setActive(self.cost, false)
	else
		goutil.setActive(self.cost, true)

		local matType, matId, matNum = MaterialMgr.getMatParams(self._itemCostStr)

		self._matName = MaterialMgr.getMaterialsName(matType, matId)
		self.txtNum.text = matNum

		MaterialMgr.updateItemByStr(self.item, self._itemCostStr)

		if self._isEnough then
			self.change:SetState(0)
		else
			self.change:SetState(1)
		end
	end

	self._inputRoleName:SetText(PigraiseModel.instance:getPigName())
end

function PigskinrenameView:onEnterFinished()
	PigskinrenameView.super.onEnterFinished(self)
end

function PigskinrenameView:onExit()
	PigskinrenameView.super.onExit(self)
	removetimer(self._doUpdateTips, self)
	MaterialMgr.clearIcon(self.item)
end

function PigskinrenameView:onExitFinished()
	PigskinrenameView.super.onExitFinished(self)
end

function PigskinrenameView:_onClickInput()
	if self._inputRoleName.input.isFocused then
		self:_updateTips(0)
	end
end

function PigskinrenameView:_updateTips(status)
	if not self._lastStatus then
		self._lastStatus = status

		settimer(0, self._doUpdateTips, self, false)
	else
		self:_doUpdateTips(status)
	end
end

function PigskinrenameView:_doUpdateTips(status)
	status = status or self._lastStatus

	removetimer(self._doUpdateTips, self)

	if not resultCode[status] then
		goutil.setActive(self._rectTips.gameObject, true)

		self._txtTips.text = resultCode[status]
	end
end

function PigskinrenameView:_onValueChanged()
	self:_updateTips(0)

	local value = self._inputRoleName:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputRoleName:SetText(result)
end

function PigskinrenameView:_onClickCreateRole()
	if self._isLocked then
		return
	end

	local name = self._inputRoleName:GetText()

	if name == PigraiseModel.instance:getPigName() then
		TipsFacade.instance:openCommonTips(lang("名字没有改动"))
	else
		local isValid = self:_checkNameValid(name)

		if isValid then
			if self._isFree or self._isEnough then
				TipsFacade.instance:openPopupWindow(lang("tip"), langPara("是否确定把宠物名字修改成<color=#C54949>%s</color>？", name), function()
					self._isLocked = true

					AnimalsAgent.instance:sendPM_AnimalsRenameReq(PigraiseModel.instance:getPigId(), name, self.onRenameOk, self, self.onRenameError)
				end)
			else
				FloatWordMgr.instance:show(self._matName .. "不足")
			end
		end
	end
end

function PigskinrenameView:onRenameOk(msg)
	self._isLocked = false

	PigraiseModel.instance:updateAfterRenamePet(self._inputRoleName:GetText())
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseStateUpdate)
	GlobalDispatcher:dispatch(GlobalNotify.PigRaiseNameUpdate)
end

function PigskinrenameView:onRenameError(msg, status)
	self._isLocked = false
end

function PigskinrenameView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_updateTips(-1)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_updateTips(-1513)
	elseif realLen < 2 then
		self:_updateTips(-1502)
	elseif isAllNum then
		self:_updateTips(-1513)
	elseif isAllUnderLine then
		self:_updateTips(-1513)
	elseif realLen > inputLenLimit then
		self:_updateTips(-1504)
	else
		isValid = true
	end

	return isValid
end

return PigskinrenameView

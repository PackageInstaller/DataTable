-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetskinrenameView.lua

module("logic.extensions.bag.view.PetskinPetskinrenameView", package.seeall)

local PetskinrenameView = class("PetskinrenameView", ViewComponent)
local inputLenLimit = 7
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "精灵皮肤名可以由<color=#ffffff>2-7个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-1] = "奥奇名不能为空哦！"
resultCode[-2605] = "已经有小奥奇叫这个名字了哦"
resultCode[-2606] = "奥奇名不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-2607] = "名字不能长于<color=#ffffff>7个字的长度</color>"
resultCode[-2608] = "奥奇名只能由<color=#ffffff>汉字、字母、数字和下划线</color>等组成，不能含有空格或特殊符号哦！"
resultCode[-2609] = "有些字不太合适哦，再想想看？"
resultCode[-2612] = "不能全部是数字哦！"
resultCode[-2613] = "不能全部是下划线哦！"

function PetskinrenameView:ctor()
	PetskinrenameView.super.ctor(self)
end

function PetskinrenameView:buildUI()
	PetskinrenameView.super.buildUI(self)

	self._inputRoleName = self:getInput("inputRoleName")

	self._inputRoleName:SetCharacterLimit(inputLenLimit * 2)

	self._rectTips = self:getGo("imgTips")
	self._txtTips = self:getTxt("imgTips/txtTips")
	self._btnRefresh = self:getBtn("btnRefresh")
	self.btnOK = self:getBtn("btnOK")
	self.btnClose = self:getBtn("btnClose")
	self._btnReset = self:getBtn("btnReset")
end

function PetskinrenameView:bindEvents()
	PetskinrenameView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self._inputRoleName:AddOnValueChanged(self._onValueChanged, self)
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
	self.btnOK:AddClickListener(self._onClickCreateRole, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function PetskinrenameView:unbindEvents()
	PetskinrenameView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnOK:RemoveClickListener()
	self._inputRoleName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputRoleName.input.gameObject):RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function PetskinrenameView:destroyUI()
	PetskinrenameView.super.destroyUI(self)
end

function PetskinrenameView:onEnter()
	PetskinrenameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SetPetSkinOtherNameRes, self._onSetPetSkinOtherNameRes, self)

	self._skinId = self:getFirstParam()

	local skinMo = PetskinModel.instance:getSkinMoById(self._skinId)

	self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)
	self._curSkinName = skinMo and not string.nilorempty(skinMo:getOtherName()) and skinMo:getOtherName() or self._skinCfg.skinName

	self._inputRoleName:SetText(self._curSkinName)
end

function PetskinrenameView:onEnterFinished()
	PetskinrenameView.super.onEnterFinished(self)
end

function PetskinrenameView:onExit()
	PetskinrenameView.super.onExit(self)
end

function PetskinrenameView:onExitFinished()
	PetskinrenameView.super.onExitFinished(self)
end

function PetskinrenameView:_onClickInput()
	if self._inputRoleName.input.isFocused then
		self:_updateTips(0)
	end
end

function PetskinrenameView:_updateTips(status)
	if not self._lastStatus then
		self._lastStatus = status

		settimer(0, self._doUpdateTips, self, false)
	else
		self:_doUpdateTips(status)
	end
end

function PetskinrenameView:_doUpdateTips(status)
	status = status or self._lastStatus

	removetimer(self._doUpdateTips, self)

	if not resultCode[status] then
		goutil.setActive(self._rectTips.gameObject, true)

		self._txtTips.text = resultCode[status]
	end
end

function PetskinrenameView:_onValueChanged()
	self:_updateTips(0)
end

function PetskinrenameView:_onClickCreateRole()
	if self._isLocked then
		return
	end

	local name = self._inputRoleName:GetText()

	if name == self._curSkinName then
		TipsFacade.instance:openCommonTips(lang("名字没有改动"))
	elseif name == self._skinCfg.skinName then
		PetSkinAgent.instance:sendPM_SetPetSkinOtherNameReq(self._skinId, "")
	else
		local isValid = self:_checkNameValid(name)

		if isValid then
			PetSkinAgent.instance:sendPM_SetPetSkinOtherNameReq(self._skinId, name)
		end
	end
end

function PetskinrenameView:onRenameOk(msg)
	self._isLocked = false

	self:close()
	RoleAgent.instance:sendExitGameReq()
end

function PetskinrenameView:onRenameError(msg, status)
	self._isLocked = false
end

function PetskinrenameView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_updateTips(-1)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_updateTips(-2608)
	elseif realLen < 2 then
		self:_updateTips(-2606)
	elseif isAllNum then
		self:_updateTips(-2612)
	elseif isAllUnderLine then
		self:_updateTips(-2613)
	elseif realLen > inputLenLimit then
		self:_updateTips(-2607)
	else
		isValid = true
	end

	return isValid
end

function PetskinrenameView:_onClickbtnReset()
	self._inputRoleName:SetText(self._skinCfg.skinName)
end

function PetskinrenameView:_onSetPetSkinOtherNameRes()
	self:close()
end

return PetskinrenameView

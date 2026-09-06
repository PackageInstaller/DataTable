-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetVerifyPopupView.lua

module("logic.extensions.petverify.view.PetVerifyPopupView", package.seeall)

local PetVerifyPopupView = class("PetVerifyPopupView", FlyTweenBase)

function PetVerifyPopupView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._toggle = self:getToggle("toggle")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtName = self:getTxt("toggle/txtName")
	self._txtTip = self:getTxt("toggle/txtName/txtTip")
end

function PetVerifyPopupView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetVerifyPopupView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function PetVerifyPopupView:onEnter()
	self._toggle.isOn = false

	local param = self:getFirstParam()

	if not param then
		return
	end

	self._param = param

	self:_setUIFlyTweenParam(self._param.uiFlyTweenParam)

	self._txtDesc.text = self._param.descStr
	self._txtName.text = self._param.nameStr
	self._txtTip.text = self._param.toggleDescStr
end

function PetVerifyPopupView:onExit()
	PetVerifyPopupView.super.onExit(self)

	if self._toggle.isOn then
		local onToggleIsOnCallback = self._param.onToggleIsOnCallback

		if onToggleIsOnCallback then
			onToggleIsOnCallback()
		end
	end
end

function PetVerifyPopupView:_onClickClose()
	local function closeCallback()
		self:close()
	end

	self:_doCloseCallback(closeCallback)
end

return PetVerifyPopupView

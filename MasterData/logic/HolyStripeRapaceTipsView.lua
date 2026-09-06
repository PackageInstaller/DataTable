-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeRapaceTipsView.lua

module("logic.extensions.holystripe.view.HolyStripeRapaceTipsView", package.seeall)

local HolyStripeRapaceTipsView = class("HolyStripeRapaceTipsView", ViewComponent)

function HolyStripeRapaceTipsView:buildUI()
	HolyStripeRapaceTipsView.super.buildUI()

	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._txtTip = self:getTxt("txtTip")
end

function HolyStripeRapaceTipsView:bindEvents()
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
	self._btnCancel:AddClickListener(self._onClickBtnCancel, self)
end

function HolyStripeRapaceTipsView:unbindEvents()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function HolyStripeRapaceTipsView:onEnter()
	self._holyStripId = self:getFirstParam()

	local holyStripMo = HolyStripeModel.instance:getHolyStripeMo(checknumber(self._holyStripId))
	local petMo = BagPetsController.instance:getExistPet(holyStripMo:getEquipPetId())

	self._txtTip.text = langPara("该灵纹已镶嵌在%s上，是否确认替换", petMo.name)
end

function HolyStripeRapaceTipsView:_onClickBtnSure()
	GlobalDispatcher:dispatch(HolyStripeController.Confirm_To_Replace, self._holyStripId)
	self:close()
end

function HolyStripeRapaceTipsView:_onClickBtnCancel()
	self:close()
end

return HolyStripeRapaceTipsView

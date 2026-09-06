-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdPetBuffFormationExView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdPetBuffFormationExView", package.seeall)

local YouthArenaThirdPetBuffFormationExView = class("YouthArenaThirdPetBuffFormationExView", ViewComponent)

function YouthArenaThirdPetBuffFormationExView:ctor()
	YouthArenaThirdPetBuffFormationExView.super.ctor(self)
end

function YouthArenaThirdPetBuffFormationExView:buildUI()
	YouthArenaThirdPetBuffFormationExView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
end

function YouthArenaThirdPetBuffFormationExView:bindEvents()
	YouthArenaThirdPetBuffFormationExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function YouthArenaThirdPetBuffFormationExView:unbindEvents()
	YouthArenaThirdPetBuffFormationExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function YouthArenaThirdPetBuffFormationExView:onEnter()
	YouthArenaThirdPetBuffFormationExView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
end

function YouthArenaThirdPetBuffFormationExView:onExit()
	YouthArenaThirdPetBuffFormationExView.super.onExit(self)

	self._fmtMo = nil
end

function YouthArenaThirdPetBuffFormationExView:_onClickBtnBuff()
	local buffPlanId = self._fmtMo and self._fmtMo:getBuffPlanId() or 0

	if buffPlanId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.YouthArenaThirdBuffView, buffPlanId)
end

return YouthArenaThirdPetBuffFormationExView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMBanView.lua

module("logic.extensions.gm.view.GMBanView", package.seeall)

local GMBanView = class("GMBanView", ViewComponent)

function GMBanView:ctor()
	GMBanView.super.ctor(self)
end

function GMBanView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBan:AddClickListener(self._onClickBan, self)
end

function GMBanView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnBan:RemoveClickListener()
end

function GMBanView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnBan = self:getBtn("btnBan")
	self._inputPlayerName = self:getInput("inputPlayerName")
	self._inputBanType = self:getInput("inputBanType")
end

function GMBanView:destroyUI()
	return
end

function GMBanView:onEnter()
	return
end

function GMBanView:onEnterFinished()
	return
end

function GMBanView:onExit()
	return
end

function GMBanView:onExitFinished()
	return
end

function GMBanView:_onClickClose()
	UIStateManager.instance:pop()
end

function GMBanView:_onClickBan()
	local playerName = self._inputPlayerName:GetText()
	local banType = checknumber(self._inputBanType:GetText())

	if not string.nilorempty(playerName) then
		GMAgent:sendPM_ChangeUserBanStateReq(playerName, banType)
	end
end

return GMBanView

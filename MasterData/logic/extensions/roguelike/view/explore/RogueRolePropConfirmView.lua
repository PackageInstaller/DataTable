-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRolePropConfirmView.lua

module("logic.extensions.roguelike.view.explore.RogueRolePropConfirmView", package.seeall)

local M = class("RogueRolePropConfirmView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnCancel = self:getBtn("")
	self._btnConfirm = self:getBtn("")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter()
	self._confirmCallback = self:getFirstParam()
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
end

function M:_onClickConfirm()
	if self._confirmCallback ~= nil then
		self._confirmCallback()
	end

	self:close()
end

return M

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsMaskComp.lua

module("logic.extensions.tooltips.component.ToolTipsMaskComp", package.seeall)

local M = class("ToolTipsMaskComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._clickBtn = false
end

function M:buildUI()
	self._clickBtn = self:getBtnByPath("empty_raycast_mask")

	self._clickBtn:AddClickListener(self._clickMask, self)

	self._passEvent = self._clickBtn.gameObject:GetComponent(ComponentType.PassEvent)
end

function M:unbindEvents()
	self._clickBtn:RemoveClickListener()
end

function M:destroyUI()
	return
end

function M:onEnter()
	local param = self:getFirstParam()

	if param.isPassEvent == false then
		self._passEvent.isPassEvent = param.isPassEvent
	else
		self._passEvent.isPassEvent = true
	end

	self._maskClickClose = param.maskClickClose

	goutil.setActive(self._clickBtn.gameObject, not self._maskClickClose)
end

function M:onExit()
	return
end

function M:_clickMask()
	if self._maskClickClose then
		return
	end

	ToolTipsController.instance:setInCloseTipsTime()
	GlobalDispatcher:dispatchEvent(EventType.ITEMTIPS_CLOSE)
	self:close()
end

return M

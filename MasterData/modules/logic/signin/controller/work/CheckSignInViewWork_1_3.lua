-- chunkname: @modules/logic/signin/controller/work/CheckSignInViewWork_1_3.lua

module("modules.logic.signin.controller.work.CheckSignInViewWork_1_3", package.seeall)

local CheckSignInViewWork_1_3 = class("CheckSignInViewWork_1_3", BaseWork)

function CheckSignInViewWork_1_3:onStart()
	self._funcs = {}

	SignInController.instance:registerCallback(SignInEvent.OnSignInPopupFlowUpdate, self._onSignInPopupFlowUpdate, self)
end

function CheckSignInViewWork_1_3:_removeSingleEvent(eventName)
	local func = self._funcs[eventName]

	if func then
		SignInController.instance:unregisterCallback(eventName, func, self)

		self._funcs[eventName] = nil
	end

	if not next(self._funcs) then
		self:_startBlock()
		self:onDone(true)
	end
end

function CheckSignInViewWork_1_3:_onSignInPopupFlowUpdate(eventName)
	if eventName == false then
		self:_clear()
		self:onDone(true)

		return
	end

	if eventName == nil then
		logError("impossible ?!")

		return
	end

	if self._funcs[eventName] then
		return
	end

	local funcName = string.format("__internal_%s", eventName)

	self[funcName] = function()
		self:_removeSingleEvent(eventName)
	end
	self._funcs[eventName] = self[funcName]

	SignInController.instance:registerCallback(eventName, self[funcName], self)
end

function CheckSignInViewWork_1_3:_clear()
	for eventName, func in pairs(self._funcs) do
		SignInController.instance:unregisterCallback(eventName, func, self)
	end

	self._funcs = {}
end

function CheckSignInViewWork_1_3:clearWork()
	if not self.isSuccess then
		self:_endBlock()
	end

	self:_clear()
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInPopupFlowUpdate, self._onSignInPopupFlowUpdate, self)
end

function CheckSignInViewWork_1_3:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function CheckSignInViewWork_1_3:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function CheckSignInViewWork_1_3:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

return CheckSignInViewWork_1_3

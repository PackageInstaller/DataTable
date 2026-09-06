-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/uistate/UIStateManager.lua

module("logiccommon.common.viewlib.uistate.UIStateManager", package.seeall)

local UIStateManager = class("UIStateManager")

function UIStateManager:ctor()
	self._rootUI = nil
	self._stack = {}
	self._openPool = {}
	self._viewOpenedGuard = nil
	self._transiton = UIStateTransition.New()

	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
end

function UIStateManager:addOpenedGuard(func, obj)
	self._viewOpenedGuard = self._viewOpenedGuard or {}

	table.insert(self._viewOpenedGuard, {
		func = func,
		obj = obj
	})
end

function UIStateManager:removeOpenedGuard(func, obj)
	if not self._viewOpenedGuard then
		return
	end

	for i = 1, #self._viewOpenedGuard do
		local guard = self._viewOpenedGuard[i]

		if guard.func == func and guard.obj == obj then
			table.remove(self._viewOpenedGuard, i)

			break
		end
	end
end

function UIStateManager:checkOpened(name)
	if not self._viewOpenedGuard then
		return true
	end

	for i = 1, #self._viewOpenedGuard do
		local guard = self._viewOpenedGuard[i]
		local isCanOpen = true
		local tipsStr

		if guard.obj then
			isCanOpen, tipsStr = guard.func(guard.obj, name)
		else
			isCanOpen, tipsStr = guard.func(name)
		end

		if not isCanOpen then
			FloatWordMgr.instance:show(tipsStr)

			return false
		end
	end

	return true
end

function UIStateManager:setRoot(root)
	self._rootUI = root
end

function UIStateManager:getRoot()
	return self._rootUI
end

function UIStateManager:isInStack(name)
	return self:_isInStack(name)
end

function UIStateManager:init()
	return
end

function UIStateManager:getCurStacks()
	return self._stack
end

function UIStateManager:closeAllModalViews()
	local views = ViewMgr.instance._views
	local closeViews

	for k, v in pairs(views) do
		local name = v.viewName

		if ViewMgr.instance:isOpen(name) and not self:_isInStack(name) and not ViewMgr.instance:isPermanent(name) then
			closeViews = closeViews or {}

			table.insert(closeViews, name)
		end
	end

	if closeViews then
		for i = 1, #closeViews do
			ViewMgr.instance:close(closeViews[i])
		end
	end
end

function UIStateManager:pushWithoutEnterState(state, ...)
	self:_clearExistState(state)

	local param = ...
	local tparam
	local cfg = {
		state = state,
		param = (param or nil) and {
			...
		}
	}

	table.insert(self._stack, cfg)
end

function UIStateManager:open(state, ...)
	ViewMgr.instance:open(state, ...)

	self._openPool[state] = true
end

function UIStateManager:push(state, ...)
	if not self:checkOpened(state) then
		return
	end

	if ViewSetting.instance:isModal(state) then
		self:open(state, ...)

		return
	end

	self:_pushState(state, true, ...)
end

function UIStateManager:popByName(name, ...)
	local currUI = self:_top()

	if currUI and currUI.state == name then
		self:pop(...)
	else
		local stack = self:_clearExistState(name)

		if stack ~= nil then
			table.insert(self._stack, stack)
			self:pop(...)
		else
			ViewMgr.instance:close(name)

			self._openPool[name] = nil

			if ViewSetting.instance:isModal(name) then
				return
			end

			if currUI == nil and self._rootUI then
				self:push(self._rootUI)
			end
		end
	end
end

function UIStateManager:updateParms(name, params)
	for k, v in pairs(self._stack) do
		if v.state == name then
			v.param = params

			break
		end
	end
end

function UIStateManager:pop(...)
	local currUI = self:_top()

	if currUI and #self._stack == 1 and self._rootUI == currUI.state then
		return
	end

	self:_pop()

	local topUI = self:_top()
	local param = ...
	local tparam

	if param then
		tparam = {
			...
		}
	end

	local state

	if topUI then
		state = topUI.state

		if not tparam and topUI.param then
			tparam = topUI.param
		end
	end

	if not state then
		state = self._rootUI

		local cfg = {
			state = self._rootUI,
			param = tparam
		}

		table.insert(self._stack, cfg)
	end

	if state then
		local fromState = self._transiton:getTransitionFrom()

		if not fromState and currUI then
			fromState = currUI.state
		end

		self._transiton:closeTransitionToState()

		if tparam then
			self._transiton:startTransition(fromState, state, true, unpack(tparam))
		else
			self._transiton:startTransition(fromState, state, true)
		end
	else
		if not self._transiton.stateFrom and currUI then
			self._transiton.stateFrom = currUI.state
		end

		self._transiton:closeTransitionToState()
		self._transiton:closeTransitionFromState()
		self._transiton:stopTransition()
	end
end

function UIStateManager:clear(showDefault)
	if showDefault == nil then
		showDefault = true
	end

	self._transiton:stopTransition()

	for i, v in ipairs(self._stack) do
		ViewMgr.instance:close(v.state)
	end

	self._stack = {}
	self._openPool = {}

	ViewMgr.instance:closeAllViews()

	if showDefault and self._rootUI then
		self:push(self._rootUI)
	end
end

function UIStateManager:getTopName()
	local top = self:_top()

	if top == nil then
		return nil
	end

	return top.state
end

function UIStateManager:_clearExistState(name)
	if self._stack then
		for i = 1, #self._stack do
			if self._stack[i].state == name then
				local stack = self._stack[i]

				table.remove(self._stack, i)

				return stack
			end
		end
	end

	return nil
end

function UIStateManager:_top()
	local len = #self._stack

	if len > 0 then
		return self._stack[len]
	end
end

function UIStateManager:_getTopState()
	local topUI = self:_top()
	local topState

	return (topUI or nil) and topUI.state
end

function UIStateManager:_pop()
	local len = #self._stack

	if len > 0 then
		table.remove(self._stack, len)
	end
end

function UIStateManager:_pushState(state, closeTop, ...)
	local topState = self:_getTopState()

	if topState == state then
		return
	end

	self:_enterState(topState, state, closeTop, ...)
end

function UIStateManager:_enterState(from, state, closeTop, ...)
	local param = ...
	local tparam
	local fromState = self._transiton:getTransitionFrom()

	fromState = fromState or from

	self:_clearExistState(state)

	local cfg = {
		state = state,
		param = (param or nil) and {
			...
		}
	}

	table.insert(self._stack, cfg)
	self._transiton:closeTransitionToState()
	self._transiton:startTransition(fromState, state, closeTop, ...)
end

function UIStateManager:_isInStack(name)
	if self._stack then
		for i = 1, #self._stack do
			if self._stack[i].state == name then
				return true
			end
		end
	end

	return nil
end

function UIStateManager:_onViewOpened(view)
	if view.viewName == self._transiton:getTransitionTo() then
		self._transiton:tryCloseTransitionFromState()
		self._transiton:stopTransition()
	end
end

function UIStateManager:_onViewClosed(view)
	return
end

UIStateManager.instance = UIStateManager.New()

return UIStateManager

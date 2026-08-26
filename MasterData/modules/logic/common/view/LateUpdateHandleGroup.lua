-- chunkname: @modules/logic/common/view/LateUpdateHandleGroup.lua

module("modules.logic.common.view.LateUpdateHandleGroup", package.seeall)

local LateUpdateHandleGroup = class("LateUpdateHandleGroup")

function LateUpdateHandleGroup:ctor()
	self._handles = nil
end

function LateUpdateHandleGroup:add(callback, callbackObj)
	if not callback then
		return
	end

	if not self._handles then
		self._handles = {}

		LateUpdateBeat:Add(self._onFrameLateUpdate, self)
	end

	if self:_indexOf(callback, callbackObj) then
		return
	end

	table.insert(self._handles, {
		cb = callback,
		obj = callbackObj
	})
end

function LateUpdateHandleGroup:remove(callback, callbackObj)
	if not self._handles then
		return
	end

	local index = self:_indexOf(callback, callbackObj)

	if not index then
		return
	end

	table.remove(self._handles, index)

	if #self._handles == 0 then
		self:_unsubscribe()
	end
end

function LateUpdateHandleGroup:_indexOf(callback, callbackObj)
	if not self._handles then
		return nil
	end

	for i = 1, #self._handles do
		local h = self._handles[i]

		if h.cb == callback and h.obj == callbackObj then
			return i
		end
	end

	return nil
end

function LateUpdateHandleGroup:_onFrameLateUpdate()
	if not self._handles then
		return
	end

	local dt = Time.deltaTime
	local snapshot = {}

	for i = 1, #self._handles do
		snapshot[i] = self._handles[i]
	end

	for i = 1, #snapshot do
		local h = snapshot[i]

		if h.obj then
			h.cb(h.obj, dt)
		else
			h.cb(dt)
		end
	end
end

function LateUpdateHandleGroup:_unsubscribe()
	self._handles = nil

	LateUpdateBeat:Remove(self._onFrameLateUpdate, self)
end

function LateUpdateHandleGroup:clear()
	self:_unsubscribe()
end

function LateUpdateHandleGroup:destroy()
	self:clear()
end

return LateUpdateHandleGroup

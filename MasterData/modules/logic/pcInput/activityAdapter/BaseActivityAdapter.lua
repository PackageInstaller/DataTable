-- chunkname: @modules/logic/pcInput/activityAdapter/BaseActivityAdapter.lua

module("modules.logic.pcInput.activityAdapter.BaseActivityAdapter", package.seeall)

local BaseActivityAdapter = class("BaseActivityAdapter")

function BaseActivityAdapter:ctor()
	self.keytoFunction = {}
	self.activitid = nil
	self._registeredKey = {}
	self._priorty = 0
end

function BaseActivityAdapter:getPriorty()
	return self._priorty or 0
end

function BaseActivityAdapter:registerFunction()
	local keys = PCInputModel.instance:getActivityKeys(self.activitid)

	if not keys then
		return
	end

	self._registeredKey = keys

	for _, v in pairs(keys) do
		PCInputController.instance:registerKey(v[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end
end

function BaseActivityAdapter:unRegisterFunction()
	for _, v in pairs(self._registeredKey) do
		PCInputController.instance:unregisterKey(v[4], ZProj.PCInputManager.PCInputEvent.KeyUp)
	end

	self._registeredKey = {}
end

function BaseActivityAdapter:OnkeyUp(keyName)
	local keyid = PCInputModel.instance:getkeyidBykeyName(self.activitid, keyName)

	if not keyid then
		return
	end

	local func = self.keytoFunction[keyid]

	if func then
		func()
	end
end

function BaseActivityAdapter:OnkeyDown(keyName)
	local keyid = PCInputModel.instance:getkeyidBykeyName(self.activitid, keyName)

	if not keyid then
		return
	end

	local func = self.keytoFunction[keyid]

	if func then
		func()
	end
end

function BaseActivityAdapter:destroy()
	self:unRegisterFunction()
end

return BaseActivityAdapter

-- chunkname: @modules/logic/room/entity/comp/base/RoomBaseBlockEffectComp.lua

module("modules.logic.room.entity.comp.base.RoomBaseBlockEffectComp", package.seeall)

local RoomBaseBlockEffectComp = class("RoomBaseBlockEffectComp", LuaCompBase)

function RoomBaseBlockEffectComp:ctor(entity)
	self.entity = entity
	self.delayTaskTime = 0.1
	self._effectKeyDict = {}
	self._allEffectKeyList = {}
	self._effectPrefixKey = self.__cname
end

function RoomBaseBlockEffectComp:addEventListeners()
	return
end

function RoomBaseBlockEffectComp:removeEventListeners()
	return
end

function RoomBaseBlockEffectComp:onBeforeDestroy()
	return
end

function RoomBaseBlockEffectComp:onRunDelayTask()
	return
end

function RoomBaseBlockEffectComp:removeParamsAndPlayAnimator(keyList, animName, delayDestroy)
	local effect = self.entity.effect

	if delayDestroy then
		for i = 1, #keyList do
			effect:playEffectAnimator(keyList[i], animName)
		end
	end

	effect:removeParams(keyList, delayDestroy)
end

function RoomBaseBlockEffectComp:getEffectKeyById(index)
	if not self._effectKeyDict[index] then
		local effectNameKey = self:formatEffectKey(index)

		self._effectKeyDict[index] = effectNameKey

		table.insert(self._allEffectKeyList, effectNameKey)
	end

	return self._effectKeyDict[index]
end

function RoomBaseBlockEffectComp:formatEffectKey(index)
	return string.format("%s_%s", self._effectPrefixKey, index)
end

function RoomBaseBlockEffectComp:startWaitRunDelayTask()
	if not self.__hasWaitRunDelayTask_ then
		self.__hasWaitRunDelayTask_ = true

		if not self.delayTaskTime then
			TaskDispatcher.runDelay(self.__onWaitRunDelayTask_, self, math.max(0.001, tonumber(self.delayTaskTime)))
		end
	end
end

function RoomBaseBlockEffectComp:__onWaitRunDelayTask_()
	self.__hasWaitRunDelayTask_ = false

	if not self:isWillDestory() then
		self:onRunDelayTask()
	end
end

function RoomBaseBlockEffectComp:isWillDestory()
	return self.__willDestroy
end

function RoomBaseBlockEffectComp:beforeDestroy()
	self.__willDestroy = true
	self.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(self.__onWaitRunDelayTask_, self)
	self:onBeforeDestroy()
end

return RoomBaseBlockEffectComp

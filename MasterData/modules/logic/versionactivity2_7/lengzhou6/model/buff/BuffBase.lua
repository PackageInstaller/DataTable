-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/buff/BuffBase.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.buff.BuffBase", package.seeall)

local BuffBase = class("BuffBase")

function BuffBase:ctor()
	self._id = 0
	self._configId = 0
	self._layerCount = 0
	self._addLimit = 1
end

function BuffBase:init(id, configId)
	self._id = id
	self.config = LengZhou6Config.instance:getEliminateBattleBuff(configId)
	self._addLimit = self.config.limit
	self._configId = configId
	self._triggerPoint = self.config.triggerPoint
	self._layerCount = 1
	self._effect = self.config.effect
end

function BuffBase:getBuffEffect()
	return self._effect
end

function BuffBase:getLayerCount()
	return self._layerCount
end

function BuffBase:addCount(diff)
	local value = self._layerCount + diff

	self._layerCount = math.max(0, math.min(value, self._addLimit))
end

function BuffBase:execute()
	return true
end

return BuffBase

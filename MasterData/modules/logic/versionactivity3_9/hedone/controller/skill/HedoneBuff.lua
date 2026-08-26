-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/skill/HedoneBuff.lua

module("modules.logic.versionactivity3_9.hedone.controller.skill.HedoneBuff", package.seeall)

local HedoneBuff = class("HedoneBuff")

function HedoneBuff:ctor(uid, buffId)
	self._uid = uid
	self._id = buffId
	self._consumedLife = 0
	self._maxLife = HedoneConfig.instance:getHedoneBuffLifeParam(self._id)
end

function HedoneBuff:addConsumedLife(addVal)
	self._consumedLife = self._consumedLife + (addVal or 1)

	return self:isBuffAlive()
end

function HedoneBuff:isBuffAlive()
	return self._consumedLife < self._maxLife
end

function HedoneBuff:getId()
	return self._id
end

function HedoneBuff:getUid()
	return self._uid
end

function HedoneBuff:getMaxLife()
	return self._maxLife
end

function HedoneBuff:getConsumedLife()
	return self._consumedLife
end

return HedoneBuff

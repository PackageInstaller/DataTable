-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/set/HedoneBaseSet.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.set.HedoneBaseSet", package.seeall)

local HedoneBaseSet = class("HedoneBaseSet")

function HedoneBaseSet:ctor(unitMO)
	self._unitMO = unitMO
	self._genUid = 0

	self:onCtor()
end

function HedoneBaseSet:getUnitMO()
	return self._unitMO
end

function HedoneBaseSet:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

function HedoneBaseSet:onCtor()
	return
end

return HedoneBaseSet

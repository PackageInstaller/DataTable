-- chunkname: @modules/logic/fight/model/data/FightCounterDataMgr.lua

module("modules.logic.fight.model.data.FightCounterDataMgr", package.seeall)

local FightCounterDataMgr = FightDataClass("FightCounterDataMgr", FightDataMgrBase)

FightCounterDataMgr.CounterId = {
	DeviceCostPower = 62,
	DeviceUseSkill = 63
}

function FightCounterDataMgr:onConstructor()
	self.counterDict = {}
end

function FightCounterDataMgr:getCounter(counterId)
	return self.counterDict[counterId]
end

function FightCounterDataMgr:setCounter(counterId, value)
	self.counterDict[counterId] = value
end

function FightCounterDataMgr:removeCounter(counterId)
	self.counterDict[counterId] = nil
end

return FightCounterDataMgr

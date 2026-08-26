-- chunkname: @modules/logic/fight/model/mo/FightRecordMO.lua

module("modules.logic.fight.model.mo.FightRecordMO", package.seeall)

local FightRecordMO = pureTable("FightRecordMO")

function FightRecordMO:init(info)
	self.fightId = info.fightId
	self.fightName = info.fightName
	self.fightTime = info.fightTime
	self.fightResult = info.fightResult

	FightStatModel.instance:setAtkStatInfo(info.attackStatistics)
end

return FightRecordMO

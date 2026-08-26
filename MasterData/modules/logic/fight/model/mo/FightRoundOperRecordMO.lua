-- chunkname: @modules/logic/fight/model/mo/FightRoundOperRecordMO.lua

module("modules.logic.fight.model.mo.FightRoundOperRecordMO", package.seeall)

local FightRoundOperRecordMO = pureTable("FightRoundOperRecordMO")

function FightRoundOperRecordMO:ctor()
	self.clothSkillOpers = {}
	self.opers = {}
end

function FightRoundOperRecordMO:init(operRecord)
	for _, one in ipairs(operRecord.clothSkillOpers) do
		local clothSkillOper = {}

		clothSkillOper.skillId = one.skillId
		clothSkillOper.fromId = one.fromId
		clothSkillOper.toId = one.toId
		clothSkillOper.type = one.type

		table.insert(self.clothSkillOpers, clothSkillOper)
	end

	for _, one in ipairs(operRecord.opers) do
		local beginRoundOp = FightOperationItemData.New()

		beginRoundOp:setByProto(one)
		table.insert(self.opers, beginRoundOp)
	end
end

return FightRoundOperRecordMO

-- chunkname: @modules/logic/fight/model/data/FightBloodPoolDataMgr.lua

module("modules.logic.fight.model.data.FightBloodPoolDataMgr", package.seeall)

local FightBloodPoolDataMgr = FightDataClass("FightBloodPoolDataMgr", FightDataMgrBase)

function FightBloodPoolDataMgr:onConstructor()
	self.playedSkill = false
end

function FightBloodPoolDataMgr:onCancelOperation()
	if self.playedSkill then
		self.playedSkill = false
	end

	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnCancelPlayCard)
end

function FightBloodPoolDataMgr:playBloodPoolCard()
	self.playedSkill = true

	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnPlayCard)
end

function FightBloodPoolDataMgr:checkPlayedCard()
	return self.playedSkill
end

return FightBloodPoolDataMgr

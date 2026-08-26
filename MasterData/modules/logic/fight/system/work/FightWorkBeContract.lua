-- chunkname: @modules/logic/fight/system/work/FightWorkBeContract.lua

module("modules.logic.fight.system.work.FightWorkBeContract", package.seeall)

local FightWorkBeContract = class("FightWorkBeContract", FightEffectBase)

function FightWorkBeContract:onStart()
	FightModel.instance:setBeContractEntityUid(self.actEffectData.targetId)
	self:onDone(true)
end

return FightWorkBeContract

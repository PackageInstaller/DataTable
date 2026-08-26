-- chunkname: @modules/logic/fight/system/work/FightWorkContract.lua

module("modules.logic.fight.system.work.FightWorkContract", package.seeall)

local FightWorkContract = class("FightWorkContract", FightEffectBase)

function FightWorkContract:onStart()
	local entityMO = FightDataHelper.entityMgr:getById(self.actEffectData.targetId)

	if entityMO then
		entityMO:clearNotifyBindContract()
		FightModel.instance:setContractEntityUid(entityMO.uid)
	end

	self:onDone(true)
end

return FightWorkContract

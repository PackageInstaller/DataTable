-- chunkname: @modules/logic/fight/system/work/FightWorkNotifyBindContract.lua

module("modules.logic.fight.system.work.FightWorkNotifyBindContract", package.seeall)

local FightWorkNotifyBindContract = class("FightWorkNotifyBindContract", FightEffectBase)

function FightWorkNotifyBindContract:onStart()
	local entityList = FightStrUtil.instance:getSplitCache(self.actEffectData.reserveStr, "#")

	FightModel.instance:setNotifyContractInfo(self.actEffectData.targetId, entityList)
	self:onDone(true)
end

return FightWorkNotifyBindContract

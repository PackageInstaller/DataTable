-- chunkname: @modules/logic/fight/system/work/FightWorkMagicCircleUpgrade340.lua

module("modules.logic.fight.system.work.FightWorkMagicCircleUpgrade340", package.seeall)

local FightWorkMagicCircleUpgrade340 = class("FightWorkMagicCircleUpgrade340", FightEffectBase)

function FightWorkMagicCircleUpgrade340:onStart()
	local magicData = FightModel.instance:getMagicCircleInfo()

	if magicData then
		magicData:refreshData(self.actEffectData.magicCircle)
		FightController.instance:dispatchEvent(FightEvent.UpgradeMagicCircile, magicData)
	end

	self:onDone(true)
end

return FightWorkMagicCircleUpgrade340

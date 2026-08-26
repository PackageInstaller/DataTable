-- chunkname: @modules/logic/fight/view/work/FightAutoDetectUpgradeWork.lua

module("modules.logic.fight.view.work.FightAutoDetectUpgradeWork", package.seeall)

local FightAutoDetectUpgradeWork = class("FightAutoDetectUpgradeWork", FightWorkItem)

function FightAutoDetectUpgradeWork:onConstructor()
	self.SAFETIME = 10
end

function FightAutoDetectUpgradeWork:onStart(entity)
	local upgradeDataList = FightPlayerOperateMgr.detectUpgrade()

	if #upgradeDataList > 0 then
		FightController.instance:registerCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)

		for i = #upgradeDataList, 1, -1 do
			local data = upgradeDataList[i]

			FightRpc.instance:sendUseClothSkillRequest(data.id, data.entityId, data.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
			self:cancelFightWorkSafeTimer()

			return
		end
	end

	self:onDone(true)
end

function FightAutoDetectUpgradeWork:_onRespUseClothSkillFail()
	self:onDone(true)
end

function FightAutoDetectUpgradeWork:clearWork()
	FightController.instance:unregisterCallback(FightEvent.RespUseClothSkillFail, self._onRespUseClothSkillFail, self)
end

return FightAutoDetectUpgradeWork

-- chunkname: @modules/logic/fight/system/work/FightWorkCheckLuXiHeroUpgrade.lua

module("modules.logic.fight.system.work.FightWorkCheckLuXiHeroUpgrade", package.seeall)

local FightWorkCheckLuXiHeroUpgrade = class("FightWorkCheckLuXiHeroUpgrade", FightWorkItem)

function FightWorkCheckLuXiHeroUpgrade:onStart()
	local upgradeDataList = FightPlayerOperateMgr.detectUpgrade()

	if #upgradeDataList > 0 then
		for i = #upgradeDataList, 1, -1 do
			local data = upgradeDataList[i]
			local config = lua_hero_upgrade.configDict[data.id]

			if config.type == 1 then
				FightRpc.instance:sendUseClothSkillRequest(data.id, data.entityId, data.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
				self:cancelFightWorkSafeTimer()

				return
			end
		end

		if #upgradeDataList > 0 then
			self._upgradeDataList = upgradeDataList

			ViewMgr.instance:openView(ViewName.FightSkillStrengthenView, upgradeDataList)
			self:cancelFightWorkSafeTimer()

			return
		end
	end

	self:onDone(true)
end

return FightWorkCheckLuXiHeroUpgrade

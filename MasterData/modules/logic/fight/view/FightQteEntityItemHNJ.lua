-- chunkname: @modules/logic/fight/view/FightQteEntityItemHNJ.lua

module("modules.logic.fight.view.FightQteEntityItemHNJ", package.seeall)

local FightQteEntityItemHNJ = class("FightQteEntityItemHNJ", FightQteEntityItemBase)
local EnergyMax = 2

function FightQteEntityItemHNJ:init(entityMo, useType)
	FightQteEntityItemHNJ.super.init(self, entityMo, useType)

	self.buffId = tonumber(lua_fight_hnj_cost.configDict[1].value)
	self.threshold = tonumber(lua_fight_hnj_cost.configDict[2].value)
	self.replaceSkillId = tonumber(lua_fight_hnj_cost.configDict[3].value)
	self.longPressSkillId = self.activeSkillId
	self.preBuffLayer = 0
end

function FightQteEntityItemHNJ:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
end

function FightQteEntityItemHNJ:onBuffUpdate(entityId, effectType, buffId)
	if entityId ~= self.entityId then
		return
	end

	if buffId ~= self.buffId then
		return
	end

	self:refreshUI()
end

function FightQteEntityItemHNJ:initView()
	FightQteEntityItemHNJ.super.initView(self)

	self.goEnergy = gohelper.findChild(self.viewGo, "root/energy")
	self.energyItemList = self:getUserDataTb_()

	for i = 1, EnergyMax do
		local energyItem = self:getUserDataTb_()

		energyItem.goLight = gohelper.findChild(self.goEnergy, string.format("energy_%d", i))
		energyItem.animator = energyItem.goLight:GetComponent(gohelper.Type_Animator)
		energyItem.goCanUse = gohelper.findChild(energyItem.goLight, "#go_canuse")

		table.insert(self.energyItemList, energyItem)
	end
end

function FightQteEntityItemHNJ:refreshUI()
	if not self.loadedDone then
		return
	end

	FightQteEntityItemHNJ.super.refreshUI(self)
	self:refreshEnergy()
end

local EnergyChangeStatus = {
	Reduce = 1,
	Add = 2,
	Equal = 3
}

function FightQteEntityItemHNJ:refreshEnergy()
	if not self.loadedDone then
		return
	end

	if self.useType == FightQteEntityItemBase.UseType.QTEBtn then
		gohelper.setActive(self.goEnergy, true)

		local buffLayer = self:getBuffLayer()

		self.longPressSkillId = buffLayer >= self.threshold and self.replaceSkillId or self.activeSkillId

		local status = EnergyChangeStatus.Equal

		status = self.preBuffLayer == buffLayer and EnergyChangeStatus.Equal or buffLayer > self.preBuffLayer and EnergyChangeStatus.Add or EnergyChangeStatus.Reduce

		for i, energyItem in ipairs(self.energyItemList) do
			local animator = energyItem.animator

			if status == EnergyChangeStatus.Add then
				if i <= self.preBuffLayer then
					animator:Play("light", 0, 1)
				elseif i <= buffLayer then
					animator:Play("light_open", 0, 0)
				else
					animator:Play("empty", 0, 1)
				end
			elseif status == EnergyChangeStatus.Reduce then
				if i <= buffLayer then
					animator:Play("light", 0, 1)
				elseif i <= self.preBuffLayer then
					animator:Play("use", 0, 0)
				else
					animator:Play("empty", 0, 1)
				end
			else
				local animAnim = i <= buffLayer and "light" or "empty"

				animator:Play(animAnim, 0, 1)
			end

			gohelper.setActive(energyItem.goCanUse, buffLayer >= EnergyMax)
		end

		self.preBuffLayer = buffLayer
	else
		self.longPressSkillId = self.activeSkillId

		gohelper.setActive(self.goEnergy, false)
	end
end

function FightQteEntityItemHNJ:getBuffLayer()
	local buffDict = self.entityMo:getBuffDic()

	for _, buffMO in pairs(buffDict) do
		if self.buffId == buffMO.buffId then
			return buffMO.layer
		end
	end

	return 0
end

function FightQteEntityItemHNJ:getCostTypeAndCost()
	local skillCo = lua_skill.configDict[self.longPressSkillId]

	if not skillCo then
		return 0, 0
	end

	local costType, cost = FightHelper.getQTESkillCost(skillCo)

	return costType, cost
end

function FightQteEntityItemHNJ:getStage()
	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		return FightQteEntityItemBase.Stage.CantUse
	end

	if self.useType == FightQteEntityItemBase.UseType.QTEUnique then
		return FightQteEntityItemBase.Stage.Special
	end

	local costType, cost = self:getCostTypeAndCost()
	local count = qteInfo:getEnergyCount(costType)

	if count < cost then
		return FightQteEntityItemBase.Stage.CantUse
	end

	local buffLayer = self:getBuffLayer()

	return (buffLayer >= EnergyMax or nil) and (FightQteEntityItemBase.Stage.Special or FightQteEntityItemBase.Stage.CanUse)
end

return FightQteEntityItemHNJ

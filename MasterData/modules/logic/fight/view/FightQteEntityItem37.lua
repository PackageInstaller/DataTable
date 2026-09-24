-- chunkname: @modules/logic/fight/view/FightQteEntityItem37.lua

module("modules.logic.fight.view.FightQteEntityItem37", package.seeall)

local FightQteEntityItem37 = class("FightQteEntityItem37", FightQteEntityItemBase)

function FightQteEntityItem37:init(entityMo, useType)
	FightQteEntityItem37.super.init(self, entityMo, useType)

	self.preBuffLayer = 0
end

function FightQteEntityItem37:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
end

function FightQteEntityItem37:onBuffUpdate(entityId, effectType, buffId)
	if entityId ~= self.entityId then
		return
	end

	local featuresSplit = self.entityMo:getFeaturesSplitInfoByBuffId(buffId)

	if not featuresSplit then
		return
	end

	local targetBuffId = FightEnum.BuffActId.QTECostModify

	for _, oneFeature in ipairs(featuresSplit) do
		if oneFeature[1] == targetBuffId then
			self:refreshUI()

			return
		end
	end
end

function FightQteEntityItem37:initView()
	FightQteEntityItem37.super.initView(self)

	self.goEnergy = gohelper.findChild(self.viewGo, "root/energy")
	self.energyItemList = self:getUserDataTb_()

	for i = 1, 2 do
		local energyItem = self:getUserDataTb_()

		energyItem.goLight = gohelper.findChild(self.goEnergy, string.format("energy_%d", i))
		energyItem.animator = energyItem.goLight:GetComponent(gohelper.Type_Animator)
		energyItem.goCanUse = gohelper.findChild(energyItem.goLight, "#go_canuse")

		table.insert(self.energyItemList, energyItem)
	end
end

function FightQteEntityItem37:refreshUI()
	if not self.loadedDone then
		return
	end

	FightQteEntityItem37.super.refreshUI(self)
	self:refreshEnergy()
end

local EnergyChangeStatus = {
	Reduce = 1,
	Add = 2,
	Equal = 3
}

function FightQteEntityItem37:refreshEnergy()
	if not self.loadedDone then
		return
	end

	if self.useType == FightQteEntityItemBase.UseType.QTEBtn then
		gohelper.setActive(self.goEnergy, true)

		local buffLayer = self:getBuffLayer()
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

			gohelper.setActive(energyItem.goCanUse, i <= buffLayer)
		end

		self.preBuffLayer = buffLayer
	else
		gohelper.setActive(self.goEnergy, false)
	end
end

function FightQteEntityItem37:getCostTypeAndCost()
	local skillCo = lua_skill.configDict[self.activeSkillId]

	if not skillCo then
		return 0, 0
	end

	local costType, cost = FightHelper.getQTESkillCost(skillCo)
	local targetBuffId = FightEnum.BuffActId.QTECostModify
	local buffDict = self.entityMo:getBuffDic()

	for _, buffMO in pairs(buffDict) do
		local buffId = buffMO.buffId
		local featuresSplit = self.entityMo:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == targetBuffId then
					return costType, oneFeature[2]
				end
			end
		end
	end

	return costType, cost
end

function FightQteEntityItem37:getBuffLayer()
	local targetBuffId = FightEnum.BuffActId.QTECostModify
	local buffDict = self.entityMo:getBuffDic()

	for _, buffMO in pairs(buffDict) do
		local buffId = buffMO.buffId
		local featuresSplit = self.entityMo:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == targetBuffId then
					return buffMO.layer
				end
			end
		end
	end

	return 0
end

function FightQteEntityItem37:refreshCanUse()
	if not self.loadedDone then
		return
	end

	local _, cost = self:getCostTypeAndCost()

	gohelper.setActive(self.goCanUse, cost <= 0)
end

function FightQteEntityItem37:getStage()
	local qteInfo = FightDataHelper.qteDataMgr:getQteInfo()

	if not qteInfo then
		return FightQteEntityItemBase.Stage.CantUse
	end

	local costType, cost = self:getCostTypeAndCost()
	local count = qteInfo:getEnergyCount(costType)

	if count < cost then
		return FightQteEntityItemBase.Stage.CantUse
	end

	local buffLayer = self:getBuffLayer()

	return (buffLayer > 0 or nil) and (FightQteEntityItemBase.Stage.Special or FightQteEntityItemBase.Stage.CanUse)
end

return FightQteEntityItem37

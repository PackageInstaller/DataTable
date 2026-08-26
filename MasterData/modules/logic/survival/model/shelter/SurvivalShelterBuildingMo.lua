-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterBuildingMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterBuildingMo", package.seeall)

local SurvivalShelterBuildingMo = pureTable("SurvivalShelterBuildingMo")

function SurvivalShelterBuildingMo:init(data, isUpgrade)
	self.id = data.id
	self.buildingId = data.buildingId
	self.level = data.level
	self.status = data.status
	self.attrs = {}

	for i, v in ipairs(data.attrContainer.values) do
		self.attrs[v.attrId] = v.finalVal
	end

	self:updateHeros(data.heroPos)

	self.npcs = {}

	for i, v in ipairs(data.npcPos) do
		self:addNpc(v.npcId, v.pos)
	end

	self.baseCo = SurvivalConfig.instance:getBuildingConfig(self.buildingId, 1)
	self.isSingleLevel = SurvivalConfig.instance:getBuildingConfig(self.buildingId, 2, true) == nil
	self.shop = self.shop or SurvivalShopMo.New()

	self.shop:init(data.shop)

	self.survivalReputationPropMo = self.survivalReputationPropMo or SurvivalReputationPropMo.New()

	self:setReputationData(data.reputationProp)

	if self:isEqualType(SurvivalEnum.BuildingType.Tech) then
		self.survivalTechShelterMo = self.survivalTechShelterMo or SurvivalTechShelterMo.New()

		self.survivalTechShelterMo:setData(data.insideTechProp)
	end

	if isUpgrade then
		self._lockLevel = nil
	end
end

function SurvivalShelterBuildingMo:setReputationData(reputationProp)
	self.survivalReputationPropMo:setData(reputationProp)
	self:refreshReputationRedDot()
end

function SurvivalShelterBuildingMo:updateHeros(heros)
	self.heros = {}

	for i, v in ipairs(heros) do
		self.heros[v.heroId] = v.pos
	end
end

function SurvivalShelterBuildingMo:batchHeros(heros)
	self.heros = {}

	for i, heroId in ipairs(heros) do
		if heroId ~= 0 then
			self.heros[heroId] = i - 1
		end
	end
end

function SurvivalShelterBuildingMo:isDestoryed()
	return self.status == SurvivalEnum.BuildingStatus.Destroy
end

function SurvivalShelterBuildingMo.sort(a, b)
	return a.buildingId < b.buildingId
end

function SurvivalShelterBuildingMo:isEqualType(type)
	return self.baseCo.type == type
end

function SurvivalShelterBuildingMo:getBuildingType()
	return self.baseCo.type
end

function SurvivalShelterBuildingMo:isBuild()
	return self.level > 0
end

function SurvivalShelterBuildingMo:getNpcByPosition(pos)
	for npcId, v in pairs(self.npcs) do
		if v == pos then
			return npcId
		end
	end
end

function SurvivalShelterBuildingMo:isNpcInBuilding(npcId)
	local pos = self:getNpcPos(npcId)

	return pos ~= nil
end

function SurvivalShelterBuildingMo:getNpcPos(npcId)
	return self.npcs[npcId]
end

function SurvivalShelterBuildingMo:removeNpc(npcId)
	self.npcs[npcId] = nil
end

function SurvivalShelterBuildingMo:addNpc(npcId, pos)
	if pos < 0 then
		return
	end

	self.npcs[npcId] = pos
end

function SurvivalShelterBuildingMo:isHeroInBuilding(heroId)
	local pos = self:getHeroPos(heroId)

	return pos ~= nil
end

function SurvivalShelterBuildingMo:getHeroPos(heroId)
	return self.heros[heroId]
end

function SurvivalShelterBuildingMo:removeHero(heroId)
	self.heros[heroId] = nil
end

function SurvivalShelterBuildingMo:addHero(heroId, pos)
	self.heros[heroId] = pos
end

function SurvivalShelterBuildingMo:getAttr(attrType, curNum)
	if not self.attrs[attrType] then
		local attrVal = 0

		if SurvivalEnum.AttrTypePer[attrType] then
			curNum = curNum or 0
			attrVal = math.floor(curNum * math.max(0, 1 + self.attrs[attrType] / 1000))
		end

		return self.attrs[attrType]
	end
end

function SurvivalShelterBuildingMo:refreshLocalStatus()
	self._localStatus = self:getRealLocalStatus()
end

function SurvivalShelterBuildingMo:getLocalStatus()
	if self._localStatus == nil then
		self:refreshLocalStatus()

		return self._localStatus
	end

	local realStatus = self:getRealLocalStatus()

	if self._localStatus == realStatus then
		return self._localStatus
	end

	if self._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.UnBuild and realStatus == SurvivalEnum.ShelterBuildingLocalStatus.Normal then
		return SurvivalEnum.ShelterBuildingLocalStatus.UnBuildToNormal
	end

	if self._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.Destroy and realStatus == SurvivalEnum.ShelterBuildingLocalStatus.Normal then
		return SurvivalEnum.ShelterBuildingLocalStatus.DestroyToNormal
	end

	if self._localStatus == SurvivalEnum.ShelterBuildingLocalStatus.Normal and realStatus == SurvivalEnum.ShelterBuildingLocalStatus.Destroy then
		return SurvivalEnum.ShelterBuildingLocalStatus.NormalToDestroy
	end

	return SurvivalEnum.ShelterBuildingLocalStatus.Normal
end

function SurvivalShelterBuildingMo:getRealLocalStatus()
	if self:isDestoryed() then
		return SurvivalEnum.ShelterBuildingLocalStatus.Destroy
	end

	if self:isBuild() then
		return SurvivalEnum.ShelterBuildingLocalStatus.Normal
	end

	return SurvivalEnum.ShelterBuildingLocalStatus.UnBuild
end

function SurvivalShelterBuildingMo:lockLevel()
	self._lockLevel = self.level
end

function SurvivalShelterBuildingMo:getLevel()
	return self._lockLevel or self.level
end

function SurvivalShelterBuildingMo:getShop()
	if self:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		return self.survivalReputationPropMo.survivalShopMo
	else
		return self.shop
	end
end

function SurvivalShelterBuildingMo:refreshReputationRedDot()
	if self:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		local redDotNum = self:getReputationShopRedDot()
		local redDotType = SurvivalConfig.instance:getReputationRedDotType(self.buildingId)
		local redDotInfoList = {}

		table.insert(redDotInfoList, {
			id = redDotType,
			value = redDotNum
		})
		RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
	end
end

function SurvivalShelterBuildingMo:getReputationShopRedDot()
	return self.survivalReputationPropMo:haveFreeReward() and 1 or 0
end

return SurvivalShelterBuildingMo

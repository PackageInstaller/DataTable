-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/model/mo/TRBuildingMo.lua

module("logic.extensions.treasureraider.model.mo.TRBuildingMo", package.seeall)

local TRBuildingMo = tableMO()

function TRBuildingMo:ctor()
	self.buildingId = 0
	self.buildingLevel = 0
	self.gridId = nil
	self.startTime = 0
	self.lastProduct = 0
end

function TRBuildingMo:updateLevel(level)
	self.buildingLevel = level
end

function TRBuildingMo:updateByServerData(params)
	self.buildingId = params.cfgId
	self.gridId = params.gridId
	self.buildingLevel = params.level
	self.srcData = params.srcData

	if params.srcData then
		self.form = params.srcData.form
		self.startTime = checknumber(params.srcData.startTime)

		if self.startTime == 0 then
			self.startTime = ServerTime.nowMs() - 1000
		end

		self.lastProduct = checknumber(params.srcData.lastProduct)
	end

	self.buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(self.buildingId)
	self.resourceConfig = checknumber(self.buildingConfig.srcPlanId) > 0 and TreasureRaiderConfig.instance:getResourcePlanConfig(self.buildingConfig.srcPlanId, self.buildingLevel) or nil
end

function TRBuildingMo:updateGridIdOnly(gridId)
	self.gridId = gridId
	self.buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(self.buildingId)
	self.resourceConfig = checknumber(self.buildingConfig.srcPlanId) > 0 and TreasureRaiderConfig.instance:getResourcePlanConfig(self.buildingConfig.srcPlanId, self.buildingLevel) or nil
end

function TRBuildingMo:clone()
	local mo = TRBuildingMo.New()

	mo.buildingId = self.buildingId
	mo.gridId = self.gridId
	mo.buildingLevel = self.buildingLevel
	mo.startTime = self.startTime
	mo.lastProduct = self.lastProduct
	mo.__originMo = self
	mo.buildingConfig = self.buildingConfig
	mo.resourceConfig = self.resourceConfig

	return mo
end

function TRBuildingMo:getBuildingScenePrefabPath()
	return self.buildingConfig.scenePrefabPath
end

function TRBuildingMo:getBuildingViewPath()
	return self.buildingConfig.viewPath
end

function TRBuildingMo:isNeedShowLevel()
	return self.buildingConfig.type ~= TreasureRaiderConst.BuildingType_Effect
end

function TRBuildingMo:getResourceStartTime()
	return self.startTime
end

function TRBuildingMo:isStopProduce()
	return checknumber(self.startTime) > ServerTime.nowMs()
end

function TRBuildingMo:getProduceCount(nowMs)
	if nowMs == nil then
		nowMs = ServerTime.nowMs()
	end

	if nowMs < checknumber(self.startTime) then
		return checknumber(self.lastProduct)
	end

	if not self.resourceConfig then
		return checknumber(self.lastProduct)
	end

	local minute = math.floor((nowMs - checknumber(self.startTime)) / 60000)

	if self.resourceConfig.maxProduct ~= nil then
		minute = math.min(minute, self.resourceConfig.maxProduct)
	end

	if self._startResourceMinute == nil then
		self._startResourceMinute = TreasureRaiderConfig.instance:getCommonValue("StartResourceMinute", true)
	end

	if minute < self._startResourceMinute then
		minute = 0
	end

	local perTenMinute = math.floor(minute / 10)

	return math.floor(self.lastProduct + perTenMinute * self.resourceConfig.product)
end

function TRBuildingMo:getRobProduceRange(isRevenge, attackAddition, opMainCampLevel)
	attackAddition = checknumber(attackAddition) / 10000

	local activityConfig = TreasureRaiderConfig.instance:getActivityConfig()
	local revengeAddition = checknumber(activityConfig.revengeAddition) / 10000
	local mainCampConfig = TreasureRaiderConfig.instance:getMainCampConfig(opMainCampLevel)
	local mainCampAddition = checknumber(mainCampConfig.srcAddition) / 10000
	local attackFactor = self.resourceConfig.attackFactor
	local produceCount = self:getProduceCount()
	local minProduce = checknumber(self.resourceConfig.attackMinGain)
	local maxProduce = math.max(minProduce, produceCount * attackFactor * (1 + mainCampAddition))

	if isRevenge then
		minProduce = minProduce * (1 + revengeAddition)
		maxProduce = maxProduce * (1 + revengeAddition)
	else
		minProduce = minProduce * (1 + attackAddition)
		maxProduce = maxProduce * (1 + attackAddition)
	end

	return math.floor(minProduce), math.floor(maxProduce)
end

function TRBuildingMo:getProduceRateOneHour()
	return (self.resourceConfig or nil) and (self.resourceConfig.product * 6 or 0)
end

function TRBuildingMo:getProduceItemKey()
	return self.buildingConfig.itemKey
end

function TRBuildingMo:hasProduceRate()
	return self.buildingConfig.srcPlanId > 0
end

return TRBuildingMo

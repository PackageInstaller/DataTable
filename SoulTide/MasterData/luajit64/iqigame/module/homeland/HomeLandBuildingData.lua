-- chunkname: @IQIGame\\Module\\HomeLand\\HomeLandBuildingData.lua

HomeLandBuildingData = {}

local HomeLandPlantData = require("IQIGame.Module.HomeLand.HomeLandPlantData")

function HomeLandBuildingData.New()
	local o = Clone(HomeLandBuildingData)

	return o
end

function HomeLandBuildingData:Init(buildingPOD)
	self.cfgBuildingID = buildingPOD.cid
	self.cfgBuilding = CfgHomeLandBuildingTable[self.cfgBuildingID]
	self.buildingPOD = buildingPOD
	self.plantDataTab = {}

	for i, v in pairs(self.buildingPOD.lands) do
		local plantData = HomeLandPlantData.New()

		plantData:Init(self.buildingPOD.cid, v)
		table.insert(self.plantDataTab, plantData)
	end

	table.sort(self.plantDataTab, function(a, b)
		return a.plantCid < b.plantCid
	end)

	if self.buildingPOD.officePOD ~= nil then
		if self.workData == nil then
			self.workData = HLWorkData.New()
		end

		self.workData:Initialize(self.buildingPOD.officePOD)
	end
end

function HomeLandBuildingData:GetBuildingLvAndMaxLv()
	local lv = self.buildingPOD.lv
	local maxLv = 0

	for i, v in pairsCfg(CfgHomeLandBuildingLevelUpTable) do
		if v.BuildingId == self.cfgBuildingID then
			maxLv = maxLv + 1
		end
	end

	return lv, maxLv
end

function HomeLandBuildingData:GetCfgBuildLevelUpByLv(lv)
	local getLv = lv
	local curLv, maxLv = self:GetBuildingLvAndMaxLv()

	if maxLv < getLv then
		getLv = maxLv
	end

	for i, v in pairsCfg(CfgHomeLandBuildingLevelUpTable) do
		if v.BuildingId == self.cfgBuildingID and v.Level == getLv then
			return v
		end
	end

	return nil
end

function HomeLandBuildingData:GetPlantData(plantGridID)
	for i, v in pairs(self.plantDataTab) do
		if v.plantCid == plantGridID then
			return v
		end
	end

	return nil
end

function HomeLandBuildingData:GetPlantDataByDecorateCid(decorateCid)
	for i, v in pairs(self.plantDataTab) do
		if v.decorateCid == decorateCid then
			return v
		end
	end

	return nil
end

function HomeLandBuildingData:GetHelpTimes()
	local number = #self.buildingPOD.helpLogs
	local maxNum = self.cfgBuilding.CanHelpTimes[1]

	if maxNum == nil then
		maxNum = 0
	end

	return number, maxNum
end

function HomeLandBuildingData:IsWorking(decorateDid)
	if self.cfgBuildingID == Constant.HomelandBuildType.BuildGold then
		return true
	else
		if self.buildingPOD.officePOD then
			local result = self.workData:IsWorking()

			if result then
				return true
			end
		end

		if self.plantDataTab then
			for i, v in pairs(self.plantDataTab) do
				if v.decorateCid == decorateDid and (v.landPOD.status == 2 or v.landPOD.status == 3 or v.landPOD.status == 4) then
					return true
				end
			end
		end

		if self.buildingPOD.kitchenPOD then
			for i, v in pairs(self.buildingPOD.kitchenPOD.culinarys) do
				if v.status == 1 then
					return true
				end
			end
		end

		if self.buildingPOD.manufacture then
			for i, v in pairs(self.buildingPOD.manufacture.makes) do
				if v.status == 1 then
					return true
				end
			end
		end
	end

	return false
end

function HomeLandBuildingData:GetRewardPlants()
	local decTab = {}

	if self.plantDataTab then
		for i, v in pairs(self.plantDataTab) do
			if v.landPOD.status == 5 then
				table.insert(decTab, v.decorateCid)
			end
		end
	end

	return decTab
end

function HomeLandBuildingData:IsGetReward(decorateCid)
	if self.cfgBuildingID == Constant.HomelandBuildType.BuildGold then
		local value = CfgDiscreteDataTable[6520020].Data[1] / 100
		local outNum = 0

		for i, v in pairs(self.buildingPOD.productionData.output) do
			outNum = outNum + v
		end

		return outNum >= self.buildingPOD.productionData.storageLimit * value
	else
		if self.buildingPOD.officePOD then
			local result = self.workData:IsGetReward()

			if result then
				return true
			end
		end

		if self.plantDataTab then
			for i, v in pairs(self.plantDataTab) do
				if decorateCid ~= nil then
					if v.landPOD.status == 5 and decorateCid == v.decorateCid then
						return true
					end
				elseif v.landPOD.status == 5 then
					return true
				end
			end
		end

		if self.buildingPOD.kitchenPOD then
			for i, v in pairs(self.buildingPOD.kitchenPOD.culinarys) do
				if v.status == 2 then
					return true
				end
			end
		end

		if self.buildingPOD.manufacture then
			for i, v in pairs(self.buildingPOD.manufacture.makes) do
				if v.status and v.status == 2 then
					return true
				end
			end
		end
	end

	return false
end

function HomeLandBuildingData:IsEmptyQueue()
	if self.cfgBuildingID == Constant.HomelandBuildType.BuildPlant and self.plantDataTab then
		for i, v in pairs(self.plantDataTab) do
			if v.landPOD.status ~= 1 then
				return false
			end
		end

		return false
	end

	if self.cfgBuildingID == Constant.HomelandBuildType.BuildCooking and self.buildingPOD.kitchenPOD then
		for i, v in pairs(self.buildingPOD.kitchenPOD.culinarys) do
			if v.status >= 0 then
				return false
			end
		end

		return true
	end

	if self.cfgBuildingID == Constant.HomelandBuildType.BuildManufacture and self.buildingPOD.manufacture then
		for i, v in pairs(self.buildingPOD.manufacture.makes) do
			if v.status >= 0 then
				return false
			end
		end

		return true
	end

	if self.cfgBuildingID == Constant.HomelandBuildType.BuildWork and self.buildingPOD.officePOD then
		for i, v in pairs(self.buildingPOD.officePOD.affairs) do
			if v.status == 0 then
				return true
			end
		end

		return false
	end

	return false
end

function HomeLandBuildingData:GetBuildingPlantMsg()
	local HomeLandPlantData
	local maxCD = 0
	local workingPlantNum = 0

	for i, v in pairs(self.plantDataTab) do
		if v.landPOD.status ~= Constant.HomelandPlantType.landStatusIdle then
			if v.landPOD.status ~= Constant.HomelandPlantType.landStatusMature then
				local cd = v.landPOD.finishTime - PlayerModule.GetServerTime()

				if maxCD < cd then
					maxCD = cd
					HomeLandPlantData = v
				end
			end

			workingPlantNum = workingPlantNum + 1
		end
	end

	return HomeLandPlantData, maxCD, workingPlantNum
end

return HomeLandBuildingData

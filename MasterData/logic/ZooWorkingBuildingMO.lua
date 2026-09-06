-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooWorkingBuildingMO.lua

module("logic.extensions.zoo.model.building.ZooWorkingBuildingMO", package.seeall)

local ZooWorkingBuildingMO = class("ZooWorkingBuildingMO", ZooBuildingMO)

function ZooWorkingBuildingMO:ctor()
	ZooWorkingBuildingMO.super.ctor(self)

	self.currScore = 0
	self.currWorkerNum = 0
	self.refreshTime = 0
	self.workAnimalIds = nil
end

function ZooWorkingBuildingMO:isScoreMax()
	return self:getCurrScore() >= self:getMaxScore()
end

function ZooWorkingBuildingMO:getCurrScore()
	local now = (ServerTime.now() - self.refreshTime) / 60
	local speedRate = self:getCurrRate()

	return self.currScore + math.floor(now * speedRate)
end

function ZooWorkingBuildingMO:getCurrScoreSpeed()
	local speedRate = self:getCurrRate()

	return math.floor(speedRate * 60)
end

function ZooWorkingBuildingMO:getAnimalBenefit(animalId)
	local animalMO = self.zooMo:getAnimalById(animalId)

	if animalMO then
		local cfg = ZooConfig.instance:getWorkGeneById(animalMO.workGene)
		local animalLvCo = ZooConfig.instance:getAnimalLevelById(animalMO.level)

		return animalLvCo.levelRateFactor * ((cfg or nil) and (cfg[self:getWorkGeneBenefitKey()] or 0) / 100)
	end

	return 0
end

function ZooWorkingBuildingMO:getCurrRate()
	local speedRate = 0

	if self.workAnimalIds then
		for i = 1, #self.workAnimalIds do
			if self.workAnimalIds[i] > 0 then
				local workGeneRate = self:getAnimalBenefit(self.workAnimalIds[i])

				speedRate = speedRate + workGeneRate
			end
		end
	end

	return speedRate * self:getRateFactor() / 10000
end

function ZooWorkingBuildingMO:getWorkGeneBenefitKey()
	return ""
end

function ZooWorkingBuildingMO:getMaxScore()
	return 0
end

function ZooWorkingBuildingMO:getRateFactor()
	return 0
end

function ZooWorkingBuildingMO:_onClickGet()
	ZooController.instance:gainWorkBuildingProduction(self:getBuildingId())
end

return ZooWorkingBuildingMO

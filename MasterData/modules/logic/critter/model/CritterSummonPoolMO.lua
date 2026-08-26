-- chunkname: @modules/logic/critter/model/CritterSummonPoolMO.lua

module("modules.logic.critter.model.CritterSummonPoolMO", package.seeall)

local CritterSummonPoolMO = pureTable("CritterSummonPoolMO")

function CritterSummonPoolMO:init(rare, id, count, hasSummonCount)
	self.rare = rare
	self.uid = "0"
	self.critterId = id
	self.count = count
	self.poolCount = count - hasSummonCount
	self.co = CritterConfig.instance:getCritterCfg(id)

	self:initCritterMo()
end

function CritterSummonPoolMO:initCritterMo()
	self.critterMo = CritterMO.New()

	local efficiency = 0
	local patience = 0
	local lucky = 0
	local efficiencyIncrRate = 0
	local patienceIncrRate = 0
	local luckyIncrRate = 0
	local skillInfo = {}

	if self.co then
		if not string.nilorempty(self.co.baseAttribute) then
			local values = GameUtil.splitString2(self.co.baseAttribute, true)

			efficiency = values[1][2] or 0
			patience = values[2][2] or 0
			lucky = values[3][2] or 0
		end

		if not string.nilorempty(self.co.baseAttribute) then
			local rates = GameUtil.splitString2(self.co.attributeIncrRate, true)

			efficiencyIncrRate = rates[1][2] or 0
			patienceIncrRate = rates[2][2] or 0
			luckyIncrRate = rates[3][2] or 0
		end

		skillInfo = {
			tags = {
				self.co.raceTag
			}
		}
	end

	local info = {
		specialSkin = false,
		id = self.uid,
		uid = self.uid,
		defineId = self.critterId,
		efficiency = efficiency,
		patience = patience,
		lucky = lucky,
		efficiencyIncrRate = efficiencyIncrRate,
		patienceIncrRate = patienceIncrRate,
		luckyIncrRate = luckyIncrRate,
		tagAttributeRates = {},
		skillInfo = skillInfo
	}

	self.critterMo:init(info)
end

function CritterSummonPoolMO:getCritterMo()
	return self.critterMo
end

function CritterSummonPoolMO:onRefreshPoolCount(hasSummonCount)
	self.poolCount = self.count - hasSummonCount
end

function CritterSummonPoolMO:getPoolCount()
	return self.poolCount
end

function CritterSummonPoolMO:isFullPool()
	return self.count == self.poolCount
end

return CritterSummonPoolMO

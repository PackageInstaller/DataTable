-- chunkname: @modules/logic/fight/model/data/FightQTEInfoData.lua

module("modules.logic.fight.model.data.FightQTEInfoData", package.seeall)

local FightQTEInfoData = FightDataClass("FightQTEInfoData")

function FightQTEInfoData:onConstructor(proto)
	if proto then
		self.max = proto.max or 0
	end

	self.energies = {}

	if proto and proto.type then
		for _, energyType in ipairs(proto.type) do
			table.insert(self.energies, energyType)
		end
	end

	if proto then
		self.threshold = proto.threshold or 0
	end

	if proto then
		self.status = proto.status or FightEnum.QTEStage.QTE_FIRST
	end

	self.realMax = proto and proto.realMax
end

function FightQTEInfoData:changeMax(max)
	self.max = max
end

function FightQTEInfoData:updateByInfo(info)
	if not info then
		logError("update qte info fail")

		return
	end

	self.max = info.max

	tabletool.clear(self.energies)

	for _, energyType in ipairs(info.energies) do
		table.insert(self.energies, energyType)
	end

	self.threshold = info.threshold or 0
	self.status = info.status or FightEnum.QTEStage.Normal
	self.realMax = info.realMax
end

function FightQTEInfoData:checkUnlock()
	return false
end

function FightQTEInfoData:getEnergyList()
	return self.energies
end

function FightQTEInfoData:getEnergyCount(energyType)
	local count = 0

	for _, type in ipairs(self.energies) do
		if energyType == type then
			count = count + 1
		end
	end

	return count
end

function FightQTEInfoData:getCurEnergy()
	return #self.energies
end

function FightQTEInfoData:getMaxEnergy()
	return self.max
end

function FightQTEInfoData:getStatus()
	return self.status
end

function FightQTEInfoData:getRealMax()
	return self.realMax
end

function FightQTEInfoData:getThreshold()
	return self.threshold
end

return FightQTEInfoData

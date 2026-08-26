-- chunkname: @modules/logic/versionactivity2_4/pinball/model/PinballBuildingMo.lua

module("modules.logic.versionactivity2_4.pinball.model.PinballBuildingMo", package.seeall)

local PinballBuildingMo = pureTable("PinballBuildingMo")

function PinballBuildingMo:init(data)
	self.configId = data.configId
	self.level = data.level
	self.index = data.index
	self.food = data.food
	self.interact = data.interact

	self:refreshCo()
end

function PinballBuildingMo:refreshCo()
	local coList = lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][self.configId]

	if not coList then
		logError("没有建筑配置" .. tostring(self.configId))

		return
	end

	self.co = coList[self.level]
	self.baseCo = coList[1]
	self.nextCo = coList[self.level + 1]
	self._foodCost = 0
	self._playDemand = 0

	if self.co then
		local effectDict = GameUtil.splitString2(self.co.effect, true) or {}

		for _, arr in pairs(effectDict) do
			if arr[1] == PinballEnum.BuildingEffectType.CostFood then
				self._foodCost = self._foodCost + arr[2]
			elseif arr[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				self._playDemand = self._playDemand + arr[2]
			end
		end
	end
end

function PinballBuildingMo:upgrade()
	self.level = self.level + 1

	self:refreshCo()
end

function PinballBuildingMo:isMainCity()
	return self.co.type == PinballEnum.BuildingType.MainCity
end

function PinballBuildingMo:isTalent()
	return self.co.type == PinballEnum.BuildingType.Talent
end

function PinballBuildingMo:getFoodCost()
	return self._foodCost
end

function PinballBuildingMo:getPlayDemand()
	return self._playDemand
end

return PinballBuildingMo

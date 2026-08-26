-- chunkname: @modules/logic/explore/model/mo/unit/ExploreSpikeUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreSpikeUnitMO", package.seeall)

local ExploreSpikeUnitMO = pureTable("ExploreSpikeUnitMO", ExploreBaseUnitMO)

function ExploreSpikeUnitMO:initTypeData()
	local arr = string.split(self.specialDatas[1], "#")
	local intervalInfos = string.split(self.specialDatas[2], "#")

	self.intervalTime = tonumber(intervalInfos[1])
	self.keepTime = tonumber(intervalInfos[2])
	self.playAudio = tonumber(intervalInfos[3]) == 1
	self.enterTriggerType = true
	self.heroDir = tonumber(arr[3]) or 0
	self.triggerEffects = tabletool.copy(self.triggerEffects)

	local data = {
		ExploreEnum.TriggerEvent.Spike
	}

	table.insert(self.triggerEffects, data)
end

function ExploreSpikeUnitMO:getUnitClass()
	return ExploreSpikeUnit
end

return ExploreSpikeUnitMO

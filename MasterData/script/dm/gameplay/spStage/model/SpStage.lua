-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/model/SpStage.lua

require("dm.gameplay.spStage.model.SpStagePoint")

SpStage = class("SpStage", objectlua.Object, _M)

SpStage:has("_stageList", {
	is = "rw"
})
SpStage:has("_stageMap", {
	is = "rw"
})
SpStage:has("_config", {
	is = "rw"
})

local spStageIds = ConfigReader:getRecordById("ConfigValue", "StageSp_List").content

function SpStage:initialize()
	super.initialize(self)

	self._stageList = {}
	self._stageMap = {}
	self._config = ConfigReader:getDataTable("BlockSp")

	if spStageIds then
		for k, v in pairs(spStageIds) do
			local stage = SpStagePoint:new(v)

			self._stageList[#self._stageList + 1] = stage
			self._stageMap[v] = stage
		end
	end

	table.sort(self._stageList, function(a, b)
		return a:getIndex() < b:getIndex()
	end)
end

function SpStage:synchronize(data)
	if data then
		for k, v in pairs(data) do
			if not self._stageMap[spStageIds[k]] then
				local stage = SpStagePoint:new(v.stageId)

				stage:synchronize(v)

				self._stageMap[spStageIds[k]] = stage
			else
				local stage = self._stageMap[spStageIds[k]]

				stage:synchronize(v)
			end
		end
	end
end

function SpStage:synchronizeBestReport(stageType, data)
	if data then
		for k, v in pairs(data) do
			local stage = self._stageMap[spStageIds[stageType]]

			stage:synchronizeBestReport(k, v)
		end
	end
end

function SpStage:resetLeaveTimes(stageType, value)
	if not spStageIds then
		return
	end

	local stageId = spStageIds[stageType]

	self._stageMap[stageId]:setChallengeTime(value)
end

function SpStage:getStageConfigList()
	local stageInfo = {}

	for k, v in pairs(self._config) do
		stageInfo[v.Index] = v
	end

	return stageInfo
end

function SpStage:getStageById(id)
	return self._stageMap[id]
end

function SpStage:getStageByIndex(index)
	return self._stageList[index]
end

function SpStage:getShowReward()
	return self._config.ShowReward
end

function SpStage:getStageByType(stageType)
	stageType = string.lower(stageType)

	return self._stageMap[spStageIds[stageType]]
end

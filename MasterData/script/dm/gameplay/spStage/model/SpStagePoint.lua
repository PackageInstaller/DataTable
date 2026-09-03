-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/spStage/model/SpStagePoint.lua

SpStagePoint = class("SpStagePoint", objectlua.Object, _M)

SpStagePoint:has("_challengeTime", {
	is = "rw"
})
SpStagePoint:has("_receivedRewards", {
	is = "rw"
})
SpStagePoint:has("_preTotalProgressCount", {
	is = "rw"
})
SpStagePoint:has("_totalProgressCount", {
	is = "rw"
})
SpStagePoint:has("_pointInfo", {
	is = "rw"
})
SpStagePoint:has("_buffs", {
	is = "rw"
})
SpStagePoint:has("_id", {
	is = "rw"
})
SpStagePoint:has("_config", {
	is = "rw"
})
SpStagePoint:has("_extraRewardTime", {
	is = "rw"
})

function SpStagePoint:initialize(id)
	super.initialize(self)

	self._id = id
	self._challengeTime = 2
	self._receivedRewards = {}
	self._totalProgressCount = 0
	self._preTotalProgressCount = 0
	self._pointInfo = {}
	self._buffs = {}
	self._config = ConfigReader:requireRecordById("BlockSp", id)
	self._extraRewardTime = nil
end

function SpStagePoint:dispose()
	super.dispose(self)
end

function SpStagePoint:synchronize(data)
	if data.challengeTime then
		self._challengeTime = data.challengeTime.value
	end

	if data.totalProgressCount then
		self._preTotalProgressCount = self._totalProgressCount
		self._totalProgressCount = data.totalProgressCount
	end

	if data.pointInfos then
		for k, v in pairs(data.pointInfos) do
			self._pointInfo[k] = v
		end
	end

	self:synchronizeRewards(data.receivedRewards)

	if data.buffs then
		self._buffs = data.buffs
	end

	if data.extraRewardTime then
		self._extraRewardTime = self._extraRewardTime or {}

		for i, v in pairs(data.extraRewardTime) do
			self._extraRewardTime[i] = v
		end
	end
end

function SpStagePoint:synchronizeBestReport(id, data)
	if self._pointInfo[id] then
		if data.passCombat then
			self._pointInfo[id].bestPlayerCombat = data.passCombat
		end

		if data.nickname then
			self._pointInfo[id].bestPlayerNickname = data.nickname
		end
	end
end

function SpStagePoint:synchronizeRewards(rewards)
	if rewards then
		for k, v in pairs(rewards) do
			self._receivedRewards[k + 1] = v
		end
	end
end

function SpStagePoint:getIndex()
	return self._config.Index
end

function SpStagePoint:getPointInfoById(id)
	return self._pointInfo[id]
end

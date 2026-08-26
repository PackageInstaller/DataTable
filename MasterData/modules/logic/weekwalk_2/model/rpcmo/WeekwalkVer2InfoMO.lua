-- chunkname: @modules/logic/weekwalk_2/model/rpcmo/WeekwalkVer2InfoMO.lua

module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2InfoMO", package.seeall)

local WeekwalkVer2InfoMO = pureTable("WeekwalkVer2InfoMO")

function WeekwalkVer2InfoMO:init(info)
	self.timeId = info.timeId
	self.startTime = info.startTime / 1000
	self.endTime = info.endTime / 1000
	self.popRule = info.popRule
	self.layerInfos = GameUtil.rpcInfosToMap(info.layerInfos, WeekwalkVer2LayerInfoMO)
	self.prevSettle = nil

	if info:HasField("prevSettle") then
		self.prevSettle = WeekwalkVer2PrevSettleInfoMO.New()

		self.prevSettle:init(info.prevSettle)
	end

	self.isPopSettle = self.prevSettle and self.prevSettle.show
	self.snapshotInfos = GameUtil.rpcInfosToMap(info.snapshotInfos or {}, WeekwalkVer2SnapshotInfoMO, "no")
	self._layerInfosMap = {}

	for k, v in pairs(self.layerInfos) do
		self._layerInfosMap[v:getLayer()] = v
	end

	local config = lua_weekwalk_ver2_time.configDict[self.timeId]

	self.issueId = config and config.issueId

	if not self.issueId then
		logError("WeekwalkVer2InfoMO weekwalk_ver2_time configDict not find timeId:" .. tostring(self.timeId))
	end
end

function WeekwalkVer2InfoMO:getOptionSkills()
	if self._skillList and self._skillList._timeId == self.timeId then
		return self._skillList
	end

	local timeConfig = lua_weekwalk_ver2_time.configDict[self.timeId]

	self._skillList = string.splitToNumber(timeConfig.optionalSkills, "#")
	self._skillList._timeId = self.timeId

	return self._skillList
end

function WeekwalkVer2InfoMO:getHeroGroupSkill(index)
	local snapshotInfo = self.snapshotInfos[index]

	return snapshotInfo and snapshotInfo:getChooseSkillId()
end

function WeekwalkVer2InfoMO:setHeroGroupSkill(index, skillIds)
	local snapshotInfo = self.snapshotInfos[index]

	if not snapshotInfo then
		snapshotInfo = WeekwalkVer2SnapshotInfoMO.New()
		snapshotInfo.no = index
		self.snapshotInfos[index] = snapshotInfo
	end

	snapshotInfo:setChooseSkillId(skillIds)
end

function WeekwalkVer2InfoMO:isOpen()
	local time = ServerTime.now()

	return time >= self.startTime and time <= self.endTime
end

function WeekwalkVer2InfoMO:allLayerPass()
	for k, v in pairs(self.layerInfos) do
		if not v.allPass then
			return false
		end
	end

	return true
end

function WeekwalkVer2InfoMO:setLayerInfo(layerInfo)
	local info = self.layerInfos[layerInfo.id]

	info:init(layerInfo)
end

function WeekwalkVer2InfoMO:getLayerInfo(id)
	return self.layerInfos[id]
end

function WeekwalkVer2InfoMO:getLayerInfoByLayerIndex(index)
	return self._layerInfosMap[index]
end

function WeekwalkVer2InfoMO:getNotFinishedMap()
	for i = WeekWalk_2Enum.MaxLayer, 1, -1 do
		local layerInfo = self._layerInfosMap[i]

		if layerInfo and layerInfo.unlock then
			return layerInfo, i
		end
	end
end

return WeekwalkVer2InfoMO

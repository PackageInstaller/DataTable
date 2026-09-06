-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timegate/config/TimeGateConfig.lua

module("logic.extensions.timegate.config.TimeGateConfig", package.seeall)

local TimeGateConfig = class("TimeGateConfig", BaseConfig)

function TimeGateConfig:getNames()
	return {
		"time_gate_type",
		"time_gate",
		"time_gate_tab",
		"time_gate_sub_tab",
		"time_gate_common"
	}
end

function TimeGateConfig:handleConfig(name, content)
	if name == "time_gate_type" then
		self._time_gate_type = content
	elseif name == "time_gate" then
		self._time_gate = content
	elseif name == "time_gate_tab" then
		self._time_gate_tab = content
	elseif name == "time_gate_sub_tab" then
		self._time_gate_sub_tab = content
	elseif name == "time_gate_common" then
		self._time_gate_common = content
	end
end

function TimeGateConfig:_handleTimeGateType(content)
	self._gateTypeDic = {}

	for typeId, cfg in ipairs(content.dataList) do
		self._gateTypeDic[typeId] = self._gateTypeDic[typeId] or {}

		local count = #cfg.refreshDays

		for i, startDay in ipairs(cfg.refreshDays) do
			self._gateTypeDic[typeId][startDay] = i == count and cfg.refreshDays[1] or cfg.refreshDays[i + 1]
		end
	end
end

function TimeGateConfig:getStartDayAndEndDay(typeId, curDay, hour)
	local dic = self._gateTypeDic[typeId]
	local cfg = self:getTypeCfg(typeId)
	local startDay = 0
	local endDay = 0
	local monthOffset = 0
	local count = #cfg.refreshDays

	for i = count, 1, -1 do
		local day = cfg.refreshDays[i]
		local curRealDay = hour >= 5 and curDay or curDay - 1

		if day <= curRealDay then
			startDay = day

			if i == count then
				monthOffset = 1
			end

			break
		end
	end

	if startDay > 0 then
		endDay = dic[startDay] or endDay
	else
		startDay = cfg.refreshDays[#cfg.refreshDays]
		endDay = cfg.refreshDays[1]
		monthOffset = -1
	end

	return startDay, endDay, monthOffset
end

function TimeGateConfig:getTypeCfg(typeId)
	return self._time_gate_type[typeId]
end

function TimeGateConfig:getRegressExtraTimes(typeId)
	local cfg = self:getTypeCfg(typeId)

	return checknumber(cfg.regressExtraTimes)
end

function TimeGateConfig:getRegressExtraTimesDurationWeeks()
	return checknumber(self._time_gate_common.REGRESS_EXTRA_TIMES_DURATION_WEEKS.value)
end

function TimeGateConfig:getPowerLimitYuanqi()
	return checknumber(self._time_gate_common.POWER_LIMIT_YUANQI.value)
end

function TimeGateConfig:getPowerLimitShenyao()
	return checknumber(self._time_gate_common.POWER_LIMIT_SHENYAO.value)
end

function TimeGateConfig:getTypeCfgList(typeId)
	return self._time_gate[typeId]
end

function TimeGateConfig:getTypeCfgSortList(typeId)
	local list = {}
	local curTimestamp = ServerTime.now()

	for raceId, v in pairs(self._time_gate[typeId]) do
		local openTimestamp = GameUtil.string2time(v[1].openTime)
		local isOpen = openTimestamp <= curTimestamp

		if isOpen then
			for i, cfg in ipairs(v) do
				if not string.nilorempty(cfg.endTime) then
					local endTimestamp = GameUtil.string2time(cfg.endTime)

					if endTimestamp <= curTimestamp then
						isOpen = false

						break
					end
				end
			end
		end

		if isOpen then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		if a[1] and b[1] then
			return a[1].sortIndex < b[1].sortIndex
		else
			return true
		end
	end)

	return list
end

function TimeGateConfig:getTypePetCfgList(typeId, raceId)
	return self._time_gate[typeId] and self._time_gate[typeId][raceId]
end

function TimeGateConfig:getRaceIdByActivityId(activityId)
	activityId = checknumber(activityId)

	for i, v in ipairs(self._time_gate.dataList) do
		if not string.nilorempty(v.challengeParam) then
			local list = string.split(v.challengeParam, "_")

			if list[2] then
				local actId = checknumber(list[2])

				if actId == activityId then
					return v.raceId
				end
			end
		end
	end

	return 0
end

function TimeGateConfig:getCfgByActivityId(activityId)
	activityId = checknumber(activityId)

	for i, v in ipairs(self._time_gate.dataList) do
		if not string.nilorempty(v.challengeParam) then
			local list = string.split(v.challengeParam, "_")

			if list[2] then
				local actId = checknumber(list[2])

				if actId == activityId then
					return v
				end
			end
		end
	end

	return nil
end

function TimeGateConfig:getRaceIdByChallengeId(challengeId)
	challengeId = checknumber(challengeId)

	for i, v in ipairs(self._time_gate.dataList) do
		if not string.nilorempty(v.challengeParam) then
			local cfgId = checknumber(v.challengeParam)

			if challengeId == cfgId then
				return v.raceId
			end
		end
	end

	return nil
end

function TimeGateConfig:getCfgByChallengeId(challengeId)
	challengeId = checknumber(challengeId)

	for i, v in ipairs(self._time_gate.dataList) do
		if not string.nilorempty(v.challengeParam) then
			local cfgId = checknumber(v.challengeParam)

			if challengeId == cfgId then
				return v
			end
		end
	end

	return nil
end

function TimeGateConfig:getPreviewList(time)
	local list = {}

	for i, v in ipairs(self._time_gate.dataList) do
		if v.preview == 1 and v.id == 1 then
			local startTime = GameUtil.string2time(v.openTime)

			if time < startTime then
				table.insert(list, v)
			end
		end
	end

	return list
end

function TimeGateConfig:getTabCfgs()
	return self._time_gate_tab.dataList
end

function TimeGateConfig:getTabCfg(type, tabId)
	local tabCfgs = self:getTabCfgs()

	for i, cfg in ipairs(tabCfgs) do
		if cfg.type == type and cfg.tabId == tabId then
			return cfg
		end
	end

	return nil
end

function TimeGateConfig:getSubTabCfgs()
	return self._time_gate_sub_tab.dataList
end

TimeGateConfig.instance = TimeGateConfig.New()

return TimeGateConfig

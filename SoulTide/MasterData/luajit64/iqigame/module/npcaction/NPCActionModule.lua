-- chunkname: @IQIGame\\Module\\NPCAction\\NPCActionModule.lua

NPCActionModule = {}

function NPCActionModule.GetAction(groupId, playerLv, triggerType, triggerParam)
	local weightCfgDatas = {}
	local totalWeight = 0

	for i, v in pairsCfg(CfgNPCActionTable) do
		if v.GroupId == groupId and playerLv >= v.ChurchLevelId[1] and playerLv <= v.ChurchLevelId[2] and triggerType == v.TriggerType then
			if triggerType == Constant.NPCTriggerType.OpenUI then
				local times = string.split(v.TriggerParam, "|")
				local timeStart = tonumber(times[1])
				local timeEnd = tonumber(times[2])
				local timeCur = tonumber(triggerParam)

				if timeStart <= timeCur and timeCur < timeEnd then
					return v
				end
			elseif triggerType == Constant.NPCTriggerType.Standby then
				weightCfgDatas[#weightCfgDatas + 1] = v
				totalWeight = totalWeight + tonumber(v.TriggerParam)
			elseif triggerParam == tonumber(v.TriggerParam) then
				return v
			end
		end
	end

	local compareWeight = math.random(1, totalWeight)
	local curTotal = 0

	for i, v in pairs(weightCfgDatas) do
		curTotal = curTotal + tonumber(v.TriggerParam)

		if compareWeight <= curTotal then
			return v
		end
	end

	return nil
end

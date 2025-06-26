-- chunkname: @IQIGame\\Module\\Common\\NpcTalk\\NpcActionModule.lua

NpcActionModule = {}

function NpcActionModule.Initialize()
	return
end

function NpcActionModule.GetAction(groupId, playerLv, triggerType, triggerParam)
	local weightCfgDatas = {}
	local totalWeight = 0

	for i, v in pairsCfg(CfgNpcUiActionTable) do
		if v.GroupId == groupId and triggerType == v.TriggerType then
			if triggerType == Constant.NPCTriggerType.OpenUI then
				local times = string.split(v.TriggerParam, "|")
				local timeStart = tonumber(times[1])
				local timeEnd = tonumber(times[2])
				local timeCur = tonumber(triggerParam)

				if timeStart <= timeCur and timeCur < timeEnd then
					weightCfgDatas[#weightCfgDatas + 1] = v
					totalWeight = totalWeight + tonumber(times[3])
				end
			elseif triggerType == Constant.NPCTriggerType.Standby then
				return v
			elseif triggerType == Constant.NPCTriggerType.BuyOnShop then
				return v
			elseif triggerParam == tonumber(v.TriggerParam) then
				return v
			end
		end
	end

	local compareWeight = math.random(1, totalWeight)
	local curTotal = 0

	for i, v in pairs(weightCfgDatas) do
		local times = string.split(v.TriggerParam, "|")

		curTotal = curTotal + tonumber(times[3])

		if compareWeight <= curTotal then
			return v
		end
	end

	return nil
end

function NpcActionModule.Shutdown()
	return
end

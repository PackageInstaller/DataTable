-- chunkname: @IQIGame\\UIExternalApi\\HomeLandApi.lua

HomeLandApi = BaseLangApi:Extend()
HomeLandApi.PlayerMoveSpeed = 1.5
HomeLandApi.PlayerMoveAnimName = "S_move"
HomeLandApi.PlayerRunSpeed = 3
HomeLandApi.PlayerRunAnimaName = "S_run"

function HomeLandApi:InNight(hour)
	return WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Night
end

function HomeLandApi:GetLevelText(lv)
	return string.format("Lv.%s", lv)
end

function HomeLandApi:GetLvUpgradeOpenRoomText(roomCidList)
	if #roomCidList == nil then
		return nil
	end

	if #roomCidList == 0 then
		return nil
	end

	local text = self:GetCfgText(1500001)
	local roomNames = ""

	for i = 1, #roomCidList do
		local roomCid = roomCidList[i]
		local roomCfg = CfgHomeRoomTable[roomCid]

		if i ~= 1 then
			roomNames = roomNames .. "、"
		end

		roomNames = roomNames .. roomCfg.Name
	end

	return text .. roomNames
end

function HomeLandApi:GetLvUpgradeUnlockTaskQualityText(unlockTaskQuality)
	if unlockTaskQuality == 1 then
		return self:GetCfgText(1500002)
	elseif unlockTaskQuality == 2 then
		return self:GetCfgText(1500003)
	elseif unlockTaskQuality == 3 then
		return self:GetCfgText(1500004)
	elseif unlockTaskQuality == 4 then
		return self:GetCfgText(1500005)
	elseif unlockTaskQuality == 5 then
		return self:GetCfgText(1500006)
	end

	return nil
end

function HomeLandApi:GetLvUpgradeTaskCountLimitText(taskCount)
	if taskCount == nil then
		return nil
	end

	if taskCount == 0 then
		return nil
	end

	return string.format(self:GetCfgText(1500007), taskCount)
end

function HomeLandApi:GetLvUpgradePlayerLevelLimitText(level)
	return string.format(self:GetCfgText(1500008), level)
end

function HomeLandApi:GetTaskRefreshTime_Hour()
	return 4
end

function HomeLandApi:GetTaskRefreshTime_Min()
	return 0
end

function HomeLandApi:GetTaskRefreshCountLimitText()
	return self:GetCfgText(1500009)
end

function HomeLandApi:GetTaskRefreshCostNotEnoughText()
	return self:GetCfgText(1500010)
end

function HomeLandApi:GetTaskRefreshCountText(count)
	return string.format(self:GetCfgText(1500011), count)
end

function HomeLandApi:GetTaskRefreshTimeText(timeStr)
	return string.format(self:GetCfgText(1500012), timeStr)
end

function HomeLandApi:GetTaskQualityImagePath(quality)
	local imageIconNumber = quality + 4

	return string.format("Assets/05_Images/UI/HomeLand/HomeLandMissionUI/Bg_0%s.png", imageIconNumber)
end

function HomeLandApi:GetReceiveTaskCostText(cost)
	return string.format(self:GetCfgText(1500013), cost)
end

function HomeLandApi:GetReceiveTaskNeedHeroNumText(num)
	return string.format(self:GetCfgText(1500014), num)
end

function HomeLandApi:GetReceiveTaskNeedTimeText(timeStr)
	return string.format(self:GetCfgText(1500015), timeStr)
end

function HomeLandApi:GetCompleteTaskTimeText(timeStr)
	return string.format(self:GetCfgText(1500016), timeStr)
end

function HomeLandApi:GetTaskAdvText(type, value)
	if type == Constant.HomeLandDispTaskAdvType.Profession then
		return string.format(self:GetCfgText(1500017), self:GetRoleProfessionText(value))
	elseif type == Constant.HomeLandDispTaskAdvType.Elemental then
		return string.format(self:GetCfgText(1500018), self:GetRoleElementalText(value))
	elseif type == Constant.HomeLandDispTaskAdvType.Level then
		return string.format(self:GetCfgText(1500019), value[1])
	end
end

function HomeLandApi:GetRoleProfessionText(value)
	local str = ""

	for i = 1, #value do
		if i ~= 1 then
			str = str .. "、"
		end

		str = str .. HomeLandApi:GetRoleProfessionNameText(value[i])
	end

	return str
end

function HomeLandApi:GetRoleProfessionNameText(profession)
	if profession == 1 then
		return self:GetCfgText(122)
	elseif profession == 2 then
		return self:GetCfgText(123)
	elseif profession == 3 then
		return self:GetCfgText(124)
	elseif profession == 4 then
		return self:GetCfgText(125)
	elseif profession == 5 then
		return self:GetCfgText(126)
	elseif profession == 6 then
		return self:GetCfgText(127)
	end

	return tostring(profession)
end

function HomeLandApi:GetRoleElementalText(value)
	local str = ""

	for i = 1, #value do
		if i ~= 1 then
			str = str .. "、"
		end

		str = str .. HomeLandApi:GetRoleElementNameText(value[i])
	end

	return str
end

function HomeLandApi:GetRoleElementNameText(element)
	if element == 1 then
		return self:GetCfgText(102)
	elseif element == 2 then
		return self:GetCfgText(103)
	elseif element == 3 then
		return self:GetCfgText(104)
	elseif element == 4 then
		return self:GetCfgText(105)
	elseif element == 5 then
		return self:GetCfgText(106)
	elseif element == 6 then
		return self:GetCfgText(107)
	end

	return tostring(element)
end

function HomeLandApi:GetTaskExRewardNumText(num)
	return "x" .. num
end

function HomeLandApi:GetTaskExecuteTextID()
	return 53001
end

function HomeLandApi:GetTaskRefreshSuccessTextID()
	return 53003
end

function HomeLandApi:GetTaskRefreshNoChangeTextID()
	return 53002
end

function HomeLandApi:CheckHomeMapButtonNeedShowRedDotByRoomCid(roomCid)
	return roomCid ~= 30300002
end

function HomeLandApi:GetRoomUnlockText(level)
	return string.format(self:GetCfgText(1500020), level)
end

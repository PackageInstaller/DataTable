-- chunkname: @IQIGame\\UIExternalApi\\MissionUIApi.lua

MissionUIApi = BaseLangApi:Extend()

function MissionUIApi:Init()
	self:RegisterApi("goBtnCloseTxt", self.GetBtnCloseTxt)
	self:RegisterApi("goToggleName", self.GetToggleName)
	self:RegisterApi("goToggleEngName", self.GetToggleEngName)
	self:RegisterApi("goEasyGetTxt", self.GetEasyGetTxt)
	self:RegisterApi("goBtnGetTxt", self.GetBtnGetTxt)
	self:RegisterApi("goBtnJumpTxt", self.GetBtnJumpTxt)
	self:RegisterApi("goFinishedTaskSign", self.GetFinishedTaskSign)
	self:RegisterApi("goExpBonusDesc1", self.GetExpBonusDesc1)
	self:RegisterApi("goExpBonusDesc2", self.GetExpBonusDesc2)
	self:RegisterApi("taskViewProgress", self.GetTaskViewProgress)
	self:RegisterApi("taskViewTabName", self.GetTaskViewTabName)
	self:RegisterApi("taskViewTabEngName", self.GetTaskViewTabEngName)
	self:RegisterApi("taskViewToggleIconPath", self.GetTaskViewToggleIconPath)
	self:RegisterApi("activeViewActiveValue", self.GetActiveViewActiveValue)
	self:RegisterApi("activeViewTargetDesc", self.GetActiveViewTargetDesc)
	self:RegisterApi("activeViewActiveLv", self.GetActiveViewActiveLv)
	self:RegisterApi("activeViewProgress", self.GetActiveViewActiveProgress)
	self:RegisterApi("activeViewRewardCount", self.GetActiveViewRewardCount)
	self:RegisterApi("activeViewNoRewardTxt", self.GetActiveViewNoRewardTxt)
	self:RegisterApi("activeViewNoRewardEngTxt", self.GetActiveViewNoRewardEngTxt)
end

function MissionUIApi:GetTaskViewProgress(finishedCount, totalCount)
	local value = math.floor(finishedCount * 100 / totalCount, 0)

	if finishedCount > 0 and totalCount > finishedCount * 100 then
		return "1%"
	elseif value > 99 and totalCount > finishedCount * 100 then
		return "99%"
	else
		return value .. "%"
	end
end

function MissionUIApi:GetTaskViewToggleIconPath(type, isLight)
	if isLight then
		if type == 1 then
			return self:GetResUrl(2500001)
		elseif type == 2 then
			return self:GetResUrl(2500002)
		elseif type == 3 then
			return self:GetResUrl(2500003)
		elseif type == 4 then
			return self:GetResUrl(2500004)
		elseif type == 5 then
			return self:GetResUrl(2500005)
		elseif type == 6 then
			return self:GetResUrl(2500006)
		end
	elseif type == 1 then
		return self:GetResUrl(2500010)
	elseif type == 2 then
		return self:GetResUrl(2500011)
	elseif type == 3 then
		return self:GetResUrl(2500012)
	elseif type == 4 then
		return self:GetResUrl(2500013)
	elseif type == 5 then
		return self:GetResUrl(2500014)
	elseif type == 6 then
		return self:GetResUrl(2500015)
	end
end

function MissionUIApi:GetTaskViewTabName(type, isLight)
	local names

	names = {
		[0] = self:GetCfgText(1107005),
		self:GetCfgText(1107006),
		self:GetCfgText(1107007),
		self:GetCfgText(1107008),
		self:GetCfgText(1107009),
		self:GetCfgText(1107010),
		(self:GetCfgText(1107011))
	}

	if isLight then
		return self:FirstLarge(self:Blank(names[type], 1), 1, 41, 24)
	else
		return self:Blank(names[type], 1)
	end
end

function MissionUIApi:GetTaskViewTabEngName(type, isLight)
	local names = {
		[0] = self:GetCfgText(1107014),
		self:GetCfgText(1107015),
		self:GetCfgText(1107016),
		self:GetCfgText(1107017),
		self:GetCfgText(1107018),
		self:GetCfgText(1107019),
		(self:GetCfgText(1107020))
	}

	return self:Blank(names[type], 3)
end

function MissionUIApi:GetActiveViewActiveProgress(finishedCount, totalCount)
	if finishedCount == totalCount then
		return self:GetCfgText(1218012) .. "：" .. finishedCount .. "/" .. totalCount
	else
		return self:GetCfgText(1218012) .. "：" .. finishedCount .. "/" .. totalCount
	end
end

function MissionUIApi:GetExpBonusDesc1()
	return self:GetCfgText(1218013)
end

function MissionUIApi:GetExpBonusDesc2(value)
	return self:GetCfgText(1218014) .. "+" .. value .. "%"
end

function MissionUIApi:GetFinishedTaskSign()
	return self:GetCfgText(1107013)
end

function MissionUIApi:GetActiveViewRewardCount(count)
	return "<size=20>" .. "x" .. count .. "</size>"
end

function MissionUIApi:GetActiveViewNoRewardTxt(isWeek)
	if isWeek then
		return self:GetCfgText(1218010)
	else
		return self:GetCfgText(1218011)
	end
end

function MissionUIApi:GetActiveViewNoRewardEngTxt(isWeek)
	if isWeek then
		return self:Blank(self:GetCfgText(1218015), 2)
	else
		return self:Blank(self:GetCfgText(1218016), 2)
	end
end

function MissionUIApi:GetActiveBtnGetTxt()
	return
end

function MissionUIApi:GetActiveViewActiveValue(value)
	return "x" .. tostring(value)
end

function MissionUIApi:GetActiveViewTargetDesc(desc, curNum, targetNum)
	return "<size=20>" .. desc .. " (<size=25>" .. tostring(curNum) .. "</size>/" .. tostring(targetNum) .. ")</size>"
end

function MissionUIApi:GetBtnJumpTxt()
	return self:GetCfgText(1101009)
end

function MissionUIApi:GetBtnGetTxt()
	return self:GetCfgText(1217001)
end

function MissionUIApi:GetActiveViewActiveLv(index)
	if index == 1 then
		return "S"
	elseif index == 2 then
		return "A"
	elseif index == 3 then
		return "B"
	elseif index == 4 then
		return "C"
	elseif index == 5 then
		return "D"
	elseif index == 6 then
		return "E"
	elseif index == 7 then
		return "F"
	else
		return ""
	end
end

function MissionUIApi:GetToggleName(index)
	if index == 1 then
		return self:GetCfgText(1218002)
	elseif index == 2 then
		return self:GetCfgText(1218004)
	else
		return self:GetCfgText(1218006)
	end
end

function MissionUIApi:GetToggleEngName(index)
	if index == 1 then
		return self:Blank(self:GetCfgText(1218003), 2)
	elseif index == 2 then
		return self:Blank(self:GetCfgText(1218005), 2)
	elseif index == 3 then
		return self:Blank(self:GetCfgText(1218007), 2)
	elseif index == 4 then
		return self:Blank(self:GetCfgText(1218009), 2)
	end
end

function MissionUIApi:GetEasyGetTxt()
	return self:GetCfgText(1216013)
end

function MissionUIApi:GetBtnCloseTxt()
	return self:GetCfgText(1218001)
end

MissionUIApi:Init()

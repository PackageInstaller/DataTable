-- chunkname: @IQIGame\\UIExternalApi\\MonsterAcademyMissionUIApi.lua

MonsterAcademyMissionUIApi = BaseLangApi:Extend()

function MonsterAcademyMissionUIApi:Init()
	self:RegisterApi("TaskItemFunctionBtnText", self.GetTaskItemFunctionBtnText)
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
	self:RegisterApi("TaskItemPercentText", self.GetTaskItemPercentText)
	self:RegisterApi("StateText", self.GetStateText)
	self:RegisterApi("ImgStatePath", self.GetImgStatePath)
end

function MonsterAcademyMissionUIApi:GetImgStatePath(state)
	local path = self:GetResUrl(4700023)

	if state == 1 then
		return self:GetResUrl(4700021)
	elseif state == 2 then
		return self:GetResUrl(4700023)
	elseif state == 3 then
		return self:GetResUrl(4700022)
	end

	return path
end

function MonsterAcademyMissionUIApi:GetStateText(state)
	if state == 1 then
		return "<color=#3e6b08>" .. self:GetCfgText(3420101) .. "</color>"
	elseif state == 2 then
		return self:GetCfgText(3420102)
	elseif state == 3 then
		return "<color=#946625>" .. self:GetCfgText(3420103) .. "</color>"
	end

	return "<color=#696969>" .. self:GetCfgText(3420104) .. "</color>"
end

function MonsterAcademyMissionUIApi:GetTaskItemPercentText(finishNum, targetNum)
	local percent = math.floor(finishNum / targetNum * 100)

	return string.format("%s%%", percent)
end

function MonsterAcademyMissionUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("%s/%s", finishNum, targetNum)
end

function MonsterAcademyMissionUIApi:GetTaskItemFunctionBtnText(state)
	if state == 1 then
		return self:GetCfgText(3700201)
	elseif state == 2 then
		return self:GetCfgText(3600032)
	elseif state == 3 then
		return self:GetCfgText(3600033)
	end
end

MonsterAcademyMissionUIApi:Init()

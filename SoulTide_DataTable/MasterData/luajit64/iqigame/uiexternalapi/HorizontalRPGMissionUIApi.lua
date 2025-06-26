-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRPGMissionUIApi.lua

HorizontalRPGMissionUIApi = BaseLangApi:Extend()

function HorizontalRPGMissionUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("goBtnGetTxt", self.GetBtnGetTxt)
	self:RegisterApi("activeViewTargetDesc", self.GetActiveViewTargetDesc)
	self:RegisterApi("taskViewProgress", self.GetTaskViewProgress)
	self:RegisterApi("emptyTxt", self.GetEmptyTxt)
	self:RegisterApi("progressNow", self.GetProgressNow)
	self:RegisterApi("progressTotal", self.GetProgressTotal)
	self:RegisterApi("signNotOverTxt", self.GetSignNotOverTxt)
	self:RegisterApi("itemCellGoCount", self.GetItemCellGoCount)
end

function HorizontalRPGMissionUIApi:GetSignNotOverTxt()
	return self:GetCfgText(3100203)
end

function HorizontalRPGMissionUIApi:GetProgressNow(count)
	return self:ShortNum(count)
end

function HorizontalRPGMissionUIApi:GetProgressTotal(count)
	return self:ShortNum(count)
end

function HorizontalRPGMissionUIApi:GetItemCellGoCount(count)
	return "x" .. count
end

function HorizontalRPGMissionUIApi:GetTitle()
	return self:GetCfgText(3100201)
end

function HorizontalRPGMissionUIApi:GetActiveViewTargetDesc(desc, curNum, targetNum)
	return desc
end

function HorizontalRPGMissionUIApi:GetTaskViewProgress(finishedCount, totalCount)
	local value = math.floor(finishedCount * 100 / totalCount, 0)

	if finishedCount > 0 and totalCount > finishedCount * 100 then
		return "1%"
	elseif value > 99 and totalCount > finishedCount * 100 then
		return "99%"
	else
		return value .. "%"
	end
end

function HorizontalRPGMissionUIApi:GetEmptyTxt()
	return self:GetCfgText(3100202)
end

function HorizontalRPGMissionUIApi:GetBtnGetTxt()
	return self:GetCfgText(1217001)
end

HorizontalRPGMissionUIApi:Init()

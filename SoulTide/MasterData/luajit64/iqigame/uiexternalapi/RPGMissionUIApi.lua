-- chunkname: @IQIGame\\UIExternalApi\\RPGMissionUIApi.lua

RPGMissionUIApi = BaseLangApi:Extend()

function RPGMissionUIApi:Init()
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

function RPGMissionUIApi:GetSignNotOverTxt()
	return self:GetCfgText(3100203)
end

function RPGMissionUIApi:GetProgressNow(count)
	return self:ShortNum(count, 2)
end

function RPGMissionUIApi:GetProgressTotal(count)
	return self:ShortNum(count, 2)
end

function RPGMissionUIApi:GetItemCellGoCount(count)
	return "x" .. count
end

function RPGMissionUIApi:GetTitle()
	return self:GetCfgText(3100201)
end

function RPGMissionUIApi:GetActiveViewTargetDesc(desc, curNum, targetNum)
	return desc
end

function RPGMissionUIApi:GetTaskViewProgress(finishedCount, totalCount)
	local value = math.floor(finishedCount * 100 / totalCount, 0)

	if finishedCount > 0 and totalCount > finishedCount * 100 then
		return "1%"
	elseif value > 99 and totalCount > finishedCount * 100 then
		return "99%"
	else
		return value .. "%"
	end
end

function RPGMissionUIApi:GetEmptyTxt()
	return self:GetCfgText(3100202)
end

function RPGMissionUIApi:GetBtnGetTxt()
	return self:GetCfgText(1217001)
end

RPGMissionUIApi:Init()

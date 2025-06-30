-- chunkname: @IQIGame\\UIExternalApi\\ActiveWeekendUIApi.lua

ActiveWeekendUIApi = BaseLangApi:Extend()

function ActiveWeekendUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("tabTopTxt", self.GetTabTopTxt)
	self:RegisterApi("growUpViewTabLeftTxt", self.GetGrowUpViewTabLeftTxt)
	self:RegisterApi("growUpViewBtnJumpTxt", self.GetGrowUpViewBtnJumpTxt)
	self:RegisterApi("growUpViewBtnGetTxt", self.GetGrowUpViewBtnGetTxt)
	self:RegisterApi("growUpViewFinishSign", self.GetGrowUpViewFinishSign)
	self:RegisterApi("growUpViewTargetDesc", self.GetGrowUpViewTargetDesc)
	self:RegisterApi("growUpViewProgressDesc", self.GetGrowUpViewProgressDesc)
	self:RegisterApi("growUpViewProgressScore", self.GetGrowUpViewProgressScore)
	self:RegisterApi("growUpViewProgressScoreDesc", self.GetGrowUpViewProgressScoreDesc)
end

function ActiveWeekendUIApi:GetGrowUpViewProgressScoreDesc(cur, total)
	return cur .. "/" .. total
end

function ActiveWeekendUIApi:GetGrowUpViewProgressScore(value, curValue)
	return curValue .. "/" .. value
end

function ActiveWeekendUIApi:GetGrowUpViewTargetDesc(desc, curNum, targetNum)
	return desc
end

function ActiveWeekendUIApi:GetGrowUpViewProgressDesc(curNum, targetNum)
	return curNum .. "/" .. targetNum
end

function ActiveWeekendUIApi:GetGrowUpViewBtnJumpTxt()
	return self:GetCfgText(1101009)
end

function ActiveWeekendUIApi:GetGrowUpViewBtnGetTxt()
	return self:GetCfgText(1217001)
end

function ActiveWeekendUIApi:GetGrowUpViewFinishSign()
	return self:GetCfgText(1107013)
end

function ActiveWeekendUIApi:GetGrowUpViewTabLeftTxt(dayIndex)
	return self:GetCfgText(2900003) .. dayIndex .. self:GetCfgText(2900004)
end

function ActiveWeekendUIApi:GetTitle()
	return self:GetCfgText(2900001)
end

function ActiveWeekendUIApi:GetTabTopTxt(index)
	if index == 1 then
		return self:GetCfgText(2900002)
	elseif index == 2 then
		return self:GetCfgText(2900005)
	end
end

ActiveWeekendUIApi:Init()

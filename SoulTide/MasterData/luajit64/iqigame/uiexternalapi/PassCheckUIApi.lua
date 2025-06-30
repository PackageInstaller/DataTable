-- chunkname: @IQIGame\\UIExternalApi\\PassCheckUIApi.lua

PassCheckUIApi = BaseLangApi:Extend()

function PassCheckUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("passName", self.GetPassName)
	self:RegisterApi("passTime", self.GetPassTime)
	self:RegisterApi("passLv", self.GetPassLv)
	self:RegisterApi("passExp", self.GetPassExp)
	self:RegisterApi("passExpDesc", self.GetPassExpDesc)
	self:RegisterApi("btnRewardTxt", self.GetBtnRewardTxt)
	self:RegisterApi("btnBuyPassTxt", self.GetBtnBuyPassTxt)
	self:RegisterApi("btnEasyGetTxt", self.GetBtnEasyGetTxt)
	self:RegisterApi("btnBuyLvTxt", self.GetBtnBuyLvTxt)
	self:RegisterApi("baseTitle", self.GetBaseTitle)
	self:RegisterApi("superTitle", self.GetSuperTitle)
	self:RegisterApi("superStateDesc", self.GetSuperStateDesc)
	self:RegisterApi("rewardCellLv", self.GetRewardCellLv)
	self:RegisterApi("rewardCellEngLvDesc", self.GetRewardCelEngLvDesc)
	self:RegisterApi("rewardCellNowDesc", self.GetRewardCellNowDesc)
	self:RegisterApi("rewardCellGotDesc", self.GetRewardCellGotDesc)
end

function PassCheckUIApi:GetTitle()
	return self:GetCfgText(3501101)
end

function PassCheckUIApi:GetSuperStateDesc(lock)
	if lock then
		return self:GetCfgText(3501102)
	else
		return ""
	end
end

function PassCheckUIApi:GetBaseTitle()
	return self:GetCfgText(3501103)
end

function PassCheckUIApi:GetSuperTitle()
	return self:GetCfgText(3501104)
end

function PassCheckUIApi:GetBtnEasyGetTxt()
	return self:GetCfgText(3501105)
end

function PassCheckUIApi:GetBtnBuyLvTxt()
	return self:GetCfgText(3501106)
end

function PassCheckUIApi:GetBtnBuyPassTxt()
	return self:GetCfgText(3501107)
end

function PassCheckUIApi:GetBtnRewardTxt()
	return self:GetCfgText(3501108)
end

function PassCheckUIApi:GetPassName(name)
	return name
end

function PassCheckUIApi:GetPassTime(openTime, endTime)
	return openTime .. "/" .. endTime
end

function PassCheckUIApi:GetPassLv(lv)
	return lv
end

function PassCheckUIApi:GetPassExp(curExp, needExp, isMax)
	return self:GetCfgText(3501111) .. self:Space(1) .. curExp .. "/" .. needExp
end

function PassCheckUIApi:GetPassExpDesc()
	return self:GetCfgText(3501109)
end

function PassCheckUIApi:GetRewardCellLv(lv)
	return lv
end

function PassCheckUIApi:GetRewardCelEngLvDesc()
	return self:Blank(self:GetCfgText(3501112), 1)
end

function PassCheckUIApi:GetRewardCellNowDesc()
	return "CURRENT"
end

function PassCheckUIApi:GetRewardCellGotDesc()
	return self:GetCfgText(3501110)
end

PassCheckUIApi:Init()

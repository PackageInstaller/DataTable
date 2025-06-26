-- chunkname: @IQIGame\\UIExternalApi\\CheckRewardUIApi.lua

CheckRewardUIApi = BaseLangApi:Extend()

function CheckRewardUIApi:Init()
	self:RegisterApi("TitleImage", self.GetTitleImage)
	self:RegisterApi("GetCloseTxt", self.GetCloseTxt)
	self:RegisterApi("GetRewardTxt", self.GetRewardTxt)
	self:RegisterApi("GetCheckTitle", self.GetCheckTitle)
	self:RegisterApi("BtnTitle", self.GetBtnTitle)
end

function CheckRewardUIApi:GetBtnTitle(state)
	if state == 1 then
		return self:GetCfgText(1243004)
	elseif state == 2 then
		return self:GetCfgText(1243005)
	elseif state == 3 then
		return self:GetCfgText(1243006)
	end
end

function CheckRewardUIApi:GetCloseTxt()
	return self:GetCfgText(1243001)
end

function CheckRewardUIApi:GetRewardTxt()
	return self:GetCfgText(1243002)
end

function CheckRewardUIApi:GetTitleImage()
	return self:GetCfgText(1243003)
end

function CheckRewardUIApi:GetCheckTitle()
	return ""
end

CheckRewardUIApi:Init()

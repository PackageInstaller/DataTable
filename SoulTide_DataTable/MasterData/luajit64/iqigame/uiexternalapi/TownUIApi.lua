-- chunkname: @IQIGame\\UIExternalApi\\TownUIApi.lua

TownUIApi = BaseLangApi:Extend()

function TownUIApi:Init()
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("Error", self.GetError)
	self:RegisterApi("TownTaskIcon", self.GetTownTaskIcon)
	self:RegisterApi("Error1", self.GetError1)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitleName", self.GetTextTitleName)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("ImgBgPath", self.GetImgBgPath)
end

function TownUIApi:GetImgBgPath(backGround, currentWeatherCid, timeInterval)
	return ""
end

function TownUIApi:GetTextRewardTitle()
	return self:GetCfgText(1180003)
end

function TownUIApi:GetTextTitleName()
	return self:GetCfgText(1180004)
end

function TownUIApi:GetError1()
	return self:GetCfgText(1180005)
end

function TownUIApi:GetTownTaskIcon()
	return ""
end

function TownUIApi:GetTextName(Name)
	return self:GetCfgText(1180000) .. Name .. self:GetCfgText(1180001)
end

function TownUIApi:GetError(Name)
	return Name .. self:GetCfgText(1180002)
end

function TownUIApi:GetTextTitle()
	return self:GetCfgText(1180006) .. "："
end

TownUIApi:Init()

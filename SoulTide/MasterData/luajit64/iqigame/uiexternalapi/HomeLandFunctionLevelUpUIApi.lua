-- chunkname: @IQIGame\\UIExternalApi\\HomeLandFunctionLevelUpUIApi.lua

HomeLandFunctionLevelUpUIApi = BaseLangApi:Extend()

function HomeLandFunctionLevelUpUIApi:Init()
	self:RegisterApi("TextLeftGrid", self.GetTextLeftGrid)
	self:RegisterApi("TextRightTitle1", self.GetTextRightTitle1)
	self:RegisterApi("TextRightTitle2", self.GetTextRightTitle2)
	self:RegisterApi("TextRightTitle3", self.GetTextRightTitle3)
	self:RegisterApi("TextBtnLevelUp", self.TextBtnLevelUp)
	self:RegisterApi("TextLeftTitle1", self.GetTextLeftTitle1)
	self:RegisterApi("ShowEntitySize", self.GetShowEntitySize)
	self:RegisterApi("ShowEntityPosition", self.GetShowEntityPosition)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("ErrorMsg2", self.GetErrorMsg2)
	self:RegisterApi("TextMax1", self.GetTextMax1)
	self:RegisterApi("TextMax2", self.GetTextMax2)
end

function HomeLandFunctionLevelUpUIApi:GetTextMax2()
	return self:GetCfgText(1015480)
end

function HomeLandFunctionLevelUpUIApi:GetTextMax1()
	return self:GetCfgText(1015481)
end

function HomeLandFunctionLevelUpUIApi:GetErrorMsg2()
	return self:GetCfgText(1015482)
end

function HomeLandFunctionLevelUpUIApi:GetErrorMsg1()
	return self:GetCfgText(1015483)
end

function HomeLandFunctionLevelUpUIApi:GetShowEntityPosition()
	return Vector3.New(-133.1, 160, 0)
end

function HomeLandFunctionLevelUpUIApi:GetShowEntitySize()
	return Vector3.New(45, 45, 45)
end

function HomeLandFunctionLevelUpUIApi:GetTextLeftTitle1(name, lv)
	return string.format("%s Lv.%s", name, lv)
end

function HomeLandFunctionLevelUpUIApi:TextBtnLevelUp()
	return self:GetCfgText(1015484)
end

function HomeLandFunctionLevelUpUIApi:GetTextRightTitle3()
	return self:GetCfgText(1015485)
end

function HomeLandFunctionLevelUpUIApi:GetTextRightTitle2()
	return self:GetCfgText(1015486)
end

function HomeLandFunctionLevelUpUIApi:GetTextRightTitle1()
	return self:GetCfgText(1015487)
end

function HomeLandFunctionLevelUpUIApi:GetTextLeftGrid()
	return {
		self:GetCfgText(1015488)
	}
end

HomeLandFunctionLevelUpUIApi:Init()

-- chunkname: @IQIGame\\UIExternalApi\\LibraryRewardUIApi.lua

LibraryRewardUIApi = BaseLangApi:Extend()

function LibraryRewardUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("TextBtn1", self.GetTextBtn1)
	self:RegisterApi("TextBtn2", self.GetTextBtn2)
	self:RegisterApi("TextBtn3", self.GetTextBtn3)
end

function LibraryRewardUIApi:GetTextBtn3()
	return self:GetCfgText(1015039)
end

function LibraryRewardUIApi:GetTextBtn2()
	return self:GetCfgText(1015039)
end

function LibraryRewardUIApi:GetTextBtn1()
	return self:GetCfgText(1101015)
end

function LibraryRewardUIApi:GetTextCondition(num, top)
	if top then
		return string.format(self:GetCfgText(1106146), self.TextColor[202] .. num .. self.TextColor[0])
	end

	return string.format(self:GetCfgText(1106146), self.TextColor[203] .. num .. self.TextColor[0])
end

function LibraryRewardUIApi:GetTextTitle()
	return self:GetCfgText(1106145)
end

LibraryRewardUIApi:Init()

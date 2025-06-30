-- chunkname: @IQIGame\\UIExternalApi\\InvasionScoreTipsUIApi.lua

InvasionScoreTipsUIApi = BaseLangApi:Extend()

function InvasionScoreTipsUIApi:Init()
	self:RegisterApi("TextScoreTitle", self.GetTextScoreTitle)
	self:RegisterApi("TypePath", self.GetTypePath)
	self:RegisterApi("TextType", self.GetTextType)
	self:RegisterApi("TextTypeValue", self.GetTextTypeValue)
	self:RegisterApi("TextMax", self.GetTextMax)
end

function InvasionScoreTipsUIApi:GetTextMax(value, maxValue)
	return string.format("%s\n<color=#929292><size=12>/%s</size></color>", value, maxValue)
end

function InvasionScoreTipsUIApi:GetTextTypeValue(type, value)
	if type == 1 then
		return string.format(self:GetCfgText(3505001), value)
	elseif type == 2 then
		return string.format(self:GetCfgText(3505002), value)
	end

	return tostring(value)
end

function InvasionScoreTipsUIApi:GetTextType(type)
	if type == 1 then
		return self:GetCfgText(3505003)
	elseif type == 2 then
		return self:GetCfgText(3505004)
	end

	return ""
end

function InvasionScoreTipsUIApi:GetTypePath(type)
	if type == 1 then
		return self:GetResUrl(4201001)
	end

	return self:GetResUrl(4201002)
end

function InvasionScoreTipsUIApi:GetTextScoreTitle()
	return self:GetCfgText(3505005)
end

InvasionScoreTipsUIApi:Init()

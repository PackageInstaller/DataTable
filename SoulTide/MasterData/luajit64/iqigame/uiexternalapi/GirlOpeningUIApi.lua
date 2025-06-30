-- chunkname: @IQIGame\\UIExternalApi\\GirlOpeningUIApi.lua

GirlOpeningUIApi = BaseLangApi:Extend()

function GirlOpeningUIApi:Init()
	self:RegisterApi("TextNameBg", self.GetTextNameBg)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextType", self.GetTextType)
	self:RegisterApi("DelayClose", self.GetDelayClose)
end

function GirlOpeningUIApi:GetDelayClose()
	return 2
end

function GirlOpeningUIApi:GetTextNameBg(type, str)
	if type == 1 then
		-- block empty
	elseif type == 2 then
		-- block empty
	elseif type == 3 then
		-- block empty
	elseif type == 4 then
		-- block empty
	end

	return str
end

function GirlOpeningUIApi:GetTextName(type, str)
	if type == 1 then
		-- block empty
	elseif type == 2 then
		-- block empty
	elseif type == 3 then
		-- block empty
	elseif type == 4 then
		-- block empty
	end

	return str
end

function GirlOpeningUIApi:GetTextType(type)
	if type == 1 then
		return self:GetCfgText(1013001)
	elseif type == 2 then
		return self:GetCfgText(1013002)
	elseif type == 3 then
		return self:GetCfgText(1013003)
	elseif type == 4 then
		return self:GetCfgText(1013004)
	end

	return ""
end

GirlOpeningUIApi:Init()

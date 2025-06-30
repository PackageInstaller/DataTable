-- chunkname: @IQIGame\\UIExternalApi\\DupMultipleActivityUIApi.lua

DupMultipleActivityUIApi = BaseLangApi:Extend()

function DupMultipleActivityUIApi:Init()
	self:RegisterApi("", self.Get)
end

function DupMultipleActivityUIApi:Get()
	return ""
end

function DupMultipleActivityUIApi:GetChapterNameByTag(tag)
	if tag == 1 then
		return self:GetCfgText(270001)
	elseif tag == 2 then
		return self:GetCfgText(270002)
	elseif tag == 3 then
		return self:GetCfgText(270003)
	elseif tag == 4 then
		return self:GetCfgText(270004)
	elseif tag == 5 then
		return self:GetCfgText(270005)
	elseif tag == 6 then
		return self:GetCfgText(270006)
	elseif tag == 7 then
		return self:GetCfgText(270007)
	elseif tag == 8 then
		return self:GetCfgText(270008)
	elseif tag == 9 then
		return self:GetCfgText(270009)
	end
end

DupMultipleActivityUIApi:Init()

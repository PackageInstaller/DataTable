-- chunkname: @IQIGame\\UIExternalApi\\LinkTipUIApi.lua

LinkTipUIApi = BaseLangApi:Extend()

function LinkTipUIApi:Init()
	self:RegisterApi("goName", self.GetName)
	self:RegisterApi("goDesc", self.GetDesc)
end

function LinkTipUIApi:GetName(name)
	return name
end

function LinkTipUIApi:GetDesc(desc)
	return self:SkillValueColor(desc, 29)
end

LinkTipUIApi:Init()

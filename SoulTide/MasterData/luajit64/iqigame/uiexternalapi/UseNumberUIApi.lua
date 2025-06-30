-- chunkname: @IQIGame\\UIExternalApi\\UseNumberUIApi.lua

UseNumberUIApi = BaseLangApi:Extend()

function UseNumberUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goOwnNumDesc", self.GetOwnNumDesc)
	self:RegisterApi("goUseNumDesc", self.GetUseNumDesc)
	self:RegisterApi("goBtnUse", self.GetBtnUseTxt)
end

function UseNumberUIApi:GetTitle()
	return self:GetCfgText(1230001)
end

function UseNumberUIApi:GetDesc(name)
	return name
end

function UseNumberUIApi:GetOwnNumDesc(value)
	return self:GetCfgText(1230002) .. value
end

function UseNumberUIApi:GetUseNumDesc(value)
	return self:GetCfgText(1230003) .. value
end

function UseNumberUIApi:GetBtnUseTxt()
	return self:GetCfgText(1230004)
end

UseNumberUIApi:Init()

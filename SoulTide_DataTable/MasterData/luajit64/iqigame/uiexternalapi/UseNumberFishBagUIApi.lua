-- chunkname: @IQIGame\\UIExternalApi\\UseNumberFishBagUIApi.lua

UseNumberFishBagUIApi = BaseLangApi:Extend()

function UseNumberFishBagUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitle)
	self:RegisterApi("goDesc", self.GetDesc)
	self:RegisterApi("goOwnNumDesc", self.GetOwnNumDesc)
	self:RegisterApi("goUseNumDesc", self.GetUseNumDesc)
	self:RegisterApi("goBtnUse", self.GetBtnUseTxt)
end

function UseNumberFishBagUIApi:GetTitle()
	return self:GetCfgText(1230001)
end

function UseNumberFishBagUIApi:GetDesc(name)
	return name
end

function UseNumberFishBagUIApi:GetOwnNumDesc(value)
	return self:GetCfgText(1230002) .. value
end

function UseNumberFishBagUIApi:GetUseNumDesc(value)
	return self:GetCfgText(1230003) .. value
end

function UseNumberFishBagUIApi:GetBtnUseTxt()
	return self:GetCfgText(1230004)
end

UseNumberFishBagUIApi:Init()

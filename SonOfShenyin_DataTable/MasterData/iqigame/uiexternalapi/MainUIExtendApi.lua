-- chunkname: @IQIGame\\UIExternalApi\\MainUIExtendApi.lua

MainUIExtendApi = BaseLangApi:Extend()

function MainUIExtendApi:Get()
	return ""
end

function MainUIExtendApi:GetActivity(path)
	return UIGlobalApi.ImagePath .. path
end

function MainUIExtendApi:GetTips_Type1_1()
	return self:GetCfgText(4080005)
end

function MainUIExtendApi:GetTips_Type1_2()
	return self:GetCfgText(4080006)
end

function MainUIExtendApi:GetTips_Type1_3()
	return self:GetCfgText(4080007)
end

function MainUIExtendApi:GetTips_Type1_4()
	return self:GetCfgText(4080008)
end

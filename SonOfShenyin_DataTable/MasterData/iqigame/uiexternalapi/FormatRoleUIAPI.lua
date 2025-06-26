-- chunkname: @IQIGame\\UIExternalApi\\FormatRoleUIAPI.lua

FormatRoleUIAPI = BaseLangApi:Extend()

function FormatRoleUIAPI:Get()
	return ""
end

function FormatRoleUIAPI:GetTips_Type1_1()
	return self:GetCfgText(4080001)
end

function FormatRoleUIAPI:GetTips_Type1_2()
	return self:GetCfgText(4080002)
end

function FormatRoleUIAPI:GetTips_Type1_3()
	return self:GetCfgText(4080003)
end

function FormatRoleUIAPI:GetTips_Type1_4()
	return self:GetCfgText(4080004)
end

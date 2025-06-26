-- chunkname: @IQIGame\\UIExternalApi\\RoleInfoDetailsUIApi.lua

RoleInfoDetailsUIApi = BaseLangApi:Extend()

function RoleInfoDetailsUIApi:GetRoleSex(type)
	if type == 1 then
		return self:GetCfgText(210001)
	else
		return self:GetCfgText(210002)
	end
end

function RoleInfoDetailsUIApi:GetRoleBaseInfo(index)
	if index == 1 then
		return self:GetCfgText(210003)
	elseif index == 2 then
		return self:GetCfgText(210004)
	elseif index == 3 then
		return self:GetCfgText(210005)
	elseif index == 4 then
		return self:GetCfgText(210006)
	elseif index == 5 then
		return self:GetCfgText(210007)
	elseif index == 6 then
		return self:GetCfgText(210008)
	else
		return ""
	end
end

function RoleInfoDetailsUIApi:GetWayInfo()
	return self:GetCfgText(210009)
end

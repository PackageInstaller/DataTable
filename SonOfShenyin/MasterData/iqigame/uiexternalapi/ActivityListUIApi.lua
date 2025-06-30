-- chunkname: @IQIGame\\UIExternalApi\\ActivityListUIApi.lua

ActivityListUIApi = BaseLangApi:Extend()

function ActivityListUIApi:Init()
	self:RegisterApi("", self.Get)
end

function ActivityListUIApi:Get()
	return ""
end

function ActivityListUIApi:GetStrengthActivityTitle(index)
	if index == 1 then
		return self:GetCfgText(280001)
	elseif index == 2 then
		return self:GetCfgText(280002)
	end
end

ActivityListUIApi:Init()

-- chunkname: @IQIGame\\UIExternalApi\\RestaurantOperationMissionUIApi.lua

RestaurantOperationMissionUIApi = BaseLangApi:Extend()

function RestaurantOperationMissionUIApi:Init()
	self:RegisterApi("StateText", self.GetStateText)
	self:RegisterApi("ProgressText", self.GetProgressText)
end

function RestaurantOperationMissionUIApi:GetProgressText(num)
	return num
end

function RestaurantOperationMissionUIApi:GetStateText(state)
	if state == 1 then
		return "<color=#3e6b08>" .. self:GetCfgText(3420101) .. "</color>"
	elseif state == 3 then
		return "<color=#946625>" .. self:GetCfgText(3420103) .. "</color>"
	end

	return "<color=#696969>" .. self:GetCfgText(3420104) .. "</color>"
end

RestaurantOperationMissionUIApi:Init()

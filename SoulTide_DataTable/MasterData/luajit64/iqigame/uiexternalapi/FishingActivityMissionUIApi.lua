-- chunkname: @IQIGame\\UIExternalApi\\FishingActivityMissionUIApi.lua

FishingActivityMissionUIApi = BaseLangApi:Extend()

function FishingActivityMissionUIApi:Init()
	self:RegisterApi("StateText", self.GetStateText)
	self:RegisterApi("ProgressText", self.GetProgressText)
end

function FishingActivityMissionUIApi:GetProgressText(num)
	return num
end

function FishingActivityMissionUIApi:GetStateText(state)
	if state == 1 then
		return "<color=#5e5e5b>" .. self:GetCfgText(3830010) .. "</color>"
	elseif state == 3 then
		return "<color=#ec9c50>" .. self:GetCfgText(3830011) .. "</color>"
	end

	return "<color=#696969>" .. self:GetCfgText(3830012) .. "</color>"
end

FishingActivityMissionUIApi:Init()

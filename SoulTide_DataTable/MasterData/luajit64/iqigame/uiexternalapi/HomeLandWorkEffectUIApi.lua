-- chunkname: @IQIGame\\UIExternalApi\\HomeLandWorkEffectUIApi.lua

HomeLandWorkEffectUIApi = BaseLangApi:Extend()

function HomeLandWorkEffectUIApi:Init()
	self:RegisterApi("WorkCameraPosition", self.GetWorkCameraPosition)
	self:RegisterApi("WorkCameraSize", self.GetWorkCameraSize)
	self:RegisterApi("WaitTime", self.GetWaitTime)
	self:RegisterApi("CreateRoleTime", self.GetCreateRoleTime)
end

function HomeLandWorkEffectUIApi:GetCreateRoleTime()
	return 1.5
end

function HomeLandWorkEffectUIApi:GetWaitTime()
	return 11
end

function HomeLandWorkEffectUIApi:GetWorkCameraSize()
	return 4.35
end

function HomeLandWorkEffectUIApi:GetWorkCameraPosition()
	return Vector3.New(34, -20, -47)
end

HomeLandWorkEffectUIApi:Init()

-- chunkname: @IQIGame\\UIExternalApi\\GhostGameApi.lua

GhostGameApi = BaseLangApi:Extend()

function GhostGameApi:Init()
	return
end

function GhostGameApi:GetGhostGameVirtualCameraPrefabPath()
	return self:GetResUrl(5002)
end

function GhostGameApi:GetGhostGameBirthPointPrefabPath()
	return self:GetResUrl(5001)
end

function GhostGameApi:GetGhostGameHpBarPrefabPath()
	return self:GetResUrl(5004)
end

GhostGameApi:Init()

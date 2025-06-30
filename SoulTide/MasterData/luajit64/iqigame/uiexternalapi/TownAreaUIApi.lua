-- chunkname: @IQIGame\\UIExternalApi\\TownAreaUIApi.lua

TownAreaUIApi = BaseLangApi:Extend()

function TownAreaUIApi:Init()
	self:RegisterApi("title", self.GetTitle)
	self:RegisterApi("npcTip", self.GetNpcTip)
	self:RegisterApi("times", self.GetTimes)
	self:RegisterApi("sceneStairSpeed", self.GetSceneStairSpeed)
end

function TownAreaUIApi:GetSceneStairSpeed()
	return 0.08
end

function TownAreaUIApi:GetTimes(curTimes, totalTimes)
	return tostring(curTimes) .. "/" .. tostring(totalTimes)
end

function TownAreaUIApi:GetNpcTip(tip)
	return tip
end

function TownAreaUIApi:GetTitle(title)
	return title
end

TownAreaUIApi:Init()

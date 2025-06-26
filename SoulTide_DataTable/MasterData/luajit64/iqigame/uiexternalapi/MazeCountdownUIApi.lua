-- chunkname: @IQIGame\\UIExternalApi\\MazeCountdownUIApi.lua

MazeCountdownUIApi = BaseLangApi:Extend()

function MazeCountdownUIApi:Init()
	self:RegisterApi("LeftTimeLabel", self.GetLeftTimeLabel)
end

function MazeCountdownUIApi:GetLeftTimeLabel()
	return self:GetCfgText(2300170)
end

MazeCountdownUIApi:Init()

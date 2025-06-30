-- chunkname: @IQIGame\\UIExternalApi\\MazeStageAssistantUIApi.lua

MazeStageAssistantUIApi = BaseLangApi:Extend()

function MazeStageAssistantUIApi:Init()
	self:RegisterApi("SpeedBtnText", self.GetSpeedBtnText)
end

function MazeStageAssistantUIApi:GetSpeedBtnText(speed)
	return "x" .. speed
end

MazeStageAssistantUIApi:Init()

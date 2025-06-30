-- chunkname: @IQIGame\\UIExternalApi\\IllusionMazeElementCollectionUIApi.lua

IllusionMazeElementCollectionUIApi = BaseLangApi:Extend()

function IllusionMazeElementCollectionUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("LockNameText", self.GetLockNameText)
	self:RegisterApi("InfoPanelTitle", self.GetInfoPanelTitle)
	self:RegisterApi("LockDescText", self.GetLockDescText)
end

function IllusionMazeElementCollectionUIApi:GetTitleText()
	return self:GetCfgText(1106131)
end

function IllusionMazeElementCollectionUIApi:GetLockNameText()
	return "?????"
end

function IllusionMazeElementCollectionUIApi:GetInfoPanelTitle()
	return self:GetCfgText(1106019)
end

function IllusionMazeElementCollectionUIApi:GetLockDescText()
	return self:GetCfgText(1106130)
end

IllusionMazeElementCollectionUIApi:Init()

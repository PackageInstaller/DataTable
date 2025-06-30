-- chunkname: @IQIGame\\UIExternalApi\\DreamlandSceneApi.lua

DreamlandSceneApi = BaseLangApi:Extend()

function DreamlandSceneApi:Init()
	self:RegisterApi("NodeLeftMarginX", self.GetNodeLeftMarginX)
	self:RegisterApi("NodeBottomMarginY", self.GetNodeBottomMarginY)
	self:RegisterApi("NodeRightMarginX", self.GetNodeRightMarginX)
	self:RegisterApi("NodeTopMarginY", self.GetNodeTopMarginY)
	self:RegisterApi("CameraLookHeroOffsetY", self.GetCameraLookHeroOffsetY)
	self:RegisterApi("HeroMoveSpeed", self.GetHeroMoveSpeed)
	self:RegisterApi("LevelSpeedRatios", self.GetLevelSpeedRatios)
end

function DreamlandSceneApi:GetNodeLeftMarginX()
	return 3
end

function DreamlandSceneApi:GetNodeBottomMarginY()
	return 2
end

function DreamlandSceneApi:GetNodeRightMarginX()
	return 3
end

function DreamlandSceneApi:GetNodeTopMarginY()
	return 2
end

function DreamlandSceneApi:GetCameraLookHeroOffsetY()
	return 0.8
end

function DreamlandSceneApi:GetHeroMoveSpeed()
	return 5
end

function DreamlandSceneApi:GetLevelSpeedRatios()
	return {
		1,
		2
	}
end

DreamlandSceneApi:Init()

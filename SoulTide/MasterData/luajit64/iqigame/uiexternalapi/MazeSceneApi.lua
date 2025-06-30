-- chunkname: @IQIGame\\UIExternalApi\\MazeSceneApi.lua

MazeSceneApi = BaseLangApi:Extend()
MazeSceneApi.S_NodeNoticeEffects = {
	[3] = 9000513
}

function MazeSceneApi:Init()
	self:RegisterApi("NodeLeftMarginX", self.GetNodeLeftMarginX)
	self:RegisterApi("NodeBottomMarginY", self.GetNodeBottomMarginY)
	self:RegisterApi("NodeRightMarginX", self.GetNodeRightMarginX)
	self:RegisterApi("NodeTopMarginY", self.GetNodeTopMarginY)
	self:RegisterApi("CameraLookHeroOffsetY", self.GetCameraLookHeroOffsetY)
	self:RegisterApi("Type3NodeAlpha", self.GetType3NodeAlpha)
	self:RegisterApi("NodeNoticeEffects", self.GetNodeNoticeEffects)
	self:RegisterApi("ScrollMazeDuration", self.GetScrollMazeDuration)
	self:RegisterApi("ElementWeakTypeGap", self.GetElementWeakTypeGap)
	self:RegisterApi("ElementWeakTypeBGMargin", self.GetElementWeakTypeBGMargin)
end

function MazeSceneApi:GetNodeLeftMarginX()
	return 3
end

function MazeSceneApi:GetNodeBottomMarginY()
	return 2.5
end

function MazeSceneApi:GetNodeRightMarginX()
	return 4
end

function MazeSceneApi:GetNodeTopMarginY()
	return 5
end

function MazeSceneApi:GetCameraLookHeroOffsetY()
	return 0.8
end

function MazeSceneApi:GetType3NodeAlpha()
	return 0.135
end

function MazeSceneApi:GetNodeNoticeEffects()
	return MazeSceneApi.S_NodeNoticeEffects
end

function MazeSceneApi:GetScrollMazeDuration()
	return 2
end

function MazeSceneApi:GetElementWeakTypeGap()
	return 0.3
end

function MazeSceneApi:GetElementWeakTypeBGMargin()
	return 0.1, 0.25
end

MazeSceneApi:Init()

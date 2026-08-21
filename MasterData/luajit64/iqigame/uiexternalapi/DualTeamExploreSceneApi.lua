-- chunkname: @IQIGame\\UIExternalApi\\DualTeamExploreSceneApi.lua

DualTeamExploreSceneApi = BaseLangApi:Extend()

function DualTeamExploreSceneApi:Init()
	self:RegisterApi("NodeLeftMarginX", self.GetNodeLeftMarginX)
	self:RegisterApi("NodeBottomMarginY", self.GetNodeBottomMarginY)
	self:RegisterApi("NodeRightMarginX", self.GetNodeRightMarginX)
	self:RegisterApi("NodeTopMarginY", self.GetNodeTopMarginY)
	self:RegisterApi("CameraLookHeroOffsetY", self.GetCameraLookHeroOffsetY)
	self:RegisterApi("HeroMoveSpeed", self.GetHeroMoveSpeed)
	self:RegisterApi("PathAsset", self.GetPathAsset)
end

function DualTeamExploreSceneApi:GetNodeLeftMarginX()
	return 3
end

function DualTeamExploreSceneApi:GetNodeBottomMarginY()
	return 2
end

function DualTeamExploreSceneApi:GetNodeRightMarginX()
	return 3
end

function DualTeamExploreSceneApi:GetNodeTopMarginY()
	return 2
end

function DualTeamExploreSceneApi:GetCameraLookHeroOffsetY()
	return 0.8
end

function DualTeamExploreSceneApi:GetHeroMoveSpeed()
	return 3
end

function DualTeamExploreSceneApi:GetPathAsset()
	return "Assets/03_Prefabs/ART_Prefabs/Scene/DualTeamExplore/Path/DualTeamExplorePath.prefab"
end

DualTeamExploreSceneApi:Init()

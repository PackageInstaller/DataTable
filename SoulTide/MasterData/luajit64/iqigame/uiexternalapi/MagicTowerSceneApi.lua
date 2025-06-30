-- chunkname: @IQIGame\\UIExternalApi\\MagicTowerSceneApi.lua

MagicTowerSceneApi = BaseLangApi:Extend()

function MagicTowerSceneApi:Init()
	self:RegisterApi("NodeLeftMarginX", self.GetNodeLeftMarginX)
	self:RegisterApi("NodeBottomMarginY", self.GetNodeBottomMarginY)
	self:RegisterApi("NodeRightMarginX", self.GetNodeRightMarginX)
	self:RegisterApi("NodeTopMarginY", self.GetNodeTopMarginY)
	self:RegisterApi("CameraLookHeroOffsetY", self.GetCameraLookHeroOffsetY)
	self:RegisterApi("HeroMoveSpeed", self.GetHeroMoveSpeed)
	self:RegisterApi("NodeGapXY", self.GetNodeGapXY)
	self:RegisterApi("NodeOffsetXY", self.GetNodeOffsetXY)
	self:RegisterApi("AttrChangeText", self.GetAttrChangeText)
	self:RegisterApi("CostKeyText", self.GetCostKeyText)
end

function MagicTowerSceneApi:GetNodeLeftMarginX()
	return 3
end

function MagicTowerSceneApi:GetNodeBottomMarginY()
	return 2
end

function MagicTowerSceneApi:GetNodeRightMarginX()
	return 3
end

function MagicTowerSceneApi:GetNodeTopMarginY()
	return 2
end

function MagicTowerSceneApi:GetCameraLookHeroOffsetY()
	return 0.8
end

function MagicTowerSceneApi:GetHeroMoveSpeed()
	return 5
end

function MagicTowerSceneApi:GetNodeGapXY()
	return 2.5, 1.3
end

function MagicTowerSceneApi:GetNodeOffsetXY()
	return 0, 0
end

function MagicTowerSceneApi:GetAttrChangeText(id, deltaValue)
	local finalText

	finalText = id == 1 and "血量 +%s" or id == 2 and "攻击 +%s" or "防御 +%s"

	return string.format(finalText, tostring(deltaValue))
end

function MagicTowerSceneApi:GetCostKeyText(name, deltaValue)
	return string.format("扣除了%s×%s", name, tostring(deltaValue))
end

MagicTowerSceneApi:Init()

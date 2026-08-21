-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StorySettingData.lua

module("logic.extensions.story.core.graph.assets.StorySettingData", package.seeall)

local M = class("StorySettingData")

function M:ctor()
	self.skip = false
	self.auto = false
	self.sceneType = StoryConstDef.EStorySettingSceneType.None
	self.sce3D = nil
	self.sce2D = nil
	self.sce2DTex = nil
	self.sce2DScale = Vector3.zero
	self.sce2DPos = Vector3.zero
	self.sce2DRot = Vector3.zero
	self.stageTpl = nil
	self.stagePos = Vector3.zero
	self.stageRotation = Vector3.zero
	self.skipTitle = nil
	self.skipDes = nil
end

return M

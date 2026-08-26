-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsBlackFog.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsBlackFog", package.seeall)

local StoryHeroEffsBlackFog = class("StoryHeroEffsBlackFog", StoryHeroEffsBase)

function StoryHeroEffsBlackFog:ctor()
	StoryHeroEffsBlackFog.super.ctor(self)
end

function StoryHeroEffsBlackFog:init(go)
	StoryHeroEffsBlackFog.super.init(self)

	self._heroGo = go
	self._skeletonGraphic = self._heroGo:GetComponent(GuiSpine.TypeSkeletonGraphic)
end

function StoryHeroEffsBlackFog:start()
	StoryHeroEffsBlackFog.super.start(self)
	self:loadRes()
end

function StoryHeroEffsBlackFog:onLoadFinished()
	StoryHeroEffsBlackFog.super.onLoadFinished(self)

	if not self._skeletonGraphic then
		return
	end

	local uiCameraGO = CameraMgr.instance:getUICameraGO()
	local uiCustomCameraData = uiCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self._originalUseRoleMask = uiCustomCameraData.useRoleMask
	uiCustomCameraData.useRoleMask = true

	StoryTool.enablePostProcess(true)
end

function StoryHeroEffsBlackFog:destroy()
	if self._originalUseRoleMask ~= nil then
		local uiCameraGO = CameraMgr.instance:getUICameraGO()

		if not gohelper.isNil(uiCameraGO) then
			local uiCustomCameraData = uiCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

			uiCustomCameraData.useRoleMask = self._originalUseRoleMask
		end

		self._originalUseRoleMask = nil
	end

	StoryHeroEffsBlackFog.super.destroy(self)
end

return StoryHeroEffsBlackFog

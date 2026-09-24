-- chunkname: @modules/spine/special/SpineSpecialEffect_539302_ml_p.lua

module("modules.spine.special.SpineSpecialEffect_539302_ml_p", package.seeall)

local SpineSpecialEffect_539302_ml_p = class("SpineSpecialEffect_539302_ml_p", BaseSpineSpecialEffect)

function SpineSpecialEffect_539302_ml_p:_onInit()
	self._skeletonComponent = self._spine:getSpineGo():GetComponent(GuiSpine.TypeSkeletonGraphic)

	self:_fadeUpdate(0)
	self:loadRes()

	local uiCameraGO = CameraMgr.instance:getUICameraGO()
	local uiCustomCameraData = uiCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

	self._originalUseRoleMask = uiCustomCameraData.useRoleMask
	uiCustomCameraData.useRoleMask = true
end

function SpineSpecialEffect_539302_ml_p:addEventListeners()
	return
end

function SpineSpecialEffect_539302_ml_p:removeEventListeners()
	return
end

function SpineSpecialEffect_539302_ml_p:_onBodyChange(prevBodyName, curBodyName)
	return
end

function SpineSpecialEffect_539302_ml_p:loadRes()
	self._effectPath = "effects/prefabs/roleeffects/roleeffect_story_radialflow.prefab"

	if not self._effectLoader then
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectPath)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end
end

function SpineSpecialEffect_539302_ml_p:_loadEffectFinished()
	self._loadedFinish = true

	local assetItem = self._effectLoader:getAssetItem(self._effectPath)
	local res = assetItem and assetItem:GetResource(self._effectPath)

	self._effect = gohelper.clone(res, self._spine:getSpineGo())
	self._outlineImage = gohelper.findChildImage(self._effect, "root/outline")

	TaskDispatcher.runDelay(self._fadeInFinished, self, 0.1)

	if self._alpha then
		self:setAlpha(self._alpha)
	else
		self:setAlpha(0)
	end
end

function SpineSpecialEffect_539302_ml_p:_fadeUpdate(alpha)
	ZProj.UGUIHelper.SetColorAlpha(self._skeletonComponent, alpha)
end

function SpineSpecialEffect_539302_ml_p:_fadeInFinished()
	self:_fadeUpdate(1)
end

function SpineSpecialEffect_539302_ml_p:setAlpha(alpha)
	self._alpha = alpha

	if not self._outlineImage then
		return
	end

	ZProj.UGUIHelper.SetColorAlpha(self._outlineImage, alpha)
end

function SpineSpecialEffect_539302_ml_p:onDestroy()
	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	TaskDispatcher.cancelTask(self._fadeInFinished, self)

	if self._originalUseRoleMask ~= nil then
		local uiCameraGO = CameraMgr.instance:getUICameraGO()

		if not gohelper.isNil(uiCameraGO) then
			local uiCustomCameraData = uiCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)

			uiCustomCameraData.useRoleMask = self._originalUseRoleMask
		end

		self._originalUseRoleMask = nil
	end
end

return SpineSpecialEffect_539302_ml_p

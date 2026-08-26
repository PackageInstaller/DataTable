-- chunkname: @modules/logic/main/view/skininteraction/WMZSkinInteraction.lua

module("modules.logic.main.view.skininteraction.WMZSkinInteraction", package.seeall)

local WMZSkinInteraction = class("WMZSkinInteraction", CommonSkinInteraction)
local b_feie = "b_feie"
local mat1Name = "unlit ( 0 - 0 )"
local mat2Name = "unlit ( 0 - 1 )"
local cameraAnimStart = "v3a7_wmz_bloom_start"
local cameraAnimEnd = "v3a7_wmz_bloom_end"
local normalMapKey = "_NormalMap"

function WMZSkinInteraction:_onInit()
	WMZSkinInteraction.super._onInit(self)

	self._lightSpine = self._view._lightSpine
	self._rawMap1 = nil
	self._rawMap2 = nil

	if not self._effectLoader then
		self._animationControllerName = "v3a7_wmz_bloom"
		self._effectUrl = string.format("ui/animations/dynamic/%s.controller", self._animationControllerName)
		self._normalMap0 = "live2d/dynamic/314702_wmz_bloom_01_special.png"
		self._normalMap1 = "live2d/dynamic/314702_wmz_bloom_00_special.png"
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectUrl)
		self._effectLoader:addPath(self._normalMap0)
		self._effectLoader:addPath(self._normalMap1)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end
end

function WMZSkinInteraction:_loadEffectFinished()
	return
end

function WMZSkinInteraction:_onBodyChange(prevBodyName, curBodyName)
	TaskDispatcher.cancelTask(self._delayChangeNormalMaps, self)
	TaskDispatcher.cancelTask(self._delayResetNormalMaps, self)

	if curBodyName == b_feie then
		self:_playCameraAnim(cameraAnimStart)
		TaskDispatcher.runDelay(self._delayChangeNormalMaps, self, 1)
		TaskDispatcher.runDelay(self._delayResetNormalMaps, self, 14.4)
	else
		self:_resetCamera()
		self:_delayResetNormalMaps()
	end
end

function WMZSkinInteraction:_delayResetNormalMaps()
	if not self._rawMap1 and not self._rawMap2 then
		return
	end

	local live2d = self._lightSpine:getLive2d()

	if not live2d then
		logError("WMZSkinInteraction _delayResetNormalMaps can't find live2d")

		return
	end

	local mats = live2d:getSharedMaterials()

	for i, mat in ipairs(mats) do
		if mat.name == mat1Name and self._rawMap1 then
			mat:SetTexture(normalMapKey, self._rawMap1)

			self._rawMap1 = nil
		end

		if mat.name == mat2Name and self._rawMap2 then
			mat:SetTexture(normalMapKey, self._rawMap2)

			self._rawMap2 = nil
		end

		if not self._rawMap1 and not self._rawMap2 then
			break
		end
	end

	if self._rawMap1 or self._rawMap2 then
		logError("WMZSkinInteraction _delayResetNormalMaps raw map error", self._rawMap1, self._rawMap2)
	end
end

function WMZSkinInteraction:_delayChangeNormalMaps()
	local normalMap1 = self._effectLoader:getAssetItem(self._normalMap0)
	local map1 = normalMap1 and normalMap1:GetResource(self._normalMap0)

	if not map1 then
		logError("WMZSkinInteraction _delayChangeNormalMaps can't find normal map 1", self._normalMap0)
	end

	local normalMap2 = self._effectLoader:getAssetItem(self._normalMap1)
	local map2 = normalMap2 and normalMap2:GetResource(self._normalMap1)

	if not map2 then
		logError("WMZSkinInteraction _delayChangeNormalMaps can't find normal map 2", self._normalMap1)
	end

	local live2d = self._lightSpine:getLive2d()

	if not live2d then
		logError("WMZSkinInteraction _delayChangeNormalMaps can't find live2d")

		return
	end

	local mats = live2d:getSharedMaterials()

	for i, mat in ipairs(mats) do
		if mat.name == mat1Name and not self._rawMap1 and map1 then
			self._rawMap1 = mat:GetTexture(normalMapKey)

			mat:SetTexture(normalMapKey, map1)
		end

		if mat.name == mat2Name and not self._rawMap2 and map2 then
			self._rawMap2 = mat:GetTexture(normalMapKey)

			mat:SetTexture(normalMapKey, map2)
		end

		if self._rawMap1 and self._rawMap2 then
			break
		end
	end

	if not self._rawMap1 or not self._rawMap2 then
		logError("WMZSkinInteraction _delayChangeNormalMaps can't find raw map", self._rawMap1, self._rawMap2)
	end
end

function WMZSkinInteraction:_playCameraAnim(animName)
	if not self._effectLoader then
		return
	end

	local path = self._effectUrl
	local assetItem = self._effectLoader:getAssetItem(path)

	if not assetItem then
		logError("WMZSkinInteraction _playCameraAnim can't find assetItem", path)

		return
	end

	local animatorInst = assetItem:GetResource(path)

	if not animatorInst then
		logError("WMZSkinInteraction _playCameraAnim can't find animatorInst", path)

		return
	end

	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = animatorInst
	animator.enabled = true

	animator:Play(animName, 0, 0)
end

function WMZSkinInteraction:_resetCamera()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	animator:Play(cameraAnimEnd, 0, 0)

	animator.runtimeAnimatorController = nil
end

function WMZSkinInteraction:_onDestroy()
	WMZSkinInteraction.super._onDestroy(self)
	TaskDispatcher.cancelTask(self._delayChangeNormalMaps, self)
	TaskDispatcher.cancelTask(self._delayResetNormalMaps, self)

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	self:_resetCamera()

	self._rawMap1 = nil
	self._rawMap2 = nil
end

return WMZSkinInteraction

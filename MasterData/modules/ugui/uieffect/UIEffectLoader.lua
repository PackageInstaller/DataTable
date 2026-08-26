-- chunkname: @modules/ugui/uieffect/UIEffectLoader.lua

module("modules.ugui.uieffect.UIEffectLoader", package.seeall)

local UIEffectLoader = class("UIEffectLoader")

function UIEffectLoader:ctor()
	return
end

local photographerPool = SLFramework.EffectPhotographerPool.Instance

function UIEffectLoader:Init(effectPath, width, height)
	self._effectPath = effectPath
	self._width = width
	self._height = height
	self._photographer = photographerPool:Get(width, height)
	self._refCount = 0
end

function UIEffectLoader:startLoad()
	if self._loader then
		return
	end

	local effectPath = self._effectPath
	local loader = MultiAbLoader.New()

	self._loader = loader

	loader:addPath(effectPath)

	local materialPath = "ui/materials/dynamic/ui_photo_additive.mat"

	loader:addPath(materialPath)
	loader:startLoad(function(multiAbLoader)
		if self:CheckDispose() then
			return
		end

		local assetItem = loader:getAssetItem(effectPath)
		local mainPrefab = assetItem:GetResource(effectPath)
		local effectGo = gohelper.clone(mainPrefab, nil, effectPath)

		effectGo:SetActive(false)
		SLFramework.GameObjectHelper.SetLayer(effectGo, photographerPool.DefaultEffectLayer, true)
		effectGo.transform:SetParent(self._photographer.effectRootGo.transform, false)
		effectGo:SetActive(true)

		self._effectGo = effectGo

		if self._loadcallback ~= nil then
			self._loadcallback(self._callbackTarget)
		end

		assetItem = loader:getAssetItem(materialPath)

		local material = assetItem:GetResource(materialPath)

		self._material = material

		for i, rawImage in ipairs(self._rawImageList) do
			rawImage.material = material
		end
	end)
end

function UIEffectLoader:GetPhotographer()
	self._refCount = self._refCount + 1

	return self._photographer
end

function UIEffectLoader:getEffectGo()
	return self._effectGo
end

function UIEffectLoader:getEffect(rawImage, loadcallback, callbackTarget)
	local photographer = self:GetPhotographer()

	rawImage.texture = photographer.renderTexture

	if self._material then
		rawImage.material = self._material

		return
	end

	self._rawImageList = self._rawImageList or {}

	table.insert(self._rawImageList, rawImage)

	self._loadcallback = loadcallback
	self._callbackTarget = callbackTarget

	self:startLoad()
end

function UIEffectLoader:ReduceRef()
	self._refCount = self._refCount - 1

	self:CheckDispose()
end

function UIEffectLoader:CheckDispose()
	if self._refCount <= 0 then
		if not self._loader then
			return true
		end

		self._loader:dispose()

		self._loader = nil
		self._rawImageList = nil
		self._material = nil

		photographerPool:Put(self._photographer)

		self._photographer = nil

		if self._effectGo then
			gohelper.destroy(self._effectGo)

			self._effectGo = nil
		end

		UIEffectManager.instance:_delEffectLoader(self._effectPath, self._width, self._height)

		return true
	end
end

return UIEffectLoader

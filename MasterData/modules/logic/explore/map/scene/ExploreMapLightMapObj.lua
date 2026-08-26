-- chunkname: @modules/logic/explore/map/scene/ExploreMapLightMapObj.lua

module("modules.logic.explore.map.scene.ExploreMapLightMapObj", package.seeall)

local ExploreMapLightMapObj = class("ExploreMapLightMapObj", UserDataDispose)

function ExploreMapLightMapObj:ctor(lightmapData, config, emptRes, lightmapColorAssetItem, lightmapDirAssetItem)
	self:__onInit()

	self.isActive = false
	self._lightmapData = lightmapData
	self._emptRes = emptRes
	self._lightmapColorAssetItem = lightmapColorAssetItem
	self._lightmapDirAssetItem = lightmapDirAssetItem
	self.lightmapColorPath = config[1]
	self.lightmapDirPath = config[2]
end

function ExploreMapLightMapObj:show()
	self.isActive = true

	self:updateLightMap()
end

function ExploreMapLightMapObj:hide()
	self.isActive = false

	self:updateLightMap()
end

function ExploreMapLightMapObj:updateLightMap(assetMO)
	if self.isActive then
		self._colorRes = self._colorRes or self._lightmapColorAssetItem:GetResource(self.lightmapColorPath)
		self._dirRes = self._dirRes or self._lightmapDirAssetItem:GetResource(self.lightmapDirPath)
		self._lightmapData.lightmapColor = self._colorRes
		self._lightmapData.lightmapDir = self._dirRes
	else
		self:_clear()

		self._lightmapData.lightmapColor = self._emptRes
		self._lightmapData.lightmapDir = self._emptRes
	end
end

function ExploreMapLightMapObj:dispose()
	self:_clear()

	self._lightmapData = nil
	self._lightmapColorAssetItem = nil
	self._lightmapDirAssetItem = nil

	self:__onDispose()
end

function ExploreMapLightMapObj:_clear()
	if self._colorRes then
		UnityEngine.Resources.UnloadAsset(self._colorRes)
	end

	if self._dirRes then
		UnityEngine.Resources.UnloadAsset(self._dirRes)
	end

	self._dirRes = nil
	self._colorRes = nil
end

return ExploreMapLightMapObj

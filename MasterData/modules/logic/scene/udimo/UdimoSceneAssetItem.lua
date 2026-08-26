-- chunkname: @modules/logic/scene/udimo/UdimoSceneAssetItem.lua

module("modules.logic.scene.udimo.UdimoSceneAssetItem", package.seeall)

local UdimoSceneAssetItem = class("UdimoSceneAssetItem")

function UdimoSceneAssetItem:ctor()
	self._abPath = nil
	self._refCount = 0
	self._resCacheDict = nil
	self._assetItem = nil
	self._createTime = 0
end

function UdimoSceneAssetItem:isInitialized()
	return not string.nilorempty(self._abPath)
end

function UdimoSceneAssetItem:init(assetItem, abPath)
	local isInit = self:isInitialized()

	if isInit then
		logError(string.format("UdimoSceneAssetItem init error, ab: %s", tostring(abPath)))

		return
	end

	self._abPath = abPath
	self._refCount = 0
	self._resCacheDict = {}
	self._assetItem = assetItem

	assetItem:Retain()

	self._createTime = Time.time
end

function UdimoSceneAssetItem:retain()
	local isInit = self:isInitialized()

	if not isInit then
		return
	end

	self._refCount = self._refCount + 1
end

function UdimoSceneAssetItem:release()
	local isInit = self:isInitialized()

	if not isInit then
		return
	end

	self._refCount = self._refCount - 1

	if self._refCount <= 0 then
		self:dispose()
	end
end

function UdimoSceneAssetItem:dispose()
	self._abPath = nil

	if self._resCacheDict then
		for resPath, _ in pairs(self._resCacheDict) do
			self._resCacheDict[resPath] = nil
		end

		self._resCacheDict = nil
	end

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	self._refCount = 0
end

function UdimoSceneAssetItem:getResource(resPath)
	local isInit = self:isInitialized()

	if not isInit then
		return
	end

	local assetRes = self._resCacheDict[resPath]

	if assetRes then
		return assetRes
	end

	assetRes = self._assetItem:GetResource(resPath)
	self._resCacheDict[resPath] = assetRes

	if not assetRes then
		logError(string.format("UdimoSceneAssetItem:getResource error, res:%s, ab:%s", tostring(resPath), tostring(self._abPath)))
	end

	return assetRes
end

function UdimoSceneAssetItem:getCreateTime()
	return self._createTime
end

return UdimoSceneAssetItem

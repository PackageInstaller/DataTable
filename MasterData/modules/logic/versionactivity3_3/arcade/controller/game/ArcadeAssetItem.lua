-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/ArcadeAssetItem.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.ArcadeAssetItem", package.seeall)

local ArcadeAssetItem = class("ArcadeAssetItem")

function ArcadeAssetItem:ctor()
	self._abPath = nil
	self._initialized = false
	self._resCacheDict = nil
	self._assetItem = nil
	self._refCount = 0
end

function ArcadeAssetItem:init(assetItem, abPath)
	if self._initialized then
		logError(string.format("ArcadeAssetItem init error, ab: %s", tostring(abPath)))

		return
	end

	self._abPath = abPath
	self._initialized = true
	self._refCount = 0
	self._resCacheDict = {}
	self._assetItem = assetItem

	assetItem:Retain()
end

function ArcadeAssetItem:retain()
	if not self._initialized then
		return
	end

	self._refCount = self._refCount + 1
end

function ArcadeAssetItem:getResource(resPath)
	if not self._initialized then
		return
	end

	local assetRes = self._resCacheDict[resPath]

	if assetRes then
		return assetRes
	end

	assetRes = self._assetItem:GetResource(resPath)
	self._resCacheDict[resPath] = assetRes

	if not assetRes then
		logError(string.format("ArcadeAssetItem:getResource error, res:%s, ab:%s", tostring(resPath), tostring(self._abPath)))
	end

	return assetRes
end

function ArcadeAssetItem:release()
	if not self._initialized then
		return
	end

	self._refCount = self._refCount - 1

	if self._refCount <= 0 then
		self:_dispose()
	end
end

function ArcadeAssetItem:_dispose()
	self._initialized = false
	self._abPath = nil

	if self._resCacheDict then
		for resPath, _ in pairs(self._resCacheDict) do
			self._resCacheDict[resPath] = nil
		end
	end

	self._resCacheDict = nil

	if self._assetItem then
		self._assetItem:Release()
	end

	self._assetItem = nil
	self._refCount = 0
end

return ArcadeAssetItem

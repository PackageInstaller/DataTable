-- chunkname: @modules/logic/scene/room/asset/RoomAssetItem.lua

module("modules.logic.scene.room.asset.RoomAssetItem", package.seeall)

local RoomAssetItem = class("RoomAssetItem")

function RoomAssetItem:ctor()
	self._initialized = false
	self.createTime = 0
	self._refCount = 0
end

function RoomAssetItem:init(assetItem, adPath)
	if self._initialized then
		logError(string.format("初始化失败: [RoomAssetItem] ab: %s", tostring(adPath)))

		return
	end

	self._refCount = 0
	self._abPath = adPath
	self._initialized = true
	self._assetItem = assetItem

	assetItem:Retain()

	self._cacheResourceDict = {}
	self.createTime = Time.time
end

function RoomAssetItem:getResource(resPath)
	if not self._initialized then
		return
	end

	local assetRes = self._cacheResourceDict[resPath]

	if assetRes then
		return assetRes
	end

	assetRes = self._assetItem:GetResource(resPath)
	self._cacheResourceDict[resPath] = assetRes

	if not assetRes then
		logError(string.format("获取资源失败, [RoomAssetItem] res: %s, ab: %s", tostring(resPath), tostring(self._abPath)))
	end

	return assetRes
end

function RoomAssetItem:dispose()
	self._initialized = false

	if self._cacheResourceDict then
		local target = self._cacheResourceDict

		self._cacheResourceDict = nil

		for resPath, _ in pairs(target) do
			target[resPath] = nil
		end
	end

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	self._refCount = 0
end

function RoomAssetItem:retain()
	if self._initialized then
		self._refCount = self._refCount + 1
	end
end

function RoomAssetItem:release()
	if not self._initialized then
		return
	end

	if self._refCount <= 1 then
		self._refCount = 0

		self:dispose()
	else
		self._refCount = self._refCount - 1
	end
end

RoomAssetItem.GetResource = RoomAssetItem.getResource
RoomAssetItem.Release = RoomAssetItem.release
RoomAssetItem.Retain = RoomAssetItem.retain
RoomAssetItem.Dispose = RoomAssetItem.dispose

return RoomAssetItem

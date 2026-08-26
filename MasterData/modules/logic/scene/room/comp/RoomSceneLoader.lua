-- chunkname: @modules/logic/scene/room/comp/RoomSceneLoader.lua

module("modules.logic.scene.room.comp.RoomSceneLoader", package.seeall)

local RoomSceneLoader = class("RoomSceneLoader", BaseSceneComp)

function RoomSceneLoader:onInit()
	self._assetItemDict = {}
	self._loader = nil
	self._needLoadList = {}
	self._needLoadDict = {}
	self._callbackList = {}
	self._loaderList = {}
	self._initialized = false
end

function RoomSceneLoader:init(sceneId, levelId)
	self._initialized = true
end

function RoomSceneLoader:isLoaderInProgress()
	if self._loader then
		return true
	end

	if self._needLoadList and #self._needLoadList > 0 then
		return true
	end

	return false
end

function RoomSceneLoader:makeSureLoaded(resPathList, callback, callbackObj)
	if not self._initialized then
		return
	end

	local needLoadList
	local preloader = self:getCurScene().preloader

	for _, resPath in ipairs(resPathList) do
		if not preloader:exist(resPath) then
			needLoadList = needLoadList or {}

			table.insert(needLoadList, resPath)
		end
	end

	if not needLoadList then
		callback(callbackObj)

		return
	end

	local loader = MultiAbLoader.New()

	table.insert(self._loaderList, loader)
	loader:setPathList(needLoadList)
	loader:startLoad(function(...)
		self:_onLoadFinish(loader)
		callback(callbackObj)
	end, self)
end

function RoomSceneLoader:_delayStartLoad()
	local list = self._needLoadList

	self._needLoadList = {}
	self._needLoadDict = {}
	self._loader = MultiAbLoader.New()

	self._loader:setPathList(list)
	self._loader:startLoad(self._onLoadFinish, self)
end

function RoomSceneLoader:_onLoadFinish(loader)
	local dict = loader:getAssetItemDict()
	local preloader = self:getCurScene().preloader

	for url, assetItem in pairs(dict) do
		preloader:addAssetItem(url, assetItem)
	end

	tabletool.removeValue(self._loaderList, loader)
	loader:dispose()
end

function RoomSceneLoader:onSceneClose()
	self._initialized = false

	TaskDispatcher.cancelTask(self._delayStartLoad, self)

	for i, v in ipairs(self._loaderList) do
		v:dispose()
	end

	self._loaderList = {}

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return RoomSceneLoader

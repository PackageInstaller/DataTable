-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneLoader.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneLoader", package.seeall)

local UdimoSceneLoader = class("UdimoSceneLoader", BaseSceneComp)

function UdimoSceneLoader:onInit()
	self._initialized = false
	self._assetItemDict = nil
	self._loaderDataList = nil
end

function UdimoSceneLoader:init(sceneId, levelId)
	self._assetItemDict = {}
	self._loaderDataList = {}
	self._initialized = true
end

function UdimoSceneLoader:onSceneStart(sceneId, levelId)
	return
end

function UdimoSceneLoader:makeSureLoaded(resPathList, cb, cbObj)
	if not self._initialized then
		return
	end

	local needLoadList = {}

	for _, resPath in ipairs(resPathList) do
		local hasLoaded = self:hasLoadedAsset(resPath)

		if not hasLoaded then
			table.insert(needLoadList, resPath)
		end
	end

	if #needLoadList <= 0 then
		if cb then
			cb(cbObj)
		end

		return
	end

	local loader = MultiAbLoader.New()

	table.insert(self._loaderDataList, {
		loader = loader,
		cb = cb,
		cbObj = cbObj
	})
	loader:setPathList(needLoadList)
	loader:startLoad(self._onLoadFinish, self)
end

function UdimoSceneLoader:_onLoadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self:_addAssetItem(url, assetItem)
	end

	local findIndex, loadData

	for i, tmpData in ipairs(self._loaderDataList) do
		if tmpData.loader == loader then
			findIndex = i
			loadData = tmpData

			break
		end
	end

	if findIndex and loadData then
		loadData.loader:dispose()

		if loadData.cb then
			loadData.cb(loadData.cbObj)
		end

		table.remove(self._loaderDataList, findIndex)
	end
end

function UdimoSceneLoader:_addAssetItem(url, assetItem)
	if not self._initialized or self._assetItemDict[url] then
		return
	end

	local udimoAssetItem = UdimoSceneAssetItem.New()

	udimoAssetItem:init(assetItem, url)
	udimoAssetItem:retain()

	self._assetItemDict[url] = udimoAssetItem
end

function UdimoSceneLoader:_getAssetItem(url)
	return self._assetItemDict and self._assetItemDict[url]
end

function UdimoSceneLoader:hasLoadedAsset(url)
	local assetItem = self:_getAssetItem(url)

	return not not assetItem
end

function UdimoSceneLoader:getResource(res, ab)
	local url = res

	url = not GameResMgr.IsFromEditorDir and ab or url

	local assetItem = self:_getAssetItem(url)

	if assetItem then
		return assetItem:getResource(res)
	end
end

function UdimoSceneLoader:_releaseAssetItemDict()
	if self._assetItemDict then
		for _, assetItem in pairs(self._assetItemDict) do
			assetItem:release()
		end
	end

	self._assetItemDict = nil
end

function UdimoSceneLoader:onSceneClose()
	self._initialized = false

	for _, loaderData in ipairs(self._loaderDataList) do
		loaderData.loader:dispose()
	end

	self._loaderDataList = nil

	self:_releaseAssetItemDict()
end

return UdimoSceneLoader

-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/comp/ArcadeLoader.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.comp.ArcadeLoader", package.seeall)

local ArcadeLoader = class("ArcadeLoader", ArcadeBaseSceneComp)

function ArcadeLoader:onInit()
	self._assetItemDict = {}
	self._loaderDict = {}
end

function ArcadeLoader:loadRes(resPath, cb, cbObj, cbParam)
	if not self._initialized then
		return
	end

	local assetItem = self:_getAssetItem(resPath)

	if not assetItem then
		local loader = MultiAbLoader.New()

		self._loaderDict[loader] = {
			cb = cb,
			cbObj = cbObj,
			cbParam = cbParam
		}

		loader:addPath(resPath)
		loader:startLoad(self._onLoadFinish, self)
	else
		ArcadeGameHelper.callCallbackFunc(cb, cbObj, cbParam)
	end
end

function ArcadeLoader:loadResList(resPathList, cb, cbObj, cbParam)
	if not self._initialized then
		return
	end

	local needLoadList = {}

	for _, resPath in ipairs(resPathList) do
		local assetItem = self:_getAssetItem(resPath)

		if not assetItem then
			table.insert(needLoadList, resPath)
		end
	end

	if #needLoadList > 0 then
		local loader = MultiAbLoader.New()

		self._loaderDict[loader] = {
			cb = cb,
			cbObj = cbObj,
			cbParam = cbParam
		}

		loader:setPathList(needLoadList)
		loader:startLoad(self._onLoadFinish, self)
	else
		ArcadeGameHelper.callCallbackFunc(cb, cbObj, cbParam)
	end
end

function ArcadeLoader:getResource(res, ab)
	local url = res

	url = not GameResMgr.IsFromEditorDir and ab or url

	local assetItem = self:_getAssetItem(url)

	if assetItem then
		return assetItem:getResource(res)
	end
end

function ArcadeLoader:_onLoadFinish(loader)
	if not self._initialized then
		return
	end

	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self:_addAssetItem(url, assetItem)
	end

	local loaderData = self._loaderDict[loader]

	if loaderData then
		local cb = loaderData.cb
		local cbObj = loaderData.cbObj
		local cbParam = loaderData.cbParam

		ArcadeGameHelper.callCallbackFunc(cb, cbObj, cbParam)
	end

	self._loaderDict[loader] = nil

	loader:dispose()
end

function ArcadeLoader:_addAssetItem(url, assetItem)
	if not self._initialized or self._assetItemDict[url] then
		return
	end

	local arcadeAssetItem = ArcadeAssetItem.New()

	arcadeAssetItem:init(assetItem, url)
	arcadeAssetItem:retain()

	self._assetItemDict[url] = arcadeAssetItem
end

function ArcadeLoader:_getAssetItem(url)
	return self._assetItemDict and self._assetItemDict[url]
end

function ArcadeLoader:_clearLoaderDict()
	for loader, _ in pairs(self._loaderDict) do
		loader:dispose()
	end

	self._loaderDict = nil
end

function ArcadeLoader:_releaseAssetItemDict()
	if self._assetItemDict then
		for _, assetItem in pairs(self._assetItemDict) do
			assetItem:release()
		end
	end

	self._assetItemDict = nil
end

function ArcadeLoader:onClear()
	self:_clearLoaderDict()
	self:_releaseAssetItemDict()
end

return ArcadeLoader

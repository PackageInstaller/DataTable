-- chunkname: @modules/logic/scene/summon/comp/SummonScenePreloader.lua

module("modules.logic.scene.summon.comp.SummonScenePreloader", package.seeall)

local SummonScenePreloader = class("SummonScenePreloader", BaseSceneComp)

function SummonScenePreloader:onSceneStart(sceneId, levelId)
	self._isImageLoad = false
	self._assetItemDict = {}
	self._assetItemList = {}

	self:_startLoadImage()
end

function SummonScenePreloader:_startLoadImage()
	local imageUrlList = SummonMainController.instance:pickAllUIPreloadRes()

	if #imageUrlList > 0 then
		self._uiLoader = SequenceAbLoader.New()

		self._uiLoader:setPathList(imageUrlList)
		self._uiLoader:setConcurrentCount(5)
		self._uiLoader:startLoad(self._onUIPreloadFinish, self)
	end
end

function SummonScenePreloader:_onUIPreloadFinish()
	local assetItemDict = self._uiLoader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		assetItem:Retain()

		self._assetItemDict[url] = assetItem

		table.insert(self._assetItemList, assetItem)
	end

	if self._uiLoader then
		self._uiLoader:dispose()

		self._uiLoader = nil
	end

	self._isImageLoad = true
end

function SummonScenePreloader:getAssetItem(path)
	local assetItem = self._assetItemDict[path]

	if assetItem then
		return assetItem
	end
end

function SummonScenePreloader:onSceneClose()
	if self._uiLoader then
		self._uiLoader:dispose()

		self._uiLoader = nil
	end

	if self._assetItemList and #self._assetItemList > 0 then
		for _, assetItem in ipairs(self._assetItemList) do
			assetItem:Release()
		end

		self._assetItemList = {}
		self._assetItemDict = {}
	end
end

function SummonScenePreloader:onSceneHide()
	self:onSceneClose()
end

return SummonScenePreloader

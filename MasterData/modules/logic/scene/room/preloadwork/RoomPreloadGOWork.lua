-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadGOWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadGOWork", package.seeall)

local RoomPreloadGOWork = class("RoomPreloadGOWork", BaseWork)

function RoomPreloadGOWork:onStart(context)
	local uiUrlList = self:_getUIUrlList()

	self._loader = MultiAbLoader.New()

	for _, resPath in ipairs(uiUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function RoomPreloadGOWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function RoomPreloadGOWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadGOWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadGOWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadGOWork:_getUIUrlList()
	local urlList = {}

	if RoomController.instance:isEditMode() then
		table.insert(urlList, RoomScenePreloader.ResEffectB)
		table.insert(urlList, RoomScenePreloader.ResVXPlacingHere)
		table.insert(urlList, RoomScenePreloader.ResSmoke)
		table.insert(urlList, RoomScenePreloader.ResSmokeSnow)
	end

	if RoomController.instance:isObMode() then
		table.insert(urlList, RoomScenePreloader.ResEffectE)
		table.insert(urlList, RoomScenePreloader.ResEffectD01)
		table.insert(urlList, RoomScenePreloader.ResEffectD02)
		table.insert(urlList, RoomScenePreloader.ResEffectD05)
		table.insert(urlList, RoomScenePreloader.ResVXXuXian)
		table.insert(urlList, RoomScenePreloader.ResCharacterClickHelper)
		table.insert(urlList, RoomScenePreloader.ResEffectConfirmCharacter)
		table.insert(urlList, RoomScenePreloader.ResEffectCharacterShadow)
		table.insert(urlList, RoomScenePreloader.ResEffectPressingCharacter)
		table.insert(urlList, RoomScenePreloader.ResEffectPlaceCharacter)
		table.insert(urlList, RoomScenePreloader.ResCharacterFaithEffect)
	end

	if RoomController.instance:isVisitMode() then
		table.insert(urlList, RoomScenePreloader.ResEffectCharacterShadow)
	end

	for _, res in ipairs(RoomScenePreloader.ResEffectWaveList) do
		table.insert(urlList, res)
	end

	for _, res in ipairs(RoomScenePreloader.ResEffectWaveWithRiverList) do
		table.insert(urlList, res)
	end

	table.insert(urlList, RoomScenePreloader.ResOcean)

	if RoomController.instance:isDebugPackageMode() then
		for _, res in pairs(RoomScenePreloader.ResDebugPackageColorDict) do
			table.insert(urlList, res)
		end
	end

	for _, res in ipairs(RoomScenePreloader.ResCommonList) do
		table.insert(urlList, res)
	end

	table.insert(urlList, RoomScenePreloader.ResFogParticle)

	for i, url in ipairs(urlList) do
		self.context.poolGODict[url] = 6
	end

	return urlList
end

return RoomPreloadGOWork

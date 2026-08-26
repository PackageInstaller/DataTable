-- chunkname: @modules/logic/versionactivity3_9/racingcar/scene/preloadwork/V3a9RacingCarScenePreloadGOWork.lua

module("modules.logic.versionactivity3_9.racingcar.scene.preloadwork.V3a9RacingCarScenePreloadGOWork", package.seeall)

local V3a9RacingCarScenePreloadGOWork = class("V3a9RacingCarScenePreloadGOWork", BaseWork)

function V3a9RacingCarScenePreloadGOWork:onStart(context)
	local goUrlList = self:_getGOUrlList()

	self._loader = MultiAbLoader.New()

	for _, resPath in ipairs(goUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function V3a9RacingCarScenePreloadGOWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function V3a9RacingCarScenePreloadGOWork:_onPreloadOneFail(loader, assetItem)
	logError("V3a9RacingCarScenePreloadGOWork: 加载失败, url: " .. assetItem.ResPath)
end

function V3a9RacingCarScenePreloadGOWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function V3a9RacingCarScenePreloadGOWork:_getGOUrlList()
	local urlList = {}

	for _, res in ipairs(V3a9RacingCarScenePreloader.resList) do
		table.insert(urlList, res)
	end

	V3a9RacingCarScenePreloader.Tuowei = V3a9RacingCarScenePreloader.getTuoweiPrefab()

	table.insert(urlList, V3a9RacingCarScenePreloader.Tuowei)
	table.insert(urlList, V3a9RacingCarScenePreloadGOWork.getDolphinPrefab(V3a9RacingCarModel.instance:getMainPlayerRacer().dolphinPrefab))

	local aiRacers = V3a9RacingCarModel.instance:getAiRacers()
	local aiRacersList = string.splitToNumber(aiRacers, "#")

	for i, v in ipairs(aiRacersList) do
		local aiRacerConfig = lua_racing_racer.configDict[v]

		if aiRacerConfig then
			table.insert(urlList, V3a9RacingCarScenePreloadGOWork.getDolphinPrefab(aiRacerConfig.dolphinPrefab))
		end
	end

	return urlList
end

function V3a9RacingCarScenePreloadGOWork.getDolphinPrefab(path)
	return "scenes/v3a9_m_s21_racing_games/scene/" .. path
end

return V3a9RacingCarScenePreloadGOWork

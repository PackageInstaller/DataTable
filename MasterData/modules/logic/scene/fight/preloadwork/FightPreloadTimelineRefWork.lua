-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadTimelineRefWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadTimelineRefWork", package.seeall)

local FightPreloadTimelineRefWork = class("FightPreloadTimelineRefWork", BaseWork)

function FightPreloadTimelineRefWork:onStart(context)
	self._urlDict = self:_getUrlList()
	self._loader = SequenceAbLoader.New()

	for resPath, _ in pairs(self._urlDict) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onOneLoadFail)
	self._loader:setConcurrentCount(10)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightPreloadTimelineRefWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightPreloadTimelineRefWork:_onOneLoadFail(_, assetItem)
	local url = assetItem.ResPath

	logError("预加载战斗Timeline引用资源失败！\nTimeline: " .. self._urlDict[url] .. "\n引用资源: " .. url)
end

function FightPreloadTimelineRefWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
		FightPreloadController.instance:addTimelineRefAsset(assetItem)
	end

	TaskDispatcher.runDelay(self._delayDone, self, 0.001)
end

function FightPreloadTimelineRefWork:_delayDone()
	self:onDone(true)
end

function FightPreloadTimelineRefWork:_getUrlList()
	local urlDict = {}

	for timelineUrl, tlAssetItem in pairs(self.context.timelineDict) do
		local jsonArr = FightTLHelper.getTLJsonData(tlAssetItem, timelineUrl)

		for i = 1, #jsonArr, 2 do
			local tlType = tonumber(jsonArr[i])
			local paramList = jsonArr[i + 1]

			if tlType == 30 then
				-- block empty
			elseif tlType == 31 then
				-- block empty
			elseif tlType == 32 then
				local resName = paramList[2]

				if not string.nilorempty(resName) then
					urlDict[ResUrl.getRoleSpineMatTex(resName)] = timelineUrl
				end
			elseif tlType == 11 then
				if not self.context.timelineSkinDict[timelineUrl] then
					local skinIdDict = {}

					for skinId, _ in pairs(skinIdDict) do
						local spineName = FightTLEventCreateSpine.getSkinSpineName(paramList[1], skinId)

						if not string.nilorempty(spineName) then
							if string.sub(spineName, 1, 8) == "roles_3d" then
								urlDict[string.format("%s.prefab", spineName)] = timelineUrl
							else
								urlDict[ResUrl.getSpineFightPrefab(spineName)] = timelineUrl
							end
						end
					end
				end
			end
		end
	end

	return urlDict
end

return FightPreloadTimelineRefWork

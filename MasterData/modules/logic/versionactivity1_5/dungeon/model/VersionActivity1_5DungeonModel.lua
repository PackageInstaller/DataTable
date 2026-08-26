-- chunkname: @modules/logic/versionactivity1_5/dungeon/model/VersionActivity1_5DungeonModel.lua

module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5DungeonModel", package.seeall)

local VersionActivity1_5DungeonModel = class("VersionActivity1_5DungeonModel", BaseModel)

function VersionActivity1_5DungeonModel:onInit()
	return
end

function VersionActivity1_5DungeonModel:reInit()
	return
end

function VersionActivity1_5DungeonModel:init()
	self.dispatchInfoDict = {}
	self.elementId2DispatchMoDict = {}
	self.dispatchedHeroDict = {}
	self.needCheckDispatchInfoList = {}
end

function VersionActivity1_5DungeonModel:checkDispatchFinish()
	local len = #self.needCheckDispatchInfoList

	if len <= 0 then
		return
	end

	local needDispatchEvent = false

	for index = len, 1, -1 do
		local dispatchMo = self.needCheckDispatchInfoList[index]

		if dispatchMo:isFinish() then
			needDispatchEvent = true

			for _, heroId in ipairs(dispatchMo.heroIdList) do
				self.dispatchedHeroDict[heroId] = nil
			end

			table.remove(self.needCheckDispatchInfoList, index)
		end
	end

	if needDispatchEvent then
		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnDispatchFinish)
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.V1a5DungeonExploreTask
		})
	end
end

function VersionActivity1_5DungeonModel:addDispatchInfos(dispatchInfos)
	for _, dispatchInfo in ipairs(dispatchInfos) do
		local dispatchMo = self.dispatchInfoDict[dispatchInfo.id]

		if not dispatchMo then
			dispatchMo = VersionActivity1_5DispatchMo.New()

			dispatchMo:init(dispatchInfo)

			self.dispatchInfoDict[dispatchInfo.id] = dispatchMo
		else
			dispatchMo:update(dispatchInfo)
		end

		if dispatchMo:isRunning() then
			for _, heroId in ipairs(dispatchInfo.heroIds) do
				self.dispatchedHeroDict[heroId] = true
			end

			table.insert(self.needCheckDispatchInfoList, dispatchMo)
		end
	end
end

function VersionActivity1_5DungeonModel:addOneDispatchInfo(dispatchId, endTime, heroIds)
	local dispatchMo = VersionActivity1_5DispatchMo.New()

	dispatchMo:init({
		id = dispatchId,
		endTime = endTime,
		heroIds = heroIds
	})

	self.dispatchInfoDict[dispatchId] = dispatchMo

	if dispatchMo:isRunning() then
		for _, heroId in ipairs(heroIds) do
			self.dispatchedHeroDict[heroId] = true
		end

		table.insert(self.needCheckDispatchInfoList, dispatchMo)
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.AddDispatchInfo, dispatchId)
end

function VersionActivity1_5DungeonModel:removeOneDispatchInfo(dispatchId)
	local dispatchMo = self.dispatchInfoDict[dispatchId]

	self.dispatchInfoDict[dispatchId] = nil

	for _, heroId in ipairs(dispatchMo.heroIdList) do
		self.dispatchedHeroDict[heroId] = nil
	end

	tabletool.removeValue(self.needCheckDispatchInfoList, dispatchMo)

	for elementId, _dispatchMo in pairs(self.elementId2DispatchMoDict) do
		if _dispatchMo.id == dispatchId then
			self.elementId2DispatchMoDict[elementId] = nil

			break
		end
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.RemoveDispatchInfo, dispatchId)
end

function VersionActivity1_5DungeonModel:getDispatchMo(dispatchId)
	return self.dispatchInfoDict[dispatchId]
end

function VersionActivity1_5DungeonModel:getDispatchStatus(dispatchId)
	local dispatchMo = self.dispatchInfoDict[dispatchId]

	if not dispatchMo then
		return VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch
	elseif dispatchMo:isFinish() then
		return VersionActivity1_5DungeonEnum.DispatchStatus.Finished
	else
		return VersionActivity1_5DungeonEnum.DispatchStatus.Dispatching
	end
end

function VersionActivity1_5DungeonModel:isDispatched(heroId)
	return self.dispatchedHeroDict[heroId]
end

function VersionActivity1_5DungeonModel:getElementCoList(mapId)
	local normalElementCoList = {}
	local shareElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivity1_5DungeonEnum.DungeonChapterId.Story then
			local elementExtendCo = lua_activity11502_episode_element.configDict[elementCo.id]

			if elementExtendCo and not string.nilorempty(elementExtendCo.mapIds) then
				local belongMapIdList = string.splitToNumber(elementExtendCo.mapIds, "#")

				if tabletool.indexOf(belongMapIdList, mapId) then
					table.insert(shareElementCoList, elementCo)
				end
			elseif mapId == elementCo.mapId then
				table.insert(normalElementCoList, elementCo)
			end
		end
	end

	return normalElementCoList, shareElementCoList
end

function VersionActivity1_5DungeonModel:getDispatchMoByElementId(elementId)
	local dispatchMo = self.elementId2DispatchMoDict[elementId]

	if dispatchMo then
		return dispatchMo
	end

	for _, _dispatchMo in pairs(self.dispatchInfoDict) do
		if _dispatchMo.config.elementId == elementId then
			self.elementId2DispatchMoDict[elementId] = _dispatchMo

			return _dispatchMo
		end
	end
end

function VersionActivity1_5DungeonModel:setShowInteractView(isShow)
	self.isShowInteractView = isShow
end

function VersionActivity1_5DungeonModel:checkIsShowInteractView()
	return self.isShowInteractView
end

VersionActivity1_5DungeonModel.instance = VersionActivity1_5DungeonModel.New()

return VersionActivity1_5DungeonModel

-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaModel.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaModel", package.seeall)

local TianShiNaNaModel = class("TianShiNaNaModel", BaseModel)

function TianShiNaNaModel:onInit()
	self.nowMapId = nil
	self._curState = TianShiNaNaEnum.CurState.None
	self.unitMos = {}
	self.nowScenePos = nil
	self.currEpisodeId = 0
	self._episodeStars = {}
	self.sceneLevelLoadFinish = false
	self.waitStartFlow = false
	self.waitClickJump = false
	self.statMo = nil
	self.curSelectIndex = 1
end

function TianShiNaNaModel:reInit()
	self:onInit()
end

function TianShiNaNaModel:initInfo(episodeInfos)
	local episodeIdToStar = {}

	for _, info in ipairs(episodeInfos) do
		if info.passChessGame then
			episodeIdToStar[info.episodeId] = info.star
		end
	end

	local stageCoList = TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	for i = 1, #stageCoList do
		if stageCoList[i].episodeType == 1 then
			self._episodeStars[i] = (stageCoList[i].storyBefore > 0 or nil) and StoryModel.instance:isStoryFinished(stageCoList[i].storyBefore) and 1 or 0
		elseif not episodeIdToStar[stageCoList[i].id] then
			self._episodeStars[i] = 0
		end
	end
end

function TianShiNaNaModel:markEpisodeFinish(index, star)
	self.currEpisodeId = 0

	if self._episodeStars[index] ~= star then
		local preStar = self._episodeStars[index]

		self._episodeStars[index] = star

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeStarChange, index, preStar, star)
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeFinish)
end

function TianShiNaNaModel:getEpisodeStar(index)
	return self._episodeStars[index] or 0
end

function TianShiNaNaModel:getUnLockMaxIndex()
	local index = 0

	while self:getEpisodeStar(index + 1) > 0 do
		index = index + 1
	end

	return index
end

function TianShiNaNaModel:initDatas(episodeId, scene)
	self.statMo = TianShiNaNaStatMo.New()
	self._curState = TianShiNaNaEnum.CurState.None
	self.episodeCo = lua_activity167_episode.configDict[VersionActivity2_2Enum.ActivityId.TianShiNaNa][episodeId]
	self.nowMapId = self.episodeCo.mapId

	local mapCo = TianShiNaNaConfig.instance:getMapCo(self.episodeCo.mapId)

	self.unitMos = {}
	self.mapCo = mapCo
	self.heroMo = nil
	self.nowRound = scene.currentRound
	self.stepCount = scene.stepCount

	for _, interact in ipairs(scene.interact) do
		local id = interact.id
		local unitCo = mapCo:getUnitCo(id)

		if unitCo then
			local unitMo = TianShiNaNaMapUnitMo.New()

			unitMo:init(unitCo)
			unitMo:updatePos(interact.x, interact.y, interact.direction)
			unitMo:setActive(interact.active)

			self.unitMos[unitCo.id] = unitMo

			if unitCo.unitType == TianShiNaNaEnum.UnitType.Player then
				self.heroMo = unitMo
			end
		else
			logError(string.format("天使娜娜地图 %d 元件 %d 不存在", self.nowMapId, id))
		end
	end

	self.remainCubeList = string.splitToNumber(self.episodeCo.cubeList, "#")
	self.totalRound = #self.remainCubeList

	if not self.heroMo then
		logError(string.format("天使娜娜地图 %d 角色元件不存在", self.nowMapId))
	end

	self.curOperList = {}
	self.curPointList = {}
	self.waitClickJump = false
end

function TianShiNaNaModel:sendStat(result)
	if self.statMo then
		self.statMo:sendStatData(result)

		self.statMo = nil
	end
end

function TianShiNaNaModel:isWaitClick()
	return self._curState == TianShiNaNaEnum.CurState.DoStep and self.waitClickJump
end

function TianShiNaNaModel:resetScene(scene, isReset)
	if self.statMo then
		if isReset then
			self.statMo:sendStatData("重置")
			self.statMo:reset()
		else
			self.statMo:addBackNum()
		end
	else
		self.statMo = TianShiNaNaStatMo.New()
	end

	TianShiNaNaController.instance:clearFlow()

	self.waitClickJump = false
	self.nowRound = scene.currentRound
	self.stepCount = scene.stepCount

	local preIds = {}

	for id in pairs(self.unitMos) do
		preIds[id] = true
	end

	local mapCo = self.mapCo

	for _, interact in ipairs(scene.interact) do
		local id = interact.id

		if preIds[id] then
			preIds[id] = nil
		end

		local unitMo = self.unitMos[id]

		if unitMo then
			unitMo:updatePos(interact.x, interact.y, interact.direction)
			unitMo:setActive(interact.active)

			local entity = TianShiNaNaEntityMgr.instance:getEntity(id)

			if entity then
				entity:updatePosAndDir()
			end
		else
			local unitCo = mapCo:getUnitCo(id)

			if unitCo then
				unitMo = TianShiNaNaMapUnitMo.New()

				unitMo:init(unitCo)
				unitMo:updatePos(interact.x, interact.y, interact.direction)

				self.unitMos[unitCo.id] = unitMo

				if unitCo.unitType == TianShiNaNaEnum.UnitType.Player then
					self.heroMo = unitMo
				end
			else
				logError(string.format("天使娜娜地图 %d 元件 %d 不存在", self.nowMapId, id))
			end
		end
	end

	for id in pairs(preIds) do
		self:removeUnit(id)
	end

	self.curOperList = scene.operations
	self.curPointList = {}

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function TianShiNaNaModel:removeUnit(id)
	if self.unitMos[id] then
		TianShiNaNaEntityMgr.instance:removeEntity(id)

		self.unitMos[id] = nil
	end
end

function TianShiNaNaModel:getNextCubeType()
	if not self.remainCubeList then
		return
	end

	return self.remainCubeList[self.nowRound + 1]
end

function TianShiNaNaModel:setState(state)
	if state ~= self._curState then
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.StatuChange, self._curState, state)

		self._curState = state
	end
end

function TianShiNaNaModel:getState()
	return self._curState
end

function TianShiNaNaModel:getHeroMo()
	return self.heroMo
end

function TianShiNaNaModel:isNodeCanPlace(x, y, isCheckNodeType)
	if not self.nowMapId then
		return false
	end

	for k, v in pairs(self.unitMos) do
		if v:isPosEqual(x, y) and not v:canWalk() then
			return false
		end
	end

	local nodeCo = self.mapCo:getNodeCo(x, y)

	if not nodeCo or isCheckNodeType and nodeCo and nodeCo.nodeType == TianShiNaNaEnum.NodeType.Swamp then
		return false
	end

	if not nodeCo.walkable then
		return false
	end

	if nodeCo:isCollapse() then
		return false
	end

	return true
end

TianShiNaNaModel.instance = TianShiNaNaModel.New()

return TianShiNaNaModel

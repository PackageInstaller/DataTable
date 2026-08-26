-- chunkname: @modules/logic/tower/model/TowerPermanentModel.lua

module("modules.logic.tower.model.TowerPermanentModel", package.seeall)

local TowerPermanentModel = class("TowerPermanentModel", MixScrollModel)

function TowerPermanentModel:onInit()
	self:initDataInfo()
end

function TowerPermanentModel:reInit()
	self:initDataInfo()

	self.curPassLayer = 0
	self.lastPassLayer = 0
	self.localCurPassLayer = -1
end

function TowerPermanentModel:initDataInfo()
	self.permanentMoList = {}
	self.ItemType = 1
	self.PermanentInfoMap = {}
	self.defaultStage = 1
	self.curSelectStage = 1
	self.curSelectLayer = 1
	self.curSelectEpisodeId = 0
	self.realSelectMap = {}
end

function TowerPermanentModel:cleanData()
	self:initDataInfo()
end

function TowerPermanentModel:initDefaultSelectStage(curPermanentMo)
	if curPermanentMo then
		self.curPassLayer = curPermanentMo.passLayerId or 0
	end

	if self.curPassLayer == 0 then
		self.defaultStage = 1
		self.curSelectLayer = 1
	else
		local defaultStage, curSelectLayer = self:getNewtStageAndLayer()

		self.defaultStage = defaultStage
		self.curSelectLayer = curSelectLayer
	end

	self.curSelectStage = self.defaultStage
	self.realSelectMap[self.curSelectStage] = self.curSelectLayer
end

function TowerPermanentModel:getNewtStageAndLayer()
	local defaultStage = 1
	local curSelectLayer = 1
	local permanentCo = TowerConfig.instance:getPermanentEpisodeCo(self.curPassLayer)
	local nextPermanentCo = TowerConfig.instance:getPermanentEpisodeCo(self.curPassLayer + 1)

	if not permanentCo then
		logError("该层配置为空，请检查：" .. self.curPassLayer)

		return defaultStage, curSelectLayer
	end

	if not nextPermanentCo then
		defaultStage = permanentCo.stageId
		curSelectLayer = self:getPassLayerIndex()
	elseif permanentCo.stageId ~= nextPermanentCo.stageId then
		local isNextStageUnlock = self:checkStageIsOnline(nextPermanentCo.stageId)

		if isNextStageUnlock then
			defaultStage = nextPermanentCo.stageId
			curSelectLayer = 1
		else
			defaultStage = permanentCo.stageId
			curSelectLayer = self:getPassLayerIndex()
		end
	else
		defaultStage = permanentCo.stageId
		curSelectLayer = self:getPassLayerIndex() + 1
	end

	return defaultStage, curSelectLayer
end

function TowerPermanentModel:getPassLayerIndex()
	local permanentCo = TowerConfig.instance:getPermanentEpisodeCo(self.curPassLayer)

	return permanentCo.index
end

function TowerPermanentModel:getStageCount()
	return self.defaultStage
end

function TowerPermanentModel:checkhasLockTip()
	return #self.permanentMoList > self.defaultStage
end

function TowerPermanentModel:InitData()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()

	self:initDefaultSelectStage(curPermanentMo)

	self.permanentMoList = {}

	for stage = 1, self.defaultStage do
		local ItemMo = self.PermanentInfoMap[stage]

		if not ItemMo then
			ItemMo = TowerPermanentMo.New()
			self.PermanentInfoMap[stage] = ItemMo
		end

		local permanentCoList = TowerConfig.instance:getPermanentEpisodeStageCoList(stage)

		ItemMo:init(stage, permanentCoList)
		table.insert(self.permanentMoList, ItemMo)
	end

	local nextStage = self.defaultStage + 1
	local nextPermanentCo = TowerConfig.instance:getPermanentEpisodeStageCoList(nextStage)
	local permanentTimeCo = TowerConfig.instance:getTowerPermanentTimeCo(nextStage)

	if (nextPermanentCo or permanentTimeCo) and nextStage < TowerDeepEnum.DeepLayerStage then
		local LockItemMo = TowerPermanentMo.New()

		self.PermanentInfoMap[nextStage] = LockItemMo

		LockItemMo:init(nextStage, {})
		table.insert(self.permanentMoList, LockItemMo)
	end

	self:setList(self.permanentMoList)
end

function TowerPermanentModel:initStageUnFoldState(stage)
	local curStage = stage or self:getCurSelectStage()

	for index, mo in ipairs(self.permanentMoList) do
		mo:setIsUnFold(mo.stage == curStage)
	end
end

function TowerPermanentModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local isUnFold = mo:getIsUnFold()
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(self.ItemType, mo:getStageHeight(isUnFold), i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

function TowerPermanentModel:getCurContentTotalHeight()
	local list = self:getList()
	local totalHeight = 0

	for i, mo in ipairs(list) do
		local isUnFold = mo:getIsUnFold()

		totalHeight = totalHeight + mo:getStageHeight(mo:getIsUnFold(isUnFold))
	end

	return totalHeight
end

function TowerPermanentModel:setCurSelectStage(stage)
	self.curSelectStage = stage
	self.curSelectLayer = self.realSelectMap[stage] or 1
	self.curSelectEpisodeId = 0
end

function TowerPermanentModel:getCurSelectStage()
	return self.curSelectStage
end

function TowerPermanentModel:setCurSelectLayer(layer, stage)
	self.realSelectMap = {}
	self.realSelectMap[stage] = layer
	self.curSelectLayer = layer
	self.curSelectEpisodeId = 0
end

function TowerPermanentModel:getCurSelectLayer()
	return self.curSelectLayer
end

function TowerPermanentModel:getRealSelectStage()
	for stage, layerIndex in pairs(self.realSelectMap) do
		if stage then
			return stage, layerIndex
		end
	end
end

function TowerPermanentModel:setCurSelectEpisodeId(episodeId)
	self.curSelectEpisodeId = episodeId
end

function TowerPermanentModel:getCurSelectEpisodeId()
	return self.curSelectEpisodeId
end

function TowerPermanentModel:checkLayerSubEpisodeFinish(layerId, episodeId)
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()
	local subEpisodeMoList = curPermanentMo:getLayerSubEpisodeList(layerId, true) or {}

	for index, subEpisodeMo in ipairs(subEpisodeMoList) do
		if subEpisodeMo.episodeId == episodeId then
			return subEpisodeMo.status == TowerEnum.PassEpisodeState.Pass, subEpisodeMo
		end
	end

	return false
end

function TowerPermanentModel:getFirstUnFinishEipsode(layerId)
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()
	local subEpisodeMoList = curPermanentMo:getLayerSubEpisodeList(layerId, true) or {}

	for index, subEpisodeMo in ipairs(subEpisodeMoList) do
		if subEpisodeMo.status == TowerEnum.PassEpisodeState.NotPass then
			return subEpisodeMo, index
		end
	end
end

function TowerPermanentModel:checkLayerUnlock(layerConfig)
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()
	local preLayerId = layerConfig.preLayerId

	if preLayerId == 0 then
		return true
	else
		return preLayerId <= curPermanentMo.passLayerId
	end
end

function TowerPermanentModel:getCurPermanentPassLayer()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()

	return (curPermanentMo or nil) and (curPermanentMo.passLayerId or 0)
end

function TowerPermanentModel:getCurPassEpisodeId()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()

	if not curPermanentMo.passLayerId then
		local curPassLayer = 0
		local nextLayer = curPassLayer + 1
		local nextPermanentCo = TowerConfig.instance:getPermanentEpisodeCo(nextLayer)

		if nextPermanentCo and nextPermanentCo.isElite == 1 then
			local episodeIdList = string.splitToNumber(nextPermanentCo.episodeIds, "|")

			for index, episodeId in ipairs(episodeIdList) do
				local subEpisodeMo = curPermanentMo:getSubEpisodeMoByEpisodeId(episodeId)
				local isFinish = subEpisodeMo and subEpisodeMo.status == TowerEnum.PassEpisodeState.Pass

				if isFinish then
					return episodeId
				end
			end
		end

		local permanentCo = TowerConfig.instance:getPermanentEpisodeCo(curPassLayer)

		if not permanentCo then
			return 0
		end

		if permanentCo.isElite == 1 then
			local episodeIdList = string.splitToNumber(permanentCo.episodeIds, "|")

			return episodeIdList[#episodeIdList]
		else
			return tonumber(permanentCo.episodeIds)
		end
	end
end

function TowerPermanentModel:setLastPassLayer(layerId)
	self.lastPassLayer = layerId
end

function TowerPermanentModel:setLocalPassLayer(passLayerId)
	self.localCurPassLayer = passLayerId
end

function TowerPermanentModel:getLocalPassLayer()
	return self.localCurPassLayer
end

function TowerPermanentModel:isNewPassLayer()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()

	return curPermanentMo.passLayerId == self.lastPassLayer and curPermanentMo.passLayerId > self.localCurPassLayer
end

function TowerPermanentModel:isNewStage()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()
	local permanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeCo(curPermanentMo.passLayerId)

	if self.defaultStage > permanentEpisodeCo.stageId and self:isNewPassLayer() then
		return true, self.defaultStage, permanentEpisodeCo.stageId
	end

	return false, self.defaultStage, permanentEpisodeCo.stageId
end

function TowerPermanentModel:checkStageIsOnline(stageId)
	local timeCo = TowerConfig.instance:getTowerPermanentTimeCo(stageId)

	if string.nilorempty(timeCo.time) then
		return true
	else
		local timeData = string.splitToNumber(timeCo.time, "-")
		local openTimeStamp = TimeUtil.timeToTimeStamp(timeData[1], timeData[2], timeData[3], TimeDispatcher.DailyRefreshTime)
		local offsetTimeStamp = openTimeStamp - ServerTime.now()

		if offsetTimeStamp <= 0 then
			return true
		else
			return false, offsetTimeStamp
		end
	end
end

function TowerPermanentModel:getCurUnfoldStage()
	for index, permanentMO in ipairs(self.permanentMoList) do
		if permanentMO.isUnFold then
			return permanentMO.stage
		end
	end

	return self.curSelectStage
end

function TowerPermanentModel:checkNewLayerIsElite()
	local curPermanentMo = TowerModel.instance:getCurPermanentMo()

	if not curPermanentMo.passLayerId then
		local curPassLayer = 0
		local nextLayer = curPassLayer + 1
		local permanentCo = TowerConfig.instance:getPermanentEpisodeCo(nextLayer)

		if not permanentCo then
			return false
		end

		return permanentCo.isElite == 1
	end
end

function TowerPermanentModel:localMopUpSaveKey()
	return TowerEnum.LocalPrefsKey.OpenMopUpViewWithFullTicket
end

function TowerPermanentModel:checkCanShowMopUpReddot()
	if not TowerController.instance:isOpen() then
		return false
	end

	local mopUpOpenLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)
	local permanentTowerMo = TowerModel.instance:getCurPermanentMo()

	if not permanentTowerMo then
		return false
	end

	local isOpenMopUp = permanentTowerMo.passLayerId >= tonumber(mopUpOpenLayerNum)

	if not isOpenMopUp then
		return false
	end

	local isNewDay = TimeUtil.getDayFirstLoginRed(TowerEnum.LocalPrefsKey.MopUpDailyRefresh)
	local curMopUpTimes = TowerModel.instance:getMopUpTimes()
	local maxMopUpTimes = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	if isNewDay and curMopUpTimes == tonumber(maxMopUpTimes) then
		return true
	end

	return false
end

TowerPermanentModel.instance = TowerPermanentModel.New()

return TowerPermanentModel

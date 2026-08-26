-- chunkname: @modules/logic/versionactivity2_2/lopera/controller/LoperaController.lua

module("modules.logic.versionactivity2_2.lopera.controller.LoperaController", package.seeall)

local LoperaController = class("LoperaController", BaseController)
local actId = VersionActivity2_2Enum.ActivityId.Lopera

function LoperaController:onInit()
	return
end

function LoperaController:reInit()
	return
end

function LoperaController:addConstEvents()
	return
end

function LoperaController:openLoperaMainView()
	local activityMo = ActivityModel.instance:getActMO(actId)

	if activityMo then
		::label_4_0::

		local var_4_0 = activityMo.config

		if activityMo.config then
			local firstStoryId = activityMo.config.storyId
			local toPlayStory = self:_checkCanPlayStory(firstStoryId)

			if toPlayStory then
				StoryController.instance:playStory(firstStoryId, nil, self.openFirstStoryEnd, self)
			else
				Activity168Rpc.instance:sendGet168InfosRequest(VersionActivity2_2Enum.ActivityId.Lopera, self._onReceivedActInfo, self)
			end
		end
	end
end

function LoperaController:openFirstStoryEnd()
	Activity168Rpc.instance:sendGet168InfosRequest(VersionActivity2_2Enum.ActivityId.Lopera, self._onReceivedActInfo, self)
end

function LoperaController:openLoperaLevelView(episodeId)
	ViewMgr.instance:openView(ViewName.LoperaLevelView)
end

function LoperaController:openTaskView()
	ViewMgr.instance:openView(ViewName.LoperaTaskView)
end

function LoperaController:_onReceivedActInfo()
	ViewMgr.instance:openView(ViewName.LoperaMainView)
end

function LoperaController:openSmeltView()
	ViewMgr.instance:openView(ViewName.LoperaSmeltView)
end

function LoperaController:openSmeltResultView()
	ViewMgr.instance:openView(ViewName.LoperaSmeltResultView)
end

function LoperaController:openGameResultView(resultParams)
	if self._isWaitingEventResult then
		self._isWaitingGameResult = true

		return
	end

	self._isWaitingGameResult = false

	ViewMgr.instance:openView(ViewName.LoperaGameResultView, resultParams)
end

function LoperaController:enterEpisode(episodeId)
	Activity168Model.instance:setCurActId(VersionActivity2_2Enum.ActivityId.Lopera)

	self._curEnterEpisode = episodeId

	Activity168Rpc.instance:sendAct168EnterEpisodeRequest(VersionActivity2_2Enum.ActivityId.Lopera, episodeId, self._onEnterGameReply, self)
	Activity168Rpc.instance:SetGameSettlePushCallback(self._onGameResultPush, self)
	Activity168Rpc.instance:SetEpisodePushCallback(self._onEpisodeUpdate, self)
end

function LoperaController:finishStoryPlay()
	Activity168Rpc.instance:sendAct168StoryRequest(VersionActivity2_2Enum.ActivityId.Lopera, self._onEpisodeUpdate, self)
end

function LoperaController:moveToDir(dir)
	self._moveTime = self._moveTime + 1

	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameMoveRequest(VersionActivity2_2Enum.ActivityId.Lopera, dir, self._onMoveDirReply, self)
end

function LoperaController:selectOption(optionId)
	self:saveOptionChoosed(optionId)

	self._finishEventNum = self._finishEventNum + 1

	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameSelectOptionRequest(VersionActivity2_2Enum.ActivityId.Lopera, optionId, self._onSelectOptionReply, self)
end

function LoperaController:startBattle()
	Activity168Rpc.instance:sendStartAct168BattleRequest(VersionActivity2_2Enum.ActivityId.Lopera)
end

function LoperaController:composeItem(composeType)
	Activity168Model.instance:clearItemChangeDict()
	Activity168Rpc.instance:sendAct168GameComposeItemRequest(actId, composeType, self._onComposeDone, self)
end

function LoperaController:abortEpisode()
	Activity168Rpc.instance:sendAct168GameSettleRequest(VersionActivity2_2Enum.ActivityId.Lopera, self._onEpisodeUpdate, self)
end

function LoperaController:gameResultOver()
	self:dispatchEvent(LoperaEvent.ExitGame)
end

function LoperaController:_onEnterGameReply()
	local episodeCfg = Activity168Config.instance:getEpisodeCfg(actId, self._curEnterEpisode)
	local curMapId = episodeCfg.mapId

	if curMapId ~= 0 then
		Activity168Config.instance:InitMapCfg(curMapId)
	end

	if episodeCfg.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
		Activity168Model.instance:setCurEpisodeId(self._curEnterEpisode)
		self:openLoperaLevelView()
	else
		self:dispatchEvent(LoperaEvent.EnterEpisode, self._curEnterEpisode)
	end

	local gameState = Activity168Model.instance:getCurGameState()
	local roundNum = gameState.round

	self._moveTime = 0

	local haveOption = gameState.eventId ~= 0 and gameState.option <= 0

	if haveOption then
		self._finishEventNum = roundNum - 2 or roundNum - 1
	end

	self:initStatData(self._curEnterEpisode)
end

function LoperaController:_onMoveDirReply(resultCode, msg)
	self:dispatchEvent(LoperaEvent.EpisodeMove)
end

function LoperaController:_onSelectOptionReply(resultCode, msg)
	self:dispatchEvent(LoperaEvent.SelectOption)
end

function LoperaController:_onEpisodeUpdate()
	self:dispatchEvent(LoperaEvent.EpisodeUpdate)
end

function LoperaController:_onComposeDone()
	self:dispatchEvent(LoperaEvent.ComposeDone)
end

function LoperaController:_checkCanPlayStory(storyId)
	if storyId and storyId ~= 0 and not StoryModel.instance:isStoryHasPlayed(storyId) then
		return true
	end

	return false
end

function LoperaController:_onGameResultPush(resultData)
	self:dispatchEvent(LoperaEvent.EpisodeFinish, resultData)

	local totalItems = resultData.totalItems
	local materials = {}
	local products = {}

	for i, item in ipairs(totalItems) do
		local itemCfg = Activity168Config.instance:getGameItemCfg(actId, item.itemId)

		if itemCfg.type == LoperaEnum.ItemType.Material then
			local itemInfo = {}

			itemInfo.alchemy_stuff = itemCfg.name
			itemInfo.alchemy_stuff_num = item.count
			materials[#materials + 1] = itemInfo
		else
			local itemInfo = {}

			itemInfo.alchemy_prop = itemCfg.name
			itemInfo.alchemy_prop_num = item.count
			products[#products + 1] = itemInfo
		end
	end

	self:fillStatInfo(self._curEnterEpisode)
	self:sendStat()
end

function LoperaController:sendStatOnHomeClick()
	local gameState = Activity168Model.instance:getCurGameState()
	local episodeId = self._curEnterEpisode
	local remainPower = gameState.power
	local cellCount = gameState.round
	local resultId = 3
	local totalItems = gameState.totalAct168Items
	local materials = {}
	local products = {}

	for i, item in ipairs(totalItems) do
		local itemCfg = Activity168Config.instance:getGameItemCfg(actId, item.itemId)

		if itemCfg.type == LoperaEnum.ItemType.Material then
			local itemInfo = {}

			itemInfo.alchemy_stuff = itemCfg.name
			itemInfo.alchemy_stuff_num = item.count
			materials[#materials + 1] = itemInfo
		else
			local itemInfo = {}

			itemInfo.alchemy_prop = itemCfg.name
			itemInfo.alchemy_prop_num = item.count
			products[#products + 1] = itemInfo
		end
	end

	self:fillStatInfo(episodeId, resultId, self._moveTime, self._finishEventNum, remainPower, cellCount, materials, products)
	self:sendStat()
end

function LoperaController:checkCanCompose(composeType)
	local curComposeTypeCfg
	local typeCfgList = Activity168Config.instance:getComposeTypeList(actId)

	for idx, composeTypeData in ipairs(typeCfgList) do
		if composeTypeData.composeType == composeType then
			curComposeTypeCfg = composeTypeData

			break
		end
	end

	local materialInfos = string.split(curComposeTypeCfg.costItems, "|")

	for idx, materialInfo in ipairs(materialInfos) do
		local materialInfoArray = string.splitToNumber(materialInfo, "#")
		local materialId = materialInfoArray[1]
		local materialRequire = materialInfoArray[2]
		local count = Activity168Model.instance:getItemCount(materialId)

		if count < materialRequire then
			return false
		end
	end

	return true
end

function LoperaController:checkAnyComposable()
	local typeCfgList = Activity168Config.instance:getComposeTypeList(actId)

	for _, cfg in ipairs(typeCfgList) do
		local canCompose = true
		local materialInfos = string.split(cfg.costItems, "|")

		for idx, materialInfo in ipairs(materialInfos) do
			local materialInfoArray = string.splitToNumber(materialInfo, "#")
			local materialId = materialInfoArray[1]
			local materialRequire = materialInfoArray[2]
			local count = Activity168Model.instance:getItemCount(materialId)

			if count < materialRequire then
				canCompose = false

				break
			end
		end

		if canCompose then
			return true
		end
	end
end

function LoperaController:checkOptionChoosed(optionId)
	if not self._optionDescRecord then
		self._optionDescRecord = {}
		self._optionDescRecordStr = ""
		self._optionDescRecordStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, "")

		local optionIds = string.splitToNumber(self._optionDescRecordStr, ",")

		for _, id in pairs(optionIds) do
			self._optionDescRecord[id] = true
		end
	end

	return self._optionDescRecord[optionId]
end

function LoperaController:saveOptionChoosed(optionId)
	self._optionDescRecord[optionId] = true
	self._optionDescRecordStr = string.nilorempty(self._optionDescRecordStr) and optionId or self._optionDescRecordStr .. "," .. optionId

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, self._optionDescRecordStr)
end

function LoperaController:initStatData(episodeId)
	self.statMo = LoperaStatMo.New()

	self.statMo:setEpisodeId(episodeId)
end

function LoperaController:fillStatInfo(episdoeId, result, roundNum, eventNum, remainPower, exploreNum, gainMaterial, product)
	self.statMo:fillInfo(episdoeId, result, roundNum, eventNum, remainPower, exploreNum, gainMaterial, product)
end

function LoperaController:sendStat()
	self.statMo:sendStatData()
end

LoperaController.instance = LoperaController.New()

return LoperaController

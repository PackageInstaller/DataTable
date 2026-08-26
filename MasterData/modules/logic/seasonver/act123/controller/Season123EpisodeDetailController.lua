-- chunkname: @modules/logic/seasonver/act123/controller/Season123EpisodeDetailController.lua

module("modules.logic.seasonver.act123.controller.Season123EpisodeDetailController", package.seeall)

local Season123EpisodeDetailController = class("Season123EpisodeDetailController", BaseController)

function Season123EpisodeDetailController:onOpenView(actId, stage, layer)
	Season123Controller.instance:registerCallback(Season123Event.StartEnterBattle, self.handleStartEnterBattle, self)
	Season123Controller.instance:registerCallback(Season123Event.StageInfoChanged, self.handleDataChanged, self)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, self.handleDataChanged, self)
	Season123Controller.instance:registerCallback(Season123Event.OnResetSucc, self.handleDataChanged, self)
	Season123EpisodeDetailModel.instance:init(actId, stage, layer)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = actId,
		stage = stage,
		layer = layer
	})
end

function Season123EpisodeDetailController:onCloseView()
	Season123Controller.instance:unregisterCallback(Season123Event.StartEnterBattle, self.handleStartEnterBattle, self)
	Season123Controller.instance:unregisterCallback(Season123Event.StageInfoChanged, self.handleDataChanged, self)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, self.handleDataChanged, self)
	Season123Controller.instance:unregisterCallback(Season123Event.OnResetSucc, self.handleDataChanged, self)
	Season123EpisodeDetailModel.instance:release()
end

function Season123EpisodeDetailController:canSwitchLayer(isNext)
	local curLayer = Season123EpisodeDetailModel.instance.layer

	if isNext then
		local nextLayer = curLayer + 1

		if not Season123EpisodeDetailModel.instance:isEpisodeUnlock(nextLayer) then
			return false
		end
	elseif curLayer < 2 then
		return false
	end

	return true
end

function Season123EpisodeDetailController:switchLayer(isNext)
	local curLayer = Season123EpisodeDetailModel.instance.layer

	if isNext then
		if not (curLayer + 1) then
			Season123EpisodeDetailModel.instance.layer = curLayer - 1

			Season123Controller.instance:dispatchEvent(Season123Event.DetailSwitchLayer, {
				isNext = isNext
			})
		end
	end
end

function Season123EpisodeDetailController:checkEnterFightScene()
	self:enterBattle()

	do return end

	if self:isStageNeedClean() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, self.checkCleanNextLayers, nil, nil, self, nil, nil)

		return
	end

	self:checkCleanNextLayers()
end

function Season123EpisodeDetailController:checkCleanNextLayers()
	if self:isNextLayersNeedClean() then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanLayer, MsgBoxEnum.BoxType.Yes_No, self.enterFightScene, nil, nil, self, nil, nil)

		return
	end

	self:enterFightScene()
end

function Season123EpisodeDetailController:isStageNeedClean()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	return seasonMO.stage ~= 0 and seasonMO.stage ~= stage
end

function Season123EpisodeDetailController:isNextLayersNeedClean()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local curLayer = Season123EpisodeDetailModel.instance.layer
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	local stageMO = seasonMO.stageMap[stage]

	if not stageMO or not stageMO.episodeMap then
		return false
	end

	for layer, episodeMO in pairs(stageMO.episodeMap) do
		if curLayer <= episodeMO.layer and episodeMO:isFinished() then
			return true
		end
	end

	return false
end

function Season123EpisodeDetailController:enterFightScene()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage

	if self:isStageNeedClean() then
		Activity123Rpc.instance:sendAct123ResetOtherStageRequest(actId, stage, self.handleResetOtherStage, self)

		return
	end

	self:handleResetOtherStage()
end

function Season123EpisodeDetailController:handleResetOtherStage()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local stageMO = seasonMO:getStageMO(stage)

	if not stageMO then
		return
	end

	if stageMO.episodeMap[layer + 1] and stageMO.episodeMap[layer + 1]:isFinished() then
		Activity123Rpc.instance:sendAct123ResetHighLayerRequest(actId, stage, layer, self.enterBattle, self)

		return
	end

	self:enterBattle()
end

function Season123EpisodeDetailController:enterBattle()
	local actId = Season123EpisodeDetailModel.instance.activityId
	local stage = Season123EpisodeDetailModel.instance.stage
	local layer = Season123EpisodeDetailModel.instance.layer
	local episodeCfg = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)

	if episodeCfg then
		Season123EpisodeDetailModel.instance.lastSendEpisodeCfg = episodeCfg

		local episodeListMO = Season123EpisodeDetailModel.instance:getByIndex(layer)

		self:startBattle(actId, stage, layer, episodeCfg.episodeId)
	end
end

function Season123EpisodeDetailController:startBattle(actId, stage, layer, episodeId)
	logNormal(string.format("startBattle with actId = %s, stage = %s, layer = %s, episodeId = %s", actId, stage, layer, episodeId))

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	Season123Model.instance:setBattleContext(actId, stage, layer, episodeId)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
end

function Season123EpisodeDetailController:handleStartEnterBattle(param)
	if not Season123EpisodeDetailModel.instance.lastSendEpisodeCfg then
		return
	end

	local lastEpisodeCfg = Season123EpisodeDetailModel.instance.lastSendEpisodeCfg
	local actId = param.actId
	local layer = param.layer

	if lastEpisodeCfg and actId == Season123EpisodeDetailModel.instance.activityId and layer == lastEpisodeCfg.layer then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(lastEpisodeCfg.episodeId)

		if episodeCo then
			DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeCo.id)
		else
			logError(string.format("episode cfg not found ! id = [%s]", lastEpisodeCfg.episodeId))
		end
	end
end

function Season123EpisodeDetailController:handleDataChanged()
	local curLayer = Season123EpisodeDetailModel.instance.layer

	Season123EpisodeDetailModel.instance:initEpisodeList()

	if not Season123EpisodeDetailModel.instance:isEpisodeUnlock(curLayer) then
		for layer = curLayer, 1, -1 do
			if Season123EpisodeDetailModel.instance:isEpisodeUnlock(layer) then
				Season123EpisodeDetailModel.instance.layer = layer

				break
			end
		end
	end

	self:notifyView()
end

function Season123EpisodeDetailController:notifyView()
	Season123Controller.instance:dispatchEvent(Season123Event.RefreshDetailView)
end

Season123EpisodeDetailController.instance = Season123EpisodeDetailController.New()

return Season123EpisodeDetailController

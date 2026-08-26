-- chunkname: @modules/logic/seasonver/act123/controller/Season123EpisodeListController.lua

module("modules.logic.seasonver.act123.controller.Season123EpisodeListController", package.seeall)

local Season123EpisodeListController = class("Season123EpisodeListController", BaseController)

function Season123EpisodeListController:onOpenView(actId, stage)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, self.handleGetActInfo, self)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfoBattleFinish, self.handleGetActInfo, self)
	Season123Controller.instance:registerCallback(Season123Event.ResetStageFinished, self.handleResetStageFinished, self)
	Season123Controller.instance:registerCallback(Season123Event.OnResetSucc, self.fixCurSelectedUnlock, self)
	Season123EpisodeListModel.instance:init(actId, stage)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = actId,
		stage = stage
	})
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	})
end

function Season123EpisodeListController:onCloseView()
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, self.handleGetActInfo, self)
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfoBattleFinish, self.handleGetActInfo, self)
	Season123Controller.instance:unregisterCallback(Season123Event.ResetStageFinished, self.handleResetStageFinished, self)
	Season123Controller.instance:unregisterCallback(Season123Event.OnResetSucc, self.fixCurSelectedUnlock, self)
	Season123EpisodeListModel.instance:release()
	Season123EpisodeRewardModel.instance:release()
end

function Season123EpisodeListController:processJumpParam(viewParam)
	if viewParam.jumpId == Activity123Enum.JumpId.Market then
		local layer = viewParam.jumpParam.tarLayer

		self:setSelectLayer(layer)

		if Season123EpisodeListModel.instance.activityId == Activity123Enum.SeasonID.Season1 and viewParam.stage == 1 and layer and layer == 2 then
			return
		end

		self:enterEpisode()
	elseif viewParam.jumpId == Activity123Enum.JumpId.MarketNoResult then
		local layer = viewParam.jumpParam.tarLayer

		ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
			actId = Season123EpisodeListModel.instance.activityId,
			stage = Season123EpisodeListModel.instance.stage,
			layer = layer
		})
	end
end

function Season123EpisodeListController:handleGetActInfo(actId)
	if actId ~= Season123EpisodeListModel.instance.activityId then
		return
	end

	Season123EpisodeListModel.instance:initEpisodeList()

	if not self:fixCurSelectedUnlock() then
		self:notifyView()
	end
end

function Season123EpisodeListController:handlePickHeroSuccess()
	local actId = Season123EpisodeListModel.instance.activityId

	Activity123Rpc.instance:sendGet123InfosRequest(actId, self.handleEnterStage, self)
end

function Season123EpisodeListController:handleEnterStage()
	self:notifyView()
end

function Season123EpisodeListController:handleResetStageFinished()
	local actId = Season123EpisodeListModel.instance.activityId

	Activity123Rpc.instance:sendGet123InfosRequest(actId, self.handleGet123InfosAfterRest, self)
	Season123Controller.instance:dispatchEvent(Season123Event.ResetCloseEpisodeList)
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123EpisodeListModel.instance.stage)
end

function Season123EpisodeListController:handleGet123InfosAfterRest()
	Season123EpisodeListController.instance:setSelectLayer(1)
	self:notifyView()
end

function Season123EpisodeListController:fixCurSelectedUnlock()
	local layer = Season123EpisodeListModel.instance.curSelectLayer
	local chanllengeLayer = Season123EpisodeListModel.instance:getCurrentChallengeLayer()

	if chanllengeLayer < layer then
		self:setSelectLayer(chanllengeLayer)

		return true
	end

	return false
end

function Season123EpisodeListController:openDetails()
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123EpisodeListModel.instance.activityId, Season123EpisodeListModel.instance.stage, Season123EpisodeListModel.instance:getCurrentChallengeLayer())
end

function Season123EpisodeListController:enterEpisode(fromView)
	local layer = Season123EpisodeListModel.instance.curSelectLayer

	if not layer then
		return
	end

	local data = Season123EpisodeListModel.instance:getById(layer)

	if not data then
		return
	end

	local actId = Season123EpisodeListModel.instance.activityId

	Season123EpisodeListController.instance:setSelectLayer(layer)

	local stage = Season123EpisodeListModel.instance.stage

	if Season123EpisodeListModel.instance:isEpisodeUnlock(layer) then
		logNormal("open layer = " .. tostring(layer))

		if fromView and (layer ~= 1 or data.isFinished or not Season123EpisodeListModel.instance:isLoadingAnimNeedPlay(stage)) then
			ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
				actId = actId,
				stage = stage,
				layer = layer
			})
		else
			Season123EpisodeListModel.instance:savePlayLoadingAnimRecord(stage)
			ViewMgr.instance:openView(Season123Controller.instance:getEpisodeLoadingViewName(), {
				actId = actId,
				stage = stage,
				layer = layer
			})
		end
	else
		logNormal(string.format("layer [%s] is lock!!!!", tostring(layer)))
	end
end

function Season123EpisodeListController:setSelectLayer(layer)
	Season123EpisodeListModel.instance:setSelectLayer(layer)
	self:notifyView()
end

function Season123EpisodeListController:notifyView()
	Season123Controller.instance:dispatchEvent(Season123Event.EpisodeViewRefresh)
end

function Season123EpisodeListController:onReceiveEnterStage(stage)
	Season123EpisodeListModel.instance:cleanPlayLoadingAnimRecord(stage)
end

Season123EpisodeListController.instance = Season123EpisodeListController.New()

return Season123EpisodeListController

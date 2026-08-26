-- chunkname: @modules/logic/seasonver/act123/controller/Season123ResetController.lua

module("modules.logic.seasonver.act123.controller.Season123ResetController", package.seeall)

local Season123ResetController = class("Season123ResetController", BaseController)

function Season123ResetController:onOpenView(actId, stage, layer)
	Season123Controller.instance:registerCallback(Season123Event.GetActInfo, self.handleGetActInfo, self)
	Season123Controller.instance:registerCallback(Season123Event.StageInfoChanged, self.handleStageInfoChange, self)
	Season123ResetModel.instance:init(actId, stage, layer)
	Season123Controller.instance:checkAndHandleEffectEquip({
		actId = actId,
		stage = stage,
		layer = layer
	})
end

function Season123ResetController:onCloseView()
	Season123Controller.instance:unregisterCallback(Season123Event.GetActInfo, self.handleGetActInfo, self)
	Season123Controller.instance:unregisterCallback(Season123Event.StageInfoChanged, self.handleStageInfoChange, self)
	Season123ResetModel.instance:release()
end

function Season123ResetController:selectLayer(layer)
	if layer == Season123ResetModel.instance.layer then
		return
	end

	if layer == nil then
		Season123ResetModel.instance.layer = nil
	elseif layer == Season123ResetModel.EmptySelect then
		Season123ResetModel.instance.layer = layer
	else
		local layerMO = Season123ResetModel.instance:getById(layer)

		if layerMO.isFinished then
			Season123ResetModel.instance.layer = layer
		else
			return
		end
	end

	Season123ResetModel.instance:updateHeroList()
	self:notifyView()

	return true
end

function Season123ResetController:tryReset()
	if Season123ResetModel.instance.layer then
		if Season123ResetModel.instance.layer ~= Season123ResetModel.EmptySelect then
			self:trySendResetLayer()
		end
	else
		self:trySendResetStage()
	end
end

function Season123ResetController:trySendResetStage()
	GameFacade.showMessageBox(MessageBoxIdDefine.Season123ResetConfirm, MsgBoxEnum.BoxType.Yes_No, self.receiveResetStage, nil, nil, self)
end

function Season123ResetController:receiveResetStage()
	Activity123Rpc.instance:sendAct123EndStageRequest(Season123ResetModel.instance.activityId, Season123ResetModel.instance.stage, self.receiveResetFinish, self)
end

function Season123ResetController:trySendResetLayer()
	local stage = Season123ResetModel.instance.stage

	if self:isStageNeedClean(stage) then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, self.checkCleanNextLayers, nil, nil, self, nil, nil)

		return
	end

	self:checkCleanNextLayers()
end

function Season123ResetController:checkCleanNextLayers()
	local layer = Season123ResetModel.instance.layer

	if self:isNextLayersNeedClean(layer) then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanLayer, MsgBoxEnum.BoxType.Yes_No, self.startSendResetLayer, nil, nil, self, nil, nil)

		return
	end

	self:startSendResetLayer()
end

function Season123ResetController:startSendResetLayer()
	local actId = Season123ResetModel.instance.activityId
	local stage = Season123ResetModel.instance.stage

	if self:isStageNeedClean(stage) then
		Activity123Rpc.instance:sendAct123ResetOtherStageRequest(actId, stage, self.receiveResetOtherStage, self)

		return
	end

	self:handleResetOtherStage()
end

function Season123ResetController:receiveResetOtherStage(cmd, resultCode, msg)
	if resultCode == 0 then
		self:handleResetOtherStage()
	end
end

function Season123ResetController:handleResetOtherStage()
	local actId = Season123ResetModel.instance.activityId
	local stage = Season123ResetModel.instance.stage
	local layer = Season123ResetModel.instance.layer
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local stageMO = seasonMO:getStageMO(stage)

	if not stageMO then
		return
	end

	if stageMO.episodeMap[layer] and stageMO.episodeMap[layer]:isFinished() then
		Activity123Rpc.instance:sendAct123ResetHighLayerRequest(actId, stage, layer, self.receiveResetFinish, self)

		return
	end

	self:notifyResetFinish()
end

function Season123ResetController:receiveResetFinish(cmd, resultCode, msg)
	if resultCode == 0 then
		self:notifyResetFinish()
	end
end

function Season123ResetController:notifyResetFinish()
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
	Activity123Rpc.instance:sendGet123InfosRequest(Season123ResetModel.instance.activityId)
	Season123Controller.instance:dispatchEvent(Season123Event.OnResetSucc)
end

function Season123ResetController:handleGetActInfo()
	self:updateModel()
end

function Season123ResetController:handleStageInfoChange()
	self:updateModel()
end

function Season123ResetController:updateModel()
	local layer = Season123ResetModel.instance.layer

	Season123ResetModel.instance:initEpisodeList()

	if layer then
		local layerMO = Season123ResetModel.instance:getById(layer)

		if not layerMO.isFinished then
			Season123ResetModel.instance.layer = Season123ResetModel.instance:getCurrentChallengeLayer()
		end
	end

	Season123ResetModel.instance:updateHeroList()
	self:notifyView()
end

function Season123ResetController:isStageNeedClean(curStage)
	local actId = Season123ResetModel.instance.activityId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return false
	end

	return seasonMO.stage ~= 0 and seasonMO.stage ~= curStage
end

function Season123ResetController:isNextLayersNeedClean(curLayer)
	local actId = Season123ResetModel.instance.activityId
	local stage = Season123ResetModel.instance.stage
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

function Season123ResetController:notifyView()
	Season123Controller.instance:dispatchEvent(Season123Event.RefreshResetView)
end

Season123ResetController.instance = Season123ResetController.New()

return Season123ResetController

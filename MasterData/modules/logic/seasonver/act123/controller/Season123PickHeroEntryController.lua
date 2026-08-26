-- chunkname: @modules/logic/seasonver/act123/controller/Season123PickHeroEntryController.lua

module("modules.logic.seasonver.act123.controller.Season123PickHeroEntryController", package.seeall)

local Season123PickHeroEntryController = class("Season123PickHeroEntryController", BaseController)

function Season123PickHeroEntryController:onOpenView(actId, stage, finishCall, finishCallObj)
	Season123PickHeroEntryModel.instance:init(actId, stage)
end

function Season123PickHeroEntryController:onCloseView()
	Season123PickHeroEntryModel.instance:release()
end

function Season123PickHeroEntryController:openPickHeroView(index)
	local selectHeroUid

	if index then
		local mo = Season123PickHeroEntryModel.instance:getByIndex(index)

		if mo and mo.heroMO then
			selectHeroUid = mo.heroMO.uid
		end
	end

	ViewMgr.instance:openView(Season123Controller.instance:getPickHeroViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		stage = Season123PickHeroEntryModel.instance.stage,
		finishCall = self.handlePickOver,
		finishCallObj = self,
		entryMOList = Season123PickHeroEntryModel.instance:getList(),
		selectHeroUid = selectHeroUid
	})
end

function Season123PickHeroEntryController:openPickSupportView(isAutoRefresh)
	local supportMO = Season123PickHeroEntryModel.instance:getSupportPosMO()
	local selectedHeroUid

	if supportMO and supportMO.isSupport then
		selectedHeroUid = supportMO.heroUid
	end

	local canRefresh = Season123PickAssistController.instance:checkCanRefresh()

	if isAutoRefresh and canRefresh then
		self.tmpIsRecordRefreshTime = true

		DungeonRpc.instance:sendRefreshAssistRequest(DungeonEnum.AssistType.Season123, self._openPickSupportViewAfterRpc, self)
	else
		self:_openPickSupportViewAfterRpc()
	end
end

function Season123PickHeroEntryController:_openPickSupportViewAfterRpc(cmd, resultCode, msg)
	if self.tmpIsRecordRefreshTime then
		Season123PickAssistController.instance:recordAssistRefreshTime()
	end

	self.tmpIsRecordRefreshTime = nil

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1)
	ViewMgr.instance:openView(Season123Controller.instance:getPickAssistViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		finishCall = self.handlePickSupport,
		finishCallObj = self,
		selectedHeroUid = Season123PickHeroEntryModel.instance:getSupporterHeroUid()
	})
end

function Season123PickHeroEntryController:cancelSupport()
	local supportMO = Season123PickHeroEntryModel.instance:getSupportPosMO()

	if supportMO and supportMO.isSupport then
		supportMO:setEmpty()
	end

	self:notifyView()
	Season123PickHeroEntryModel.instance:clearLastSupportHero()
end

function Season123PickHeroEntryController:selectMainEquips(slot)
	local viewName = Season123Controller.instance:getEquipHeroViewName()

	ViewMgr.instance:openView(viewName, {
		actId = Season123PickHeroEntryModel.instance.activityId,
		stage = Season123PickHeroEntryModel.instance.stage,
		slot = slot,
		callback = self.handleSelectMainCard,
		callbackObj = self,
		equipUidList = Season123PickHeroEntryModel.instance:getMainCardList()
	})
end

function Season123PickHeroEntryController:handlePickOver(pickHeroMOList)
	Season123PickHeroEntryModel.instance:savePickHeroDatas(pickHeroMOList)
	self:notifyView()
end

function Season123PickHeroEntryController:handlePickSupport(pickAssistMO)
	Season123PickHeroEntryModel.instance:setPickAssistData(pickAssistMO)
	self:notifyView()
end

function Season123PickHeroEntryController:handleSelectMainCard(equipUidList)
	Season123PickHeroEntryModel.instance:setMainEquips(equipUidList)
	self:notifyView()
end

function Season123PickHeroEntryController:sendEnterStage()
	local count = Season123PickHeroEntryModel.instance:getSelectCount()
	local limitCount = Season123PickHeroEntryModel.instance:getLimitCount()

	if count < 1 then
		logNormal(string.format("hero count not fit : %s/%s", count, limitCount))
		GameFacade.showToast(ToastEnum.Season123PickHeroCountErr)

		return
	end

	local isMemberNotEnough = count < limitCount

	if isMemberNotEnough then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123MemberNotEnough, MsgBoxEnum.BoxType.Yes_No, self.confirmSendEnterStage, nil, nil, self)

		return
	end

	local heroUids = Season123PickHeroEntryModel.instance:getHeroUidList()
	local equipUids = Season123PickHeroEntryModel.instance:getMainCardList()

	Activity123Rpc.instance:sendAct123EnterStageRequest(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, heroUids, equipUids)
	Season123PickHeroEntryModel.instance:flushSelectionToLocal()
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123PickHeroEntryModel.instance.stage)
end

function Season123PickHeroEntryController:confirmSendEnterStage()
	local heroUids = Season123PickHeroEntryModel.instance:getHeroUidList()
	local equipUids = Season123PickHeroEntryModel.instance:getMainCardList()

	Activity123Rpc.instance:sendAct123EnterStageRequest(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, heroUids, equipUids)
	Season123PickHeroEntryModel.instance:flushSelectionToLocal()
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123PickHeroEntryModel.instance.stage)
end

function Season123PickHeroEntryController:notifyView()
	Season123Controller.instance:dispatchEvent(Season123Event.PickEntryRefresh)
end

Season123PickHeroEntryController.instance = Season123PickHeroEntryController.New()

return Season123PickHeroEntryController

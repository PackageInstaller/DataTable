-- chunkname: @modules/logic/versionactivity2_2/act169/controller/SummonNewCustomPickChoiceController.lua

module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickChoiceController", package.seeall)

local SummonNewCustomPickChoiceController = class("SummonNewCustomPickChoiceController", BaseController)

function SummonNewCustomPickChoiceController:onSelectActivity(activityId)
	SummonNewCustomPickChoiceListModel.instance:initDatas(activityId)

	self._actId = activityId

	self:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function SummonNewCustomPickChoiceController:trySendChoice()
	local actId = SummonNewCustomPickChoiceListModel.instance:getActivityId()
	local actMo = ActivityModel.instance:getActMO(actId)

	if not actMo or not actMo:isOpen() or actMo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	local selectList = SummonNewCustomPickChoiceListModel.instance:getSelectIds()

	if not selectList then
		GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)

		return false
	end

	local maxSelectCount = SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount()

	if maxSelectCount > #selectList then
		if maxSelectCount == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(actId) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	local heroNameStr = self:getSelectHeroNameStr(selectList)
	local msgId, actName = self:getConfirmParam(selectList)

	GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSendChoice, nil, nil, self, nil, nil, heroNameStr, actName)
end

function SummonNewCustomPickChoiceController:realSendChoice()
	local selectList = SummonNewCustomPickChoiceListModel.instance:getSelectIds()
	local actId = SummonNewCustomPickViewModel.instance:getCurActId()
	local heroId = selectList[1]

	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(actId, heroId)
end

function SummonNewCustomPickChoiceController:trySendSummon()
	local actId = SummonNewCustomPickChoiceListModel.instance:getActivityId()
	local actMo = ActivityModel.instance:getActMO(actId)

	if not actMo or not actMo:isOpen() or actMo:isExpired() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return false
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(actId) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return false
	end

	local haveNewBiePool = SummonNewCustomPickViewModel.instance:isNewbiePoolExist()

	if haveNewBiePool == false then
		if not MessageBoxIdDefine.Act167SummonNeTip then
			local msgId = MessageBoxIdDefine.Act167SummonNewTipWithNewBiePool

			GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, self.realSendSummon, nil, nil, self, nil, nil, actMo.config.name)
		end
	end
end

function SummonNewCustomPickChoiceController:realSendSummon()
	local actId = SummonNewCustomPickViewModel.instance:getCurActId()

	CharacterModel.instance:setGainHeroViewShowState(true)
	SummonNewCustomPickViewRpc.instance:sendAct169SummonRequest(actId, 0)
end

function SummonNewCustomPickChoiceController:getSelectHeroNameStr(selectList)
	local heroNameStr = ""

	for i = 1, #selectList do
		local heroCo = HeroConfig.instance:getHeroCO(selectList[i])

		heroNameStr = i == 1 and heroCo.name or heroNameStr .. ", " .. heroCo.name
	end

	return heroNameStr
end

function SummonNewCustomPickChoiceController:getConfirmParam()
	local actId = SummonNewCustomPickViewModel.instance:getCurActId()
	local actCo = ActivityConfig.instance:getActivityCo(actId)

	return MessageBoxIdDefine.SummonLuckyBagSelectChar, actCo.name
end

function SummonNewCustomPickChoiceController:setSelect(heroId)
	local selectList = SummonNewCustomPickChoiceListModel.instance:getSelectIds()
	local maxSelectCount = SummonNewCustomPickViewModel.instance:getMaxSelectCount()

	if not SummonNewCustomPickChoiceListModel.instance:isHeroIdSelected(heroId) and maxSelectCount <= #selectList and maxSelectCount == 1 then
		SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
	end

	SummonNewCustomPickChoiceListModel.instance:setSelectId(heroId)
	self:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function SummonNewCustomPickChoiceController:backPage()
	self:backHome()
	self:checkRewardPop()
	NavigateMgr.instance:registerCallback(NavigateEvent.BeforeClickHome, self.onClickHome, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.onCloseActivityPage, self)
end

function SummonNewCustomPickChoiceController:onClickHome()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseActivityPage, self)
end

function SummonNewCustomPickChoiceController:getCurrentListenViewName()
	local haveAllHero = SummonNewCustomPickChoiceListModel.instance:haveAllRole()

	if haveAllHero then
		return ViewName.CommonPropView
	else
		return ViewName.CommonPropView
	end
end

function SummonNewCustomPickChoiceController:onCloseActivityPage(viewName)
	local currentViewName = self:getCurrentListenViewName()

	if viewName == currentViewName then
		self:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenActivityPageFinish, self)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onCloseActivityPage, self)

		local activityCfg = ActivityConfig.instance:getActivityCo(self._actId)
		local achievementJumpId = activityCfg and activityCfg.achievementJumpId

		if achievementJumpId then
			JumpController.instance:jump(achievementJumpId)
		else
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function SummonNewCustomPickChoiceController:onOpenActivityPageFinish(viewName)
	if viewName == ViewName.ActivityBeginnerView then
		self:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenActivityPage, self)
	end
end

function SummonNewCustomPickChoiceController:backFullPage()
	self:backHome()
	self:checkRewardPop()

	local param = {}

	param.actId = self._actId
	param.refreshData = false

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SummonNewCustomPickFullView, param)
end

function SummonNewCustomPickChoiceController:backHome()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)
end

function SummonNewCustomPickChoiceController:setSummonReward(reward)
	self._summonReward = reward
end

function SummonNewCustomPickChoiceController:checkRewardPop()
	if self._summonReward and #self._summonReward > 0 then
		self:startBlack()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onCommonPropViewOpenFinish, self)
		RoomController.instance:popUpRoomBlockPackageView(self._summonReward)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._summonReward, true)
	end

	self._summonReward = nil
end

function SummonNewCustomPickChoiceController:onCommonPropViewOpenFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:endBlack()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onCommonPropViewOpenFinish, self)
	end
end

function SummonNewCustomPickChoiceController:startBlack()
	ViewMgr.instance:openView(ViewName.LoadingBlackView, nil, true)
end

function SummonNewCustomPickChoiceController:endBlack()
	ViewMgr.instance:closeView(ViewName.LoadingBlackView, true)
end

SummonNewCustomPickChoiceController.instance = SummonNewCustomPickChoiceController.New()

LuaEventSystem.addEventMechanism(SummonNewCustomPickChoiceController.instance)

return SummonNewCustomPickChoiceController

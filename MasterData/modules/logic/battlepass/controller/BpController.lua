-- chunkname: @modules/logic/battlepass/controller/BpController.lua

module("modules.logic.battlepass.controller.BpController", package.seeall)

local BpController = class("BpController", BaseController)

function BpController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, self._onDeleteTaskList, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._getBpInfo, self)
end

function BpController:openBattlePassView(isSp, viewParams, isCharge)
	self._isOpenSp = isSp
	self._isOpenCharge = isCharge
	self._openViewParam = viewParams

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_enter_button)

	if not BpModel.instance:hasGetInfo() then
		self.registerCallback(self, BpEvent.OnGetInfo, self._onGetInfo, self)
	elseif not BpModel.instance:isEnd() then
		self:_openBpView()
	else
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	BpRpc.instance:sendGetBpInfoRequest(true)
end

function BpController:dailyRefresh()
	if not BpModel.instance:isEnd() and ViewMgr.instance:isOpen(ViewName.BpView) then
		BpRpc.instance:sendGetBpInfoRequest(true)
	end
end

function BpController:_openBpView()
	if self._isOpenSp then
		if BpModel.instance.firstShowSp then
			ViewMgr.instance:openView(ViewName.BPSPFaceView)
		else
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onViewOpen, self)
			ViewMgr.instance:openView(ViewName.BpSPView, self._openViewParam)
		end
	else
		module_views_preloader.BpViewPreLoad(function()
			if BpModel.instance:isEnd() then
				return
			end

			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onViewOpen, self)

			local viewParam = self._openViewParam

			viewParam = viewParam or {}

			if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTaskMain) then
				viewParam.defaultTabIds = {}
				viewParam.defaultTabIds[2] = 2
			end

			viewParam.isPlayDayFirstAnim = not BpModel.instance.firstShow and not self._isOpenCharge

			if BpModel.instance.firstShow then
				self._isOpenCharge = nil
			end

			ViewMgr.instance:openView(ViewName.BpView, viewParam)

			if self._isOpenCharge then
				if BpModel.instance:isBpChargeEnd() then
					return
				end

				ViewMgr.instance:openView(self:getBpChargeView())
			end
		end)
	end
end

function BpController:getBpChargeView()
	local userId = PlayerModel.instance:getMyUserId()
	local last = tonumber(userId) % 10

	if last == 1 or last == 2 then
		return ViewName.BpChargeView
	else
		return ViewName.BpChargeABTestView
	end
end

function BpController:onViewOpen(viewName)
	if viewName == ViewName.BpView then
		ViewMgr.instance:closeView(ViewName.BpSPView, true)
	elseif viewName == ViewName.BpSPView then
		ViewMgr.instance:closeView(ViewName.BpView, true)
	else
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onViewOpen, self)
end

function BpController:_onGetInfo()
	self.unregisterCallback(self, BpEvent.OnGetInfo, self._onGetInfo, self)

	if BpModel.instance:isEnd() then
		return
	end

	self:_openBpView()
end

function BpController:_getBpInfo()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		return
	end

	BpRpc.instance:sendGetBpInfoRequest(false)
end

function BpController:onCheckBpEndTime()
	if not BpModel.instance:isEnd() then
		local leftSecond = BpModel.instance.endTime - ServerTime.now()

		if leftSecond > 0 then
			TaskDispatcher.cancelTask(self._onBpClose, self)
			TaskDispatcher.runDelay(self._onBpClose, self, leftSecond)
		end
	end
end

function BpController:onBpLevelUp()
	self._isLevelUp = true

	TaskDispatcher.runDelay(self._showLevelUpView, self, 0.1)
end

function BpController:needShowLevelUp()
	return self._isLevelUp
end

function BpController:pauseShowLevelUp()
	TaskDispatcher.cancelTask(self._showLevelUpView, self)

	self._isLevelUp = nil
end

function BpController:_showLevelUpView()
	TaskDispatcher.cancelTask(self._showLevelUpView, self)

	self._isLevelUp = nil

	ViewMgr.instance:openView(ViewName.BpLevelupTipView)
end

function BpController:_onBpClose()
	if ViewMgr.instance:isOpen(ViewName.BpView) then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	BpModel.instance:clearFlow()
	ViewMgr.instance:closeView(ViewName.BpView, true)
	ViewMgr.instance:closeView(ViewName.BpBuyView, true)
	ViewMgr.instance:closeView(ViewName.BpInformationView, true)
	ViewMgr.instance:closeView(ViewName.BpRuleTipsView, true)
	ViewMgr.instance:closeView(ViewName.BpSPInformationView, true)
	ViewMgr.instance:closeView(ViewName.BpSPRuleTipsView, true)
	ViewMgr.instance:closeView(BpController.instance:getBpChargeView(), true)
	ViewMgr.instance:closeView(ViewName.BpPropView2, true)
	ViewMgr.instance:closeView(ViewName.BPSPFaceView, true)

	BpModel.instance.endTime = 0

	self:dispatchEvent(BpEvent.OnGetInfo)
end

function BpController:_onUpdateTaskList(msg)
	local hasChange = BpTaskModel.instance:updateInfo(msg.taskInfo)

	if hasChange then
		BpController.instance:dispatchEvent(BpEvent.OnTaskUpdate)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
	end
end

function BpController:_onDeleteTaskList(msg)
	local hasChange = BpTaskModel.instance:deleteInfo(msg.taskIds)

	if hasChange then
		BpController.instance:dispatchEvent(BpEvent.OnTaskUpdate)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
	end
end

function BpController:_showCommonPropView(rewards)
	if BpModel.instance.lockAlertBonus then
		BpModel.instance.cacheBonus = rewards
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, rewards)
	end
end

function BpController:isEmptySkinFaceViewStr(skinId)
	local data = PlayerPrefsHelper.getString(self:_getSkinFaceViewKey(skinId), "")

	return string.nilorempty(data)
end

function BpController:isSkinFaceOnlineBySkinId(skinId)
	local bpsvpCfg = BpConfig.instance:getBpSkinViewParamCO(skinId)

	if bpsvpCfg and bpsvpCfg.online == BpEnum.StoreSkinOnlineState.Online then
		return true
	end

	return false
end

function BpController:setSkinFaceViewStr(skinId)
	skinId = skinId or 0

	return PlayerPrefsHelper.setString(self:_getSkinFaceViewKey(skinId), tostring(skinId))
end

function BpController:_getSkinFaceViewKey(skinId)
	skinId = skinId or 0

	return string.format("%s#%s#%s", PlayerPrefsKey.BPSkinFaceView, skinId, PlayerModel.instance:getMyUserId())
end

function BpController:showSpecialBonusMaterialInfo()
	local bonus = BpModel.instance:getSpecialBonus()[1]

	MaterialTipController.instance:showMaterialInfo(bonus[1], bonus[2], nil, nil, nil, {
		type = bonus[1],
		id = bonus[2],
		quantity = bonus[3],
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function BpController:statItemClick(itemType, itemId, viewName)
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	if config and config.subType == ItemEnum.SubType.Portrait then
		StatController.instance:track(StatEnum.EventName.ButtonClick, {
			[StatEnum.EventProperties.ViewName] = viewName or "BPChargeView",
			[StatEnum.EventProperties.ButtonName] = "avatar"
		})
	end
end

BpController.instance = BpController.New()

return BpController

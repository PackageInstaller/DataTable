-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_EnterView.lua

module("modules.logic.rouge2.outside.view.Rouge2_EnterView", package.seeall)

local Rouge2_EnterView = class("Rouge2_EnterView", BaseView)

function Rouge2_EnterView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "title/LimitTime/#txt_time")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_start")
	self._goimagestart = gohelper.findChild(self.viewGO, "Middle/#btn_start/#go_image_start")
	self._goprogress = gohelper.findChild(self.viewGO, "Middle/#go_progress")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "Middle/#go_progress/#txt_difficulty")
	self._txtname = gohelper.findChildText(self.viewGO, "Middle/#go_progress/#txt_name")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_end")
	self._golocked = gohelper.findChild(self.viewGO, "Middle/#go_locked")
	self._txtunlockTime = gohelper.findChildText(self.viewGO, "Middle/#go_locked/#txt_unlockTime")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievementpreview")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Store")
	self._txtRewardNum = gohelper.findChildText(self.viewGO, "Right/#btn_Store/#txt_RewardNum")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Store/#go_reddot")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_EnterView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnend:AddClickListener(self._btnendOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	Rouge2_Controller.instance:registerCallback(Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.onAlchemyInfoUpdate, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.BackEnterScene, self.onBackScene, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.refreshUI, self)
end

function Rouge2_EnterView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	Rouge2_Controller.instance:unregisterCallback(Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.onAlchemyInfoUpdate, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.BackEnterScene, self.onBackScene, self)
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.refreshUI, self)
end

function Rouge2_EnterView:_btnendOnClick()
	self:_end()
end

function Rouge2_EnterView:_btnachievementpreviewOnClick()
	local achievementJumpId = Rouge2_Config.instance:getAchievementJumpId()

	JumpController.instance:jump(achievementJumpId)
end

function Rouge2_EnterView:_btnstartOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_start_2_1)
	self.animator:Play("close", 0, 0)
	gohelper.setActive(self._golefttop, false)
	Rouge2_Model.instance:setCurActId(self.actId)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SceneSwitch, Rouge2_OutsideEnum.SceneIndex.MainScene)
end

function Rouge2_EnterView:_btnStoreOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	Rouge2_ViewHelper.openStoreView()
end

function Rouge2_EnterView:onSceneSwitchFinish()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	Rouge2_Model.instance:setCurActId(self.actId)
	Rouge2_Controller.instance:openMainView()
end

function Rouge2_EnterView:onBackScene(sceneIndex)
	if sceneIndex == Rouge2_OutsideEnum.SceneIndex.EnterScene then
		self.animator:Play("open", 0, 0)
		gohelper.setActive(self._golefttop, true)
	end
end

function Rouge2_EnterView:_editableInitView()
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a2_Rouge_Store_Main, 0)
	gohelper.setActive(self._golocked, false)
end

function Rouge2_EnterView:onUpdateParam()
	return
end

function Rouge2_EnterView:onOpen()
	self.actId = Rouge2_Model.instance:getCurActId()

	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneSecond)

	if self.viewParam and self.viewParam.openMain == true then
		self.animator:Play("close", 0, 0)
		gohelper.setActive(self._golefttop, false)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.BackEnterScene, Rouge2_OutsideEnum.SceneIndex.MainScene)
	else
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_start_1)
		self.animator:Play("open", 0, 0)
		gohelper.setActive(self._golefttop, true)
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.SceneSwitch, Rouge2_OutsideEnum.SceneIndex.EnterScene)
	end

	Rouge2OutsideRpc.instance:sendGetRouge2OutsideInfoRequest(function(_, resultCode)
		if resultCode ~= 0 then
			logError("openRouge2ActivityView sendGetRouge2OutsideInfoRequest resultCode=" .. tostring(resultCode))

			return
		end

		Rouge2_Rpc.instance:sendGetRouge2InfoRequest(function(_, resultCode2)
			if resultCode2 ~= 0 then
				logError("openRouge2ActivityView sendGetRouge2InfoRequest resultCode=" .. tostring(resultCode2))

				return
			end

			self:refreshUI()
		end)
	end)
	Rouge2_OutsideController.instance:tryOpenActivityUpdateTips()
	self:initOpenMainCallback()
end

function Rouge2_EnterView:initOpenMainCallback()
	self._openMainCallback = self.viewParam and self.viewParam.openMainCallback
	self._openMainCallbackObj = self.viewParam and self.viewParam.openMainCallbackObj

	if not self._openMainCallback then
		return
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function Rouge2_EnterView:_onOpenView(viewName)
	if viewName ~= ViewName.Rouge2_MainView then
		return
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)

	if self._openMainCallback then
		self._openMainCallback(self._openMainCallbackObj)
	end
end

function Rouge2_EnterView:_refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self.actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txttime.text = luaLang("ended")

		return
	end

	self._txttime.text = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function Rouge2_EnterView:_onUpdateRougeInfo()
	self:refreshUI()
end

function Rouge2_EnterView:refreshUI()
	local costId = CurrencyEnum.CurrencyType.V3a2Rouge
	local currencyMo = CurrencyModel.instance:getCurrency(costId)

	if currencyMo == nil then
		return
	end

	if not currencyMo.quantity then
		local count = 0

		self._txtRewardNum.text = tostring(count)

		self:_refreshProgress()
	end
end

function Rouge2_EnterView:_refreshProgress()
	local isInRouge = Rouge2_Model.instance:inRouge()
	local difficulty = Rouge2_Model.instance:getDifficulty()
	local selectDifficulty = difficulty ~= nil and difficulty ~= 0

	gohelper.setActive(self._goprogress, isInRouge and selectDifficulty)
	gohelper.setActive(self._btnend, isInRouge and selectDifficulty)

	if not selectDifficulty then
		return
	end

	local difficultyCO = Rouge2_Config.instance:getDifficultyCoById(difficulty)

	self._txtdifficulty.text = difficultyCO.title
end

function Rouge2_EnterView:_end()
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeMainView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function Rouge2_EnterView:_endYesCallback()
	Rouge2_StatController.instance:setReset()
	Rouge2_Rpc.instance:sendRouge2AbortRequest(self._onReceiveEndReply, self)
end

function Rouge2_EnterView:_onReceiveEndReply()
	Rouge2_Controller.instance:startEndFlow()
end

function Rouge2_EnterView:onClose()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function Rouge2_EnterView:onDestroyView()
	return
end

return Rouge2_EnterView

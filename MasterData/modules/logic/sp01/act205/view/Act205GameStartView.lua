-- chunkname: @modules/logic/sp01/act205/view/Act205GameStartView.lua

module("modules.logic.sp01.act205.view.Act205GameStartView", package.seeall)

local Act205GameStartView = class("Act205GameStartView", BaseView)

function Act205GameStartView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtGameName = gohelper.findChildText(self.viewGO, "Info/#txt_GameName")
	self._txtGameDesc = gohelper.findChildText(self.viewGO, "Info/Scroll View/Viewport/#txt_GameDesc")
	self._simageGamePic = gohelper.findChildSingleImage(self.viewGO, "Info/#simage_GamePic")
	self._txtTargetDesc = gohelper.findChildText(self.viewGO, "Target/Scroll View/Viewport/#txt_TargetDesc")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Start")
	self._gonormal = gohelper.findChild(self.viewGO, "#btn_Start/#go_normal")
	self._golock = gohelper.findChild(self.viewGO, "#btn_Start/#go_lock")
	self._gogameTimes = gohelper.findChild(self.viewGO, "#btn_Start/#go_gameTimes")
	self._txtgameTimes = gohelper.findChildText(self.viewGO, "#btn_Start/#go_gameTimes/#txt_gameTimes")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205GameStartView:addEvents()
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self.addEventCb(self, Act205Controller.instance, Act205Event.OnDailyRefresh, self.refreshUI, self)
	self.addEventCb(self, Act205Controller.instance, Act205Event.OnFinishGame, self.refreshUI, self)
	self.addEventCb(self, AssassinChaseController.instance, Act205Event.OnInfoUpdate, self.refreshUI, self)
	self.addEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, self.refreshUI, self)
	self.addEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, self.refreshUI, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.checkViewClose, self)
end

function Act205GameStartView:removeEvents()
	self._btnStart:RemoveClickListener()
	self.removeEventCb(self, Act205Controller.instance, Act205Event.OnDailyRefresh, self.refreshUI, self)
	self.removeEventCb(self, Act205Controller.instance, Act205Event.OnFinishGame, self.refreshUI, self)
	self.removeEventCb(self, AssassinChaseController.instance, Act205Event.OnInfoUpdate, self.refreshUI, self)
	self.removeEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, self.refreshUI, self)
	self.removeEventCb(self, AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, self.refreshUI, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.checkViewClose, self)
end

function Act205GameStartView:_btnStartOnClick()
	if self.gameStageId == Act205Enum.GameStageId.Chase then
		AssassinChaseController.instance:openAssassinChaseView(self.activityId)
	else
		local isGameOpen = Act205Model.instance:isGameStageOpen(self.gameStageId, true)

		if not isGameOpen then
			return
		elseif self.curGameTimes <= 0 then
			GameFacade.showToast(ToastEnum.Act205DailyRefresh)

			return
		end

		if self.gameStageId == Act205Enum.GameStageId.Ocean then
			Act205Controller.instance:openOceanSelectView({
				gameStageId = self.gameStageId
			})
		elseif self.gameStageId == Act205Enum.GameStageId.Card then
			Act205CardController.instance:enterCardGame()
		end
	end
end

function Act205GameStartView:_editableInitView()
	self.titleGOMap = self:getUserDataTb_()

	for stage = Act205Enum.GameStageId.Card, Act205Enum.GameStageId.Chase do
		self.titleGOMap[stage] = gohelper.findChild(self.viewGO, "Info/Title/#go_Title" .. stage)
	end
end

function Act205GameStartView:onUpdateParam()
	return
end

function Act205GameStartView:onOpen()
	self.activityId = self.viewParam.activityId
	self.gameStageId = self.viewParam.gameStageId

	if self.gameStageId == Act205Enum.GameStageId.Chase then
		AssassinChaseModel.instance:setCurActivityId(self.activityId)

		self.stageConfig = AssassinChaseConfig.instance:getDescConfig(self.activityId, self.gameStageId)
	else
		Act205Model.instance:setGameStageId(self.gameStageId)

		self.stageConfig = Act205Config.instance:getStageConfig(self.activityId, self.gameStageId)
	end

	self:refreshUI()
end

function Act205GameStartView:refreshUI()
	local curGameTimes, totalGameTimes

	if self.gameStageId == Act205Enum.GameStageId.Chase then
		local constConfig = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.TotalGameTime)

		totalGameTimes = tostring(constConfig.value)

		local gameInfoMo = AssassinChaseModel.instance:getActInfo(self.activityId)
		local isActOpen = AssassinChaseModel.instance:isActOpen(self.activityId, false, false)
		local isActRealOpen = AssassinChaseModel.instance:isActOpen(self.activityId, false, true)
		local canEnter = isActOpen or isActRealOpen and gameInfoMo:canGetBonus()

		gohelper.setActive(self._gogameTimes, isActOpen)

		if isActOpen then
			curGameTimes = gameInfoMo:isSelect() and 0 or totalGameTimes
			self._txtgameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_canPlayGameTimes"), curGameTimes, totalGameTimes)
		end

		gohelper.setActive(self._golock, not canEnter)
		gohelper.setActive(self._gonormal, canEnter)
	else
		totalGameTimes = self.stageConfig.times

		gohelper.setActive(self._gogameTimes, true)

		local gameInfoMo = Act205Model.instance:getGameInfoMo(self.activityId, self.gameStageId)

		curGameTimes = gameInfoMo and gameInfoMo.haveGameCount or 0
		self._txtgameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_canPlayGameTimes"), curGameTimes, totalGameTimes)

		gohelper.setActive(self._golock, curGameTimes <= 0 or not gameInfoMo)
		gohelper.setActive(self._gonormal, curGameTimes > 0 and gameInfoMo)
	end

	self._txtGameName.text = self.stageConfig.name
	self._txtGameDesc.text = self.stageConfig.desc
	self._txtTargetDesc.text = self.stageConfig.targetDesc
	self.curGameTimes = curGameTimes

	for stage, titleGO in pairs(self.titleGOMap) do
		gohelper.setActive(titleGO, stage == self.gameStageId)
	end

	self._simageGamePic:LoadImage(ResUrl.getV2a9ActSingleBg("gamestart_pic0" .. self.gameStageId))
	self:refreshOceanNewUnlockRedDot()
end

function Act205GameStartView:refreshOceanNewUnlockRedDot()
	local isDotShow = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a9_Act205OceanOpen, 0)

	if isDotShow then
		Activity204Controller.instance:setPlayerPrefs(PlayerPrefsKey.Activity204OceanOpenReddot, 1)
		Activity204Controller.instance:checkOceanNewOpenRedDot()
	end
end

function Act205GameStartView:checkViewClose()
	local isGameOpen = true

	if self.gameStageId == Act205Enum.GameStageId.Chase then
		local gameInfoMo = AssassinChaseModel.instance:getActInfo(self.activityId)
		local isActOpen = AssassinChaseModel.instance:isActOpen(self.activityId, false, false)
		local isActRealOpen = AssassinChaseModel.instance:isActOpen(self.activityId, false, true)

		isGameOpen = isActOpen or isActRealOpen and gameInfoMo:canGetBonus()
	else
		isGameOpen = Act205Model.instance:isGameStageOpen(self.gameStageId, false)
	end

	if not isGameOpen then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, Act205GameStartView.yesCallback)
	end
end

function Act205GameStartView.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

function Act205GameStartView:onClose()
	return
end

function Act205GameStartView:onDestroyView()
	self._simageGamePic:UnLoadImage()
end

return Act205GameStartView

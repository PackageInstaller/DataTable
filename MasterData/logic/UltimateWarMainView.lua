-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarMainView.lua

module("logic.extensions.ultimatewar.view.UltimateWarMainView", package.seeall)

local UltimateWarMainView = class("UltimateWarMainView", ViewComponent)

function UltimateWarMainView:buildUI()
	UltimateWarMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnUpPet = self:getGo("btnUpPet")
	self._redBtnUpPet = self:getGo("btnUpPet/redPoint")

	local btnStepOne = self:getGo("btnStepOne")
	local btnStepTwo = self:getGo("btnStepTwo")
	local btnStepThree = self:getGo("btnStepThree")

	self._btnSteps = {}

	for stepId, mainGo in ipairs({
		btnStepOne,
		btnStepTwo,
		btnStepThree
	}) do
		local cell = {}

		cell._mainGo = mainGo
		cell._btn = goutil.findChild(mainGo, "btn")
		cell._red = goutil.findChild(mainGo, "btn/redPoint")
		cell._imgLock = goutil.findChild(mainGo, "btn/imgLock")
		cell._tips = goutil.findChild(mainGo, "tips")
		cell._txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")
		self._btnSteps[stepId] = cell
	end
end

function UltimateWarMainView:bindEvents()
	UltimateWarMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnUpPet, self._onClickBtnUpPet, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, function()
		GotoMgr.gotoByString("func#1174")
	end)

	for stepId, cell in ipairs(self._btnSteps) do
		GameUtil.addClickHandler(cell._btn, GameUtil.handler(self._onClickBtnStep, self, stepId))
	end
end

function UltimateWarMainView:unbindEvents()
	UltimateWarMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnUpPet)

	for stepId, cell in ipairs(self._btnSteps) do
		GameUtil.rmClickHandler(cell._btn)
		RedPointController.instance:unregRedPoint(cell._red)
	end

	RedPointController.instance:unregRedPoint(self._redBtnUpPet)
end

function UltimateWarMainView:onEnter()
	UltimateWarMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = UltimateWarController.instance:getActivityId()
	end

	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._isPlayingPlot = false

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarFinishPlotRes, self._handlePM_UltimateWarFinishPlotRes, self)
	UltimateWarController.instance:sendPM_UltimateWarGetMainInfoReq(self._activityId)
end

function UltimateWarMainView:onExit()
	UltimateWarMainView.super.onExit(self)
end

function UltimateWarMainView:_handlePM_UltimateWarFinishPlotRes(status, msg)
	self._isPlayingPlot = false

	if status ~= 0 then
		return
	end

	local storyId = UltimateWarConfig.instance:getPlotStoryId(msg.activityId, msg.plotId)

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
end

function UltimateWarMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local cell1 = self._btnSteps[UltimateWarEnum.StepId_One]
	local cell2 = self._btnSteps[UltimateWarEnum.StepId_Two]
	local cell3 = self._btnSteps[UltimateWarEnum.StepId_Three]

	RedPointController.instance:regRedPoint(cell1._red, RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY, RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH, RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_CANDISPATCH)
	RedPointController.instance:regRedPoint(cell2._red, RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_BOSSPRIZE, RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_STAGEPRIZE)
	RedPointController.instance:regRedPoint(cell3._red, RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BUFF, RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BOSSPrize)

	local redIdList = {
		RedPointModel.ID_ULTIMATEWAR_PET_UP
	}
	local result = UltimateWarController.instance:getTryUpPetLevelResultAndTips(false, self._activityId)

	if result ~= GameEnum.ResultCode.NotInTime and result ~= GameEnum.ResultCode.IsMaxLimit then
		local value = self._actData.gameReds

		if not string.nilorempty(value) then
			local list = string.split(value, "#")

			table.insertto(redIdList, list)
		end
	end

	RedPointController.instance:regRedPoint(self._redBtnUpPet, unpack(redIdList))
end

function UltimateWarMainView:_onUpdate()
	if not self._ultimateWarMo:isHasReqStep(UltimateWarEnum.StepId_One) then
		local result = UltimateWarController.instance:getTryEnterStepResultAndTips(false, self._activityId, UltimateWarEnum.StepId_One)

		if result == GameEnum.ResultCode.Success then
			UltimateWarController.instance:sendPM_UltimateWarFirstStepInfoReq(self._activityId)
		end
	end

	if not self._ultimateWarMo:isHasReqStep(UltimateWarEnum.StepId_Two) then
		local result = UltimateWarController.instance:getTryEnterStepResultAndTips(false, self._activityId, UltimateWarEnum.StepId_Two)

		if result == GameEnum.ResultCode.Success then
			UltimateWarController.instance:sendPM_UltimateWarSecondStepInfoReq(self._activityId)
		end
	end

	if not self._ultimateWarMo:isHasReqStep(UltimateWarEnum.StepId_Three) then
		local result = UltimateWarController.instance:getTryEnterStepResultAndTips(false, self._activityId, UltimateWarEnum.StepId_Three)

		if result == GameEnum.ResultCode.Success then
			UltimateWarController.instance:sendPM_UltimateWarThirdStepInfoReq(self._activityId)
		end
	end

	if not self._ultimateWarMo:isFinishPlotId(UltimateWarEnum.Story_Plot_1) then
		self._isPlayingPlot = true

		UltimateWarController.instance:sendPM_UltimateWarFinishPlotReq(self._activityId, UltimateWarEnum.Story_Plot_1)
	end

	local stepCfg = UltimateWarConfig.instance:getStepCfg(self._activityId) or {}

	for _, data in ipairs(stepCfg) do
		local stepId = data.stepId
		local result = UltimateWarController.instance:getTryEnterStepResultAndTips(false, self._activityId, stepId)
		local isUnLock = result == GameEnum.ResultCode.Success
		local cell = self._btnSteps[stepId]

		GameUtil.SetActive(cell._imgLock, not isUnLock)
		GameUtil.SetActive(cell._tips, not isUnLock)

		if not self._ultimateWarMo:isUnLockStepByTime(stepId) then
			cell._txtTips.text = string.format("%s后开启", GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime)))
		elseif not self._ultimateWarMo:isUnLockStepByPreCond(stepId) then
			cell._txtTips.text = ""

			GameUtil.SetActive(cell._tips, false)
		else
			local level = self._ultimateWarMo:getPetLevel()
			local needLevel = UltimateWarEnum.StepUnlock_Levels[stepId]

			if level < needLevel then
				cell._txtTips.text = string.format("强化至%s级", needLevel)
			end
		end
	end
end

function UltimateWarMainView:_onClickBtnJump(key)
	if key == "jumpStrOne" then
		UltimateWarController.instance:openCommonTabRank(self._activityId)
	else
		local jumpToStr = self._actData[key]

		GotoMgr.gotoByString(jumpToStr)
	end
end

function UltimateWarMainView:_onClickBtnStep(stepId)
	local result = UltimateWarController.instance:getTryEnterStepResultAndTips(true, self._activityId, stepId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if stepId == UltimateWarEnum.StepId_One then
		UIStateManager.instance:push(ViewName.UltimateWarDispatchPartView, self._activityId)
	elseif stepId == UltimateWarEnum.StepId_Two then
		UIStateManager.instance:push(ViewName.UltimateWarTowerView, self._activityId)
	elseif stepId == UltimateWarEnum.StepId_Three then
		if self._ultimateWarMo:isFinishPlotId(UltimateWarEnum.Story_Plot_5) then
			UIStateManager.instance:push(ViewName.UltimateWarFinalBossView, self._activityId)
		else
			UIStateManager.instance:push(ViewName.UltimatewarFinalStartView, self._activityId)
		end
	end
end

function UltimateWarMainView:_onClickBtnTip()
	local key = self._actData.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function UltimateWarMainView:_onClickBtnUpPet()
	UIStateManager.instance:push(ViewName.UltimateWarUpPetView, self._activityId)
end

return UltimateWarMainView

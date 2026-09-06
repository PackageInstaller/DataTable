-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyaostory/view/FuYaoStoryMainView.lua

module("logic.extensions.fuyaostory.view.FuYaoStoryMainView", package.seeall)

local FuYaoStoryMainView = class("FuYaoStoryMainView", ViewComponent)

function FuYaoStoryMainView:buildUI()
	FuYaoStoryMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnStory = self:getGo("leftTop/btnStory")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")

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

function FuYaoStoryMainView:bindEvents()
	FuYaoStoryMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStory, self._onClickBtnStory, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))

	for stepId, cell in ipairs(self._btnSteps) do
		GameUtil.addClickHandler(cell._btn, GameUtil.handler(self._onClickBtnStep, self, stepId))
	end
end

function FuYaoStoryMainView:unbindEvents()
	FuYaoStoryMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStory)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)

	for stepId, cell in ipairs(self._btnSteps) do
		GameUtil.rmClickHandler(cell._btn)
	end
end

function FuYaoStoryMainView:onEnter()
	FuYaoStoryMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._basePlanId = checknumber(params[1])

	if self._basePlanId <= 0 then
		self._basePlanId = FuYaoStoryController.instance:getBasePlanId()
	end

	local isInTime = FuYaoStoryController.instance:isInTimeOfPlan(self._basePlanId)

	if not isInTime then
		self:close()

		return
	end

	self._baseData = FuYaoStoryConfig.instance:getBaseData(self._basePlanId)
	self._enterCfg = FuYaoStoryConfig.instance:getEnterCfg(self._basePlanId)
	self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(GameUtil.string2time(self._baseData.startTime), GameUtil.string2time(self._baseData.endTime))

	for _, data in ipairs(self._enterCfg) do
		local stepId = data.stepId
		local cell = self._btnSteps[stepId]

		if not data.redId then
			if #data.redId > 0 then
				RedPointController.instance:regRedPoint(cell._red, GameUtil.unpack10(data.redId))
			else
				GameUtil.SetActive(cell._red, false)
			end
		end
	end

	self:_onUpdate()
	FuYaoStoryController.instance:tryPlayPlotOnce(FuYaoStoryEnum.Story_Plot_1)
end

function FuYaoStoryMainView:onExit()
	FuYaoStoryMainView.super.onExit(self)

	for stepId, cell in ipairs(self._btnSteps) do
		RedPointController.instance:unregRedPoint(cell._red)
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function FuYaoStoryMainView:_onUpdate()
	local skinId = 0

	for _, data in ipairs(self._enterCfg) do
		local stepId = data.stepId
		local timePeriod = FuYaoStoryController.instance:getTimePeriodInStep(self._basePlanId, stepId)
		local isUnLock = timePeriod == GameUtil.inTimePeriod
		local cell = self._btnSteps[stepId]

		if isUnLock then
			skinId = data.skinId
		end

		GameUtil.SetActive(cell._imgLock, not isUnLock)
		GameUtil.SetActive(cell._tips, not isUnLock)

		cell._txtTips.text = string.format("%s后开启", GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.startTime)))
	end

	if skinId > 0 then
		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[3] then
			local x, y, scale = checknumber(modelCfg[1]), checknumber(modelCfg[2]), 1

			self._loader = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, modelCfg[3], nil, true, x, y)
		end
	else
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end
end

function FuYaoStoryMainView:_onClickBtnJump(key)
	local jumpToStr = self._baseData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function FuYaoStoryMainView:_onClickBtnStep(stepId)
	local timePeriod = FuYaoStoryController.instance:getTimePeriodInStep(self._basePlanId, stepId)

	if timePeriod ~= GameUtil.inTimePeriod then
		FloatWordMgr.instance:show("未开启")

		return
	end

	local data = FuYaoStoryConfig.instance:getEnterData(self._basePlanId, stepId)

	GotoMgr.gotoByString(data.jumpStr)
end

function FuYaoStoryMainView:_onClickBtnTip()
	local key = self._baseData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function FuYaoStoryMainView:_onClickBtnStory()
	UIStateManager.instance:push(ViewName.FuYaoStoryPlotView, self._basePlanId)
end

return FuYaoStoryMainView

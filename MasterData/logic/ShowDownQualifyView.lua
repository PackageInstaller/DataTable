-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifyView.lua

module("logic.extensions.showdown.view.ShowDownQualifyView", package.seeall)

local ShowDownQualifyView = class("ShowDownQualifyView", ViewComponent)

function ShowDownQualifyView:ctor()
	ShowDownQualifyView.super.ctor(self)
end

function ShowDownQualifyView:buildUI()
	ShowDownQualifyView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnTask = goutil.findChild(self.mainGO, "btnTask")
	self._redBtnTask = goutil.findChild(self.mainGO, "btnTask/redPoint")
	self._btnShop = goutil.findChild(self.mainGO, "btnShop")
	self._btnFmt = goutil.findChild(self.mainGO, "btnFmt")
	self._btnMatch = goutil.findChild(self.mainGO, "btnMatch")
	self._txtLeftTimes = goutil.findChildTextComponent(self.mainGO, "leftTimes/txt")
	self._qualifyTime = goutil.findChild(self.mainGO, "qualifyTime")
	self._txtQualifyTime = goutil.findChildTextComponent(self.mainGO, "qualifyTime/txt")
end

function ShowDownQualifyView:bindEvents()
	ShowDownQualifyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._btnMatch, self._onClickBtnMatch, self)
end

function ShowDownQualifyView:unbindEvents()
	ShowDownQualifyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._btnMatch)
end

function ShowDownQualifyView:onEnter()
	ShowDownQualifyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._qualType = ShowDownEnum.QualType_Normal
	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_StartMatchingRes, self._handlePM_ShowDownQualify_StartMatchingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetQualifyMainInfoRes, self._onUpdate, self)
	ShowDownController.instance:sendPM_ShowDown_GetQualifyMainInfoReq(self._activityId)
end

function ShowDownQualifyView:onExit()
	ShowDownQualifyView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function ShowDownQualifyView:_handlePM_ShowDownQualify_StartMatchingRes(status)
	if status == 0 then
		UIStateManager.instance:push(ViewName.ShowDownQualifyMatchView, self._activityId, self._qualType)
	else
		FloatWordMgr.instance:show("无法进行匹配")
	end
end

function ShowDownQualifyView:_onSetUI()
	if self._txtQualifyTime then
		local startTime, endTime = ShowDownController.instance:getMatchTimeInQualify(self._activityId, self._qualType)

		if not string.nilorempty(startTime) and not string.nilorempty(endTime) then
			local startT, endT = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			self._txtQualifyTime.text = string.format("可匹配时间：<color=#ffd89d>%02d时%02d分-%02d时%02d分</color>", startT.hour, startT.min, endT.hour, endT.min)

			GameUtil.SetActive(self._qualifyTime, true)
		else
			GameUtil.SetActive(self._qualifyTime, false)
		end
	end

	local skinId = ShowDownConfig.instance:getCommonValue(self._activityId, "skinId", true)

	if skinId > 0 then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	end

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end
end

function ShowDownQualifyView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownQualifyView:_onUpdateData()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
end

function ShowDownQualifyView:_onUpdateUI()
	local left = ShowDownController.instance:getLeftChallengeTimesInQualify(self._activityId, self._qualType)
	local max = ShowDownController.instance:getMaxChallengeTimesInQualify(self._activityId, self._qualType)

	self._txtLeftTimes.text = left <= 0 and string.format("<color=#ffa251>%s</color>/%s", left, max) or string.format("%s/%s", left, max)
end

function ShowDownQualifyView:_onClickBtnRank()
	ShowDownController.instance:opShowDownRank(self._activityId, self._qualType)
end

function ShowDownQualifyView:_onClickBtnTask()
	ShowDownController.instance:opTaskView(self._activityId)
end

function ShowDownQualifyView:_onClickBtnShop()
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, "jumpStrShop")

	GotoMgr.gotoByString(value)
end

function ShowDownQualifyView:_onClickBtnFmt()
	ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, self._curRoundId, self._curStepId)
end

function ShowDownQualifyView:_onClickBtnMatch()
	local isHasConfirm = ShowDownController.instance:isHasConfirmInPetShop(self._activityId, self._curRoundId)

	if not isHasConfirm then
		FloatWordMgr.instance:show("请确认上阵精灵")
		ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, self._curRoundId, self._curStepId)

		return
	end

	local isEmptyForm = ShowDownController.instance:isEmptyFormInPetShop(self._activityId, self._curRoundId, self._curStepId)

	if isEmptyForm then
		FloatWordMgr.instance:show("请调整空阵")
		ShowDownController.instance:enterShowDownPetShopAndFmt(self._activityId, self._curRoundId, self._curStepId)

		return
	end

	local curRacePeriod = ShowDownController.instance:getRacePeriodByStep(self._activityId, self._curRoundId)

	if curRacePeriod ~= ShowDownEnum.RacePeriod_Qualify then
		FloatWordMgr.instance:show("不在预选赛时间范围内")

		return
	end

	if not ShowDownController.instance:isMatchTimeInQualify(self._activityId, self._qualType) then
		local startTime, endTime = ShowDownController.instance:getMatchTimeInQualify(self._activityId, self._qualType)

		if not string.nilorempty(startTime) and not string.nilorempty(endTime) then
			local startT, endT = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

			FloatWordMgr.instance:show(string.format("预选赛每日匹配时间段为%02d时%02d分-%02d时%02d分", startT.hour, startT.min, endT.hour, endT.min))
		end

		return
	end

	if ShowDownController.instance:isEndMatchMinuteEarlyInQualify(self._activityId, self._qualType) then
		local data = ShowDownConfig.instance:getQualifyData(self._activityId, self._qualType)

		FloatWordMgr.instance:show(string.format("预选赛提前%s分钟结算，不可匹配对手", data.endMatchMinuteEarly))

		return
	end

	if isEmptyForm then
		FloatWordMgr.instance:show("无法使用空阵进行挑战")

		return
	end

	ShowDownController.instance:sendPM_ShowDownQualify_StartMatchingReq(self._activityId, self._qualType)
end

return ShowDownQualifyView

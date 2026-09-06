-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownScheduleView.lua

module("logic.extensions.showdown.view.ShowDownScheduleView", package.seeall)

local ShowDownScheduleView = class("ShowDownScheduleView", ViewComponent)

function ShowDownScheduleView:ctor()
	ShowDownScheduleView.super.ctor(self)
end

function ShowDownScheduleView:buildUI()
	ShowDownScheduleView.super.buildUI(self)

	self._roundConList = {}

	for i = 1, 3 do
		local con = {}

		con.go = self:getGo("round_" .. i)
		con.tipStay = goutil.findChild(con.go, "tipStay")
		con.tipNow = goutil.findChild(con.go, "tipNow")
		con.btnTips = goutil.findChild(con.go, "btnTips")
		con.txtTime = goutil.findChildTextComponent(con.go, "txtTime")
		self._roundConList[i] = con
	end

	self._tipWin = self:getGo("tipWin")
	self._txtTipWin = self:getTxt("tipWin/txt")
	self._txtShowTip = self:getTxt("schedule/txtShowTip")
	self._txtTimeSchedule = self:getTxt("schedule/txtShowTip/txtTime")
	self._remainTime = goutil.findChild(self.mainGO, "remainTime")
	self._txtRemainTimeName = self:getTxt("remainTime/txtRemainTimeName")
	self._txtRemainTime = self:getTxt("remainTime/txtRemainTime")
	self._slider = self:getSlider("slider")
end

function ShowDownScheduleView:bindEvents()
	ShowDownScheduleView.super.bindEvents(self)

	for idx, con in ipairs(self._roundConList) do
		GameUtil.addClickHandler(con.btnTips, GameUtil.handler(self._onClickBtnTip, self, idx))
	end
end

function ShowDownScheduleView:unbindEvents()
	ShowDownScheduleView.super.unbindEvents(self)

	for idx, con in ipairs(self._roundConList) do
		GameUtil.rmClickHandler(con.btnTips)
	end
end

function ShowDownScheduleView:onEnter()
	ShowDownScheduleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)

	GameUtil.SetActive(self._remainTime, false)

	self._isVoteTime = false

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self.updateInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self.updateInfo, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetTeamMainInfoRes, self.updateInfo, self)

	if self._curRoundId == ShowDownEnum.Round_Eliminate_Group then
		ShowDownController.instance:sendPM_ShowDown_GetTeamMainInfoReq(self._activityId, -1)
	end

	ShowDownController.instance:sendPM_ShowDown_GetScheduleInfoReq(self._activityId)
end

function ShowDownScheduleView:onExit()
	ShowDownScheduleView.super.onExit(self)
	removetimer(self._onTicking, self)
end

function ShowDownScheduleView:updateInfo()
	self:updateScheduleData()

	local isFighter = ShowDownController.instance:isFighter(self._activityId, self._curRoundId)
	local isCanGuess = ShowDownController.instance:isCanGuessInStep(self._activityId, self._curStepId)

	if self._curRoundId == ShowDownEnum.Round_Final_Result then
		GameUtil.SetActive(self._remainTime, false)
		removetimer(self._onTicking, self)
	else
		GameUtil.SetActive(self._remainTime, true)

		if not isFighter and isCanGuess then
			self._txtRemainTimeName.text = "剩余应援时间："
			self._isVoteTime = true
		else
			local tipsStr = ShowDownController.instance:getShowTipsInStep(self._activityId, self._curStepId)

			self._txtRemainTimeName.text = tipsStr .. "："
			self._isVoteTime = false
		end

		self:_onTicking()
		settimer(1, self._onTicking, self, true)
	end

	for i = 1, 3 do
		local con = self._roundConList[i]

		goutil.setActive(con.tipStay, false)
		goutil.setActive(con.tipNow, false)

		local name = string.format("detailTips_%s", i)
		local value = ShowDownConfig.instance:getCommonValue(self._activityId, name)

		GameUtil.SetActive(con.btnTips, not string.nilorempty(value))

		local startStepId, endStepId = 0, 0

		if i == 1 then
			endStepId = 2
			startStepId = 1
		elseif i == 2 then
			endStepId = 20
			startStepId = 2
		elseif i == 3 then
			endStepId = 49
			startStepId = 21
		end

		if startStepId > 0 and endStepId > 0 then
			local startStamp, endStamp = ShowDownController.instance:getStepTimeStamp(self._activityId, startStepId, endStepId)
			local sDate, eDate = GameUtil.time2date(startStamp), GameUtil.time2date(endStamp)

			con.txtTime.text = string.format("%d.%d~%d.%d", sDate.month, sDate.day, eDate.month, eDate.day)
		else
			printError("请检查stepId设置")
		end
	end

	goutil.setActive(self._tipWin, false)

	if isFighter then
		local index = 0
		local roundInRace = ShowDownEnum.RoundInRace[self._curRoundId]

		if roundInRace == ShowDownEnum.RacePeriod_Qualify then
			index = 1
		elseif roundInRace == ShowDownEnum.RacePeriod_Eliminate then
			index = 2
		elseif roundInRace == ShowDownEnum.RacePeriod_Final then
			index = 3
		end

		GameUtil.SetActive(self._roundConList[index].tipNow, true)
	else
		local tipsStr = ""

		if self._curRoundId == ShowDownEnum.Round_Final_Result then
			local myRank = ShowDownController.instance:getMyFinalRank(self._activityId)

			if myRank == 1 then
				tipsStr = "恭喜您！获得本次比赛的冠军"
			elseif myRank == 2 then
				tipsStr = "恭喜您！获得本次比赛的亚军"
			elseif myRank == 3 then
				tipsStr = "恭喜您！获得本次比赛的季军"
			elseif myRank >= 4 then
				tipsStr = string.format("恭喜您！获得本次比赛的第%s名", myRank)
			end
		end

		local isNeedTipWin = not string.nilorempty(tipsStr)

		if isNeedTipWin then
			self._txtTipWin.text = tipsStr

			GameUtil.SetActive(self._tipWin, true)
		else
			local playerRoundId = ShowDownController.instance:getPlayerRoundId(self._activityId)

			if playerRoundId <= ShowDownEnum.Round_Eliminate_Group then
				GameUtil.SetActive(self._roundConList[1].tipStay, true)
			elseif playerRoundId < ShowDownEnum.Round_Final_01 then
				GameUtil.SetActive(self._roundConList[2].tipStay, true)
			elseif playerRoundId < ShowDownEnum.Round_Final_Result then
				GameUtil.SetActive(self._roundConList[3].tipStay, true)
			end
		end
	end

	local racePeriod = ShowDownController.instance:getRacePeriodByStep(self._activityId, self._curRoundId)

	self._slider:SetValue(racePeriod == ShowDownEnum.RacePeriod_Qualify and 0 or racePeriod == ShowDownEnum.RacePeriod_Eliminate and 0.503 or 1)
end

function ShowDownScheduleView:updateScheduleData()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curStepData = ShowDownConfig.instance:getStepData(self._activityId, self._curStepId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
end

function ShowDownScheduleView:_onTicking()
	self._txtRemainTime.text = GameUtil.FormatTimeSymbol(self._isVoteTime and ShowDownController.instance:getLeftTimeStampToNextInVote(self._activityId, self._curStepId) or ShowDownController.instance:getLeftTimeStampToNext(self._activityId, self._curStepId))
end

function ShowDownScheduleView:_onClickBtnTip(idx)
	local name = string.format("detailTips_%s", idx)
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, name)

	TipsFacade.instance:openRulesView(value)
end

return ShowDownScheduleView

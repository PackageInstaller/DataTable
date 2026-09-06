-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownMainView.lua

module("logic.extensions.showdown.view.ShowDownMainView", package.seeall)

local ShowDownMainView = class("ShowDownMainView", ViewComponent)
local CurTabIdx = 0

function ShowDownMainView:ctor()
	ShowDownMainView.super.ctor(self)
end

function ShowDownMainView:buildUI()
	ShowDownMainView.super.buildUI(self)

	self._imgBg = goutil.findChild(self.mainGO, "imgBg")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._periodChangeTips = goutil.findChild(self.mainGO, "periodChangeTips")
	self._txtTipsInPeriodChangeTips = goutil.findChildTextComponent(self.mainGO, "periodChangeTips/txt")
end

function ShowDownMainView:bindEvents()
	ShowDownMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function ShowDownMainView:unbindEvents()
	ShowDownMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ShowDownMainView:onEnter()
	ShowDownMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	ShowDownController.instance:enterInStepMgr(self._activityId)

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = "活动不在开启期限内"

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = ShowDownConfig.instance:getActData(self._activityId)
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
	self._mainRaceInfo = ShowDownController.instance:getMainRaceInfoMo(self._activityId, self._curStepId)
	self._newestBatEndStepId = -1
	self._isShowingTips = false
	CurTabIdx = CurTabIdx or 0

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self, NotifyPriority.Low)
	self.addGEvent(self, GlobalNotify.ShowDownMainViewJumpTab, self._handleShowDownMainViewJumpTab, self, NotifyPriority.Low)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._handlePM_ShowDown_GetScheduleInfoRes, self, NotifyPriority.Low)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetTeamMainInfoRes, self._handlePM_ShowDown_GetTeamMainInfoRes, self, NotifyPriority.Low)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetDisplayInfoRes, self._handlePM_ShowDown_GetDisplayInfoRes, self, NotifyPriority.Low)
	self.addGEvent(self, GlobalNotify.ShowDownClose, self._handleShowDownClose, self, NotifyPriority.Low)
	self:_sendBaseInfoReq()
	GameUtil.SetActive(self._periodChangeTips, false)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local list = {}
	local tab = {
		showAdd = false,
		id = self._actData.guessItem
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
	local changeSetIdList = showDownMo:getChangeSetIdListInQualify()

	showDownMo:clearChangeSetIdListInQualify()

	if changeSetIdList then
		for _, changeSetId in ipairs(changeSetIdList) do
			MaterialController.instance:showChangeSetInTemp(changeSetId)
		end
	end

	ShowDownController.instance:sendPM_ShowDown_GetStepInfoReq(self._activityId)
end

function ShowDownMainView:onExit()
	ShowDownMainView.super.onExit(self)
	ShowDownController.instance:exitInStepMgr(self._activityId)
	removetimer(self._endTipsInPeriodChangeTips, self)
	self:_onClearTabAt()
end

function ShowDownMainView:_handleShowDownClose()
	UIStateManager.instance:clear()
end

function ShowDownMainView:_handleShowDownStepChange()
	local oldStepId = self._curStepId
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)

	if oldStepId == curStepId then
		self:_onUpdate()
	else
		self:_sendBaseInfoReq()
	end
end

function ShowDownMainView:_handlePM_ShowDown_GetScheduleInfoRes()
	local isPopResultView = false
	local stepMatchViewMoList, teamViewMo
	local racePeriod = ShowDownController.instance:getRacePeriodByStep(self._activityId, self._curRoundId)

	if racePeriod == ShowDownEnum.RacePeriod_Eliminate then
		local scheduleInfo = ShowDownController.instance:getScheduleInfoInElimate(self._activityId)

		stepMatchViewMoList = scheduleInfo:getStepMatchViewMoList()
		teamViewMo = scheduleInfo:getTeamViewMo()
	elseif racePeriod == ShowDownEnum.RacePeriod_Final then
		local scheduleInfo = ShowDownController.instance:getScheduleInfoInFinal(self._activityId)

		stepMatchViewMoList = scheduleInfo:getStepMatchViewMoList()
		teamViewMo = scheduleInfo:getTeamViewMo()
	end

	if stepMatchViewMoList and teamViewMo then
		local oldBatEndStepId = self._newestBatEndStepId
		local curBatEndStepId = 0
		local newestMo

		for idx, stepMatchViewMo in ipairs(stepMatchViewMoList) do
			local result = stepMatchViewMo:getResult()

			if result ~= nil then
				curBatEndStepId = stepMatchViewMo:getStepId()
				newestMo = stepMatchViewMo
			else
				break
			end
		end

		if newestMo and oldBatEndStepId > 0 and oldBatEndStepId ~= curBatEndStepId then
			local result = newestMo:getResult()

			ShowDownController.instance:opEliminateResultView(self._activityId, teamViewMo, result)

			isPopResultView = true
		end

		self._newestBatEndStepId = curBatEndStepId
	end

	if isPopResultView == false then
		self:_checkPopResultTips()
	end

	self:_onUpdate()
end

function ShowDownMainView:_handlePM_ShowDown_GetTeamMainInfoRes()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)

	if curStepId == ShowDownEnum.Round_Eliminate_Group then
		self:_checkPopResultTips()
	end

	self:_onUpdate()
end

function ShowDownMainView:_handleShowDownMainViewJumpTab(tabIdx)
	CurTabIdx = tabIdx or 0
	CurTabIdx = Mathf.Clamp(CurTabIdx, 0, #self._tabDataList)

	self:_onUpdateUI()
end

function ShowDownMainView:_handlePM_ShowDown_GetDisplayInfoRes()
	local myRank = -1
	local myUserId = RoleModel.instance:getUserId()
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
	local resultInfos = showDownMo:getFinalResultInfos()

	for i, v in ipairs(resultInfos) do
		for _, playerView in ipairs(v.playerViewList) do
			local userId = checknumber(playerView.headInfo.userId)

			if userId == myUserId then
				myRank = v.rank

				break
			end
		end

		if myRank > 0 then
			break
		end
	end

	self._txtTipsInPeriodChangeTips.text = myRank == 1 and "恭喜您在比赛中获得了冠军" or myRank == 2 and "恭喜您在比赛中获得了亚军" or myRank == 3 and "恭喜您在比赛中获得了季军" or "决赛已结束，去主赛场看看吧~"
end

function ShowDownMainView:_sendBaseInfoReq()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

	if curRoundId == ShowDownEnum.Round_Eliminate_Group then
		ShowDownController.instance:sendPM_ShowDown_GetTeamMainInfoReq(self._activityId, -1)
	end

	ShowDownController.instance:sendPM_ShowDown_GetScheduleInfoReq(self._activityId)
end

function ShowDownMainView:_checkPopResultTips()
	local key = string.format("ShowDownPopResultTips_%s", self._activityId)
	local oldRoundId = GameUtil.getUserData(key)
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)
	local isNeedShow = false
	local tipsContent = ""

	if not self._isShowingTips and oldRoundId ~= curRoundId then
		local playerRoundId = ShowDownController.instance:getPlayerRoundId(self._activityId)
		local mainRaceInfo = ShowDownController.instance:getMainRaceInfoMo(self._activityId, curStepId)
		local isPromotion = mainRaceInfo:isPromotionGroup()

		if curRoundId == ShowDownEnum.Round_Eliminate_Group then
			tipsContent = isPromotion and "您已晋级小组赛，快去组队吧！" or "您止步于预选赛"
			isNeedShow = true
		elseif curRoundId == ShowDownEnum.Round_Eliminate_512To64 then
			if isPromotion then
				tipsContent = "组队阶段已结束，快去备战吧！"
				isNeedShow = true
			end
		elseif curRoundId == ShowDownEnum.Round_Eliminate_64To8 then
			if playerRoundId == ShowDownEnum.Round_Eliminate_512To64 then
				tipsContent = "很遗憾你止步于小组赛512进64"
				isNeedShow = true
			elseif playerRoundId > ShowDownEnum.Round_Eliminate_512To64 then
				tipsContent = "您已晋级小组赛64进8，快去备战吧！"
				isNeedShow = true
			end
		elseif curRoundId == ShowDownEnum.Round_Final_Result then
			tipsContent = ""
			isNeedShow = true

			ShowDownController.instance:sendPM_ShowDown_GetDisplayInfoReq(self._activityId)
		end

		if isNeedShow then
			self._isShowingTips = true

			GameUtil.saveUserData(key, curRoundId)
			GameUtil.SetActive(self._periodChangeTips, true)

			self._txtTipsInPeriodChangeTips.text = tipsContent

			settimer(3, self._endTipsInPeriodChangeTips, self, false)
		end
	end
end

function ShowDownMainView:_endTipsInPeriodChangeTips()
	self._isShowingTips = false

	GameUtil.SetActive(self._periodChangeTips, false)
end

function ShowDownMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownMainView:_onUpdateData()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)
	self._mainRaceInfo = ShowDownController.instance:getMainRaceInfoMo(self._activityId, self._curStepId)
	self._tabDataList = {}

	local playerRoundId = ShowDownController.instance:getPlayerRoundId(self._activityId)
	local playerRacePeriod = ShowDownEnum.RoundInRace[playerRoundId]
	local isFighter = ShowDownController.instance:isFighter(self._activityId, self._curRoundId)
	local roundId = self._curRoundId

	if roundId == ShowDownEnum.Round_Qualify then
		self._tabDataList[1] = self:_makeTabData("主赛场", ViewName.ShowDownQualifyView, {
			self._activityId
		})
		self._tabDataList[2] = self:_makeTabData("我的赛程", ViewName.ShowDownQualifySceneView, {
			self._activityId
		})
		self._tabDataList[3] = self:_makeTabData("赛程", ViewName.ShowDownScheduleView, {
			self._activityId
		})
		self._tabDataList[4] = self:_makeTabData("娱乐赛", ViewName.ShowDownFunView, {
			self._activityId
		})
	elseif roundId == ShowDownEnum.Round_Eliminate_Group then
		self._tabDataList[1] = self:_makeTabData("主赛场", ViewName.ShowDownEliminateView, {
			self._activityId
		})
		self._tabDataList[2] = self:_makeTabData("我的赛程", ViewName.ShowDownQualifySceneView, {
			self._activityId
		})
		self._tabDataList[3] = self:_makeTabData("赛程", ViewName.ShowDownScheduleView, {
			self._activityId
		})
		self._tabDataList[4] = self:_makeTabData("娱乐赛", ViewName.ShowDownFunView, {
			self._activityId
		})
	elseif roundId == ShowDownEnum.Round_Eliminate_512To64 or roundId == ShowDownEnum.Round_Eliminate_64To8 then
		self._tabDataList[1] = self:_makeTabData("主赛场", ViewName.ShowDownEliminateView, {
			self._activityId
		})
		self._tabDataList[2] = playerRacePeriod == ShowDownEnum.RacePeriod_Qualify and self:_makeTabData("我的赛程", ViewName.ShowDownQualifySceneView, {
			self._activityId
		}) or self:_makeTabData("我的赛程", ViewName.ShowDownEliminateSceneView, {
			self._activityId
		})
		self._tabDataList[3] = self:_makeTabData("赛程", ViewName.ShowDownScheduleView, {
			self._activityId
		})
		self._tabDataList[4] = self:_makeTabData("娱乐赛", ViewName.ShowDownFunView, {
			self._activityId
		})
	elseif roundId == ShowDownEnum.Round_Final_01 or roundId == ShowDownEnum.Round_Final_02 or roundId == ShowDownEnum.Round_Final_03 or roundId == ShowDownEnum.Round_Final_04 or roundId == ShowDownEnum.Round_Final_05 or roundId == ShowDownEnum.Round_Final_06 or roundId == ShowDownEnum.Round_Final_07 then
		self._tabDataList[1] = self:_makeTabData("主赛场", ViewName.ShowDownFinalView, {
			self._activityId
		})
		self._tabDataList[2] = playerRacePeriod == ShowDownEnum.RacePeriod_Qualify and self:_makeTabData("我的赛程", ViewName.ShowDownQualifySceneView, {
			self._activityId
		}) or playerRacePeriod == ShowDownEnum.RacePeriod_Eliminate and self:_makeTabData("我的赛程", ViewName.ShowDownEliminateSceneView, {
			self._activityId
		}) or self:_makeTabData("我的赛程", ViewName.ShowDownFinalSceneView, {
			self._activityId
		})
		self._tabDataList[3] = self:_makeTabData("赛程", ViewName.ShowDownScheduleView, {
			self._activityId
		})
		self._tabDataList[4] = self:_makeTabData("娱乐赛", ViewName.ShowDownFunView, {
			self._activityId
		})
	elseif roundId == ShowDownEnum.Round_Final_Result then
		self._tabDataList[1] = self:_makeTabData("主赛场", ViewName.ShowDownFinalResultView, {
			self._activityId
		})
		self._tabDataList[2] = playerRacePeriod == ShowDownEnum.RacePeriod_Qualify and self:_makeTabData("我的赛程", ViewName.ShowDownQualifySceneView, {
			self._activityId
		}) or playerRacePeriod == ShowDownEnum.RacePeriod_Eliminate and self:_makeTabData("我的赛程", ViewName.ShowDownEliminateSceneView, {
			self._activityId
		}) or self:_makeTabData("我的赛程", ViewName.ShowDownFinalSceneView, {
			self._activityId
		})
		self._tabDataList[3] = self:_makeTabData("赛程", ViewName.ShowDownScheduleView, {
			self._activityId
		})
		self._tabDataList[4] = self:_makeTabData("娱乐赛", ViewName.ShowDownFunView, {
			self._activityId
		})
	end

	if CurTabIdx <= 0 then
		CurTabIdx = roundId > ShowDownEnum.Round_Eliminate_Group and roundId < ShowDownEnum.Round_Final_Result and isFighter and 2 or 1
	end

	CurTabIdx = Mathf.Clamp(CurTabIdx, 0, #self._tabDataList)
end

function ShowDownMainView:_onUpdateUI()
	self:_updateTabColUI()
	self:_showTabAt()
end

function ShowDownMainView:_makeTabData(tabName, viewName, viewParams)
	local data = {}

	data.tabName = tabName
	data.viewName = viewName
	data.viewParams = viewParams

	return data
end

function ShowDownMainView:_updateTabColUI()
	self._tabScrollerList:reloadData(self._tabDataList)
end

function ShowDownMainView:_clearTabColUI()
	self._tabScrollerList:dispose()
end

function ShowDownMainView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local isSelected = CurTabIdx == tabIdx
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtNameSelect = goutil.findChildTextComponent(mainGo, "txtNameSelect")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")

	GameUtil.SetActive(imgSelect, isSelected)
	GameUtil.SetActive(txtNameSelect.gameObject, isSelected)
	GameUtil.SetActive(txtName.gameObject, not isSelected)

	if isSelected then
		txtNameSelect.text = data.tabName
	else
		txtName.text = data.tabName
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function ShowDownMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function ShowDownMainView:_onClickTab(data, idx)
	CurTabIdx = idx

	self:_onUpdateUI()
end

function ShowDownMainView:_showTabAt()
	local data = self._tabDataList[CurTabIdx]

	if data == nil then
		return
	end

	local viewName = data.viewName

	if self._oldViewName and self._oldViewName == viewName then
		return
	end

	self:_onClearTabAt()

	self._oldViewName = viewName

	if data.viewParams then
		self:showTabAt(self._contentCol, viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, viewName)
	end

	GameUtil.SetActive(self._imgBg, viewName ~= ViewName.ShowDownFinalResultView)
end

function ShowDownMainView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldViewName = nil
end

function ShowDownMainView:_onClickBtnTip()
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(value)
end

return ShowDownMainView

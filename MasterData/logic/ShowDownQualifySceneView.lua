-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifySceneView.lua

module("logic.extensions.showdown.view.ShowDownQualifySceneView", package.seeall)

local ShowDownQualifySceneView = class("ShowDownQualifySceneView", ViewComponent)

function ShowDownQualifySceneView:ctor()
	ShowDownQualifySceneView.super.ctor(self)
end

function ShowDownQualifySceneView:buildUI()
	ShowDownQualifySceneView.super.buildUI(self)

	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._headCell = goutil.findChild(self.mainGO, "headCell")
	self._txtPlayerName = goutil.findChildTextComponent(self.mainGO, "txtPlayerName")
	self._txtQualifyResult = goutil.findChildTextComponent(self.mainGO, "txtQualifyResult")
	self._txtQualifyScore = goutil.findChildTextComponent(self.mainGO, "txtQualifyScore")
	self._txtQualifyRank = goutil.findChildTextComponent(self.mainGO, "txtQualifyRank")
	self._recordCol = goutil.findChild(self.mainGO, "recordCol")
	self._recordCol_emptyGo = goutil.findChild(self.mainGO, "recordCol/emptyGo")
	self._btnJumpInRecord = goutil.findChild(self.mainGO, "recordCol/emptyGo/btnJump")

	local recordScrView = goutil.findChild(self.mainGO, "recordCol/scrView")
	local recordScrCell = goutil.findChild(self.mainGO, "recordCol/scrCell")

	self._recordScrollList = ScrollerList.create(recordScrView, recordScrCell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
end

function ShowDownQualifySceneView:bindEvents()
	ShowDownQualifySceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJumpInRecord, self._onClickBtnJump, self)
end

function ShowDownQualifySceneView:unbindEvents()
	ShowDownQualifySceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJumpInRecord)
end

function ShowDownQualifySceneView:onEnter()
	ShowDownQualifySceneView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = ShowDownConfig.instance:getActData(self._activityId)

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_GetQualifyBattleVideoRes, self._handlePM_ShowDownQualify_GetQualifyBattleVideoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetBattleRecordsError, self._handleGetBattleRecordsError, self)
	ShowDownController.instance:sendPM_ShowDown_GetScheduleInfoReq(self._activityId)

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(self._headCell, headInfo, true)

	self._txtPlayerName.text = RoleModel.instance:getUserName()
end

function ShowDownQualifySceneView:onExit()
	ShowDownQualifySceneView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headCell)
	self:_onClearRecordCol()
end

function ShowDownQualifySceneView:_handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	if msg.battleResult then
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.ShowDownMainView, nil, self._activityId)

		local myUserId = checknumber(RoleModel.instance:getUserId())

		ShowDownController.instance:playFightRecord(self._activityId, msg.battleResult, myUserId)
	end
end

function ShowDownQualifySceneView:_onUpdate()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)

	local isFighter = ShowDownController.instance:isFighter(self._activityId, self._curRoundId)
	local winCount = 0
	local loseCount = 0
	local myScore = 0
	local myRank = -1

	self._battleRecordList = {}

	if self._curRoundId <= ShowDownEnum.Round_Qualify then
		local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
		local scheduleInfo = showDownMo:getScheduleInfoInQualify()

		winCount = scheduleInfo:getWinCount()
		loseCount = scheduleInfo:getLoseCount()
		myScore = scheduleInfo:getMyScore()
		myRank = scheduleInfo:getMyRank()
		self._battleRecordList = scheduleInfo:getBattleRecordList()
	else
		local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)
		local scheduleInfo = showDownMo:getScheduleInfoInElimate()

		winCount = scheduleInfo:getWinCount()
		loseCount = scheduleInfo:getLoseCount()
		myScore = scheduleInfo:getMyScore()
		myRank = scheduleInfo:getMyRank()
		self._battleRecordList = scheduleInfo:getBattleRecordList()
	end

	self._txtQualifyResult.text = string.format("%s胜%s负", winCount, loseCount)
	self._txtQualifyScore.text = myScore
	self._txtQualifyRank.text = myRank <= 0 and "暂无" or myRank
	self._txtTips.text = self._curRoundId == ShowDownEnum.Round_Qualify and "预选赛已开启，快去主场赛看看吧~" or isFighter and "您已进入小组赛，快去主场赛看看吧~" or "很遗憾，您未进入小组赛"

	self:_onUpdateRecordColUI()
end

function ShowDownQualifySceneView:_onUpdateRecordColUI()
	self._recordScrollList:reloadData(self._battleRecordList)
	GameUtil.SetActive(self._recordCol_emptyGo, #self._battleRecordList <= 0)
end

function ShowDownQualifySceneView:_onClearRecordCol()
	self._recordScrollList:dispose()
end

function ShowDownQualifySceneView:_updateRecordCell(view, cell, recordMo, tag)
	local timeStamp = recordMo:getRecordTimeStamp()
	local result = recordMo:getResult()
	local isWin = recordMo:isWin(GameEnum.BattleTeam.Left)
	local qualType = recordMo:getQualType()
	local mainGo = cell.gameObject
	local imgResult = goutil.findChild(mainGo, "imgResult")
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local time_txt = goutil.findChildTextComponent(mainGo, "time/txt")
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local norVs = goutil.findChild(mainGo, "norVs")
	local funcVs = goutil.findChild(mainGo, "funcVs")
	local headGoList = {
		leftHead,
		rightHead
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = headGoList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")
		local txtName = goutil.findChildTextComponent(headGo, "txtName")
		local txtScore = goutil.findChildTextComponent(headGo, "txtScore")
		local tag = goutil.findChild(headGo, "tag")
		local teamRecord = recordMo:getTeamBattleRecord(teamId)
		local headInfo = teamRecord:getHeadInfo()
		local userName = teamRecord:getUserName()
		local score = teamRecord:getScore()
		local buffId = teamRecord:getBuffId()

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)
			GameUtil.SetActive(headRoot, true)
		else
			HeadItemController.instance:resetHeadCell(headRoot)
			GameUtil.SetActive(headRoot, false)
		end

		txtName.text = userName
		txtScore.text = score
	end

	if result == ShowDownEnum.BattleRecordResult_Draw then
		GameUtil.setUIImageSpriteIdx(imgResult, 1)
	else
		GameUtil.setUIImageSpriteIdx(imgResult, isWin and 2 or 0)
	end

	GameUtil.SetActive(norVs, qualType == ShowDownEnum.QualType_Normal)
	GameUtil.SetActive(funcVs, qualType == ShowDownEnum.QualType_Fun)

	if timeStamp > 0 then
		local date = GameUtil.time2date(timeStamp)

		time_txt.text = string.format("%02d月%02d日 %02d:%02d", date.month, date.day, date.hour, date.min)
	else
		time_txt.text = ""
	end

	GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickBtnDetail, self, recordMo))
end

function ShowDownQualifySceneView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local leftHead = goutil.findChild(mainGo, "leftHead")
	local rightHead = goutil.findChild(mainGo, "rightHead")
	local headGoList = {
		leftHead,
		rightHead
	}

	for idx, teamId in ipairs(GameEnum.BattleTeamList) do
		local headGo = headGoList[idx]
		local headRoot = goutil.findChild(headGo, "headRoot")

		HeadItemController.instance:resetHeadCell(headRoot)
	end
end

function ShowDownQualifySceneView:_onClickBtnDetail(recordMo)
	local battleId = recordMo:getBattleId()

	if checknumber(battleId) > 0 then
		ShowDownController.instance:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
	else
		printError("缺失battleId")
	end
end

function ShowDownQualifySceneView:_onClickBtnJump()
	GlobalDispatcher:dispatch(GlobalNotify.ShowDownMainViewJumpTab, 1)
end

function ShowDownQualifySceneView:_handleGetBattleRecordsError(status)
	if status == -526 then
		FloatWordMgr.instance:show("战斗记录已过期")
	end
end

return ShowDownQualifySceneView

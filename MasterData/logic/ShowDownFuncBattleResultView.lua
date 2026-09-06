-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFuncBattleResultView.lua

module("logic.extensions.showdown.view.ShowDownFuncBattleResultView", package.seeall)

local ShowDownFuncBattleResultView = class("ShowDownFuncBattleResultView", ViewComponent)

function ShowDownFuncBattleResultView:buildUI()
	ShowDownFuncBattleResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._empty = goutil.findChild(self.mainGO, "empty")

	local scrCell = goutil.findChild(self.mainGO, "scrCell")
	local scrView = goutil.findChild(self.mainGO, "scrView")

	self._recordScrollerList = ScrollerList.create(scrView, scrCell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
end

function ShowDownFuncBattleResultView:bindEvents()
	ShowDownFuncBattleResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ShowDownFuncBattleResultView:unbindEvents()
	ShowDownFuncBattleResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ShowDownFuncBattleResultView:onEnter()
	ShowDownFuncBattleResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetJoyModeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownQualify_GetQualifyBattleVideoRes, self._handlePM_ShowDownQualify_GetQualifyBattleVideoRes, self)
	ShowDownAgent.instance:sendPM_ShowDown_GetJoyModeInfoReq(self._activityId)
end

function ShowDownFuncBattleResultView:onExit()
	ShowDownFuncBattleResultView.super.onExit(self)
	self._recordScrollerList:dispose()
end

function ShowDownFuncBattleResultView:_handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	if msg.battleResult then
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.ShowDownMainView, nil, self._activityId)
		UIJumper.instance:pushOneStack(ViewName.ShowDownFuncBattleResultView, nil, self._activityId)

		local myUserId = checknumber(RoleModel.instance:getUserId())

		ShowDownController.instance:playFightRecord(self._activityId, msg.battleResult, myUserId)
	end
end

function ShowDownFuncBattleResultView:_onUpdate()
	local list = self._showDownMo:getBattleRecordsInFunc()
	local records = {}

	for _, v in ipairs(list) do
		if v:getQualType() == ShowDownEnum.QualType_Fun then
			table.insert(records, v)
		end
	end

	table.sort(records, function(a, b)
		return a:getRecordTimeStamp() > b:getRecordTimeStamp()
	end)
	self._recordScrollerList:reloadData(records)
	GameUtil.SetActive(self._empty, #records <= 0)
end

function ShowDownFuncBattleResultView:_updateRecordCell(view, cell, recordMo, tag)
	local timeStamp = recordMo:getRecordTimeStamp()
	local result = recordMo:getResult()
	local isWin = recordMo:isWin(GameEnum.BattleTeam.Left)
	local qualType = recordMo:getQualType()
	local mainGo = cell.gameObject
	local imgResult = goutil.findChild(mainGo, "imgResult")
	local btnDetail = goutil.findChild(mainGo, "btnDetail")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
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

		txtTime.text = string.format("%02d月%02d日 %02d:%02d", date.month, date.day, date.hour, date.min)
	else
		txtTime.text = ""
	end

	GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickBtnDetail, self, recordMo))
end

function ShowDownFuncBattleResultView:_clearRecordCell(cell)
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

function ShowDownFuncBattleResultView:_onClickBtnDetail(recordMo)
	local battleId = recordMo:getBattleId()

	if checknumber(battleId) > 0 then
		ShowDownController.instance:sendPM_ShowDownQualify_GetQualifyBattleVideoReq(battleId)
	else
		printError("缺失battleId")
	end
end

return ShowDownFuncBattleResultView

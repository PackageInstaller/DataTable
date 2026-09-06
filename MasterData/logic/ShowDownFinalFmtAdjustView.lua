-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalFmtAdjustView.lua

module("logic.extensions.showdown.view.ShowDownFinalFmtAdjustView", package.seeall)

local ShowDownFinalFmtAdjustView = class("ShowDownFinalFmtAdjustView", ViewComponent)

function ShowDownFinalFmtAdjustView:ctor()
	ShowDownFinalFmtAdjustView.super.ctor(self)
end

function ShowDownFinalFmtAdjustView:buildUI()
	ShowDownFinalFmtAdjustView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtTipsInAdjust = goutil.findChildTextComponent(self.mainGO, "detailCol/txtTipsInAdjust")
	self._txtTipsInViewer = goutil.findChildTextComponent(self.mainGO, "detailCol/txtTipsInViewer")
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "detailCol/txtProgress")

	local playerCellGo_1 = goutil.findChild(self.mainGO, "detailCol/playerView/playerCell_1")
	local playerCellGo_2 = goutil.findChild(self.mainGO, "detailCol/playerView/playerCell_2")

	self._playerCellList = {}

	for i, mainGo in ipairs({
		playerCellGo_1,
		playerCellGo_2
	}) do
		local cell = {}

		cell._mainGo = mainGo
		cell._teamIcon = goutil.findChild(mainGo, "teamIcon")
		cell._txtName = goutil.findChildTextComponent(mainGo, "txtName")
		cell._txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

		table.insert(self._playerCellList, cell)
	end

	local teamScrView = goutil.findChild(self.mainGO, "detailCol/teamScrView")
	local teamScrCell = goutil.findChild(self.mainGO, "detailCol/teamScrCell")

	self._teamScrollList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
end

function ShowDownFinalFmtAdjustView:bindEvents()
	ShowDownFinalFmtAdjustView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function ShowDownFinalFmtAdjustView:unbindEvents()
	ShowDownFinalFmtAdjustView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ShowDownFinalFmtAdjustView:onEnter()
	ShowDownFinalFmtAdjustView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curRoundId = checknumber(params[2])
	self._enemyTeamId = checknumber(params[3])
	self._state = params[4] or ShowDownEnum.FmtAdjustState_Viewer
	self._activityType = ShowDownController.instance:getActivityType()

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._battleOrderMo = ShowDownController.instance:getBattleOrderMo(self._activityId, self._curRoundId)
	self._scheduleInfo = ShowDownController.instance:getScheduleInfoInFinal(self._activityId)

	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._handleShowDownStepChange, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetScheduleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownKnockout_GetBattleOrderRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownKnockout_AdjustBattleOrderRes, self._handlePM_ShowDownKnockout_AdjustBattleOrderRes, self)
	GameUtil.SetActive(self._txtTipsInAdjust.gameObject, self._state == ShowDownEnum.FmtAdjustState_Adjust)
	GameUtil.SetActive(self._txtTipsInViewer.gameObject, self._state == ShowDownEnum.FmtAdjustState_Viewer)
	GameUtil.SetActive(self._btnSure, self._state == ShowDownEnum.FmtAdjustState_Adjust)
	ShowDownController.instance:sendPM_ShowDownKnockout_GetBattleOrderReq(self._activityId, self._curRoundId, self._enemyTeamId)
end

function ShowDownFinalFmtAdjustView:onExit()
	ShowDownFinalFmtAdjustView.super.onExit(self)
	self:_onClear()
end

function ShowDownFinalFmtAdjustView:_handleShowDownStepChange()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)
	local curRacePeriod = ShowDownController.instance:getRacePeriodByStep(self._activityId, curRoundId)
	local oldRacePeriod = ShowDownEnum.RoundInRace[self._curRoundId]

	if curRacePeriod == oldRacePeriod then
		self:_onUpdate()
	else
		self:close()
	end
end

function ShowDownFinalFmtAdjustView:_handlePM_ShowDownKnockout_AdjustBattleOrderRes()
	FloatWordMgr.instance:show("阵容调整完成")
	self:close()
end

function ShowDownFinalFmtAdjustView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function ShowDownFinalFmtAdjustView:_onUpdateData()
	self:_onUpdateTeamColData()
end

function ShowDownFinalFmtAdjustView:_onUpdateUI()
	self:_onUpdatePlayerCellInMy()
	self:_onUpdatePlayerCellInOp()
	self:_onUpdateTeamColUI()
end

function ShowDownFinalFmtAdjustView:_onClear()
	self:_onClearPlayerCell()
	self:_onClearTeamCol()
end

function ShowDownFinalFmtAdjustView:_getCurStepMatchViewMo()
	local list = self._scheduleInfo:getStepMatchViewMoList()

	return list[1]
end

function ShowDownFinalFmtAdjustView:_onUpdatePlayerCellInMy()
	local cell = self._playerCellList[1]
	local leaderHeadInfo = self._scheduleInfo:getMyTeamLeaderHeadInfo()
	local teamIconId = self._scheduleInfo:getMyTeamOfTeamLogo()

	ShowDownController.instance:setTeamHeadCellRoot(cell._teamIcon, leaderHeadInfo, self._activityId, teamIconId)

	cell._txtName.text = self._scheduleInfo:getMyTeamOfTeamName()

	local teamScore = self._scheduleInfo:getMyTeamOfScore()

	cell._txtScore.text = string.format("积分：<color=#20b376>%s</color>", teamScore)
end

function ShowDownFinalFmtAdjustView:_onUpdatePlayerCellInOp()
	local cell = self._playerCellList[2]
	local stepMatchViewMo = self:_getCurStepMatchViewMo()
	local leaderHeadInfo = stepMatchViewMo:getLeaderHeadInfo()
	local teamIconId = stepMatchViewMo:getTeamLogo()

	ShowDownController.instance:setTeamHeadCellRoot(cell._teamIcon, leaderHeadInfo, self._activityId, teamIconId)

	cell._txtName.text = stepMatchViewMo:getTeamName()

	local teamScore = stepMatchViewMo:getMyScore()

	cell._txtScore.text = string.format("积分：<color=#20b376>%s</color>", teamScore)
end

function ShowDownFinalFmtAdjustView:_onClearPlayerCell()
	for k, cell in pairs(self._playerCellList) do
		ShowDownController.instance:clearTeamHeadCellRoot(cell._teamIcon)
	end
end

function ShowDownFinalFmtAdjustView:_onUpdateTeamColData()
	self._battleTeams = {
		GameEnum.BattleTeam.Left,
		GameEnum.BattleTeam.Right
	}

	local leftTeamId = self._battleOrderMo:getTeamId(GameEnum.BattleTeam.Left)

	if leftTeamId and leftTeamId == self._enemyTeamId then
		self._battleTeams = {
			GameEnum.BattleTeam.Right,
			GameEnum.BattleTeam.Left
		}
	end

	local count = ShowDownController.instance:getTeamMemberCount(self._activityId)
	local userIdsList = {}

	for teamIndex = 1, count do
		userIdsList[teamIndex] = {}

		for _, battleTeam in ipairs(self._battleTeams) do
			local teamId = self._battleOrderMo:getTeamId(battleTeam)

			userIdsList[teamIndex][battleTeam] = self._battleOrderMo:getUserId(teamId, teamIndex)
		end
	end

	self._userIdsList = userIdsList
end

function ShowDownFinalFmtAdjustView:_onUpdateTeamColUI()
	self._teamScrollList:reloadData(self._userIdsList)
end

function ShowDownFinalFmtAdjustView:_onClearTeamCol()
	self._teamScrollList:dispose()
end

function ShowDownFinalFmtAdjustView:_updateTeamCell(view, cell, userIds, tag)
	local teamIndex = cell.data
	local mainGo = cell.gameObject
	local formGos = {}

	formGos[1] = goutil.findChild(mainGo, "leftForm")
	formGos[2] = goutil.findChild(mainGo, "rightForm")

	for idx, battleTeam in ipairs(self._battleTeams) do
		local teamId = self._battleOrderMo:getTeamId(battleTeam)
		local userId = userIds[battleTeam]

		if not string.nilorempty(userId) then
			local formMo = self._battleOrderMo:getForm(teamId, userId)

			self:_setFormUI(formGos[idx], teamIndex, idx, formMo)
		else
			self:_setFormUI(formGos[idx], teamIndex, idx, nil)
		end
	end
end

function ShowDownFinalFmtAdjustView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local formGos = {}

	formGos[GameEnum.BattleTeam.Left] = goutil.findChild(mainGo, "leftForm")
	formGos[GameEnum.BattleTeam.Right] = goutil.findChild(mainGo, "rightForm")

	for k, go in pairs(formGos) do
		local formations = goutil.findChild(go, "formations")
		local buffIcon = goutil.findChild(go, "buff/icon")

		for petCellIdx = 1, formations.transform.childCount do
			local petCell = formations.transform:GetChild(petCellIdx - 1)
			local pointPet = goutil.findChild(petCell, "pointPet")

			MaterialMgr.resetAll(pointPet)
		end

		uGuiUtil.clearImage(buffIcon)
	end
end

function ShowDownFinalFmtAdjustView:_setFormUI(mainGo, teamIndex, idx, formMo)
	local petIdList = formMo and formMo:getPetIdList() or {}
	local isEmptyFmt = formMo and formMo:isEmptyForm()
	local buffId = formMo and formMo:getBuffId()
	local txtTeam = goutil.findChildTextComponent(mainGo, "txtTeam")
	local txtTeamEx = goutil.findChildTextComponent(mainGo, "txtTeamEx")
	local formations = goutil.findChild(mainGo, "formations")
	local btnChange = goutil.findChild(mainGo, "btnChange")
	local empty = goutil.findChild(mainGo, "empty")
	local buffIcon = goutil.findChild(mainGo, "buff/icon")

	txtTeam.text = string.format("队伍%s", teamIndex)

	for petCellIdx = 1, formations.transform.childCount do
		local petCell = formations.transform:GetChild(petCellIdx - 1)
		local pointPet = goutil.findChild(petCell, "pointPet")
		local petId = checknumber(petIdList[petCellIdx])
		local petData = ShowDownConfig.instance:getSystemPetData(petId)

		if petData then
			local raceId = petData.raceId
			local skinId = checknumber(petData.faceId)

			if skinId <= 0 then
				skinId = raceId
			end

			local level = petData.lv
			local awakenLv = petData.awakenLv
			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, pointPet)

			if proxy then
				proxy.binder:setClickCallBack(function()
					local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, level, awakenLv, skinId)

					CommonTipsMgr.instance:showPetTips(tmpMo, true)
				end)
			end
		else
			MaterialMgr.resetAll(pointPet)
		end
	end

	GameUtil.SetActive(empty, isEmptyFmt)
	GameUtil.SetActive(btnChange, false)
	GameUtil.SetActive(txtTeam, false)
	GameUtil.SetActive(txtTeamEx, false)

	if self._state == ShowDownEnum.FmtAdjustState_Adjust then
		GameUtil.SetActive(btnChange, idx == 1)
		GameUtil.SetActive(txtTeam, idx == 1)
		GameUtil.SetActive(txtTeamEx, idx == 2)
	else
		GameUtil.SetActive(txtTeam, true)
	end

	local path = ShowDownController.instance:getBuffIconPath(self._activityId, self._curRoundId, buffId)

	if not string.nilorempty(path) then
		uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, path)
	else
		uGuiUtil.clearImage(buffIcon)
	end

	GameUtil.addClickHandler(btnChange, GameUtil.handler(self._onClickBtnChange, self, teamIndex, idx))
end

function ShowDownFinalFmtAdjustView:_onClickBtnChange(teamIndex, idx)
	if self._state == ShowDownEnum.FmtAdjustState_Viewer then
		return
	end

	local battleTeam = self._battleTeams[idx]
	local lastTeamIndex = Mathf.Max(teamIndex - 1, 1)

	self._userIdsList[lastTeamIndex][battleTeam] = self._userIdsList[teamIndex][battleTeam]
	self._userIdsList[teamIndex][battleTeam] = self._userIdsList[lastTeamIndex][battleTeam]

	self:_onUpdateTeamColUI()
end

function ShowDownFinalFmtAdjustView:_onClickBtnSure()
	local userIdList = {}
	local battleTeam = self._battleTeams[1]

	for teamIndex = 1, #self._userIdsList do
		local userId = self._userIdsList[teamIndex][battleTeam]

		table.insert(userIdList, userId or "0")
	end

	ShowDownController.instance:sendPM_ShowDownKnockout_AdjustBattleOrderReq(self._activityId, self._curRoundId, userIdList)
end

return ShowDownFinalFmtAdjustView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownfinalpkfmtView.lua

module("logic.extensions.showdown.view.ShowdownfinalpkfmtView", package.seeall)

local ShowdownfinalpkfmtView = class("ShowdownfinalpkfmtView", ViewComponent)

function ShowdownfinalpkfmtView:ctor()
	ShowdownfinalpkfmtView.super.ctor(self)
end

function ShowdownfinalpkfmtView:buildUI()
	ShowdownfinalpkfmtView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")

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
		cell._headRoot = goutil.findChild(mainGo, "headRoot")

		table.insert(self._playerCellList, cell)
	end

	local teamScrView = goutil.findChild(self.mainGO, "detailCol/teamScrView")
	local teamScrCell = goutil.findChild(self.mainGO, "detailCol/teamScrCell")

	self._teamScrollList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
end

function ShowdownfinalpkfmtView:bindEvents()
	ShowdownfinalpkfmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function ShowdownfinalpkfmtView:unbindEvents()
	ShowdownfinalpkfmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ShowdownfinalpkfmtView:onEnter()
	ShowdownfinalpkfmtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._leftTeamId = checknumber(params[2])
	self._rightTeamId = checknumber(params[3])
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)

	ShowDownController:sendPM_ShowDownKnockout_GetBattleOrderReq(self._activityId, self._curRoundId, self._leftTeamId)

	local isInTime = ShowDownController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDownKnockout_GetBattleOrderRes, self._updateUI, self)
end

function ShowdownfinalpkfmtView:onExit()
	ShowdownfinalpkfmtView.super.onExit(self)
	self:_onClear()
end

function ShowdownfinalpkfmtView:_updateUI()
	self._finalMoInfo = ShowDownController.instance:getMainRaceInfoMoInFinal(self._activityId, self._curRoundId)
	self._simpleView = self._finalMoInfo:getTeamSimpleViewMo(1, self._leftTeamId)
	self._simpleViewOther = self._finalMoInfo:getTeamSimpleViewMo(1, self._rightTeamId)
	self._battleOrderMo = ShowDownController.instance:getBattleOrderMo(self._activityId, self._curRoundId)

	self:_onUpdatePlayerCellInMy()
	self:_onUpdatePlayerCellInOp()
	self:_onUpdateTeamColUI()
end

function ShowdownfinalpkfmtView:_onClear()
	self:_onClearPlayerCell()
	self:_onClearTeamCol()
end

function ShowdownfinalpkfmtView:_onUpdatePlayerCellInMy()
	local cell = self._playerCellList[1]
	local leaderHeadInfo = self._simpleView:getLeaderHeadInfo()
	local teamIconId = self._simpleView:getTeamLogo()

	ShowDownController.instance:setTeamHeadCellRoot(cell._teamIcon, leaderHeadInfo, self._activityId, teamIconId)

	cell._txtName.text = self._simpleView:getTeamName()
	cell._txtScore.text = self._simpleView:getHeatValue()
end

function ShowdownfinalpkfmtView:_onUpdatePlayerCellInOp()
	local cell = self._playerCellList[2]
	local leaderHeadInfo = self._simpleViewOther:getLeaderHeadInfo()
	local teamIconId = self._simpleViewOther:getTeamLogo()

	ShowDownController.instance:setTeamHeadCellRoot(cell._teamIcon, leaderHeadInfo, self._activityId, teamIconId)

	cell._txtName.text = self._simpleViewOther:getTeamName()
	cell._txtScore.text = self._simpleViewOther:getHeatValue()
end

function ShowdownfinalpkfmtView:_onClearPlayerCell()
	for k, cell in pairs(self._playerCellList) do
		ShowDownController.instance:clearTeamHeadCellRoot(cell._teamIcon)
	end
end

function ShowdownfinalpkfmtView:_onUpdateTeamColUI()
	local count = ShowDownController.instance:getTeamMemberCount(self._activityId)
	local userIdsList = {}

	for teamIndex = 1, count do
		userIdsList[teamIndex] = {}

		for _, teamId in ipairs(GameEnum.BattleTeamList) do
			local trueTeamId = self._battleOrderMo:getTeamId(teamId)

			userIdsList[teamIndex][trueTeamId] = self._battleOrderMo:getUserId(trueTeamId, teamIndex)
		end
	end

	self._teamScrollList:reloadData(userIdsList)
end

function ShowdownfinalpkfmtView:_onClearTeamCol()
	self._teamScrollList:dispose()
end

function ShowdownfinalpkfmtView:_updateTeamCell(view, cell, userIds, tag)
	local teamIndex = cell.data
	local mainGo = cell.gameObject
	local formGos = {}

	formGos[GameEnum.BattleTeam.Left] = goutil.findChild(mainGo, "leftForm")
	formGos[GameEnum.BattleTeam.Right] = goutil.findChild(mainGo, "rightForm")

	for _, teamId in ipairs(GameEnum.BattleTeamList) do
		local userId = userIds[teamId]

		if not string.nilorempty(userId) then
			local formMo = self._battleOrderMo:getForm(teamId, userId)

			self:_setFormUI(formGos[teamId], teamIndex, teamId, formMo)
		else
			self:_setFormUI(formGos[teamId], teamIndex, teamId, nil)
		end
	end
end

function ShowdownfinalpkfmtView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local formGos = {}

	formGos[GameEnum.BattleTeam.Left] = goutil.findChild(mainGo, "leftForm")
	formGos[GameEnum.BattleTeam.Right] = goutil.findChild(mainGo, "rightForm")

	for k, go in pairs(formGos) do
		local formations = goutil.findChild(go, "formations")

		for petCellIdx = 1, formations.transform.childCount do
			local petCell = formations.transform:GetChild(petCellIdx - 1)
			local pointPet = goutil.findChild(petCell, "pointPet")

			MaterialMgr.resetAll(pointPet)
		end
	end
end

function ShowdownfinalpkfmtView:_setFormUI(mainGo, teamIndex, teamId, formMo)
	local petIdList = formMo and formMo:getPetIdList() or {}
	local txtTeam = goutil.findChildTextComponent(mainGo, "txtTeam")
	local formations = goutil.findChild(mainGo, "formations")

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
end

function ShowdownfinalpkfmtView:_onClickBtnSure()
	self:close()
end

return ShowdownfinalpkfmtView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifyMatchSuccessView.lua

module("logic.extensions.numberbomb.view.ShowDownQualifyMatchSuccessView", package.seeall)

local ShowDownQualifyMatchSuccessView = class("ShowDownQualifyMatchSuccessView", ViewComponent)

function ShowDownQualifyMatchSuccessView:ctor()
	ShowDownQualifyMatchSuccessView.super.ctor(self)
end

function ShowDownQualifyMatchSuccessView:buildUI()
	ShowDownQualifyMatchSuccessView.super.buildUI(self)

	self._imgTitle = goutil.findChild(self.mainGO, "imgTitle")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._leftFormView = goutil.findChild(self.mainGO, "leftForm/view")
	self._rightFormView = goutil.findChild(self.mainGO, "rightForm/view")
	self._formViewList = {
		self._leftFormView,
		self._rightFormView
	}
	self._leftInfo = goutil.findChild(self.mainGO, "leftInfo")
	self._rightInfo = goutil.findChild(self.mainGO, "rightInfo")
	self._infoViewList = {
		self._leftInfo,
		self._rightInfo
	}
end

function ShowDownQualifyMatchSuccessView:bindEvents()
	ShowDownQualifyMatchSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancleBtn, self)
end

function ShowDownQualifyMatchSuccessView:unbindEvents()
	ShowDownQualifyMatchSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function ShowDownQualifyMatchSuccessView:onEnter()
	ShowDownQualifyMatchSuccessView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._battleResult = params[2]
	self._activityType = ShowDownController.instance:getActivityType()
	self._headInfos = {}
	self._posList = {}

	local teams = self._battleResult.originalStates.teams

	self._myTeamId = 0

	for _, v in ipairs(teams) do
		local teamId = v.teamId
		local userId = v.playerView.id

		if checknumber(userId) == checknumber(RoleModel.instance:getUserId()) then
			self._myTeamId = teamId

			break
		end
	end

	for _, v in ipairs(teams) do
		local teamId = v.teamId
		local playerView = v.playerView

		self._headInfos[teamId] = {
			headIconId = playerView.headIcon,
			headFrameId = playerView.headFrame,
			vipLv = playerView.headIcon,
			userName = playerView.name,
			userId = playerView.id,
			playerLv = playerView.playerLv
		}
		self._posList[teamId] = {}

		for k, v in ipairs(playerView.characterViews) do
			local posId = v.y * 3 + v.x + 1
			local raceId = v.curFaceId

			if raceId <= 0 then
				raceId = v.raceId
			end

			self._posList[teamId][posId] = raceId
		end
	end

	self:_onUpdateFmt()

	self._curTimeSec = 5

	self:_onTicking()
	settimer(1, self._onTicking, self, true)
end

function ShowDownQualifyMatchSuccessView:onExit()
	ShowDownQualifyMatchSuccessView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearFmt()
end

function ShowDownQualifyMatchSuccessView:_onTicking()
	self._curTimeSec = self._curTimeSec - 1
	self._txtTips.text = string.format("%s秒后进入战斗", self._curTimeSec)

	if self._curTimeSec <= 0 then
		removetimer(self._onTicking, self)
		self:_startFight()
	end
end

function ShowDownQualifyMatchSuccessView:_startFight()
	self:close()

	if self._battleResult then
		UIJumper.instance:clear()
		UIJumper.instance:pushOneStack(ViewName.ShowDownMainView, nil, self._activityId)

		local myUserId = checknumber(RoleModel.instance:getUserId())

		ShowDownController.instance:playFightRecord(self._activityId, self._battleResult, myUserId)
	else
		printError("战斗记录为空")
	end
end

function ShowDownQualifyMatchSuccessView:_onUpdateFmt()
	for teamIdx, teamId in ipairs(self._myTeamId == 0 and {
		GameEnum.BattleTeam.Left,
		GameEnum.BattleTeam.Right
	} or {
		GameEnum.BattleTeam.Right,
		GameEnum.BattleTeam.Left
	}) do
		local formView = self._formViewList[teamIdx]

		for posId = 1, formView.transform.childCount do
			local mainGo = formView.transform:GetChild(posId - 1).gameObject
			local Icon = goutil.findChild(mainGo, "Icon")
			local raceId = checknumber(self._posList[teamId][posId])
			local modelCo = CharacterConfig.instance:getModelCo(raceId)

			if modelCo then
				uGuiUtil.setSpriteToImage(Icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			else
				uGuiUtil.clearImage(Icon)
			end
		end

		local headInfo = self._headInfos[teamId]
		local infoView = self._infoViewList[teamIdx]
		local headRoot = goutil.findChild(infoView, "headRoot")
		local txtName = goutil.findChildTextComponent(infoView, "txtName")

		HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, false)

		txtName.text = headInfo.userName
	end
end

function ShowDownQualifyMatchSuccessView:_onClearFmt()
	for k, formView in pairs(self._formViewList) do
		for posId = 1, formView.transform.childCount do
			local mainGo = formView.transform:GetChild(posId - 1).gameObject
			local Icon = goutil.findChild(mainGo, "Icon")

			uGuiUtil.clearImage(Icon)
		end
	end

	for k, infoView in pairs(self._infoViewList) do
		local headRoot = goutil.findChild(infoView, "headRoot")

		HeadItemController.instance:resetHeadCell(headRoot)
	end
end

return ShowDownQualifyMatchSuccessView

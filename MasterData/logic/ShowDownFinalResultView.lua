-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalResultView.lua

module("logic.extensions.showdown.view.ShowDownFinalResultView", package.seeall)

local ShowDownFinalResultView = class("ShowDownFinalResultView", ViewComponent)

function ShowDownFinalResultView:ctor()
	ShowDownFinalResultView.super.ctor(self)
end

function ShowDownFinalResultView:buildUI()
	ShowDownFinalResultView.super.buildUI(self)

	self._moveFalg = 0
	self._teamConList = {}

	for i = 1, 3 do
		local con = {}

		con.go = self:getGo("team_" .. i)
		con.txtName = goutil.findChildTextComponent(con.go, "name/txt")
		con.txtPlayerName = goutil.findChildTextComponent(con.go, "playername/txt")
		con.teammateList = {}
		con.teamPosList = {}
		con.teammateListCon = goutil.findChild(con.go, "teammateList")

		for k = 1, 5 do
			local teammateCon = {}

			teammateCon.go = goutil.findChild(con.teammateListCon, "teammate_" .. k)
			teammateCon.head = goutil.findChild(teammateCon.go, "head")
			teammateCon.info = nil
			con.teammateList[k] = teammateCon
			con.teamPosList[k] = goutil.findChild(con.go, "posList/pos_" .. k)
		end

		self._teamConList[i] = con
		con.avatar = nil
	end

	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/redPoint")
	self._btnShop = self:getGo("btnShop")
	self._btnVoteRecord = self:getGo("btnVoteRecord")
	self._btnShowPrize = self:getGo("btnShowPrize")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
end

function ShowDownFinalResultView:bindEvents()
	ShowDownFinalResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickBtnVoteRecord, self)
	GameUtil.addClickHandler(self._btnShowPrize, self._onClickBtnShowPrize, self)
end

function ShowDownFinalResultView:unbindEvents()
	ShowDownFinalResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnShowPrize)
end

function ShowDownFinalResultView:onEnter()
	ShowDownFinalResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._isNeedVoteInAct = ShowDownController.instance:isNeedGuessInAct(self._activityId)

	self:_setAvatarCameraEnv(true)
	ShowDownController.instance:sendPM_ShowDown_GetDisplayInfoReq(self._activityId)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetDisplayInfoRes, self._updateUI, self)
	settimer(10, self._switchNext, self)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end

	GameUtil.SetActive(self._btnVoteRecord, self._isNeedVoteInAct)
end

function ShowDownFinalResultView:onExit()
	ShowDownFinalResultView.super.onExit(self)
	self:_setAvatarCameraEnv(false)

	for _, con in ipairs(self._teamConList) do
		AvatarsMgrNew.instance:removeAvatar(con.avatar)

		con.avatar = nil

		for k, teammateCon in ipairs(con.teammateList) do
			HeadItemController.instance:resetHeadCell(teammateCon.head)
			goutil.addChildToParent(teammateCon.go, con.teammateListCon)

			teammateCon.info = nil
		end
	end

	removetimer(self._switchNext, self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function ShowDownFinalResultView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	LightMgr.instance:setUseModelLight(isOnEnter)
	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

function ShowDownFinalResultView:_updateUI()
	local mo = ShowDownController.instance:getShowDownMo(self._activityId)
	local infoList = mo and mo:getFinalResultInfos() or {}

	for i, con in ipairs(self._teamConList) do
		local info = infoList[i]

		if info then
			con.txtName.text = info.teamBaseView.teamInfo.teamName

			local valueNum = 0

			for _, playerInfo in ipairs(info.playerViewList) do
				if playerInfo then
					valueNum = valueNum + 1

					local showInfo = {}
					local skId = DressModel.instance:getSkeIdByGender(playerInfo.gender)

					showInfo.avatarMo = DressModel.instance:getAvatarPlayerMo(skId, (not playerInfo.clothes or nil) and {}, 0)
					showInfo.userName = playerInfo.headInfo.userName

					local teammateCon = con.teammateList[valueNum]

					if teammateCon then
						teammateCon.info = showInfo

						HeadItemController.instance:setHeadCellByInfo(teammateCon.head, playerInfo.headInfo, true)
					end
				end
			end
		end
	end

	self:_updateHeadAndRole()
end

function ShowDownFinalResultView:_updateHeadAndRole()
	for teamIdx, con in ipairs(self._teamConList) do
		local countLimit = #con.teammateList

		for p = 1, countLimit do
			local setId = (p + self._moveFalg) % countLimit

			if setId == 0 then
				setId = countLimit
			end

			local teammateCon = con.teammateList[p]

			goutil.addChildToParent(teammateCon.go, con.teamPosList[setId])
			GameUtil.setAnchoredPos(teammateCon.go, 0, 0)
			GameUtil.setLocalScale(teammateCon.go, 1, 1, 1)

			local showInfo = teammateCon.info

			if setId == 3 and showInfo then
				if con.avatar then
					-- block empty
				else
					con.avatar = AvatarsMgrNew.instance:getAvatarByMo(showInfo.avatarMo)
					con.avatar.useType = AvatarUseType.Scene

					local avatarRoot = goutil.findChild(self._modelCam, "posList/pos_" .. teamIdx)

					con.avatar:setParent(avatarRoot.transform)
					con.avatar:setLayer(SceneLayer.UI3D_Value)
				end

				con.avatar:updateByMo(showInfo.avatarMo)

				con.txtPlayerName.text = showInfo.userName
			end
		end
	end
end

function ShowDownFinalResultView:_switchNext()
	self._moveFalg = self._moveFalg + 1

	self:_updateHeadAndRole()
end

function ShowDownFinalResultView:_onClickBtnTask()
	ShowDownController.instance:opTaskView(self._activityId)
end

function ShowDownFinalResultView:_onClickBtnShop()
	local value = ShowDownConfig.instance:getCommonValue(self._activityId, "jumpStrShop")

	GotoMgr.gotoByString(value)
end

function ShowDownFinalResultView:_onClickBtnVoteRecord()
	UIStateManager.instance:push(ViewName.ShowDownEliminateVoteRecordView, self._activityId)
end

function ShowDownFinalResultView:_onClickBtnShowPrize()
	UIStateManager.instance:push(ViewName.ShowDownRewardView, self._activityId)
end

return ShowDownFinalResultView

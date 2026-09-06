-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressTeamOtherView.lua

module("logic.extensions.groupregress.view.GroupRegressTeamOtherView", package.seeall)

local GroupRegressTeamOtherView = class("GroupRegressTeamOtherView", ViewComponent)

function GroupRegressTeamOtherView:buildUI()
	GroupRegressTeamOtherView.super.buildUI(self)

	self._txtTeamScore = self:getTxt("progressCol/progress/txt")
	self._progressSlider = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._progressScrView = self:getGo("progressCol/scrView")

	local progressScrCell = self:getGo("progressCol/scrCell")

	self._progressScrollerList = ScrollerList.create(self._progressScrView, progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))

	local teamScrView = self:getGo("teamCol/scrView")
	local teamScrCell = self:getGo("teamCol/scrCell")

	self._teamScrollerList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._txtNewCount = self:getTxt("txtNewCount")
	self._txtRegressCount = self:getTxt("txtRegressCount")
	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/red")
end

function GroupRegressTeamOtherView:bindEvents()
	GroupRegressTeamOtherView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function GroupRegressTeamOtherView:unbindEvents()
	GroupRegressTeamOtherView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTask)
end

function GroupRegressTeamOtherView:onEnter()
	GroupRegressTeamOtherView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._teamType = GroupRegressEnum.TeamType.BindOwner
	self._subMo = GroupRegressController.instance:getSubMo(self._activityId)
	self._actData = GroupRegressConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGetTeamInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressNotifyNewMemberRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IF_FORMULATASKRES, self._onHandleGainTaskPrizeRes, self)
	GroupRegressController.instance:sendPM_GroupRegressGetTeamInfoReq(self._activityId, self._teamType)
end

function GroupRegressTeamOtherView:onExit()
	GroupRegressTeamOtherView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	self._progressScrollerList:dispose()
	self._teamScrollerList:dispose()
end

function GroupRegressTeamOtherView:_onSetUI()
	local redPointId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	GameUtil.SetActive(self._redBtnTask, false)

	if checknumber(redPointId) > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, redPointId)
	end
end

function GroupRegressTeamOtherView:_onUpdate()
	self._txtTeamScore.text = self._subMo:getTeamScore(self._teamType)

	self:_updateProgressPrizeCol()
	self:_updateOncePrizeCol()
	self:_updateTeamCol()
end

function GroupRegressTeamOtherView:_onHandleGainTaskPrizeRes(msg)
	if not msg or checknumber(msg.activityId) ~= self._activityId then
		return
	end

	GroupRegressController.instance:sendPM_GroupRegressGetTeamInfoReq(self._activityId, self._teamType)
end

function GroupRegressTeamOtherView:_updateProgressPrizeCol()
	local dataList = GroupRegressConfig.instance:getGroupPrizeDatas(self._activityId)
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, checknumber(data.needProgress))
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(self._progressSlider, self._subMo:getTeamScore(self._teamType), scoreList)
end

function GroupRegressTeamOtherView:_updateProgressCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")
	local scrollRect = self._progressScrView:GetComponent(ComponentType.ScrollRect)
	local isGain = self._subMo:isGainProgressPrize(self._teamType, data.prizeId)
	local isCanGet = self._subMo:isCanGetProgressPrize(self._teamType, data.prizeId, data.needProgress)

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.needProgress

	GameUtil.SetActive(received, isGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(_, eff)
			self:_keepTabEffectVisible(eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickProgressPrize, self, data))
end

function GroupRegressTeamOtherView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function GroupRegressTeamOtherView:_getCanGetProgressPrizeIds()
	local dataList = GroupRegressConfig.instance:getGroupPrizeDatas(self._activityId)
	local prizeIds = {}

	for _, progressData in ipairs(dataList) do
		local prizeId = checknumber(progressData.prizeId)

		if self._subMo:isCanGetProgressPrize(self._teamType, prizeId, progressData.needProgress) then
			table.insert(prizeIds, prizeId)
		end
	end

	return prizeIds
end

function GroupRegressTeamOtherView:_onClickProgressPrize(data)
	local prizeId = checknumber(data.prizeId)

	if self._subMo:isGainProgressPrize(self._teamType, prizeId) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self._subMo:isEnoughProgressPrize(self._teamType, data.needProgress) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeIds = self:_getCanGetProgressPrizeIds()

	if #prizeIds <= 0 then
		FloatWordMgr.instance:show("未满足")

		return
	end

	GroupRegressController.instance:sendPM_GroupRegressGainProgressPrizeReq(self._activityId, prizeIds, self._teamType)
end

function GroupRegressTeamOtherView:_updateOncePrizeCol()
	local newPlayerCount = self._subMo:getTeamPlayerTypeCount(self._teamType, GroupRegressEnum.PlayerType.New)
	local regressPlayerCount = self._subMo:getTeamPlayerTypeCount(self._teamType, GroupRegressEnum.PlayerType.Regress)
	local maxNewPlayerCount = checknumber(self._actData.maxInviteNewPlayerCnt)
	local maxRegressPlayerCount = checknumber(self._actData.maxInviteRegressPlayerCnt)

	self._txtNewCount.text = string.format("新朋友：%s/%s", newPlayerCount, maxNewPlayerCount)
	self._txtRegressCount.text = string.format("回归朋友：%s/%s", regressPlayerCount, maxRegressPlayerCount)
end

function GroupRegressTeamOtherView:_updateTeamCol()
	local dataList = {}

	self._teamMemberList = self._subMo:getTeamMemberListCaptainFirst(self._teamType)

	for index = 1, checknumber(self._actData.maxInvitePlayerCnt) do
		table.insert(dataList, index)
	end

	self._teamScrollerList:reloadData(dataList)
end

function GroupRegressTeamOtherView:_updateTeamCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local content = goutil.findChild(mainGo, "content")
	local empty = goutil.findChild(mainGo, "empty")
	local seatIndex = data
	local memberInfo = self._teamMemberList[seatIndex]
	local hasMember = memberInfo ~= nil

	self:_clearTeamCell(cell)
	GameUtil.SetActive(content, hasMember)
	GameUtil.SetActive(empty, not hasMember)

	if hasMember then
		self:_updateTeamMemberCell(mainGo, memberInfo)
	end
end

function GroupRegressTeamOtherView:_updateTeamMemberCell(mainGo, memberInfo)
	local head = goutil.findChild(mainGo, "content/head")
	local txtName = goutil.findChildTextComponent(mainGo, "content/txtName")
	local iconScore = goutil.findChild(mainGo, "content/score/icon")
	local txtScore = goutil.findChildTextComponent(mainGo, "content/score/txt")
	local tagNew = goutil.findChild(mainGo, "content/tagNew")
	local tagRegress = goutil.findChild(mainGo, "content/tagRegress")
	local tagActive = goutil.findChild(mainGo, "content/tagActive")
	local tagCaptain = goutil.findChild(mainGo, "content/tagCaptain")

	HeadItemController.instance:setHeadCellByInfo(head, memberInfo.headInfo, true)
	MaterialMgr.setIcon(iconScore, MatType.ACTIVITY_ITEM, self._actData.progressActivityItemId)

	txtName.text = memberInfo.headInfo.userName
	txtScore.text = checknumber(memberInfo.activityItemCount)

	GameUtil.SetActive(tagNew, memberInfo.playerType == GroupRegressEnum.PlayerType.New)
	GameUtil.SetActive(tagRegress, memberInfo.playerType == GroupRegressEnum.PlayerType.Regress)
	GameUtil.SetActive(tagActive, memberInfo.playerType == GroupRegressEnum.PlayerType.Active)
	GameUtil.SetActive(tagCaptain, self._subMo:isTeamCaptain(self._teamType, memberInfo))
end

function GroupRegressTeamOtherView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "content/head")
	local iconScore = goutil.findChild(mainGo, "content/score/icon")
	local tagCaptain = goutil.findChild(mainGo, "content/tagCaptain")

	HeadItemController.instance:resetHeadCell(head)
	MaterialMgr.clearIcon(iconScore)
	GameUtil.SetActive(tagCaptain, false)
end

function GroupRegressTeamOtherView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function GroupRegressTeamOtherView:_keepTabEffectVisible(eff)
	if not eff then
		return
	end

	eff.hideEffWhileNotOnTop = false

	eff:setVisible(true, true)
end

return GroupRegressTeamOtherView

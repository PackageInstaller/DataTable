-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/GroupRegressTeamView.lua

module("logic.extensions.groupregress.view.GroupRegressTeamView", package.seeall)

local GroupRegressTeamView = class("GroupRegressTeamView", ViewComponent)

function GroupRegressTeamView:buildUI()
	GroupRegressTeamView.super.buildUI(self)

	self._txtTeamScore = self:getTxt("progressCol/progress/txt")
	self._progressSlider = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._progressScrView = self:getGo("progressCol/scrView")

	local progressScrCell = self:getGo("progressCol/scrCell")

	self._progressScrollerList = ScrollerList.create(self._progressScrView, progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))

	local teamScrView = self:getGo("teamCol/scrView")
	local teamScrCell = self:getGo("teamCol/scrCell")

	self._teamScrollerList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._newPlayerPrizeItem = self:getGo("newPlayerPrize/item")
	self._btnGetNewPlayerPrize = self:getGo("newPlayerPrize/btnGet")
	self._tagHasGainNewPlayerPrize = self:getGo("newPlayerPrize/tagHasGain")
	self._effRootNewPlayerPrize = self:getGo("newPlayerPrize/effRoot")
	self._regressPlayerPrizeItem = self:getGo("regressPlayerPrize/item")
	self._btnGetRegressPlayerPrize = self:getGo("regressPlayerPrize/btnGet")
	self._tagHasGainRegressPlayerPrize = self:getGo("regressPlayerPrize/tagHasGain")
	self._effRootRegressPlayerPrize = self:getGo("regressPlayerPrize/effRoot")
	self._txtRegressCount = self:getTxt("txtRegressCount")
	self._txtNewCount = self:getTxt("txtNewCount")
	self._btnTask = self:getGo("btnTask")
	self._redBtnTask = self:getGo("btnTask/red")
end

function GroupRegressTeamView:bindEvents()
	GroupRegressTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGetNewPlayerPrize, GameUtil.handler(self._onClickOncePrize, self, GroupRegressEnum.PlayerType.New))
	GameUtil.addClickHandler(self._btnGetRegressPlayerPrize, GameUtil.handler(self._onClickOncePrize, self, GroupRegressEnum.PlayerType.Regress))
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
end

function GroupRegressTeamView:unbindEvents()
	GroupRegressTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGetNewPlayerPrize)
	GameUtil.rmClickHandler(self._btnGetRegressPlayerPrize)
	GameUtil.rmClickHandler(self._btnTask)
end

function GroupRegressTeamView:onEnter()
	GroupRegressTeamView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._teamType = GroupRegressEnum.TeamType.InviteOwner
	self._subMo = GroupRegressController.instance:getSubMo(self._activityId)
	self._actData = GroupRegressConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGetTeamInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGainProgressPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressGainOncePrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_GroupRegressNotifyNewMemberRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IF_FORMULATASKRES, self._onHandleGainTaskPrizeRes, self)
	GroupRegressController.instance:sendPM_GroupRegressGetTeamInfoReq(self._activityId, self._teamType)
end

function GroupRegressTeamView:onExit()
	GroupRegressTeamView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
	MaterialMgr.resetAll(self._newPlayerPrizeItem)
	MaterialMgr.resetAll(self._regressPlayerPrizeItem)
	self:stopViewEffectUniGo(self._effRootNewPlayerPrize)
	self:stopViewEffectUniGo(self._effRootRegressPlayerPrize)
	self._progressScrollerList:dispose()
	self._teamScrollerList:dispose()
end

function GroupRegressTeamView:_onSetUI()
	MaterialMgr.setCellByCfg(self._actData.inviteNewPlayerPrize, self._newPlayerPrizeItem)
	MaterialMgr.setCellByCfg(self._actData.inviteRegressPlayerPrize, self._regressPlayerPrizeItem)

	local redPointId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	GameUtil.SetActive(self._redBtnTask, false)

	if checknumber(redPointId) > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, redPointId)
	end
end

function GroupRegressTeamView:_onUpdate()
	self._txtTeamScore.text = self._subMo:getTeamScore(self._teamType)

	self:_updateProgressPrizeCol()
	self:_updateOncePrizeCol()
	self:_updateTeamCol()
end

function GroupRegressTeamView:_onHandleGainTaskPrizeRes(msg)
	if not msg or checknumber(msg.activityId) ~= self._activityId then
		return
	end

	GroupRegressController.instance:sendPM_GroupRegressGetTeamInfoReq(self._activityId, self._teamType)
end

function GroupRegressTeamView:_updateProgressPrizeCol()
	local dataList = GroupRegressConfig.instance:getGroupPrizeDatas(self._activityId)
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, checknumber(data.needProgress))
	end

	self._progressScrollerList:reloadData(dataList)
	self._progressScrollerList:updateUnderSlider(self._progressSlider, self._subMo:getTeamScore(self._teamType), scoreList)
end

function GroupRegressTeamView:_updateProgressCell(view, cell, data, tag)
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

function GroupRegressTeamView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function GroupRegressTeamView:_getCanGetProgressPrizeIds()
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

function GroupRegressTeamView:_onClickProgressPrize(data)
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

function GroupRegressTeamView:_updateOncePrizeCol()
	local newPlayerCount = self._subMo:getInvitePlayerTypeCount(self._teamType, GroupRegressEnum.PlayerType.New)
	local regressPlayerCount = self._subMo:getInvitePlayerTypeCount(self._teamType, GroupRegressEnum.PlayerType.Regress)
	local maxNewPlayerCount = checknumber(self._actData.maxInviteNewPlayerCnt)
	local maxRegressPlayerCount = checknumber(self._actData.maxInviteRegressPlayerCnt)

	self._txtNewCount.text = string.format("邀请新朋友：%s/%s", newPlayerCount, maxNewPlayerCount)
	self._txtRegressCount.text = string.format("邀请回归朋友：%s/%s", regressPlayerCount, maxRegressPlayerCount)

	self:_updateOncePrize(GroupRegressEnum.PlayerType.New, self._btnGetNewPlayerPrize, self._tagHasGainNewPlayerPrize, self._effRootNewPlayerPrize)
	self:_updateOncePrize(GroupRegressEnum.PlayerType.Regress, self._btnGetRegressPlayerPrize, self._tagHasGainRegressPlayerPrize, self._effRootRegressPlayerPrize)
end

function GroupRegressTeamView:_updateOncePrize(playerType, btnGet, tagHasGain, effRoot)
	local isGain = self._subMo:isGainInviteOncePrize(self._teamType, playerType)
	local isCanGet = self._subMo:isCanGetInviteOncePrize(self._teamType, playerType)

	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.SetActive(tagHasGain, isGain)

	if isCanGet then
		local function loadedHandler(_, eff)
			self:_keepTabEffectVisible(eff)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effRoot)
	end
end

function GroupRegressTeamView:_onClickOncePrize(playerType)
	if self._subMo:isGainInviteOncePrize(self._teamType, playerType) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self._subMo:isCanGetInviteOncePrize(self._teamType, playerType) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	GroupRegressController.instance:sendPM_GroupRegressGainOncePrizeReq(self._activityId, playerType == GroupRegressEnum.PlayerType.New, self._teamType)
end

function GroupRegressTeamView:_updateTeamCol()
	local dataList = {}

	self._teamMemberList = self._subMo:getTeamMemberListCaptainFirst(self._teamType)

	for index = 1, checknumber(self._actData.maxInvitePlayerCnt) do
		table.insert(dataList, index)
	end

	self._teamScrollerList:reloadData(dataList)
end

function GroupRegressTeamView:_updateTeamCell(view, cell, data, tag)
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
	else
		self:_updateTeamEmptyCell(mainGo)
	end
end

function GroupRegressTeamView:_updateTeamMemberCell(mainGo, memberInfo)
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

function GroupRegressTeamView:_updateTeamEmptyCell(mainGo)
	local btnAdd = goutil.findChild(mainGo, "empty/btnAdd")

	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onClickInvite, self))
end

function GroupRegressTeamView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "content/head")
	local iconScore = goutil.findChild(mainGo, "content/score/icon")
	local tagCaptain = goutil.findChild(mainGo, "content/tagCaptain")
	local btnAdd = goutil.findChild(mainGo, "empty/btnAdd")

	HeadItemController.instance:resetHeadCell(head)
	MaterialMgr.clearIcon(iconScore)
	GameUtil.SetActive(tagCaptain, false)
	GameUtil.rmClickHandler(btnAdd)
end

function GroupRegressTeamView:_onClickInvite()
	UIStateManager.instance:push(ViewName.GroupRegressInvitePopView, self._activityId)
end

function GroupRegressTeamView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function GroupRegressTeamView:_keepTabEffectVisible(eff)
	if not eff then
		return
	end

	eff.hideEffWhileNotOnTop = false

	eff:setVisible(true, true)
end

return GroupRegressTeamView

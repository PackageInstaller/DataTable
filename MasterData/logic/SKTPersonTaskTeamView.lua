-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/SKTPersonTaskTeamView.lua

module("logic.extensions.saintknighttask.view.SKTPersonTaskTeamView", package.seeall)

local SKTPersonTaskTeamView = class("SKTPersonTaskTeamView", ViewComponent)
local ChannelInviteCd = 10

function SKTPersonTaskTeamView:buildUI()
	SKTPersonTaskTeamView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnFriends = self:getGo("btnFriends")
	self._progressSlider = self:getSlider("progressCol/scrView/Viewport/Content/progressBar")
	self._txtTeamScore = self:getTxt("progressCol/total/txtScore")
	self._teamScoreIcon = self:getGo("progressCol/total/icon")
	self._progressScrView = self:getGo("progressCol/scrView")

	local progressScrCell = self:getGo("progressCol/scrCell")

	self._progressScrollerList = ScrollerList.create(self._progressScrView, progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))

	local teamScrView = self:getGo("teamCol/scrView")
	local teamScrCell = self:getGo("teamCol/scrCell")

	self._teamScrollerList = ScrollerList.create(teamScrView, teamScrCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
end

function SKTPersonTaskTeamView:bindEvents()
	SKTPersonTaskTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFriends, self._onClickBtnFriends, self)
end

function SKTPersonTaskTeamView:unbindEvents()
	SKTPersonTaskTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFriends)
end

function SKTPersonTaskTeamView:onEnter()
	SKTPersonTaskTeamView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动参数错误")
		self:close()

		return
	end

	self._teamConfig = SaintKnightTaskConfig.instance:getSktTeamConfigData(self._activityId)

	if self._teamConfig == nil then
		FloatWordMgr.instance:show("活动配置不存在")
		self:close()

		return
	end

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.SKTaskGetPersonTaskRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SKTaskGainTeamPrizeRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function SKTPersonTaskTeamView:onExit()
	SKTPersonTaskTeamView.super.onExit(self)
	self._progressScrollerList:dispose()
	self._teamScrollerList:dispose()
	uGuiUtil.clearImage(self._teamScoreIcon)
end

function SKTPersonTaskTeamView:_sendInfoReq()
	SaintKnightTaskController.instance:sendSK_GetPersonTaskReq(self._activityId)
end

function SKTPersonTaskTeamView:_onUpdate(status)
	if status ~= nil and status ~= 0 then
		return
	end

	self:_updateTeamCol()
	self:_updateProgressCol()
end

function SKTPersonTaskTeamView:_updateTeamCol()
	local teamMemberCount = SaintKnightTaskConfig.instance:getSktTeamMemberCount(self._activityId)
	local dataList = {}

	for index = 1, teamMemberCount do
		table.insert(dataList, index)
	end

	self._teamScrollerList:reloadData(dataList)
end

function SKTPersonTaskTeamView:_updateTeamCell(view, cell, index, tag)
	local mainGo = cell.gameObject
	local info = goutil.findChild(mainGo, "info")
	local empty = goutil.findChild(mainGo, "empty")
	local memberInfo = SaintKnightTaskModel.instance:getTeamMembers()[index]
	local hasMember = memberInfo ~= nil

	self:_clearTeamCell(cell)
	GameUtil.SetActive(info, hasMember)
	GameUtil.SetActive(empty, not hasMember)

	if hasMember then
		self:_updateMemberCell(mainGo, memberInfo)
	else
		self:_updateEmptyCell(mainGo)
	end
end

function SKTPersonTaskTeamView:_updateMemberCell(mainGo, memberInfo)
	local head = goutil.findChild(mainGo, "info/head")
	local txtName = goutil.findChildTextComponent(mainGo, "info/txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "info/txtScore")
	local headInfo = SaintKnightTaskModel.instance:getTeamMemberHeadInfo(memberInfo)
	local proxy = headInfo and HeadItemController.instance:setHeadCell(head, headInfo.headIconId, 0, 0) or nil

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(headInfo.userId, head)
		end)
	end

	if headInfo then
		txtName.text = headInfo.userName or ""
	end

	txtScore.text = string.format("任务积分：<color=#20b376>%s</color>", self:_getMemberScore(memberInfo))
end

function SKTPersonTaskTeamView:_getMemberScore(memberInfo)
	return SaintKnightTaskModel.instance:getTeamMemberProgress(memberInfo)
end

function SKTPersonTaskTeamView:_updateEmptyCell(mainGo)
	local btnInvite = goutil.findChild(mainGo, "empty/btnInvite")
	local btnChannel = goutil.findChild(mainGo, "empty/btnChannel")
	local isCaptain = SaintKnightTaskModel.instance:isTeamCaptain()

	GameUtil.SetActive(btnInvite, isCaptain)
	GameUtil.SetActive(btnChannel, isCaptain)
	GameUtil.addClickHandler(btnInvite, self._onClickBtnInvite, self)
	GameUtil.addClickHandler(btnChannel, self._onClickBtnChannel, self)
end

function SKTPersonTaskTeamView:_clearTeamCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "info/head")
	local btnInvite = goutil.findChild(mainGo, "empty/btnInvite")
	local btnChannel = goutil.findChild(mainGo, "empty/btnChannel")

	HeadItemController.instance:resetHeadCell(head)
	GameUtil.rmClickHandler(btnInvite)
	GameUtil.rmClickHandler(btnChannel)
end

function SKTPersonTaskTeamView:_updateProgressCol()
	local teamPrizeCfg = SaintKnightTaskConfig.instance:getSktTeamPrizeCfg(self._activityId) or {}
	local teamProgress = SaintKnightTaskModel.instance:getTeamProgress(self._activityId)
	local scoreList = {}

	for _, data in ipairs(teamPrizeCfg) do
		table.insert(scoreList, data.progress)
	end

	self._txtTeamScore.text = teamProgress

	MaterialMgr.setIcon(self._teamScoreIcon, MatType.ACTIVITY_ITEM, self._teamConfig.activityItemId)
	self._progressScrollerList:reloadData(teamPrizeCfg)
	self._progressScrollerList:updateUnderSlider(self._progressSlider, teamProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(self:_getTeamPrizeFocusIndex(teamPrizeCfg, scoreList, teamProgress))
end

function SKTPersonTaskTeamView:_getTeamPrizeFocusIndex(teamPrizeCfg, scoreList, teamProgress)
	for idx, data in ipairs(teamPrizeCfg) do
		if SaintKnightTaskController.instance:isCanGetPrizeAsTeamTask(self._activityId, data.prizeId) then
			return idx - 1
		end
	end

	local index = 0

	for idx, progress in ipairs(scoreList) do
		if teamProgress < progress then
			break
		end

		index = idx - 1
	end

	return index
end

function SKTPersonTaskTeamView:_updateProgressCell(view, cell, data, tag)
	local prizeId = data.prizeId
	local isHasGain = SaintKnightTaskController.instance:isHasGainPrizeAsTeamTask(prizeId)
	local isCanGet = SaintKnightTaskController.instance:isCanGetPrizeAsTeamTask(self._activityId, prizeId)
	local scrollRect = self._progressScrView:GetComponent(ComponentType.ScrollRect)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickTeamPrizeGet, self, data))
end

function SKTPersonTaskTeamView:_clearProgressCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function SKTPersonTaskTeamView:_onClickTeamPrizeGet(data)
	local prizeId = data.prizeId

	if SaintKnightTaskController.instance:isHasGainPrizeAsTeamTask(prizeId) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not SaintKnightTaskController.instance:isEnoughGetPrizeAsTeamTask(self._activityId, prizeId) then
		FloatWordMgr.instance:show("积分不足")

		return
	end

	SaintKnightTaskController.instance:sendSK_GainTeamPrizeReq(self._activityId)
end

function SKTPersonTaskTeamView:_onClickBtnFriends()
	self:close()
	FriendController.instance:OpenFriendView()
end

function SKTPersonTaskTeamView:_checkTeamCaptainAuth()
	if SaintKnightTaskModel.instance:isTeamCaptain() then
		return true
	end

	FloatWordMgr.instance:show("只有队长可以邀请")

	return false
end

function SKTPersonTaskTeamView:_onClickBtnChannel()
	if not self:_checkTeamCaptainAuth() then
		return
	end

	local now = ServerTime.now()

	if self._nextChannelInviteTime and now < self._nextChannelInviteTime then
		FloatWordMgr.instance:show(string.format("%s秒后可再次发送", self._nextChannelInviteTime - now))

		return
	end

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Share, GameEnum.ChatType.System, GameUtil.jsonToString(SaintKnightTaskController.instance:getTeamInviteDataT(self._activityId)))

	self._nextChannelInviteTime = now + ChannelInviteCd

	FloatWordMgr.instance:show("已发送至分享频道")
end

function SKTPersonTaskTeamView:_onClickBtnInvite()
	if not self:_checkTeamCaptainAuth() then
		return
	end

	ShareController.instance:tryOpenFriendView(SaintKnightTaskController.instance:getTeamInviteDataT(self._activityId))
end

return SKTPersonTaskTeamView

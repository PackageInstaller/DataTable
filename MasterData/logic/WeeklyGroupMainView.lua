-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/view/WeeklyGroupMainView.lua

module("logic.extensions.weeklygroup.view.WeeklyGroupMainView", package.seeall)

local WeeklyGroupMainView = class("WeeklyGroupMainView", ViewComponent)
local ACTIVE_STATE = {
	RETURN = 2,
	NEW = 1,
	NORMAL = 0
}

function WeeklyGroupMainView:ctor()
	WeeklyGroupMainView.super.ctor(self)
end

function WeeklyGroupMainView:unbindEvents()
	WeeklyGroupMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, self._playerCount do
		GameUtil.addClickHandler(self._players[i].btnAdd)
	end

	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnPersonal)
end

function WeeklyGroupMainView:bindEvents()
	WeeklyGroupMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i = 1, self._playerCount do
		GameUtil.addClickHandler(self._players[i].btnAdd, self._onClickInvite, self)
	end

	GameUtil.addClickHandler(self._btnTeam, function()
		self._curShowState = 0

		GameUtil.SetActive(self._bg, true)
		GameUtil.SetActive(self._bg2, false)
		self:_refresh()
	end, self)
	GameUtil.addClickHandler(self._btnPersonal, function()
		self._curShowState = 1

		GameUtil.SetActive(self._bg, false)
		GameUtil.SetActive(self._bg2, true)
		self:_refresh()
	end, self)
end

function WeeklyGroupMainView:buildUI()
	WeeklyGroupMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._players = {}
	self._playerCount = 4

	for i = 1, self._playerCount do
		local player = {}

		player.info = self:getGo("player/player_" .. i .. "/info")
		player.head = self:getGo("player/player_" .. i .. "/info/head")
		player.txtName = self:getTxt("player/player_" .. i .. "/info/txtName")
		player.txtScore = self:getTxt("player/player_" .. i .. "/info/txtScore")
		player.btnAdd = self:getBtn("player/player_" .. i .. "/btnAdd")
		player.tag = self:getGo("player/player_" .. i .. "/tag")
		player.txtTag = self:getTxt("player/player_" .. i .. "/tag/txtTag")
		player.change = self:getGo("player/player_" .. i):GetComponent(typeof(UIChangeGroup))

		table.insert(self._players, player)
	end

	self._tableviewGo = self:getGo("progress/tableview")
	self._rewardCell = self:getGo("progress/rewardCell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtProgress = self:getTxt("progress/total/txtProgress")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")
	self._btnTeam = self:getGo("btnTeam")
	self._btnPersonal = self:getGo("btnPersonal")
	self._btnTeamChange = self._btnTeam:GetComponent(typeof(UIChangeGroup))
	self._btnPersonalChange = self._btnPersonal:GetComponent(typeof(UIChangeGroup))
	self._bg = self:getGo("bg")
	self._bg2 = self:getGo("bg2")
end

function WeeklyGroupMainView:onExit()
	WeeklyGroupMainView.super.onExit(self)
	removetimer(self._sendInviteMsg, self)
	self._tableview:dispose()

	for i, playerInfo in ipairs(self._players) do
		HeadItemController.instance:resetHeadCell(self._players[i].head)
	end
end

function WeeklyGroupMainView:onEnter()
	WeeklyGroupMainView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.WeeklyGroup)

	self.addGEvent(self, GlobalNotify.WeeklyGroupGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._friendSelected, self)
	self.addGEvent(self, GlobalNotify.WeeklyGroupJoinTeamRes, self._sendGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.WeeklyGroupGainPrizeRes, self._sendGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.WeeklyGroupGainPersonPrizeRes, self._sendGetInfoRes, self)
	self:_sendGetInfoRes()

	self.msgId = 0
	self._buddyIds = {}
	self._actCfg = WeeklyGroupConfig.instance:getWeeklyGroupCfgById(self._activityId)
	self._prizeCfg = WeeklyGroupConfig.instance:getPrizeCfg(self._activityId)
	self._prizePersonCfg = WeeklyGroupConfig.instance:getPersonPrizeCfg(self._activityId)
	self._curShowState = 0

	self._btnPersonalChange:SetState(0)
	self._btnTeamChange:SetState(1)
end

function WeeklyGroupMainView:_sendGetInfoRes()
	WeeklyGroupController.instance:sendPM_WeeklyGroupGetInfoReq(self._activityId)
end

function WeeklyGroupMainView:_refresh()
	self._teamInfo = WeeklyGroupModel.instance:getTeamInfo()
	self._prizeCfg = WeeklyGroupConfig.instance:getPrizeCfg(self._activityId)
	self._prizePersonCfg = WeeklyGroupConfig.instance:getPersonPrizeCfg(self._activityId)
	self._txtProgress.text = self._curShowState == 0 and WeeklyGroupModel.instance:getTeamScore() or WeeklyGroupModel.instance:getPersonScore()

	for i = 1, self._playerCount do
		local info = self._teamInfo[i]

		if info then
			GameUtil.SetActive(self._players[i].info, true)
			GameUtil.SetActive(self._players[i].btnAdd, false)
		else
			GameUtil.SetActive(self._players[i].info, false)
			GameUtil.SetActive(self._players[i].btnAdd, true)
		end
	end

	for i, playerInfo in ipairs(self._teamInfo) do
		local proxy = HeadItemController.instance:setHeadCellByInfo(self._players[i].head, playerInfo.headInfo)

		if proxy then
			proxy:setCallBack(function()
				FriendController.instance:showInfoView(playerInfo.headInfo.userId, self._players[i].head)
			end)
		end

		local isMe = checknumber(playerInfo.headInfo.userId) == checknumber(RoleModel.instance:getUserId())
		local activeState = playerInfo.activeState

		self._players[i].txtName.text = playerInfo.headInfo.userName
		self._players[i].txtScore.text = playerInfo.itemCount

		self._players[i].change:SetState(isMe and 0 or 1)

		local tipStr = ""

		if activeState == ACTIVE_STATE.NEW then
			tipStr = string.format("新玩家+<color=#6FFF82FF>%d%%</color>", self._actCfg.newHandBonus)
		elseif activeState == ACTIVE_STATE.RETURN then
			tipStr = string.format("回归玩家+<color=#6FFF82FF>%d%%</color>", self._actCfg.regressBonus)
		end

		self._players[i].txtTag.text = tipStr

		GameUtil.SetActive(self._players[i].tag, activeState ~= ACTIVE_STATE.NORMAL)
	end

	local dataList

	if self._curShowState == 0 then
		dataList = self._prizeCfg

		self._tableview:reloadData(self._prizeCfg)

		local teamScore = WeeklyGroupModel.instance:getTeamScore()
		local scoreList = WeeklyGroupConfig.instance:getPrizeScoreList(self._activityId)

		self._tableview:updateUnderSlider(self._progressBar, teamScore, scoreList)
		self._btnPersonalChange:SetState(0)
		self._btnTeamChange:SetState(1)
		GameUtil.SetActive(self._bg2, false)
		GameUtil.SetActive(self._bg, true)
	else
		dataList = self._prizePersonCfg

		self._tableview:reloadData(self._prizePersonCfg)

		local personScore = WeeklyGroupModel.instance:getPersonScore()
		local scoreList = WeeklyGroupConfig.instance:getPersonPrizeScoreList(self._activityId)

		self._tableview:updateUnderSlider(self._progressBar, personScore, scoreList)
		self._btnPersonalChange:SetState(1)
		self._btnTeamChange:SetState(0)
		GameUtil.SetActive(self._bg2, true)
		GameUtil.SetActive(self._bg, false)
	end

	local index = 1

	for idx, data in ipairs(dataList or {}) do
		local isCanGet = WeeklyGroupController.instance:isCanGet(data.prizeId, self._curShowState)
		local isGainPrize = WeeklyGroupController.instance:isGainPrize(data.prizeId, self._curShowState)

		if isCanGet then
			index = idx

			break
		elseif isGainPrize then
			index = idx
		else
			break
		end
	end

	self._tableview:MoveCellToCenter(index - 1)
end

function WeeklyGroupMainView:_friendSelected(buddyIds)
	self._buddyIds = buddyIds

	local tpId = 65

	self._msgType = GameEnum.ChatType.System

	local cfg = ChatConfig.instance:getSystemMsgT(tpId)
	local params = {}

	params.teamId = RoleModel.instance:getUserId()
	params.teamName = RoleModel.instance:getUserName()
	params.activityId = self._activityId
	params.teamScore = WeeklyGroupModel.instance:getTeamScore()
	params.personScore = WeeklyGroupModel.instance:getPersonScore()
	params.number = WeeklyGroupController.instance:getNeedInviteCount(self._activityId)

	local dataT = {
		tpId = 65,
		params = params
	}

	self._content = GameUtil.jsonToString(dataT)

	local buddyCount = #self._buddyIds

	if buddyCount > 0 then
		settimer(1, self._sendInviteMsg, self, true)
	end

	WeeklyGroupController.instance:sendPM_WeeklyGroupInviteReq(self._activityId, self._buddyIds)
end

function WeeklyGroupMainView:_sendInviteMsg()
	self.msgId = self.msgId + 1

	local receiveId = self._buddyIds[self.msgId]

	ChatAgent.instance:sendSendMsgReq(GameEnum.ChatChannel.Private, self._msgType, self._content, receiveId, nil, nil)

	if self.msgId >= #self._buddyIds then
		WeeklyGroupModel.instance:setCdTime(0)
		FloatWordMgr.instance:show("已成功发送邀请~等待好友的加入吧")

		self.msgId = 0

		removetimer(self._sendInviteMsg, self)
		WeeklyGroupController.instance:friendSelectedCd()
	end
end

function WeeklyGroupMainView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")
	local received = goutil.findChild(cell, "received")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.needItemCount

	local isCanGet = WeeklyGroupController.instance:isCanGet(data.prizeId, self._curShowState)
	local isGainPrize = WeeklyGroupController.instance:isGainPrize(data.prizeId, self._curShowState)

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.prizeId, self._curShowState), self)
end

function WeeklyGroupMainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function WeeklyGroupMainView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport"):GetComponent(goutil.Type_RectTransform))
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function WeeklyGroupMainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function WeeklyGroupMainView:_onClickGetPrize(prizeId, typeId)
	if typeId == 0 then
		WeeklyGroupAgent.instance:sendPM_WeeklyGroupGainPrizeReq(self._activityId, prizeId)
	else
		WeeklyGroupAgent.instance:sendPM_WeeklyGroupGainPersonPrizeReq(self._activityId, prizeId)
	end
end

function WeeklyGroupMainView:_onClickInvite()
	if not WeeklyGroupController.instance:isCaptain() then
		FloatWordMgr.instance:show("您不是队长，无法邀请好友入队")

		return
	end

	local cdTime = WeeklyGroupModel.instance:getCdTime()

	if not cdTime or cdTime >= self._actCfg.inviteCd then
		local maxCount = WeeklyGroupController.instance:getNeedInviteCount(self._activityId)
		local desc = "请选择队友，邀请他加入战队；请注意，一旦加入则不可退队，直至本期活动结束"

		UIStateManager.instance:open(ViewName.FriendSelect, 0, maxCount, desc)
	else
		FloatWordMgr.instance:show("邀请得太快啦~每次邀请之间要间隔30秒，晚点再来吧~")
	end
end

return WeeklyGroupMainView

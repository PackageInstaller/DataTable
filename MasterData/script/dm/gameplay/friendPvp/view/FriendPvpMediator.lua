-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friendPvp/view/FriendPvpMediator.lua

FriendPvpMediator = class("FriendPvpMediator", DmAreaViewMediator, _M)

FriendPvpMediator:has("_friendPvpSystem", {
	is = "r"
}):injectWith("FriendPvpSystem")
FriendPvpMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
FriendPvpMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
FriendPvpMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
FriendPvpMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
FriendPvpMediator:has("_controller", {
	is = "r"
}):injectWith("RTPVPController")

local kBtnHandlers = {
	["main.inviteBtn"] = {
		func = "showFriendList"
	},
	["main.chatBtn"] = {
		func = "showChatView"
	}
}

local function getDescTextContent(desc)
	return
end

local player1, player2 = 1, 2

function FriendPvpMediator:initialize()
	super.initialize(self)
end

function FriendPvpMediator:dispose()
	self._friendPvpSystem._enterFriendPvp = false

	if self._timeScheduler then
		LuaScheduler:getInstance():unschedule(self._timeScheduler)

		self._timeScheduler = nil
	end

	if self._prepareTimer then
		self._prepareTimer:stop()

		self._prepareTimer = nil
	end

	if self._setupPvpConnectTask then
		cancelDelayCall(self._setupPvpConnectTask)

		self._setupPvpConnectTask = nil
	end

	if self._friendPvpListView then
		self._friendPvpListView:dispose()

		self._friendPvpListView = nil
	end

	self:stopBattleTimer()

	self._viewClose = true

	super.dispose(self)
end

function FriendPvpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._costLimit = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()
end

function FriendPvpMediator:enterWithData(data)
	self:glueFieldAndUi()
	self:bindWidget("main.fight", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickStart, self)
		}
	})
	self:bindWidget("main.prepare", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickPrepare, self)
		}
	})
	self:setupTopInfoWidget()
	self:showView(data)
end

function FriendPvpMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Friend_Pvp_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function FriendPvpMediator:showView(data)
	self:clearBattleFinishData()

	self._pvpAgent = self:getInjector():getInstance(RTPVPAgent)
	self._enterBattle = false
	self._data = data
	self._type = data and data.type
	self._friendPvp = self._friendPvpSystem:getFriendPvp()
	self._hostId = self._friendPvp:getHostId()
	self._isHost = false
	self._newMessages = {}
	self._connectPvpCount = 0

	self:createMapListener()
	self:setupView()

	if self._data and self._data.inviteFriend then
		local inviteFriendId = self._data.inviteFriendId

		self._friendPvpSystem:requestInviteFriend(inviteFriendId)

		local inviteMap = self._friendPvpSystem:getInviteTimeMap()
		local gameServerAgent = self:getInjector():getInstance(GameServerAgent)

		inviteMap[inviteFriendId] = gameServerAgent:remoteTimestamp()
	end
end

function FriendPvpMediator:clearBattleFinishData()
	local rtpvpController = self:getInjector():getInstance(RTPVPController)

	if rtpvpController:getBattleFinishData() then
		rtpvpController:clearBattleFinishData()
	end
end

function FriendPvpMediator:glueFieldAndUi()
	self._main = self:getView():getChildByName("main")
	self._startBtn = self._main:getChildByName("fight")
	self._prepareBtn = self._main:getChildByName("prepare")
	self._hostPanel = self._main:getChildByName("player1")
	self._rivalPanel = self._main:getChildByName("player2")
	self._inviteBtn = self._main:getChildByName("inviteBtn")

	local text1 = self._inviteBtn:getChildByName("text")

	text1:enableOutline(cc.c4b(0, 0, 0, 150.45), 1)

	local text2 = self._hostPanel:getChildByName("isPrepared")

	text2:enableOutline(cc.c4b(0, 0, 0, 150.45), 1)

	local text3 = self._rivalPanel:getChildByName("isPrepared")

	text3:enableOutline(cc.c4b(0, 0, 0, 150.45), 1)

	self._fightInfoTip = self:getView():getChildByFullName("fightInfo")

	self._fightInfoTip:setVisible(false)
	self._fightInfoTip:setLocalZOrder(100)

	local hostChatText = self._hostPanel:getChildByFullName("chatView.text")
	local rivalChatText = self._rivalPanel:getChildByFullName("chatView.text")

	hostChatText:getVirtualRenderer():setDimensions(260, 0)
	rivalChatText:getVirtualRenderer():setDimensions(260, 0)

	local function chatViewCallFunc()
		self:showChatView()
	end

	mapButtonHandlerClick(nil, self._hostPanel:getChildByName("chatView"), {
		ignoreClickAudio = true,
		func = chatViewCallFunc
	})
	mapButtonHandlerClick(nil, self._rivalPanel:getChildByName("chatView"), {
		ignoreClickAudio = true,
		func = chatViewCallFunc
	})
end

function FriendPvpMediator:createMapListener()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDPVP_DATAUODATA, self, self.setupView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDPVP_KICKOUT, self, self.onKickOutCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDPVP_ENTERBATTLE, self, self.onEnterBattleCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDPVP_ENTERBATTLE_FAIL, self, self.onEnterBattleFailCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_CONN_SUCC, self, self._connectSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_CONN_FAIL, self, self._pvpContentFail)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECONNECTION_SUCC, self, self.onReconnectionSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESIGN_ACTIVE, self, self._homeResign)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_MATCH, self, self._enterBattleScene)
	self.mapEventListener(self, self:getEventDispatcher(), PVP_FINISH_WINNER, self, self.winnerShow)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIENDPVP_ERROR_QUIT_ROOM, self, self.errorLeave)
end

function FriendPvpMediator:_homeResign()
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)

	self._homeTs = gameServerAgent:remoteTimeMillis()
end

function FriendPvpMediator:_pvpContentFail()
	self._setupPvpConnectTask = delayCallByTime(2000, function()
		self._friendPvpSystem:enterBattle(self._friendPvpSystem:getBattleData().battleRoom.ip, self._friendPvpSystem:getBattleData().battleRoom.port, self._friendPvp:getRoomId(), self._friendPvpSystem:getBattleData().battleData)
	end)
end

function FriendPvpMediator:onReconnectionSucc()
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
	local curTime = gameServerAgent:remoteTimeMillis()

	self._homeTs = nil

	self._friendPvpSystem:requestRefreshRoom(function()
		self:setupView()
	end)
end

function FriendPvpMediator:_enterBattleScene(evt)
	if self._waitingLayout then
		self._waitingLayout:setVisible(false)
	end

	local data = {}
	local extra = {}

	if self._type == "DateBattle" then
		data.bgId = "DateBattle_Scene"
		extra.battleType = kRTBattleType.DateBattle
	else
		extra.battleType = kRTBattleType.FriendPvp
	end

	local battleData = self._controller:fetchBattleData(evt:getData(), extra)

	self:_battleMatch(battleData, data)

	self._enterPvp = true

	self._friendPvpSystem:requestPvpConnection(1)
end

function FriendPvpMediator:_connectSucc()
	self._friendPvpSystem:connectSucc()
	self:showWaitingAnim()
end

function FriendPvpMediator:showWaitingAnim()
	if not self._waitingLayout then
		local adjustPos = self:getView():convertToNodeSpace(cc.p(display.cx, display.cy))
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(1386, 640))
		layout:setAnchorPoint(cc.p(0.5, 0.5))
		layout:addTo(self:getView(), 1000):setPosition(adjustPos)
		layout:setBackGroundColorType(1)
		layout:setBackGroundColor(cc.c3b(0, 0, 0))
		layout:setBackGroundColorOpacity(130)

		local waitingAnim = cc.MovieClip:create("mengjingbbb_mingzi")

		waitingAnim:addTo(layout):center(layout:getContentSize())

		self._waitingLayout = layout
	end

	self._waitingLayout:setVisible(true)
end

function FriendPvpMediator:setupView()
	self._hostId = self._friendPvp:getHostId()

	if self._developSystem:getPlayer():getRid() == self._hostId then
		self._isHost = true
	end

	self:refreshButtonStatus()
	self:refreshHostInfo()
	self:refreshGuestInfo()
end

function FriendPvpMediator:refreshButtonStatus()
	local guestInfo = self._friendPvp:getGuestInfo()
	local guestState = guestInfo and guestInfo.state

	if not guestState then
		self._inviteBtn:setVisible(true)
	else
		self._inviteBtn:setVisible(false)
	end

	if self._friendPvpListView then
		self._friendPvpListView:hideView()
	end

	self._rivalPanel:getChildByName("winTag"):setVisible(false)
	self._hostPanel:getChildByName("winTag"):setVisible(false)
	self._rivalPanel:getChildByName("chatView"):setVisible(false)
	self._hostPanel:getChildByName("chatView"):setVisible(false)

	if self._type == "DateBattle" then
		self._startBtn:setVisible(false)
		self._emBattleBtn:setVisible(false)
		self._topInfoWidget:getBtnBack():setVisible(false)
		self._chatPanel:setVisible(false)

		if self._isHost then
			self._prepareBtn:setVisible(false)
			self._startBtn:setVisible(true)
		else
			self._startBtn:setVisible(false)
			self._prepareBtn:setVisible(true)

			if guestState == GuestState.kEnter then
				self._prepareBtnWidget:setButtonName(Strings:get("FriendPvp_UI11"))
			else
				self._prepareBtnWidget:setButtonName(Strings:get("FriendPvp_UI12"))
			end
		end
	else
		local player1EmBtn = self._hostPanel:getChildByName("player1_team")
		local player2EmBtn = self._rivalPanel:getChildByName("player2_team")
		local allReadyNode = self._main:getChildByName("allReadyNode")

		if self._isHost then
			self._prepareBtn:setVisible(false)
			self._startBtn:setVisible(true)

			if guestState == GuestState.kReady then
				self._startBtn:setSaturation(0)
				allReadyNode:setVisible(true)
			else
				self._startBtn:setSaturation(-100)
				allReadyNode:setVisible(false)
			end

			player1EmBtn:setTouchEnabled(true)
			player2EmBtn:setTouchEnabled(false)
		else
			self._prepareBtn:setVisible(true)
			self._startBtn:setVisible(false)

			local text = self._prepareBtn:getChildByFullName("name")
			local enText = self._prepareBtn:getChildByFullName("name1")

			if guestState == GuestState.kEnter then
				text:setString(Strings:get("Friend_Pvp_Prepare"))
				enText:setString(Strings:get("Friend_Pvp_En_Prepare"))
				allReadyNode:setVisible(false)
			else
				text:setString(Strings:get("Friend_Pvp_UnPrePare"))
				enText:setString(Strings:get("UITitle_EN_Quxiao"))
				allReadyNode:setVisible(true)
			end

			player1EmBtn:setTouchEnabled(false)
			player2EmBtn:setTouchEnabled(true)
		end
	end
end

function FriendPvpMediator:refreshHostInfo()
	local panel = self._hostPanel
	local hostInfo = self._friendPvp:getHostInfo()
	local nameText = panel:getChildByName("playerName")

	nameText:setString(hostInfo.nickName)

	local lvText = panel:getChildByName("playerLv")

	lvText:setString("LV." .. hostInfo.level)

	local headIcon = panel:getChildByName("headIcon")

	headIcon:removeAllChildren()

	local headImg, oldIcon = IconFactory:createRactHeadImage({
		frameId = "bustframe11_2",
		id = hostInfo.headImage
	})

	oldIcon:offset(40, -10)
	headImg:addTo(headIcon):center(headIcon:getContentSize())
	self:setupPlayerTeamInfo(hostInfo, player1)

	local isPreparedText = panel:getChildByName("isPrepared")
	local hostState = hostInfo and hostInfo.state

	if hostState then
		isPreparedText:setVisible(true)
		isPreparedText:setString(Strings:get("Friend_Pvp_Ready"))
	else
		isPreparedText:setVisible(false)
	end
end

function FriendPvpMediator:refreshGuestInfo()
	local panel = self._rivalPanel
	local guestInfo = self._friendPvp:getGuestInfo()

	if not guestInfo then
		panel:setVisible(false)

		return
	end

	panel:setVisible(true)

	local nameText = panel:getChildByName("playerName")
	local headIcon = panel:getChildByName("headIcon")
	local lvText = panel:getChildByName("playerLv")
	local isPreparedText = panel:getChildByName("isPrepared")

	headIcon:removeAllChildren()
	nameText:setString(guestInfo.nickName)
	lvText:setString("LV." .. guestInfo.level)

	local headImg, oldIcon = IconFactory:createRactHeadImage({
		frameId = "bustframe11_2",
		id = guestInfo.headImage,
		size = cc.size(152, 83)
	})

	oldIcon:offset(40, -10)
	headImg:addTo(headIcon):center(headIcon:getContentSize())
	self:setupPlayerTeamInfo(guestInfo, player2)

	local guestState = guestInfo and guestInfo.state

	if guestState == GuestState.kReady then
		isPreparedText:setVisible(true)
		isPreparedText:setString(Strings:get("Friend_Pvp_Ready"))
		isPreparedText:setTextColor(cc.c3b(229, 255, 126))
	elseif guestState == GuestState.kEnter then
		isPreparedText:setVisible(true)
		isPreparedText:setString(Strings:get("Friend_Pvp_onReady"))
		isPreparedText:setTextColor(cc.c3b(255, 255, 255))
	else
		isPreparedText:setVisible(false)
	end
end

function FriendPvpMediator:setupPlayerTeamInfo(info, playerIndex)
	local view = playerIndex == player1 and self._hostPanel:getChildByFullName("player1_team") or self._rivalPanel:getChildByFullName("player2_team")
	local teamPanel = view:getChildByFullName("unlockPanel.showTeam")
	local combatLabel = teamPanel:getChildByName("combat")

	combatLabel:setString(info.combat)

	local nameLabel = teamPanel:getChildByName("teamName")

	nameLabel:setString(Strings:get(info.teamName))

	local limit, average = self:teamCostDes(info)
	local costLimit1Str = teamPanel:getChildByFullName("costLimit1")
	local costLimit2Str = teamPanel:getChildByFullName("costLimit2")
	local costAverageStr = teamPanel:getChildByFullName("costAverage")

	costLimit1Str:setString(limit)
	costLimit2Str:setString("")
	costAverageStr:setString(average)

	local masterPanel = teamPanel:getChildByFullName("masterPanel")

	masterPanel:removeChildByTag(620)

	local stencil = teamPanel:getChildByFullName("masterPanel.stencil"):clone()

	stencil:setVisible(true)
	stencil:setPosition(cc.p(0, 0))

	local masterSystem = self._developSystem:getMasterSystem()
	local roleModel = masterSystem:getMasterLeadStageModel(info.master[1], (not info.leadStageId or nil) and "")
	local masterIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe11_3",
		id = roleModel
	})

	masterIcon:setAnchorPoint(cc.p(0, 0))
	masterIcon:setPosition(cc.p(-8, 1))
	masterIcon:setTag(620)
	masterPanel:addChild(masterIcon)

	local node = teamPanel:getChildByFullName("node_leadStage")

	node:removeAllChildren()

	local icon = IconFactory:createLeadStageIconHor(info.leadStageId, info.leadStageLevel)

	if icon then
		icon:addTo(node)
	end

	local heroPanel = view:getChildByName("heroPanel")

	heroPanel:removeAllChildren()

	local size = heroPanel:getContentSize()
	local lineCellLimit = 5
	local cellWidth = 92
	local lineHeight = 101
	local heroSystem = self._developSystem:getHeroSystem()

	for k, _hero in ipairs(info.heroes) do
		local heroInfo = {
			id = _hero[1],
			level = tonumber(_hero[2]),
			star = tonumber(_hero[3]),
			quality = tonumber(_hero[4]),
			rarity = tonumber(_hero[5])
		}

		if playerIndex == player1 and self._isHost or playerIndex == player2 and not self._isHost then
			local heroModel = heroSystem:getHeroById(_hero[1])

			heroInfo.roleModel = heroModel:getModel()
		end

		local petNode = IconFactory:createHeroLargeNotRemoveIcon(heroInfo, {
			hideLevel = true,
			hideStar = true,
			hideName = true
		})

		petNode:setAnchorPoint(cc.p(0, 0))
		petNode:setScale(0.45)

		local costNode = petNode:getChildByFullName("main.actionNode.costBg")

		petNode:addTo(heroPanel)

		local line = math.ceil(k / lineCellLimit) - 1

		petNode:setPosition((k - line * lineCellLimit - 1) * cellWidth, size.height - lineHeight * (line + 1))
	end

	local combatInfoBtn = teamPanel:getChildByFullName("infoBtn")
	local leadConfig = masterSystem:getMasterLeadStatgeInfoById(info.leadStageId)

	if leadConfig then
		if not leadConfig.LeadFightHero then
			local addPercent = 0

			combatInfoBtn:setVisible(leadConfig ~= nil and addPercent > 0)
			combatInfoBtn:addTouchEventListener(function(sender, eventType)
				if not leadConfig then
					return
				end

				if playerIndex == player1 then
					self._fightInfoTip:setAnchorPoint(cc.p(0, 0.5))
					self._fightInfoTip:setPositionX(470)
				else
					self._fightInfoTip:setAnchorPoint(cc.p(1, 0.5))
					self._fightInfoTip:setPositionX(1060)
				end

				if eventType == ccui.TouchEventType.began then
					self._fightInfoTip:removeAllChildren()

					local addPer = leadConfig.LeadFightHero
					local config = ConfigReader:getRecordById("MasterBase", info.master[1])
					local desc = Strings:get("LeadStage_TeamCombatInfo", {
						fontSize = 20,
						fontName = TTF_FONT_FZYH_M,
						leader = Strings:get(config.Name),
						stage = Strings:get(leadConfig.RomanNum) .. Strings:get(leadConfig.StageName),
						percent = addPer * 100 .. "%"
					})
					local richText = ccui.RichText:createWithXML(desc, {})

					richText:setAnchorPoint(cc.p(0, 0))
					richText:setPosition(cc.p(10, 10))
					richText:addTo(self._fightInfoTip)
					richText:renderContent(440, 0, true)

					local size = richText:getContentSize()

					self._fightInfoTip:setContentSize(460, size.height + 20)
					self._fightInfoTip:setVisible(true)
				elseif eventType == ccui.TouchEventType.moved then
					-- block empty
				elseif eventType == ccui.TouchEventType.canceled then
					self._fightInfoTip:setVisible(false)
				elseif eventType == ccui.TouchEventType.ended then
					self._fightInfoTip:setVisible(false)
				end
			end)
		end
	end
end

function FriendPvpMediator:updateCDTimeScheduler()
	if self._timeScheduler == nil then
		self._timeScheduler = LuaScheduler:getInstance():schedule(function()
			self._friendPvpSystem:requestHeartBeat()
		end, 10, true)
	end

	self._friendPvpSystem:requestHeartBeat()
end

function FriendPvpMediator:onEnterBattleCallback()
	self._startEnter = true

	self:startBattleTimer()
	self._friendPvpSystem:requestAckEnterBattle(self._friendPvp:getRoomId(), function()
		if self._viewClose then
			return
		end

		if self._friendPvpSystem:getBattleData() and self._friendPvp:getState() == FriendPvpState.kBattle then
			local type = self._type == "DateBattle" and "date_battle" or "friend"

			self._friendPvpSystem:enterBattle(self._friendPvpSystem:getBattleData().battleRoom.ip, self._friendPvpSystem:getBattleData().battleRoom.port, self._friendPvp:getRoomId(), self._friendPvpSystem:getBattleData().battleData, type)
		end
	end)
end

function FriendPvpMediator:onEnterBattleFailCallback()
	if self._setupPvpConnectTask then
		cancelDelayCall(self._setupPvpConnectTask)

		self._setupPvpConnectTask = nil
	end

	if self._waitingLayout then
		self._waitingLayout:setVisible(false)
	end

	self._startEnter = false
	self._enterPvp = false

	self:stopBattleTimer()

	local rtpvpController = self:getInjector():getInstance(RTPVPController)

	rtpvpController:errorLeave()
end

function FriendPvpMediator:onKickOutCallback()
	self:dismiss()
end

function FriendPvpMediator:startBattleTimer()
	if self._battleTimeScheduler == nil then
		self._battleTimeScheduler = LuaScheduler:getInstance():schedule(function()
			if not self._enterPvp then
				self._friendPvpSystem:requestPvpConnection(0)
				self:onEnterBattleFailCallback()
				self:dispatch(ShowTipEvent({
					tip = Strings:get("Friend_Pvp_Tips7")
				}))
			else
				self._startEnter = false
				self._enterPvp = false

				self:stopBattleTimer()
			end
		end, 10, false)
	end
end

function FriendPvpMediator:stopBattleTimer()
	if self._battleTimeScheduler then
		LuaScheduler:getInstance():unschedule(self._battleTimeScheduler)

		self._battleTimeScheduler = nil
	end
end

function FriendPvpMediator:startPrepareTimer()
	self._prepareTimeNode:setVisible(true)

	local timeText = self._prepareTimeNode:getChildByName("Text_time")
	local cd = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DateBattle_Countdown", "content")

	local function update()
		timeText:setString(cd)

		if cd <= 0 then
			if self._isHost then
				local dataBattle = self._chatSystem:getChat():getDateBattle()

				self._chatSystem:requestLeaveRoom(dataBattle:getMessageId())
			else
				self._chatSystem:requestLeaveRoom(0)
			end

			self._friendPvpSystem:gotoHomeView(Strings:get("DateBattle_CanceledTip"))
		end

		cd = cd - 1 - (self._tickTs or 0)

		if self._tickTs then
			self._tickTs = nil
		end
	end

	self._prepareTimer = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

function FriendPvpMediator:winnerShow(event)
	local data = event:getData()
	local winnerId = data.winnerId
	local hostInfo = self._friendPvp:getHostInfo()
	local guestInfo = self._friendPvp:getGuestInfo()

	if hostInfo and guestInfo then
		if winnerId == hostInfo.id then
			self._hostPanel:getChildByName("winTag"):setVisible(true)
			self._rivalPanel:getChildByName("winTag"):setVisible(false)
		end

		if winnerId == guestInfo.id then
			self._rivalPanel:getChildByName("winTag"):setVisible(true)
			self._hostPanel:getChildByName("winTag"):setVisible(false)
		end
	end
end

function FriendPvpMediator:onNewMessage(event)
	local hostInfo = self._friendPvp:getHostInfo()
	local guestInfo = self._friendPvp:getGuestInfo()

	if hostInfo == nil or guestInfo == nil then
		return
	end

	local data = event:getData()
	local message = data.message
	local channelId = data.channelId
	local strs = string.split(channelId, "-")
	local sender = strs[2]
	local receiver = strs[3]

	if sender and receiver then
		if sender == hostInfo.id and receiver == guestInfo.id then
			self:dealMessage(message, true)

			return
		end

		if sender == guestInfo.id and receiver == hostInfo.id then
			self:dealMessage(message, false)

			return
		end
	end
end

function FriendPvpMediator:dealMessage(message, senderIsHost)
	local targetView = senderIsHost and self._hostPanel:getChildByName("chatView") or self._rivalPanel:getChildByName("chatView")

	targetView:stopAllActions()
	targetView:getChildByName("text"):setString(getDescTextContent(message:getContent()))
	targetView:setVisible(true)
	targetView:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Hide:create()))
end

function FriendPvpMediator:errorLeave()
	self:willLeave()
end

function FriendPvpMediator:showFriendList()
	if self._startEnter then
		return
	end

	self._inviteBtn:setVisible(false)

	if self._friendPvpListView then
		self._friendPvpListView:showView()

		return
	end

	self._friendPvpSystem:requestInvitingList("friend", 1, 20, function()
		if self._viewClose then
			return
		end

		local viewController = self:getInjector():injectInto(FriendPvpInviteWidget:new())
		local view = viewController:getView()

		view:addTo(self:getView(), 1)
		view:setPosition(cc.p(625, 90))

		local data = {}

		data.mediator = self

		viewController:initView(data)

		self._friendPvpListView = viewController
	end)
end

function FriendPvpMediator:willLeave()
	if self._startEnter then
		return
	end

	local function leave()
		self._friendPvpSystem:requestLeaveRoom(self._friendPvp:getRoomId())
		self:dismiss()
	end

	local guestInfo = self._friendPvp:getGuestInfo()

	if self._isHost and guestInfo then
		local delegate = __associated_delegate__(self)({
			willClose = function(self, popUpMediator, data)
				if data.response == "ok" then
					leave()
				end
			end
		})
		local data = {
			title = Strings:get("Friend_Pvp_LeaveTitle"),
			content = Strings:get("Friend_Pvp_Leave"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	else
		leave()
	end
end

function FriendPvpMediator:onClickBack(sender, eventType)
	self:willLeave()
end

function FriendPvpMediator:onClickEmbattle()
	if self._startEnter then
		return
	end

	local guestInfo = self._friendPvp:getGuestInfo()
	local guestState = guestInfo and guestInfo.state

	if not self._isHost and guestState ~= GuestState.kEnter then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Pvp_Tips2")
		}))

		return
	end

	local view = self:getInjector():getInstance("StageTeamView")
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = StageTeamType.STAGE_NORMAL
	})

	self:dispatch(event)
end

function FriendPvpMediator:onClickStart(sender, eventType)
	if self._startEnter then
		return
	end

	local guestInfo = self._friendPvp:getGuestInfo()
	local guestState = guestInfo and guestInfo.state

	if not guestInfo then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Pvp_NoRival")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if guestState == GuestState.kEnter then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Friend_Pvp_Tips1")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if self._type == "DateBattle" then
		self._chatSystem:requestStartBattle()
	else
		self._friendPvpSystem:requestBattleStart()
	end

	self._startEnter = true
end

function FriendPvpMediator:onClickPrepare(sender, eventType)
	if self._startEnter then
		return
	end

	local guestInfo = self._friendPvp:getGuestInfo()
	local guestState = guestInfo and guestInfo.state

	if self._type == "DateBattle" then
		self._friendPvpSystem:requestBattleReady()
	elseif guestState == GuestState.kEnter then
		self._friendPvpSystem:requestBattleReady()
	else
		self._friendPvpSystem:requestCancelReady()
	end
end

function FriendPvpMediator:onClickRolePanel(sender, eventType, data)
	return
end

function FriendPvpMediator:showChatView()
	if self._startEnter then
		return
	end

	local view = self:getInjector():getInstance("chatMainView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view))
end

function FriendPvpMediator:_battleShowResult(result)
	Bdump(result)

	if self._type == "DateBattle" then
		self._chatSystem:requestFinishBattle(result)
	else
		self._friendPvpSystem:requestFinishBattle(self._friendPvp:getRoomId(), result)
	end
end

function FriendPvpMediator:_battleMatch(data, extra)
	local battleDelegate = RTPVPDelegate:new(self._controller:getRtpvpService():fetchRid(), data.battleData, data.simulator, bind1(self._battleShowResult, self), self._friendPvp:getRoomId())

	if extra then
		if not extra.bgId then
			local bgRes = "Battle_Scene_1"
			local logicInfo = {
				director = self._controller:getDirector(),
				interpreter = data.interpreter,
				teams = battleDelegate:getPlayers(),
				mainPlayerId = {
					battleDelegate:getMainPlayerId()
				}
			}
			local settingSystem = self:getInjector():getInstance(SettingSystem)
			local battleConfig = data.battleSession:getBattleConfig()
			local battleData = battleDelegate:getPlayersData()
			local battlePassiveSkill = data.battleSession:getBattlePassiveSkill(battleData, battleDelegate:getMainPlayerId())
			local systemKeeper = self:getInjector():getInstance("SystemKeeper")
			local unlockSpeed, tipsSpeed = systemKeeper:isUnlock("BattleSpeed")
			local speedOpenSta = systemKeeper:getBattleSpeedOpen("friend_battle")
			local battleSpeed_Display = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Display", "content")
			local battleSpeed_Actual = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BattleSpeed_Actual", "content")

			function battleDelegate:onShowRestraint(continueCallback)
				local popupDelegate = {}

				function popupDelegate:willClose(sender)
					continueCallback()
				end

				local view = settingSystem:getInjector():getInstance("battlerofessionalRestraintView")

				settingSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}, popupDelegate))
			end

			function battleDelegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
				local popupDelegate = {}

				function popupDelegate:willClose(sender, data)
					if resumeCallback then
						resumeCallback()
					end
				end

				local bossView = settingSystem:getInjector():getInstance("MasterCutInView")

				if battleDelegate:getMainPlayerId() == friend.rid then
					settingSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
						friend = friend,
						enemy = enemy
					}, popupDelegate))
				else
					settingSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
						friend = enemy,
						enemy = friend
					}, popupDelegate))
				end

				if pauseFunc then
					pauseFunc()
				end
			end

			local var_53_1 = {
				isReplay = false,
				battleData = battleData,
				battleConfig = battleConfig,
				logicInfo = logicInfo,
				delegate = battleDelegate
			}
			local var_53_2 = {
				mainView = "rtpvpBattle",
				opPanelRes = "asset/ui/BattleUILayer.csb",
				disableHeroTip = true,
				canChangeSpeedLevel = false,
				opPanelClazz = "BattleUIMediator",
				battleType = data.battleSession:getBattleType(),
				bulletTimeEnabled = BattleLoader:getBulletSetting("BulletTime_PVP_Main"),
				bgm = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Music_BattleBGM_FriendBattle", "content"),
				background = bgRes,
				refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
				battleSuppress = BattleDataHelper:getBattleSuppress()
			}

			var_53_2.hpShow = settingSystem:getSettingModel():getHpShowSetting()
			var_53_2.effectShow = self:getInjector():getInstance(SettingSystem):getSettingModel():getEffectShowSetting()
			var_53_2.passiveSkill = battlePassiveSkill
			var_53_2.unlockMasterSkill = self:getInjector():getInstance(SystemKeeper):isUnlock("Master_BattleSkill")
			var_53_2.finishWaitTime = BattleDataHelper:getBattleFinishWaitTime("friend_battle")

			local var_53_3 = {}
			local var_53_4 = {}

			var_53_4.visible = speedOpenSta and self:getInjector():getInstance(SystemKeeper):canShow("BattleSpeed")
			var_53_4.lock = not unlockSpeed
			var_53_4.tip = tipsSpeed
			var_53_4.speedConfig = battleSpeed_Actual
			var_53_4.speedShowConfig = battleSpeed_Display
			var_53_3.speed = var_53_4
			var_53_3.skip = {
				visible = false
			}
			var_53_3.auto = {
				visible = false
			}
			var_53_3.pause = {
				visible = false
			}

			local var_53_5 = {}

			var_53_5.visible = self:getInjector():getInstance(SystemKeeper):canShow("Button_CombateDominating")
			var_53_5.lock = not self:getInjector():getInstance(SystemKeeper):isUnlock("Button_CombateDominating")
			var_53_3.restraint = var_53_5
			var_53_2.btnsShow = var_53_3
			var_53_1.viewConfig = var_53_2
			var_53_1.loadingType = LoadingType.KFriendPK

			local data = var_53_1

			BattleLoader:pushBattleView(self, data, nil, true)
		end
	end
end

function FriendPvpMediator:teamCostDes(data)
	local ids = data.heroes
	local totalCost = 0

	for k, v in pairs(ids) do
		local heroCost = ConfigReader:getDataByNameIdAndKey("HeroBase", v[1], "Cost")

		totalCost = totalCost + heroCost
	end

	return totalCost, #ids == 0 and 0 or math.floor(totalCost * 10 / #ids + 0.5) / 10
end

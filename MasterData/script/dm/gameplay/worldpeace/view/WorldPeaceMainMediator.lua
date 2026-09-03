-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceMainMediator.lua

WorldPeaceMainMediator = class("WorldPeaceMainMediator", DmAreaViewMediator, _M)

WorldPeaceMainMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceMainMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
WorldPeaceMainMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

local kBtnHandlers = {
	btn_reward = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	guide = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGuide"
	}
}

function WorldPeaceMainMediator:initialize()
	super.initialize(self)
end

function WorldPeaceMainMediator:dispose()
	super.dispose(self)

	if self._wordPeaceNotic then
		self._wordPeaceNotic:dispose()

		self._wordPeaceNotic = nil
	end

	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end

	if self._worldPeaceHandWidget then
		self._worldPeaceHandWidget:dispose()

		self._worldPeaceHandWidget = nil
	end

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._battleTime then
		self._battleTime:stop()

		self._battleTime = nil
	end

	self._wordPeaceGame:clearBattleField()
	cancelDelayCall(self._delayShowTask)

	local director = cc.Director:getInstance()

	director:setAnimationInterval(1 / (GAME_MAX_FPS or 60))
end

function WorldPeaceMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:getView():getChildByFullName("btn_reward"):setLocalZOrder(999999)
	self:getView():getChildByFullName("btn_reward"):setSwallowTouches(true)
end

function WorldPeaceMainMediator:enterWithData()
	self:setupTopInfoWidget()
	self:setupView()
	self:initBattleLayer()
	self:startMainLoop()
	self:showChat()
	self:setupChatFlowWidget()
	self:setupBottomView()
	self:setupCommondView()
	self:refreshBattleInfo()
	self:startBattleTimer()

	self._delayShowTask = delayCallByTime(2, function()
		self:checkShowTipsView()
	end)

	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BATTLEFEILD_REFRESH, self, self.refreshBattleField)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_COMMON_REFRESH, self, self.updateCommondView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_PLAYER_REFRESH, self, self.updateBottomView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BACK_REFRESH, self, self.backGround)
	self:getView():getChildByFullName("infopanel"):setLocalZOrder(20)

	local listView = self:getView():getChildByFullName("infopanel.Node.Node_jifen.noticinfo"):setSwallowTouches(true)

	self:checkShowGuideView()
end

function WorldPeaceMainMediator:backGround()
	dump("backGround___WorldPeaceMainMediator")
	self:onClickBack()
end

function WorldPeaceMainMediator:setupCommondView()
	local commondnode = self:getView():getChildByFullName("commond.commond")
	local worldPeaceCommondWidget = WorldPeaceCommondWidget:new(commondnode, self, true)

	self:getInjector():injectInto(worldPeaceCommondWidget)

	self._worldPeaceCommondWidget = worldPeaceCommondWidget

	self._worldPeaceCommondWidget:setDelegate(self)
	self:updateCommondView()
	commondnode:setLocalZOrder(10)

	local arrow = self:getView():getChildByFullName("commond.arrow")
	local arrow1 = self:getView():getChildByFullName("commond.arrow1")
	local line = self:getView():getChildByFullName("commond.line")

	arrow:setLocalZOrder(11)
	arrow1:setLocalZOrder(11)
	line:setVisible(false)
	arrow:addClickEventListener(function()
		line:setVisible(true)
		commondnode:setVisible(false)
		arrow1:setVisible(true)
		arrow:setVisible(false)
	end)
	arrow1:addClickEventListener(function()
		commondnode:setVisible(true)
		line:setVisible(false)
		arrow1:setVisible(false)
		arrow:setVisible(true)
	end)
	arrow1:setVisible(false)
end

function WorldPeaceMainMediator:dragMoved(commond, sender, pt)
	local bosses = self._wordPeaceGame:getMemberFactory():getMembersPool()

	for k_, v_ in pairs(bosses) do
		if v_:getType() == K_WORLD_MEMBER_TYPE.Boss then
			local localPoint = v_._grid:getParent():convertToNodeSpace(pt)
			local cardRect = v_._grid:getBoundingBox()
			local isContain = cc.rectContainsPoint(cardRect, localPoint)

			v_._grid:setBrightness(0)

			if isContain then
				v_._grid:setBrightness(150)
			end
		end
	end
end

function WorldPeaceMainMediator:backTag(commond, sender, pt)
	self._worldPeaceSystem:sendBossTag({
		bossId = "",
		tag = sender.tag
	}, true, function(response)
		if response.resCode == 0 then
			sender:setPosition(sender.orgPos or sender:getPosition())
		end
	end)
end

function WorldPeaceMainMediator:dragEnded(commond, sender, pt, call)
	local targetBoss
	local bosses = self._wordPeaceGame:getMemberFactory():getMembersPool()

	for k_, v_ in pairs(bosses) do
		if v_:getType() == K_WORLD_MEMBER_TYPE.Boss then
			local localPoint = v_._grid:getParent():convertToNodeSpace(pt)
			local cardRect = v_._grid:getBoundingBox()
			local isContain = cc.rectContainsPoint(cardRect, localPoint)

			v_._grid:setBrightness(0)

			if isContain then
				v_._grid:setBrightness(150)

				targetBoss = v_
			end
		end
	end

	if not targetBoss then
		commond:resetPosition(sender)
	else
		local battlefeild = self._worldPeaceSystem:getBattlefield()
		local groupTags = battlefeild:getGroup()
		local back = false

		for k, v in pairs(groupTags) do
			if tonumber(k) == sender.tag then
				back = true

				break
			end
		end

		self._worldPeaceSystem:sendBossTag({
			bossId = back or targetBoss:getId(),
			tag = sender.tag
		}, true, function(response)
			if response.resCode == 0 then
				targetBoss._grid:setBrightness(0)
				sender:setPosition(sender.orgPos or sender:getPosition())
				targetBoss:updateInfo(battlefeild:getBossById(targetBoss:getId()))
				call()
			else
				targetBoss._grid:setBrightness(0)
				commond:resetPosition(sender)
			end
		end)
	end
end

function WorldPeaceMainMediator:setupBottomView()
	local bottomnode = self:getView():getChildByName("bottomnode")
	local worldPeaceHandWidget = WorldPeaceHandWidget:new(bottomnode, self, true)

	self:getInjector():injectInto(worldPeaceHandWidget)

	self._worldPeaceHandWidget = worldPeaceHandWidget

	bottomnode:setLocalZOrder(10)
	self:updateBottomView()
end

function WorldPeaceMainMediator:updateBottomView()
	local playerInfo = self._worldPeaceSystem:getMainPlayer()

	self._worldPeaceHandWidget:updateInfo(playerInfo)
end

function WorldPeaceMainMediator:updateCommondView()
	local battlefeild = self._worldPeaceSystem:getBattlefield()

	self._worldPeaceCommondWidget:updateInfo(battlefeild)
end

function WorldPeaceMainMediator:setupChatFlowWidget()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local chatFLowNode = self:getView():getChildByName("chat_flow_node")
	local wordPeaceNotic = WordPeaceNotic:new(chatFLowNode)

	self:getInjector():injectInto(wordPeaceNotic)
	wordPeaceNotic:setGroupMap(battleField:getGroupNameMap())

	self._wordPeaceNotic = wordPeaceNotic

	chatFLowNode:setLocalZOrder(10)
	wordPeaceNotic:start()
end

function WorldPeaceMainMediator:showChat()
	local view = self:getInjector():getInstance("SmallChat")

	self:getView():getChildByName("chatNode"):setLocalZOrder(20)

	if view then
		view:setAnchorPoint(cc.p(0.5, 0.5))
		view:setPosition(cc.p(568, 320))
		view:getChildByFullName("passPanel"):setVisible(false)

		self._chatViewPanel = self:getView():getChildByName("chatNode")

		self._chatViewPanel:addChild(view)

		local offsetX = 68

		view:setPosition(cc.p(568 + offsetX, 320))

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:setMessageBoxType(ChatTabType.kWordPeace)
			mediator:enterWithData(nil)
			mediator:setChatItemContent(cc.size(-60, 0))
			mediator:setChatBgSize(cc.size(385, 80))

			self._chatMediator = mediator
		end
	end

	if self._worldPeaceSystem:getStatus() ~= WPStatus.kApply then
		self._chatSystem:getHistoryByChannel(ChannelId.kWordPeace)
	else
		self._chatSystem:getChat():getChannel(ChannelId.kWordPeace):clear()
		self._chatSystem:getHistoryByChannel(ChannelId.kWordPeace)
	end
end

function WorldPeaceMainMediator:resumeWithData()
	return
end

function WorldPeaceMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kClubMapPotion
		},
		title = Strings:get("ClubMapBoss_Title02"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

local WorldPeaceLayer = {
	BgLayer = 2,
	BollLayer = 5,
	UnderLayer = 4,
	BossLayer = 3,
	LabelLayer = 10,
	UILayer = 30,
	EffectLayer = 20
}

function WorldPeaceMainMediator:getScrollView()
	return self._touch
end

function WorldPeaceMainMediator:getBossLayer()
	return self._innnerContainer:getChildByFullName("BossLayer")
end

function WorldPeaceMainMediator:initBattleLayer()
	self._touchPoint = {}
	self._touchHeroInfo = nil
	self._canTouchScaleSta = false
	self._mapTouchMove = false
	self._enterScale = 0.9
	self._minScale = 0.6
	self._maxScale = 2.3
	self._scrollView = self:getView():getChildByName("map")
	self._winSize = cc.Director:getInstance():getWinSize()

	self._scrollView:setContentSize(self._winSize)

	self._innnerContainer = self._scrollView:getInnerContainer()

	self._scrollView:setTouchEnabled(false)

	self._touch = cc.Layer:create():addTo(self:getView(), 1):center(self:getView():getContentSize())
	self._container = self._scrollView:getInnerContainer()

	self._scrollView:setScrollBarEnabled(false)
	self._container:setContentSize(cc.size(3900, 2544))

	self._containerSize = self._container:getContentSize()
	self._viewSize = self._scrollView:getContentSize()
	self._bottomview = self:getView():getChildByName("bottomview")

	self:initMultiLayer()

	local node = cc.Node:create()

	node:setName("BgLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.BgLayer)

	local bg = ccui.ImageView:create("asset/scene/cb_bg.jpg")

	bg:setAnchorPoint(cc.p(0, 0))
	bg:setPosition(0, 0)
	bg:addTo(node)

	local node = cc.Node:create()

	node:setName("UnderLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.UnderLayer)
	node:setVisible(false)

	local node = cc.Node:create()

	node:setName("BossLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.BossLayer)

	local node = cc.Node:create()

	node:setName("BollLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.BollLayer)

	local node = cc.Node:create()

	node:setName("LabelLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.LabelLayer)

	local node = cc.Node:create()

	node:setName("EffectLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.EffectLayer)
	node:setVisible(false)

	local node = cc.Node:create()

	node:setName("UILayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.UILayer)
end

function WorldPeaceMainMediator:startMainLoop()
	self._wordPeaceGame = WordPeaceGame:new()

	self._wordPeaceGame:setDisplayStage(self:getView())
	self._wordPeaceGame:setDisplayMode(K_RENDER_DISPLAYMODE.MULTILEVEL)
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
	self:getView():runAction(DelayAction:create(function()
		self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
			self._wordPeaceGame:step(dt)
			self._worldPeaceSystem:step(dt)
		end, 0, false)
	end, 0.5))

	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossList = battleField:getBossList()

	self._wordPeaceGame:createBattleFields(bossList)

	local dieQueques = battleField:getDieQueques()

	self._wordPeaceGame:createBattleShadows(dieQueques)
	self:setZoomScale(self._enterScale)

	local pos = self:getMemberInnerContainerPosition("ClubMapBoss01")

	self._scrollView:setInnerContainerPosition(pos)
end

function WorldPeaceMainMediator:getMemberInnerContainerPosition(id)
	local targetBoss = self._wordPeaceGame:getMemberFactory():getMemberById(id)
	local targetPos = cc.p(targetBoss:getDisplayNode():getPosition())
	local scale = self._container:getScale()

	return (cc.p(-(targetPos.x * scale - self._viewSize.width / 2), -(targetPos.y * scale - self._viewSize.height / 2)))
end

function WorldPeaceMainMediator:refreshBattleField(data)
	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossList = battleField:getBossList()

	self._wordPeaceGame:createBattleFields(bossList)

	local dieQueques = battleField:getDieQueques()

	self._wordPeaceGame:createBattleShadows(dieQueques)
	self:updateBottomView()
	self:updateCommondView()

	local data = data:getData()

	if data and data.collectInfo then
		for k, v in pairs(data.collectInfo) do
			if v == "reload" then
				self:backToCard(k)
			else
				self._wordPeaceGame:getMemberFactory():destoryMemberById(k)
			end
		end
	end

	self._bossChangeQueques = self._bossChangeQueques or {}

	for k, v in pairs(battleField:getBossChangeList()) do
		self._wordPeaceNotic:addMessage(v)

		self._bossChangeQueques[#self._bossChangeQueques + 1] = v
	end

	self._syncLoadBossMessage = coroutine.create(function()
		local time = os.clock()

		while true do
			if #self._bossChangeQueques > 0 then
				local v = table.remove(self._bossChangeQueques, 1)

				self:insertLogs(v)

				if os.clock() - time > 0.03333333333333333 then
					time = os.clock()

					coroutine.yield("unfinish")
				end
			end

			coroutine.yield("wait")
		end
	end)

	self:refreshBattleInfo()
	self:updateTask()
end

function WorldPeaceMainMediator:insertLogs(log)
	local itemcell = self:getView():getChildByFullName("infopanel.Node.Node_jifen.item")
	local listView = self:getView():getChildByFullName("infopanel.Node.Node_jifen.noticinfo")
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local groupNameMap = battleField:getGroupNameMap()
	local bossData = battleField:getBossById(log.bossId)
	local heroCfg = ConfigReader:getRecordById("HeroBase", bossData:getConfig().Hero)
	local v = log
	local color = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}

	for k_, v_ in pairs(groupNameMap) do
		if v.campId == v_.gId then
			gIndex = v_.gIndex
		end
	end

	local gorupInfo = playerInfo:getGroupInfo()
	local richText, newCamp

	for k_, v_ in pairs(groupNameMap) do
		if v.campId == v_.gId then
			gIndex = v_.gIndex
			newCamp = v_.gName
		end
	end

	local time = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", v.time / 1000)
	local oldCampInfo = self._worldPeaceSystem:getCampInfo(v.oldCampId)
	local newCampInfo = self._worldPeaceSystem:getCampInfo(v.campId)
	local gIndex = 1

	for k_, v_ in pairs(groupNameMap) do
		if v.params.camp and v.params.camp == v_.gName then
			gIndex = v_.gIndex
		end
	end

	local color = color[gIndex]
	local reason
	local campName
	local player
	local strformat = Strings:get("ClubMapBoss_Announce" .. v.type, {
		fontSize = 16,
		fontName = TTF_FONT_FZYH_M,
		time = time,
		camp = (v.params and v.params.camp or nil) and v.params.camp,
		bossname = Strings:get(heroCfg.Name),
		num = bossData:getLv(),
		color = color,
		reason = (v.params and v.params.reason or nil) and Strings:get("ClubMapBoss_Announce5_reason" .. v.params.reason),
		player = (v.params and v.params.player or nil) and v.params.player
	})
	local richText = ccui.RichText:createWithXML(strformat, {})
	local item = itemcell:clone()

	richText:setAnchorPoint(cc.p(0, 0))
	richText:setPosition(cc.p(0, 5))
	richText:addTo(item)
	richText:setName("richText")

	local widthOffset = self._isOpenInfo and 400 or 0

	richText:renderContent(itemcell:getContentSize().width + widthOffset, 0, true)
	item:setContentSize(itemcell:getContentSize().width + widthOffset, richText:getContentSize().height + 10)

	item.orgSize = itemcell:getContentSize()

	listView:pushBackCustomItem(item)
	listView:jumpToBottom()
end

function WorldPeaceMainMediator:updateLogic()
	if self._syncLoadBossMessage then
		coroutine.resume(self._syncLoadBossMessage)
	end
end

function WorldPeaceMainMediator:refreshBattleInfo()
	local groupNameMap = self._worldPeaceSystem:getBattlefield():getGroupNameMap()
	local bossList = self._worldPeaceSystem:getBattlefield():getBossList()
	local groupBossTime = self._worldPeaceSystem:getBattlefield():getGroupBossTime()
	local groupPointMap = self._worldPeaceSystem:getBattlefield():getGroupPointMap()
	local rankInfo = {}

	for k, v in pairs(groupNameMap) do
		rankInfo[v.gId] = {
			time = 2542600247000,
			owncnt = 0,
			campname = v.gName,
			gId = v.gId
		}

		for k_, v_ in pairs(bossList) do
			local boss = v_

			if boss:getCamp() == v.gId then
				rankInfo[v.gId].owncnt = rankInfo[v.gId].owncnt + 1

				if groupBossTime[v.gId] then
					rankInfo[v.gId].time = groupBossTime[v.gId] or rankInfo[v.gId].time
				end
			end
		end

		rankInfo[v.gId].owncnt = groupPointMap[v.gId] or 0
	end

	local sortInfo = {}

	for k, v in pairs(rankInfo) do
		sortInfo[#sortInfo + 1] = v
	end

	table.sort(sortInfo, function(a, b)
		if a.owncnt > b.owncnt then
			return true
		elseif a.owncnt < b.owncnt then
			return false
		else
			return a.time < b.time
		end
	end)
	self._worldPeaceSystem:setCampIndex(sortInfo)

	local progressRes = {
		"CB_sc9_jindu2_red.png",
		"CB_sc9_jindu2_yellow.png",
		"CB_sc9_jindu2_blue.png"
	}
	local campRes = {
		"CB_img_zhenying_hong.png",
		"CB_img_zhenying_huang.png",
		"CB_img_zhenying_lan.png"
	}
	local hurtRes = {
		"CB_img_guishudi_hong.png",
		"CB_img_guishudi_huang.png",
		"CB_img_guishudi_lan.png"
	}

	for k, v in pairs(sortInfo) do
		self:getView():getChildByFullName("infopanel.Node.Node_jifen.flag" .. k):loadTexture(campRes[v.camp], 1)
		self:getView():getChildByFullName("infopanel.Node.Node_jifen.rank" .. k):setString("")
		self:getView():getChildByFullName("infopanel.Node.Node_jifen.cnt" .. k):setString(v.owncnt)
		self:getView():getChildByFullName("infopanel.Node.Node_jifen.name" .. k):setString(v.campname)
		self:getView():getChildByFullName("infopanel.Node.Node_jifen.percent" .. k):loadTexture(progressRes[v.camp], 1)
		self:getView():getChildByFullName("infopanel.Node.Node_jifen.hurt" .. k .. ".Image_3"):loadTexture(hurtRes[v.camp], 1)

		local percent

		self:getView():getChildByFullName("infopanel.Node.Node_jifen.percent" .. k):setContentSize(cc.size(133 * (sortInfo[1].owncnt > 0 and v.owncnt / sortInfo[1].owncnt or 0), 20))
	end
end

function WorldPeaceMainMediator:onHuiShou(bossId, teamKey)
	if self._huishouAnimRun then
		return
	end

	if self._worldPeaceSystem:getStatus() ~= WPStatus.kBattle then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80604")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._worldPeaceHandWidget then
		self._worldPeaceSystem:recallTeam({
			teamId = teamKey
		}, true, function(response)
			if response.resCode == 0 then
				local boss = self._worldPeaceSystem:getBattlefield():getBossById((not bossId or nil) and self._bossId)

				boss:getDTeams()[teamKey] = nil
				boss:getATeams()[teamKey] = nil

				self:backToCard(teamKey)
			end
		end)
	end
end

function WorldPeaceMainMediator:backToCard(teamKey)
	local targetNode = self._worldPeaceHandWidget:getTargetNode(teamKey)

	if targetNode then
		local memeber = self._wordPeaceGame:getMemberFactory():getMemberById(teamKey)

		if memeber then
			local displayNode = memeber:getDisplayNode()
			local w_pos_tar = displayNode:getParent():convertToWorldSpace(cc.p(displayNode:getPosition()))
			local n_pos_tar = self:getView():convertToNodeSpace(w_pos_tar)
			local w_pos = targetNode:getParent():convertToWorldSpace(cc.p(targetNode:getPosition()))
			local n_pos = self:getView():convertToNodeSpace(w_pos)

			self._wordPeaceGame:getMemberFactory():destoryMemberById(teamKey)

			local flyNode = cc.CSLoader:createNode("asset/ui/Boll.csb")

			flyNode:getChildByName("hudun"):setVisible(false)
			flyNode:getChildByName("progress"):setVisible(false)

			local heroCfg = ConfigReader:getRecordById("HeroBase", memeber._heroId)
			local modelId = heroCfg.RoleModel
			local head = ConfigReader:getRecordById("RoleModel", modelId).HeadMain2
			local icon = flyNode:getChildByName("icon")

			reapath = head .. "_wordpeace.png"

			icon:loadTexture(reapath, ccui.TextureResType.plistType)
			flyNode:addTo(self:getView())
			flyNode:setLocalZOrder(10)
			flyNode:setPosition(n_pos_tar)
			flyNode:setVisible(true)

			local moveTo = cc.MoveTo:create(0.5, n_pos)
			local scaleTo = cc.ScaleTo:create(0.5, 0.3)
			local goaback = cc.Spawn:create(scaleTo, moveTo)
			local action = cc.Sequence:create(goaback, cc.CallFunc:create(function()
				flyNode:removeFromParent()

				local huishou = cc.MovieClip:create("huishou_qiuqiuzhandou")

				huishou:addTo(self:getView())
				huishou:setPosition(n_pos)
				huishou:addEndCallback(function()
					huishou:removeFromParent()
				end)
			end))

			flyNode:runAction(action)
		end
	end
end

function WorldPeaceMainMediator:initMultiLayer()
	local multiTouchLayer = self._touch

	multiTouchLayer:setTouchMode(cc.EVENT_TOUCH_ALL_AT_ONCE)
	multiTouchLayer:setSwallowsTouches(false)
	multiTouchLayer:setTouchEnabled(true)
	multiTouchLayer:onTouch(handler(self, self.onTouchMultiTouchLayer), true, false)

	local listener = cc.EventListenerMouse:create()

	listener:registerScriptHandler(handler(self, self.mouseMove), cc.Handler.EVENT_MOUSE_MOVE)
	listener:registerScriptHandler(handler(self, self.mouseScroll), cc.Handler.EVENT_MOUSE_SCROLL)
	multiTouchLayer:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, multiTouchLayer)
end

function WorldPeaceMainMediator:onTouchMultiTouchLayer(event)
	if event.name == "began" then
		self:dealOnMultiTouchBegan(event)
	elseif event.name == "moved" then
		self:dealOnMultiTouchMoved(event)
	elseif event.name == "ended" then
		self:dealOnMultiTouchEnded(event)
	end
end

function WorldPeaceMainMediator:getScrollViewPosition()
	return self._scrollView:getInnerContainerPosition()
end

function WorldPeaceMainMediator:setScrollViewPosition(pos, open)
	local border = {
		500,
		500,
		500,
		400
	}
	local targetPos = cc.p(pos.x, pos.y)
	local viewSize = self._scrollView:getContentSize()
	local curSize = self._scrollView:getInnerContainerSize()
	local minX = viewSize.width - curSize.width
	local minY = viewSize.height - curSize.height
	local maxX = 0
	local maxY = 0

	if not open then
		local scale = self._innnerContainer:getScale()

		minX = minX + border[2] * scale
		minY = minY + border[3] * scale
		maxX = -border[1] * scale
		maxY = -border[4] * scale
	end

	targetPos.x = minX > targetPos.x and minX or targetPos.x
	targetPos.y = minY > targetPos.y and minY or targetPos.y
	targetPos.x = maxX < targetPos.x and maxX or targetPos.x
	targetPos.y = maxY < targetPos.y and maxY or targetPos.y

	self._scrollView:setInnerContainerPosition(targetPos)
end

function WorldPeaceMainMediator:getPointById(id, points)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = math.floor(v.x)
			v.y = math.floor(v.y)

			return v
		end
	end

	return nil
end

function WorldPeaceMainMediator:dealOnMultiTouchBegan(event)
	self._touchBeganDistance = -99999
	self._scrollViewPosition = self:getScrollViewPosition()

	for k, v in pairs(event.points) do
		if self:getPointById(v.id, self._touchPoint) == nil then
			self._touchPoint[#self._touchPoint + 1] = v
		end
	end

	if #self._touchPoint > 1 then
		self._canTouchScaleSta = true

		local p1 = self:getPointById(0, self._touchPoint)
		local p2 = self:getPointById(1, self._touchPoint)

		if p2 and p1 then
			self._touchBeganDistance = math.floor(cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y)))
		end
	else
		local p1 = self:getPointById(0, self._touchPoint)

		if p1 then
			-- block empty
		end
	end
end

function WorldPeaceMainMediator:dealOnMultiTouchMoved(event)
	if #self._touchPoint > 1 then
		if self._canTouchScaleSta then
			local p1 = self:getPointById(0, event.points)
			local p2 = self:getPointById(1, event.points)

			if p2 == nil or p1 == nil or self._touchBeganDistance == -99999 then
				return
			end

			local length = math.floor(cc.pGetDistance(cc.p(p1.x, p1.y), cc.p(p2.x, p2.y)))
			local diffLen = length - self._touchBeganDistance

			if math.abs(diffLen) > 15 then
				self:changeCollectionViewSacleInRoom(diffLen, cc.p((p1.x + p2.x) / 2, (p1.y + p2.y) / 2))

				self._touchBeganDistance = length

				self:setPointById(0, self._touchPoint, p1)
				self:setPointById(1, self._touchPoint, p2)
			end
		end
	elseif #self._touchPoint > 0 then
		local pointBegin = self:getPointById(0, self._touchPoint)
		local pointNow = self:getPointById(0, event.points)

		if pointBegin and pointNow and ((pointBegin and pointNow or nil) and cc.pGetDistance(cc.p(pointBegin.x, pointBegin.y), cc.p(pointNow.x, pointNow.y))) > 15 then
			local scrollPos = cc.p(pointNow.x - pointBegin.x + self._scrollViewPosition.x, pointNow.y - pointBegin.y + self._scrollViewPosition.y)

			self:setScrollViewPosition(scrollPos)
		end
	end
end

function WorldPeaceMainMediator:setPointById(id, points, point)
	for k, v in pairs(points) do
		if v.id == id then
			v.x = point.x
			v.y = point.y
		end
	end
end

function WorldPeaceMainMediator:changeCollectionViewSacleInRoom(diffLen, centerWorldPos)
	diffLen = diffLen * 2.5

	local widthAgo = self._innnerContainer:getScale() * 1800
	local scaleNow = (widthAgo + diffLen) / 1800
	local changeScale = scaleNow - self._innnerContainer:getScale()

	if self._collectionViewScale ~= scaleNow then
		self._collectionViewScale = scaleNow

		self:setZoomScale(self._collectionViewScale, centerWorldPos)
	end

	return changeScale
end

function WorldPeaceMainMediator:dealOnMultiTouchEnded(event)
	if #self._touchPoint > 1 and self._canTouchScaleSta then
		self._canTouchScaleSta = false

		local p1 = self:getPointById(0, self._touchPoint)
		local p2 = self:getPointById(1, self._touchPoint)

		self._touchPoint = {}

		if self._touchBeganDistance ~= -99999 then
			-- block empty
		end
	elseif #self._touchPoint > 0 then
		self._mapTouchMove = false

		local pointBegin = self:getPointById(0, self._touchPoint)
		local pointNow = self:getPointById(0, event.points)

		self._touchPoint = {}

		if ((pointBegin and pointNow or nil) and cc.pGetDistance(cc.p(pointBegin.x, pointBegin.y), cc.p(pointNow.x, pointNow.y))) > 15 then
			-- block empty
		else
			self:enterBossRoom(pointNow)
		end
	end

	self._wordPeaceGame:getMemberFactory():markMemeberTransFormDirty()
end

function WorldPeaceMainMediator:enterBossRoom(pointNow)
	if not pointNow then
		return
	end

	local forcusPos = self._touch:convertToWorldSpace(pointNow)
	local pos = self._container:convertToNodeSpace(cc.p(forcusPos.x, forcusPos.y))
	local length_ = 99999999
	local targetBoss
	local bosses = self._wordPeaceGame:getMemberFactory():getMembersPool()

	for k_, v_ in pairs(bosses) do
		if v_:getType() == K_WORLD_MEMBER_TYPE.Boss then
			local targetPos = cc.p(v_:getDisplayNode():getPosition())
			local length = cc.pGetDistance(cc.p(pos.x, pos.y), cc.p(targetPos.x, targetPos.y))

			if length < length_ then
				length_ = length
				targetBoss = v_
			end
		end
	end

	local var_50_0

	if length_ > 130 then
		do return end

		var_50_0 = targetBoss:getDisplayNode()
	end

	local pos = cc.p(var_50_0:getPosition())
	local pos2 = self._innnerContainer:convertToNodeSpace(cc.p(forcusPos.x, forcusPos.y))

	if pointBegin and pointNow then
		distance = cc.pGetDistance(cc.p(pointBegin.x, pointBegin.y), cc.p(pointNow.x, pointNow.y))
	end

	self._container:runAction(cc.MoveBy:create(0.2, cc.p(pos2.x - pos.x, pos2.y - pos.y)))

	local wordPos = self._innnerContainer:convertToWorldSpace(pos)

	self:zoomScaleToCenterByTime(self._maxScale, wordPos, cc.p(self._winSize.width / 2, self._winSize.height / 2 + 60), 0.2, nil, nil, function()
		self:getView():runAction(DelayAction:create(function()
			AreanaNewLoadingModel:getInstance():showAnim(function()
				if DisposableObject:isDisposed(self) then
					return
				end

				local view = self:getInjector():getInstance("WordPeaceBattleView")

				self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
					bossId = targetBoss:getId(),
					closeCallBack = function()
						self._wordPeaceGame:resume()
						self:setZoomScale(self._enterScale)
						self._touch:setTouchEnabled(true)
						self._wordPeaceGame:resumeBallProtectsAction()
						self:getView():fadeTo({
							time = 0.2,
							opacity = 255
						})
					end
				}))
			end, {
				viewName = "WordPeaceBattleView",
				forceShow = true
			})
			self._wordPeaceGame:pause()
			self._touch:setTouchEnabled(false)
		end, 0.03))
		self:getView():fadeTo({
			time = 0.3,
			opacity = 0
		})
	end)
end

function WorldPeaceMainMediator:mouseMove(event)
	self._location = event:getLocation()

	local pos = self._innnerContainer:convertToNodeSpace(cc.p(self._location.x, self._touch:getContentSize().height - self._location.y))
	local pos = cc.p(self._location.x, self._touch:getContentSize().height - self._location.y)
	local nodPos = self:getView():convertToNodeSpace(pos)
end

function WorldPeaceMainMediator:resetAnchor(sender, newArnchor)
	local anchor = sender:getAnchorPoint()
	local size = sender:getContentSize()

	if size.width ~= 0 and size.height ~= 0 then
		size = cc.size(size.width * sender:getScaleX(), size.height * sender:getScaleY())

		local org_x, org_y = sender:getPosition()

		sender:setAnchorPoint(newArnchor)

		local offsetanchor = cc.p(newArnchor.x - anchor.x, newArnchor.y - anchor.y)

		sender:setPosition(org_x + size.width * offsetanchor.x, org_y + size.height * offsetanchor.y)
	end
end

function WorldPeaceMainMediator:zoomScaleToCenterByTime(scale, center, showCenter, time, callfun, callfunTime, endCallfun)
	center = center or self._scrollView:convertToWorldSpace(cc.p(568, 320))
	showCenter = showCenter or center

	local container = self._scrollView:getInnerContainer()
	local curScale = container:getScale()
	local scaleOffset = 0

	if scale and scale > 0 then
		scaleOffset = scale - curScale
	end

	local showOffset = cc.p(showCenter.x - center.x, showCenter.y - center.y)
	local startTime = app.getTime()
	local updateTime = startTime

	self._scrollView:stopActionByTag(1001)

	self._zoomIng = true

	local action = schedule(self._scrollView, function()
		local timeNow = app.getTime()
		local timeEnd = timeNow

		if timeNow - startTime > time then
			timeEnd = startTime + time
		end

		local timeOffset = timeEnd - updateTime

		updateTime = timeEnd

		local timePercent = timeOffset / time

		if callfunTime and timeNow - startTime >= callfunTime then
			if callfun then
				callfun()
			end

			callfun = nil
		end

		if timeNow - startTime >= time then
			self._scrollView:stopActionByTag(1001)

			if callfun then
				callfun()
			end

			callfun = nil

			if endCallfun then
				endCallfun()
			end

			endCallfun = nil
		end

		local moveOffset = cc.p(showOffset.x * timePercent, showOffset.y * timePercent)
		local targetPos = self._scrollView:getInnerContainerPosition()
		local curSize

		if scaleOffset ~= 0 then
			local scale = curScale + scaleOffset * timePercent
			local realScale = math.max(self._minScale, math.min(self._maxScale, scale))

			curScale = scale
			curSize = cc.size(self._containerSize.width * realScale, self._containerSize.height * realScale)

			if curSize.height < self._viewSize.height or curSize.width < self._viewSize.width then
				return
			end

			self._zoomIng = true

			local oldCenter = container:convertToNodeSpace(center)

			container:setScale(realScale)
			self._scrollView:setInnerContainerSize(curSize)

			local newCenter = container:convertToWorldSpace(oldCenter)
			local offset = cc.pSub(center, newCenter)
			local newOffset = cc.pAdd(moveOffset, offset)

			center = cc.pAdd(center, moveOffset)
			targetPos = cc.pAdd(self._scrollView:getInnerContainerPosition(), newOffset)
		else
			self._zoomIng = true
			curSize = cc.size(self._containerSize.width, self._containerSize.height)
			center = cc.pAdd(center, moveOffset)
			targetPos = cc.pAdd(targetPos, moveOffset)
		end

		self:setScrollViewPosition(targetPos)

		self._zoomIng = false
	end, 0)

	action:setTag(1001)
end

function WorldPeaceMainMediator:zoomByAction(scale, center, time)
	local container = self._innnerContainer

	center = center or self._scrollView:convertToWorldSpace(cc.p(568, 320))

	if scale == container:getScale() then
		return
	end

	local curScale = container:getScale()
	local scaleOffset = scale - curScale
	local startTime = app.getTime()

	self._view:stopActionByTag(1001)

	local action = schedule(self._view, function()
		local timeOffset = app.getTime() - startTime
		local timePercent = timeOffset / time

		timePercent = timePercent > 1 and 1 or timePercent

		local targetScale = curScale + scaleOffset * timePercent

		self:setZoomScale(targetScale, center)

		if timePercent >= 1 then
			self._view:stopActionByTag(1001)
		end
	end, 0)

	action:setTag(1001)
end

function WorldPeaceMainMediator:setZoomScale(scale, center)
	if scale < 1.8 then
		self._wordPeaceGame:getMemberFactory():ShowMidSimpleDisplay()
	elseif scale > 2.5 then
		self._wordPeaceGame:getMemberFactory():ShowAllDisplay()
	else
		self._wordPeaceGame:getMemberFactory():ShowSimpleDisplay()
	end

	local container = self._innnerContainer

	center = center or self:getView():convertToWorldSpace(cc.p(568, 320))

	if scale == container:getScale() then
		return
	end

	local realScale = math.max(self._minScale, math.min(self._maxScale, scale))
	local curSize = cc.size(self._containerSize.width * realScale, self._containerSize.height * realScale)

	if curSize.height < self._viewSize.height or curSize.width < self._viewSize.height then
		return
	end

	self._zoomIng = true

	local oldCenter = container:convertToNodeSpace(center)

	container:setScale(realScale)
	self._scrollView:setInnerContainerSize(curSize)

	local newCenter = container:convertToWorldSpace(oldCenter)
	local offset = cc.pSub(center, newCenter)
	local targetPos = cc.pAdd(self._scrollView:getInnerContainerPosition(), offset)

	self:setScrollViewPosition(targetPos)

	self._zoomIng = false

	self._wordPeaceGame:getMemberFactory():markMemeberTransFormDirty()
end

function WorldPeaceMainMediator:mouseScroll(event)
	if not self._location then
		return
	end

	local wordPos = cc.p(self._location.x, self._touch:getContentSize().height - self._location.y)

	self:setZoomScale(self._innnerContainer:getScale() - event:getScrollY() * 0.02, wordPos)
end

function WorldPeaceMainMediator:onClickBack()
	self:dispatch(Event:new(EVT_WORLDPESCE_MAIN_CLOSE))
	self._worldPeaceSystem:quitBattle()
	self:dismiss()
end

function WorldPeaceMainMediator:onClickRule()
	local status = self._worldPeaceSystem:getStatus()

	self._worldPeaceSystem:tryEnterRankView()
end

function WorldPeaceMainMediator:startBattleTimer()
	local timeStr = ""
	local timer = ""
	local timeList = self._worldPeaceSystem:getTimeList()

	self._oldStatus = self._worldPeaceSystem:getStatus()

	local format = Strings:get("Common_Time_07")

	local function update()
		local curTime = self._gameServerAgent:remoteTimestamp()
		local status = self._worldPeaceSystem:getStatus()

		if self._oldStatus ~= status then
			timeList = self._worldPeaceSystem:getTimeList()
			self._oldStatus = status
			self._needCheckView = true
		end

		if status == WPStatus.kBattle then
			local remainTime = math.max(timeList.battleStopTime - curTime, 0)

			timeStr = Strings:get("ClubMapBoss_Countdown_Finish")
			timer = TimeUtil:formatTime(format, remainTime)
		elseif status == WPStatus.kBattleRest or status == WPStatus.kPrepare then
			local remainTime = math.max(timeList.battleStartTime - curTime, 0)

			timeStr = Strings:get("ClubMapBoss_Countdown_Start")
			timer = TimeUtil:formatTime(format, remainTime)

			if self._needCheckView then
				self:checkShowTipsView()
			end
		elseif status == WPStatus.kResultShow then
			timeStr = Strings:get("ClubMapBoss_Result_Pause2")

			if self._needCheckView then
				self:checkShowTipsView()
			end
		elseif status == WPStatus.kApply then
			if self._battleTime then
				self._battleTime:stop()

				self._battleTime = nil
			end

			self:onClickBack()
		end

		self:updateLogic()

		local txt = "<font face='${fontName}' size='20' color='#FFFFFF'>" .. timeStr .. "</font>" .. "<font face='${fontName}' size='20' color='#3CFF00'>" .. timer .. "</font>"
		local t = TextTemplate:new(txt)

		txt = t:stringify({
			fontName = TTF_FONT_FZYH_M
		})

		self._timeText:setString(txt)
	end

	self._battleTime = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

function WorldPeaceMainMediator:checkShowGuideView()
	local rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()
	local value = cc.UserDefault:getInstance():getBoolForKey("WordPeaceGuide_battle" .. rid, false)

	if not value then
		performWithDelay(self:getView(), function()
			local view = self:getInjector():getInstance("WordPeaceGuideView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				showType = "battle"
			}))
		end, 0.2)
		cc.UserDefault:getInstance():setBoolForKey("WordPeaceGuide_battle" .. rid, true)
	end
end

function WorldPeaceMainMediator:onClickGuide()
	local view = self:getInjector():getInstance("WordPeaceGuideView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function WorldPeaceMainMediator:checkShowTipsView()
	self._needCheckView = false

	local status = self._worldPeaceSystem:getStatus()

	if status ~= WPStatus.kBattle then
		local popupDelegate = {}

		function popupDelegate:willClose(sender)
			print("csdkcdnskcndskcndscndks")
		end

		local view = self:getInjector():getInstance("WorldPeaceTipsView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}, popupDelegate))
	end
end

function WorldPeaceMainMediator:setupView()
	local infopanel = self:getView():getChildByFullName("infopanel")
	local node = infopanel:getChildByFullName("Node")
	local arrow = infopanel:getChildByFullName("arrow")
	local arrow1 = infopanel:getChildByFullName("arrow1")
	local line = infopanel:getChildByFullName("line")
	local guide = self:getView():getChildByFullName("guide")

	guide:setVisible(true)
	arrow1:setVisible(false)
	line:setVisible(false)
	arrow:addClickEventListener(function()
		arrow1:setVisible(true)
		line:setVisible(true)
		node:setVisible(false)
		arrow:setVisible(false)
	end)
	arrow1:addClickEventListener(function()
		arrow1:setVisible(false)
		line:setVisible(false)
		node:setVisible(true)
		arrow:setVisible(true)
	end)

	local btnGroup = node:getChildByName("btnGroup")
	local cursor = btnGroup:getChildByName("cursor")
	local cursor1 = btnGroup:getChildByName("cursor_0")

	self._renwu = node:getChildByName("Node_renwu")
	self._jifen = node:getChildByName("Node_jifen")

	cursor1:setVisible(false)
	self._jifen:setVisible(false)

	local t2 = btnGroup:getChildByName("t1")
	local t1 = btnGroup:getChildByName("t2")

	local function clickFunc()
		if self._renwu:isVisible() then
			self._renwu:setVisible(false)
			self._jifen:setVisible(true)
			cursor1:setVisible(true)
			cursor:setVisible(false)
			setTextWithFontStyle(t1, "FontTipsTextHei")
			setTextWithFontStyle(t2, "FontTipsText")
		else
			self._renwu:setVisible(true)
			self._jifen:setVisible(false)
			cursor1:setVisible(false)
			cursor:setVisible(true)
			setTextWithFontStyle(t2, "FontTipsTextHei")
			setTextWithFontStyle(t1, "FontTipsText")
		end
	end

	btnGroup:addClickEventListener(function()
		clickFunc()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end)
	clickFunc()

	local timeText = self:getView():getChildByFullName("infopanel.Node.Node_jifen.time")

	timeText:setString("")

	self._timeText = ccui.RichText:createWithXML("", {})

	self._timeText:setAnchorPoint(timeText:getAnchorPoint())
	self._timeText:setPosition(cc.p(timeText:getPosition()))
	self._timeText:addTo(timeText:getParent())
	node:getChildByName("bg"):addClickEventListener(function()
		if self._renwu:isVisible() then
			self._worldPeaceSystem:tryEnterRankView({
				tabType = viewRankType.kTask
			})
		else
			self._worldPeaceSystem:tryEnterRankView({
				tabType = viewRankType.kClub
			})
		end
	end)
	self:updateTask()
end

function WorldPeaceMainMediator:updateTask()
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local task = playerInfo:getTask()
	local title = self._renwu:getChildByName("title")
	local desc = self._renwu:getChildByName("desc")
	local percent = self._renwu:getChildByName("percent")
	local cnt = self._renwu:getChildByName("cnt")
	local bg1_0_0_0 = self._renwu:getChildByName("bg1_0_0_0")
	local guang = self._renwu:getChildByName("guang")
	local node_reward = self._renwu:getChildByName("Node_reward")
	local curTask = task[1]

	if curTask then
		if self._curTaskId ~= curTask.taskId then
			self._curTaskId = curTask.taskId

			local config = ConfigReader:getRecordById("ClubMapTask", curTask.taskId)

			percent:setVisible(true)
			bg1_0_0_0:setVisible(true)
			node_reward:removeAllChildren()

			local rewards = ConfigReader:getRecordById("Reward", config.reward).Content

			for i = 1, #rewards do
				local reward = rewards[i]

				if reward then
					local function func()
						local icon = IconFactory:createRewardIcon(reward, {
							showAmount = true,
							isWidget = true
						})

						IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
							needDelay = true
						})
						icon:setScaleNotCascade(0.49)
						icon:addTo(node_reward):posite((i - 1) * 65 + 52.5, 72)
					end

					node_reward:runAction(DelayAction:create(func, (i - 1) * 0.1))
				end
			end

			title:setString(Strings:get(config.Name or ""))
			desc:setString(Strings:get(config.Desc or ""))
			guang:setTouchEnabled(true)
			guang:addClickEventListener(function()
				self._worldPeaceSystem:requestTaskReward({
					taskId = self._curTaskId
				}, function(response)
					local rewards = response.data.rewards

					if rewards then
						local view = self:getInjector():getInstance("getRewardView")

						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 200
						}, {
							rewards = rewards
						}))
						self:updateTask()
					end
				end)
			end)
		end

		if curTask.taskStatus == 1 then
			local action = cc.RepeatForever:create(FadeAction:create(0.5))

			guang:runAction(action)
			guang:setVisible(true)
		else
			guang:setVisible(false)
		end

		cnt:setString(curTask.current .. "/" .. curTask.target)
		percent:setContentSize(cc.size(251.5 * curTask.percent, 20))
	else
		title:setString("")
		desc:setString(Strings:get("ClubMapBoss_renwu_notip"))
		cnt:setString("")
		percent:setVisible(false)
		bg1_0_0_0:setVisible(false)
		guang:setVisible(false)
		node_reward:removeAllChildren()
	end
end

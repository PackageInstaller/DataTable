-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceBattleMediator.lua

WordPeaceBattleMediator = class("WordPeaceBattleMediator", DmAreaViewMediator, _M)

WordPeaceBattleMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WordPeaceBattleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function WordPeaceBattleMediator:initialize()
	super.initialize(self)
end

function WordPeaceBattleMediator:dispose()
	super.dispose(self)

	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end

	if self._worldPeaceHandWidget then
		self._worldPeaceHandWidget:dispose()

		self._worldPeaceHandWidget = nil
	end

	if self._wordPeaceNotic then
		self._wordPeaceNotic:dispose()

		self._wordPeaceNotic = nil
	end

	if self._worldBossTimer then
		self._worldBossTimer:stop()

		self._worldBossTimer = nil
	end

	self._wordPeaceGame:clearBattleField()
	self._worldPeaceSystem:getBattlefield():setPlayerLog({})
end

function WordPeaceBattleMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_BATTLEFEILD_REFRESH, self, self.refreshBattleField)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_PLAYER_REFRESH, self, self.updateBottomView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_START_ZHANLING_REFRESH, self, self.starZhanling)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUBBOSS_END_ZHANEND_REFRESH, self, self.endZhanling)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORDPEACE_COMMON_REFRESH, self, self.updateCommondView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ENTER_BACKGROUND, self, self.backGround)
end

function WordPeaceBattleMediator:backGround()
	self:onClickBack()
	self._worldPeaceSystem:dispatch(Event:new(EVT_WORDPEACE_BACK_REFRESH, {}))
end

function WordPeaceBattleMediator:setupChatFlowWidget()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local chatFLowNode = self:getView():getChildByName("chat_flow_node")
	local wordPeaceNotic = WordPeaceNotic:new(chatFLowNode)

	self:getInjector():injectInto(wordPeaceNotic)
	wordPeaceNotic:setGroupMap(battleField:getGroupNameMap())

	self._wordPeaceNotic = wordPeaceNotic

	chatFLowNode:setLocalZOrder(10)
	wordPeaceNotic:start()
end

function WordPeaceBattleMediator:runSupportAnim()
	self._btnAnimRun = true

	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapButtonCD", "content")

	self._clickAnim:setPlaySpeed(5 * clubBoss_ClickLimit)
	self._clickAnim:setVisible(true)
	self._clickAnim:gotoAndPlay(1)
	self._clickAnim:addEndCallback(function(cid, mc)
		self._btnAnimRun = false

		self._clickAnim:setVisible(false)
		self._clickAnim:stop()
	end)

	self._huishouAnimRun = true

	local clubBoss_ClickLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapButtonCD", "content")

	self._huishouAnim:setPlaySpeed(5 * clubBoss_ClickLimit)
	self._huishouAnim:setVisible(true)
	self._huishouAnim:gotoAndPlay(1)
	self._huishouAnim:addEndCallback(function(cid, mc)
		self._huishouAnimRun = false

		self._huishouAnim:setVisible(false)
		self._huishouAnim:stop()
	end)
end

function WordPeaceBattleMediator:updateCommondView()
	local battlefeild = self._worldPeaceSystem:getBattlefield()

	self._worldPeaceCommondWidget:updateInfo(battlefeild)
end

function WordPeaceBattleMediator:setupCommondView()
	local commondnode = self:getView():getChildByName("commond")
	local worldPeaceCommondWidget = WorldPeaceCommondWidget:new(commondnode, self, true)

	self:getInjector():injectInto(worldPeaceCommondWidget)

	self._worldPeaceCommondWidget = worldPeaceCommondWidget

	commondnode:setLocalZOrder(10)
	self._worldPeaceCommondWidget:setDelegate(self)
	self:updateCommondView()
end

function WordPeaceBattleMediator:dragMoved(commond, sender, pt)
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

function WordPeaceBattleMediator:backTag(commond, sender, pt)
	self._worldPeaceSystem:sendBossTag({
		bossId = "",
		tag = sender.tag
	}, true, function(response)
		if response.resCode == 0 then
			sender:setPosition(sender.orgPos or sender:getPosition())
		end
	end)
end

function WordPeaceBattleMediator:dragEnded(commond, sender, pt, call, noDrag)
	if noDrag then
		local targetBoss = self._wordPeaceGame:getMemberFactory():getMemberById(self._bossId)
		local var_14_0 = {}

		var_14_0.bossId = back or self._bossId
		var_14_0.tag = sender.tag

		self._worldPeaceSystem:sendBossTag(var_14_0, true, function(response)
			local battlefeild = self._worldPeaceSystem:getBattlefield()

			sender:setPosition(sender.orgPos or sender:getPosition())
			targetBoss:updateInfo(battlefeild:getBossById(targetBoss:getId()))
			call()
		end)

		return
	end

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

function WordPeaceBattleMediator:refreshBattleField(data)
	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)

	self._wordPeaceGame:clearQueueCommond()
	self._wordPeaceGame:createBattleFieldByBoss(bossData, cc.p(568, 380), {
		1,
		0.7
	})

	local dieQueques = battleField:getDieQueques()

	self._wordPeaceGame:createBattleShadows(dieQueques, self._bossId)

	local playerInfo = self._worldPeaceSystem:getMainPlayer()

	self._worldPeaceHandWidget:updateInfo(playerInfo)

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

	for k, v in pairs(battleField:getBossChangeList()) do
		self._wordPeaceNotic:addMessage(v)
	end

	self._refreshLogSwitch = self._refreshLogSwitch or 0

	if self._refreshLogSwitch % 4 == 0 then
		self:refreshLog()
		self:refreshPlayerLog(battleField:getPlayerLog())
	end

	self._refreshLogSwitch = self._refreshLogSwitch + 1

	self:refreshOprateBtn()
	self:updateHurtPanel()
end

function WordPeaceBattleMediator:backToCard(teamKey)
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
			local playerInfo = self._worldPeaceSystem:getMainPlayer()
			local gInfo = playerInfo:getGroupInfo()

			flyNode:getChildByName("progress"):setVisible(false)
			flyNode:getChildByName("hudun"):setVisible(false)

			for i = 1, 5 do
				flyNode:getChildByName("star" .. i):setVisible(false)
			end

			flyNode:getChildByName("posname"):setVisible(false)

			local CampFrameRes = {
				"CB_di_hong.png",
				"CB_di_huang.png",
				"CB_di_lan.png"
			}
			local campFrame = flyNode:getChildByName("kuang")

			if gInfo then
				campFrame:loadTexture(CampFrameRes[gInfo.gIndex], 1)
			end

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

			local name = flyNode:getChildByFullName("nameroot")

			name:setVisible(false)

			local moveTo = cc.MoveTo:create(0.5, n_pos)
			local scaleTo = cc.ScaleTo:create(0.5, 0.3)
			local goaback = cc.Spawn:create(scaleTo, moveTo)
			local action = cc.Sequence:create(goaback, cc.CallFunc:create(function()
				flyNode:removeFromParent()

				local huishou = cc.MovieClip:create("huishou_qiuqiuzhandou")

				huishou:addTo(self:getView())
				huishou:setPosition(n_pos)
				huishou:setScale(1.5)
				huishou:addEndCallback(function()
					huishou:removeFromParent()
				end)
				self:flyEnd()
				huishou:addCallbackAtFrame(10, function()
					return
				end)
			end))

			flyNode:runAction(action)
		end
	end
end

function WordPeaceBattleMediator:flyEnd()
	return
end

function WordPeaceBattleMediator:prepareBattle(data)
	self._wordPeaceGame = WordPeaceGame:new()

	self._wordPeaceGame:setDisplayStage(self:getView())
	self._wordPeaceGame:setDisplayMode(K_RENDER_DISPLAYMODE.ALL)
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
end

function WordPeaceBattleMediator:endZhanling(data)
	local data = data and data:getData()
	local colorMap = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}
	local bossName = data.bossName
	local level = data.level
	local campName = data.campName
	local color = data.color
	local bossId = data.bossId

	if bossId ~= self._bossId then
		return
	end

	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(bossId)
	local gIndex = data.gIndex
	local ownCamp = data.ownCamp
	local ownColor
	local endCallBack = data.callback

	for k_, v_ in pairs(bossData:getGroupName()) do
		if ownCamp == v_.gId then
			ownColor = colorMap[v_.gIndex]
		end
	end

	local node = cc.CSLoader:createNode("asset/ui/WordPeaceEndTips.csb")

	node:addTo(self:getView())
	node:center(self:getView():getContentSize())
	node:setLocalZOrder(100)
	node:setOpacity(0)

	local bg = node:getChildByName("bg")

	bg:ignoreContentAdaptWithSize(true)

	local heart = node:getChildByName("heart")

	heart:setVisible(false)

	local hongProgress = heart:getChildByName("hong")
	local huangProgress = heart:getChildByName("huang")
	local lanProgress = heart:getChildByName("lan")

	hongProgress:setContentSize(cc.size(73, 0))
	huangProgress:setContentSize(cc.size(73, 0))
	lanProgress:setContentSize(cc.size(73, 0))

	local progressGroup = {
		hongProgress,
		huangProgress,
		lanProgress
	}
	local richText = ccui.RichText:createWithXML("", {})

	richText:addTo(bg):center(bg:getContentSize())

	local richText2 = ccui.RichText:createWithXML("", {})

	richText2:addTo(bg):center(bg:getContentSize())
	heart:getChildByName("frame"):setLocalZOrder(100)
	bg:loadTexture("CB_bg_jiesuan4.png", 1)
	richText:setString(Strings:get("ClubMapBoss_occupybridge", {
		size = 34,
		clubname = campName,
		fontName = TTF_FONT_FZYH_M,
		color = ownColor
	}))
	richText:center(bg:getContentSize())

	local function ownJudgeStart()
		bg:loadTexture("CB_bg_jiesuan2.png", 1)
		richText:setString(Strings:get("ClubMapBoss_judge", {
			size = 34,
			num = level,
			bossname = bossName,
			fontName = TTF_FONT_FZYH_M
		}))
		richText:center(bg:getContentSize())
		heart:setVisible(true)

		local hurtMap = bossData:getGHurtMap()

		for k, v in pairs(progressGroup) do
			v:setVisible(false)
		end

		local index = 1
		local prepercent = 0
		local order = 10

		for k, v in pairs(hurtMap or {}) do
			for k_, v_ in pairs(bossData:getGroupName()) do
				if v_.gId == k then
					index = v_.gIndex
				end
			end

			progressGroup[index]:setVisible(true)

			local percent = v / bossData:getMhp()

			order = order - 1

			progressGroup[index]:setContentSize(cc.size(73, 61 * (percent + prepercent)))
			progressGroup[index]:setLocalZOrder(order)

			prepercent = percent
		end
	end

	local function ownJudgeEnd()
		bg:loadTexture("CB_bg_jiesuan3.png", 1)
		richText:setString("")

		for k, v in pairs(progressGroup) do
			if k == gIndex then
				v:setVisible(true)
				v:setContentSize(cc.size(73, 61))
			else
				v:setVisible(false)
			end
		end

		heart:setVisible(true)
		heart:posite(0, -38)

		local guangImg1 = ccui.ImageView:create("CB_img_sucaiguang.png", 1)

		guangImg1:addTo(bg):center(bg:getContentSize())

		local guangImg2 = ccui.ImageView:create("CB_img_sucaiguang2.png", 1)

		guangImg2:addTo(bg):center(bg:getContentSize()):offset(0, 0)
		guangImg1:setScale(0.1)
		guangImg1:setOpacity(0)
		guangImg1:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 1.5)), cc.FadeOut:create(0.2)))
		guangImg2:setScale(0.1)
		guangImg2:setOpacity(0)
		guangImg2:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 1.5)), cc.DelayTime:create(0.2), cc.FadeOut:create(0.2)))
	end

	local function ownSuccess()
		bg:loadTexture("CB_bg_jiesuan5.png", 1)
		richText:setString(Strings:get("ClubMapBoss_CaptureBullet_3", {
			size = 34,
			color = color,
			camp = campName,
			fontName = TTF_FONT_FZYH_M
		}))
		richText:center(bg:getContentSize())
		richText:offset(0, 20)
		richText2:setString(Strings:get("ClubMapBoss_CaptureBullet_4", {
			size = 30,
			bossname = bossName,
			num = level,
			fontName = TTF_FONT_FZYH_M,
			camp = campName,
			color = color
		}))
		richText2:center(bg:getContentSize())
		richText2:offset(0, -20)
		heart:setVisible(false)
	end

	node:runAction(cc.Sequence:create(cc.FadeIn:create(0.1), cc.DelayTime:create(1), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
		ownJudgeStart()
	end), cc.FadeIn:create(0.3), cc.CallFunc:create(function()
		heart:runAction(cc.RepeatForever:create(BreatheAction:create(0.25, 1.1)))
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		heart:stopAllActions()
		heart:setOpacity(255)
		heart:setScale(1)
		heart:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			ownJudgeEnd()
		end), cc.Spawn:create(cc.FadeIn:create(0.2), cc.ScaleTo:create(0.2, 3)), cc.ScaleTo:create(0.1, 0.9), cc.ScaleTo:create(0.1, 1), cc.DelayTime:create(1), cc.FadeOut:create(0.2)))
	end), cc.DelayTime:create(1.5), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		ownSuccess()
	end), cc.FadeIn:create(0.2), cc.DelayTime:create(1), cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		node:removeFromParent()

		if endCallBack then
			endCallBack()
		end
	end)))
end

function WordPeaceBattleMediator:starZhanling(data)
	local data = data and data:getData()
	local campName = data.campName
	local color = data.color
	local bossId = data.bossId
	local endCallBack = data.callback

	if bossId ~= self._bossId then
		return
	end

	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(bossId)
	local nickName = ""
	local dTeams = bossData:getDTeams()

	for k, v in pairs(dTeams) do
		if v:getOrder() == 1 then
			nickName = v:getNickName()
		end
	end

	local node = cc.CSLoader:createNode("asset/ui/WordPeaceStartTips.csb")

	node:addTo(self:getView())
	node:center(self:getView():getContentSize())
	node:setLocalZOrder(100)
	node:setOpacity(0)

	local bg = node:getChildByName("bg")

	bg:ignoreContentAdaptWithSize(true)
	bg:loadTexture("CB_bg_jiesuan4.png", 1)

	local richText = ccui.RichText:createWithXML(Strings:get("ClubMapBoss_finalattack", {
		size = 34,
		color = color,
		playername = campName,
		fontName = TTF_FONT_FZYH_M
	}), {})
	local titleLabel = node:getChildByFullName("bg.title")

	titleLabel:setString("")

	local titleLabel = node:getChildByFullName("bg.title_0")

	titleLabel:setString("")
	richText:center(bg:getContentSize())
	richText:addTo(bg)

	local fadeIn = cc.FadeIn:create(0.3)
	local delay = cc.DelayTime:create(1)
	local fadeOut = cc.FadeOut:create(0.3)
	local action = cc.Sequence:create(fadeIn, delay, fadeOut, cc.CallFunc:create(function()
		node:removeFromParent()

		if endCallBack then
			endCallBack()
		end
	end))

	node:runAction(action)
end

function WordPeaceBattleMediator:onSupportByDray()
	self:onSupport()
end

function WordPeaceBattleMediator:enterWithData(data)
	self._bossId = data.bossId
	self._closeCallBack = data.closeCallBack

	self:setupTopInfoWidget()
	self:setupView()
	self:initBattleLayer()
	self:prepareBattle()
	self:setUpBottomView()
	self:setupCommondView()
	self:startMainLoop()
	self:setupChatFlowWidget()
	self:initCoroutines()

	local btngo = self._view:getChildByName("btngo")

	btngo:setTouchEnabled(true)
	btngo:addClickEventListener(function()
		self:onSupport()
	end)

	local huishou = self._view:getChildByName("btngo_0")

	huishou:setTouchEnabled(true)
	huishou:addClickEventListener(function()
		self:onHuiShou()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end)

	local infoBtn = self._view:getChildByName("btngo_0_0")

	infoBtn:setTouchEnabled(true)
	infoBtn:addClickEventListener(function()
		self:onInfoBtn()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end)

	if not self._clickAnim then
		self._clickAnim = cc.MovieClip:create("anniu_djs_qiuqiuanniu")

		self._clickAnim:addTo(btngo, 999):center(btngo:getContentSize()):offset(0, -4)
	end

	self._clickAnim:setVisible(false)

	if not self._huishouAnim then
		self._huishouAnim = cc.MovieClip:create("anniu_djs_qiuqiuanniu")

		self._huishouAnim:addTo(huishou, 999):center(huishou:getContentSize()):offset(0, 0)
		self._huishouAnim:setScale(0.58)
	end

	self._huishouAnim:setVisible(false)
	huishou:setVisible(false)

	local cnt1 = self:getView():getChildByFullName("infopanel.infopanel.cnt1")
	local cnt2 = self:getView():getChildByFullName("infopanel.infopanel.cnt2")

	if cnt1 then
		cnt1:setString(Strings:get("ClubMapBoss_Log_Rank") .. 0)
	end

	if cnt2 then
		cnt2:setString(Strings:get("ClubMapBoss_Log_Harm") .. math.floor(0))
	end

	local bg = self:getView():getChildByFullName("bg")

	bg:setOpacity(0)
	bg:fadeTo({
		time = 0.2,
		opacity = 255
	})

	local info = self:getView():getChildByFullName("infopanel.infopanel")

	if info then
		info.orgSize = info:getContentSize()

		local list = self:getView():getChildByFullName("infopanel.infopanel.noticinfo")

		list.orgSize = list:getContentSize()

		local listlog = self:getView():getChildByFullName("infopanel.infopanel.noticinfo_log")

		listlog.orgSize = listlog:getContentSize()

		info:setTouchEnabled(true)
		info:addClickEventListener(function()
			if info.running then
				return
			end

			info.isopen = info.isopen or false
			info.isopen = not info.isopen

			self:openInfoPanel(info.isopen)
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		end)
		info:setClickEffectUnVisible(true)
	end
end

function WordPeaceBattleMediator:handleBgDisplayMode()
	CustomShaderUtils.setBlurToNode(self:getView():getChildByName("bg"), 6, 6)
end

function WordPeaceBattleMediator:openInfoPanel(open, hideAnim)
	local descWidth = open and 0 or 0

	for k, v in pairs((not self._logItems or nil) and {}) do
		if not tolua.isnull(v) then
			local rich = v:getChildByName("richText")

			rich:renderContent(v.orgSize.width + descWidth, 0, true)
			v:setContentSize(cc.size(v.orgSize.width + descWidth, rich:getContentSize().height + 10))

			if hideAnim then
				v:setOpacity(0)
				v:fadeTo({
					time = 0.8,
					opacity = 255
				})
			else
				v:setOpacity(0)
				v:fadeTo({
					time = 0.8,
					opacity = 255
				})
			end
		else
			table.remove(self._logItems, k)
		end
	end

	local list = self:getView():getChildByFullName("infopanel.infopanel.noticinfo")

	list:requestDoLayout()

	local listlog = self:getView():getChildByFullName("infopanel.infopanel.noticinfo_log")

	listlog:requestDoLayout()
	ccui.ScrollView.onScroll(list, function(event)
		self._collTime = true

		self:getView():stopAllActions()
		performWithDelay(self:getView(), function()
			self._collTime = false
		end, 5)
	end)
	ccui.ScrollView.onScroll(listlog, function(event)
		self._collTime = true

		self:getView():stopAllActions()
		performWithDelay(self:getView(), function()
			self._collTime = false
		end, 5)
	end)

	local info = self:getView():getChildByFullName("infopanel.infopanel")

	info.running = true

	info:stopAllActions()

	local orgsize = info.orgSize
	local action = ContentSizeTo:create(0.1, cc.size(orgsize.width + descWidth, orgsize.height))
	local action = cc.Sequence:create(action, cc.CallFunc:create(function()
		info.running = false

		list:jumpToBottom()
	end))

	info:runAction(action)

	local orgsize = list.orgSize

	list:stopAllActions()

	local action = ContentSizeTo:create(0.1, cc.size(orgsize.width + descWidth, orgsize.height))
	local action = cc.Sequence:create(action, cc.CallFunc:create(function()
		list:jumpToBottom()
	end))

	list:runAction(action)

	local orgsize = info.orgSize
	local action = ContentSizeTo:create(0.1, cc.size(orgsize.width + descWidth, orgsize.height))
	local action = cc.Sequence:create(action, cc.CallFunc:create(function()
		info.running = false

		listlog:jumpToBottom()
	end))

	info:runAction(action)

	local orgsize = listlog.orgSize

	listlog:stopAllActions()

	local action = ContentSizeTo:create(0.1, cc.size(orgsize.width + descWidth, orgsize.height))
	local action = cc.Sequence:create(action, cc.CallFunc:create(function()
		listlog:jumpToBottom()
	end))

	listlog:runAction(action)

	self._isOpenInfo = open

	if hideAnim then
		list:jumpToBottom()
		listlog:jumpToBottom()
	end
end

function WordPeaceBattleMediator:refreshPlayerLog(logs)
	local itemcell = self:getView():getChildByFullName("infopanel.infopanel.item_log")
	local listView = self:getView():getChildByFullName("infopanel.infopanel.noticinfo_log")
	local info = self:getView():getChildByFullName("infopanel.infopanel")

	if DisposableObject:isDisposed(self) then
		return
	end

	local diffLogs = logs

	self._logItems = self._logItems or {}

	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local groupNameMap = battleField:getGroupNameMap()
	local color = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}
	local player = self._developSystem:getPlayer()
	local mRid = player:getRid()

	listView:setScrollBarEnabled(false)

	for k, v in pairs(diffLogs or {}) do
		local bossData = battleField:getBossById(v.bossId)
		local heroCfg = ConfigReader:getRecordById("HeroBase", bossData:getConfig().Hero)
		local gorupInfo = playerInfo:getGroupInfo()
		local richText, newCamp

		for k_, v_ in pairs(groupNameMap) do
			if v.campId == v_.gId then
				gIndex = v_.gIndex
				newCamp = v_.gName
			end
		end

		local gIndex = 1

		for k_, v_ in pairs(groupNameMap) do
			if v.params.camp and v.params.camp == v_.gId then
				gIndex = v_.gIndex
			end
		end

		local color = color[gIndex]
		local hurt
		local player
		local damage
		local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
		local remoteTimestamp = gameServerAgent:remoteTimestamp()
		local time = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", remoteTimestamp)
		local strformat = Strings:get("ClubMapBoss_Report" .. v.type, {
			fontSize = 16,
			fontName = TTF_FONT_FZYH_M,
			time = time,
			camp = campName,
			bossname = Strings:get(heroCfg.Name),
			num = bossData:getLv(),
			color = color,
			damage = (v.params and v.params.damage or nil) and math.floor(v.params.damage),
			hurt = (v.params and v.params.hurt or nil) and math.floor(v.params.hurt),
			player = (v.params and v.params.player or nil) and v.params.player
		})
		local widthOffset = self._isOpenInfo and 400 or 0

		self._syncLoadLogQueque[#self._syncLoadLogQueque + 1] = {
			str = strformat,
			listview = listView,
			itemcell = itemcell,
			widthOffset = widthOffset
		}
	end
end

function WordPeaceBattleMediator:updateHurtPanel(message)
	local boss = self._worldPeaceSystem:getBattlefield():getBossById(self._bossId)
	local hurtMaps = boss:getGHurtMap()
	local message = {}

	for k, v in pairs(hurtMaps) do
		message[#message + 1] = {
			gId = k,
			hurt = v
		}
	end

	table.sort(message, function(a, b)
		return a.hurt > b.hurt
	end)

	local battleField = self._worldPeaceSystem:getBattlefield()
	local groupNameMap = battleField:getGroupNameMap()
	local campRes = {
		"CB_img_zhenying_hong.png",
		"CB_img_zhenying_huang.png",
		"CB_img_zhenying_lan.png"
	}
	local progressRes = {
		"CB_sc9_jindu2_red.png",
		"CB_sc9_jindu2_yellow.png",
		"CB_sc9_jindu2_blue.png"
	}
	local sortMap = {}

	for k, v in pairs(groupNameMap) do
		sortMap[k] = v
	end

	for k, v in pairs(sortMap) do
		local rank, hurt

		for k_, v_ in pairs(message) do
			if v_.gId == v.gId then
				rank = k_
				hurt = v_.hurt
			end
		end

		if rank then
			v.rank = rank
			v.hurt = hurt
		else
			v.rank = 100
			v.hurt = 0
		end
	end

	table.sort(sortMap, function(a, b)
		return a.rank < b.rank
	end)

	for k, v in pairs(sortMap) do
		local icon = self:getView():getChildByFullName("infopanel.infopanel.node" .. k .. ".icon")
		local value = self:getView():getChildByFullName("infopanel.infopanel.node" .. k .. ".value")
		local percent = self:getView():getChildByFullName("infopanel.infopanel.node" .. k .. ".percent")

		icon:loadTexture(campRes[v.gIndex], 1)
		percent:loadTexture(progressRes[v.gIndex], 1)
		value:setString(math.floor(v.hurt))

		local per = v.hurt / boss:getMhp()

		percent:runAction(ContentSizeTo:create(0.2, cc.size(156 * per, 16)))
	end
end

function WordPeaceBattleMediator:refreshLog()
	local itemcell = self:getView():getChildByFullName("infopanel.infopanel.item")
	local listView = self:getView():getChildByFullName("infopanel.infopanel.noticinfo")
	local info = self:getView():getChildByFullName("infopanel.infopanel")
	local cnt1 = self:getView():getChildByFullName("infopanel.infopanel.cnt1")
	local cnt2 = self:getView():getChildByFullName("infopanel.infopanel.cnt2")

	self._worldPeaceSystem:chooseBoss({
		bossId = self._bossId
	}, false, function(response)
		if response.data then
			if DisposableObject:isDisposed(self) then
				return
			end

			self._logs = self._logs or {}

			local hurtArray = {}

			for k, v in pairs(response.data.playersHurt or {}) do
				hurtArray[#hurtArray + 1] = {
					rid = k,
					hurt = v
				}
			end

			table.sort(hurtArray, function(a, b)
				return a.hurt > b.hurt
			end)

			for k, v in pairs(hurtArray) do
				if mRid == v.rid then
					rank = k
					totalHurt = v.hurt
				end
			end

			self:updateHurtPanel(hurtArray)

			if table.nums(response.data.log) == table.nums(self._logs) then
				return
			end

			self._logs = response.data.log
			self._logItems = self._logItems or {}

			local playerInfo = self._worldPeaceSystem:getMainPlayer()
			local battleField = self._worldPeaceSystem:getBattlefield()
			local groupNameMap = battleField:getGroupNameMap()
			local color = {
				"#fd62ff",
				"#ffe26e",
				"#81cdff"
			}
			local rank = 0
			local totalHurt = 0
			local player = self._developSystem:getPlayer()
			local mRid = player:getRid()

			for k, v in pairs(hurtArray) do
				if mRid == v.rid then
					rank = k
					totalHurt = v.hurt
				end
			end

			listView:setScrollBarEnabled(false)
			cnt1:setString(Strings:get("ClubMapBoss_Log_Rank") .. rank)
			cnt2:setString(Strings:get("ClubMapBoss_Log_Harm") .. math.floor(totalHurt))

			for k, v in pairs(response.data.log or {}) do
				local bossData = battleField:getBossById(v.bossId)
				local heroCfg = ConfigReader:getRecordById("HeroBase", bossData:getConfig().Hero)
				local gorupInfo = playerInfo:getGroupInfo()
				local richText, newCamp

				for k_, v_ in pairs(groupNameMap) do
					if v.campId == v_.gId then
						gIndex = v_.gIndex
						newCamp = v_.gName
					end
				end

				local time = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", v.time / 1000)
				local gIndex = 1

				for k_, v_ in pairs(groupNameMap) do
					if v.params.camp and v.params.camp == v_.gName then
						gIndex = v_.gIndex
					end
				end

				local color = color[gIndex]
				local reason

				if v.params and v.params.reason then
					reason = Strings:get("ClubMapBoss_Announce5_reason" .. v.params.reason)
				end

				local campName

				if v.params and v.params.camp then
					campName = v.params.camp
				end

				local player

				if v.params and v.params.player then
					player = v.params.player
				end

				if v.params and v.params.reason and v.type == 5 then
					self._catchCampInfos = self._catchCampInfos or {}

					local isNew = true

					for k, v in pairs(self._catchCampInfos) do
						if v.id == campName .. time then
							isNew = false
						end
					end

					if isNew then
						self._catchCampInfos[#self._catchCampInfos + 1] = {
							size = 16,
							fontName = TTF_FONT_FZYH_M,
							time = time,
							camp = campName,
							bossname = Strings:get(heroCfg.Name),
							num = bossData:getLv(),
							color = color,
							truereason = v.params.reason,
							reason = reason,
							player = player,
							trans = "ClubMapBoss_Announce" .. v.type,
							id = campName .. time
						}

						if self._firstEnter then
							self:showInfoForBoss()
						end
					end
				end

				local strformat = Strings:get("ClubMapBoss_Announce" .. v.type, {
					fontSize = 16,
					fontName = TTF_FONT_FZYH_M,
					time = time,
					camp = campName,
					bossname = Strings:get(heroCfg.Name),
					num = bossData:getLv(),
					color = color,
					reason = reason,
					player = player
				})
				local widthOffset = self._isOpenInfo and 400 or 0

				self._syncLoadNoticQueque[#self._syncLoadNoticQueque + 1] = {
					str = strformat,
					listview = listView,
					itemcell = itemcell,
					widthOffset = widthOffset
				}

				self:openInfoPanel(info.isopen, true)
			end

			self._firstEnter = true
		end
	end)
end

function WordPeaceBattleMediator:initCoroutines()
	self._syncLoadNoticQueque = self._syncLoadNoticQueque or {}
	self._syncLoadLogQueque = self._syncLoadLogQueque or {}
	self._syncLoadNoticMessage = coroutine.create(function()
		local time = os.clock()

		while true do
			if #self._syncLoadNoticQueque > 0 then
				local v = table.remove(self._syncLoadNoticQueque, 1)
				local listView = v.listview
				local widthOffset = v.widthOffset
				local itemcell = v.itemcell
				local str = v.str
				local richText = ccui.RichText:createWithXML(str, {})
				local item = itemcell:clone()

				richText:setAnchorPoint(cc.p(0, 0))
				richText:setPosition(cc.p(0, 5))
				richText:addTo(item)
				richText:setName("richText")
				richText:renderContent(itemcell:getContentSize().width + widthOffset, 0, true)
				item:setContentSize(itemcell:getContentSize().width + widthOffset, richText:getContentSize().height + 10)

				item.orgSize = itemcell:getContentSize()

				listView:pushBackCustomItem(item)

				if not self._collTime then
					listView:jumpToBottom()
				end

				self._logItems[#self._logItems + 1] = item

				if os.clock() - time > 0.03333333333333333 then
					time = os.clock()

					coroutine.yield("too cost time")
				end
			end

			coroutine.yield("wait")
		end
	end)
	self._syncLoadLogMessage = coroutine.create(function()
		local time = os.clock()

		while true do
			if #self._syncLoadLogQueque > 0 then
				local v = table.remove(self._syncLoadLogQueque, 1)
				local listView = v.listview
				local widthOffset = v.widthOffset
				local itemcell = v.itemcell
				local str = v.str
				local richText = ccui.RichText:createWithXML(str, {})
				local item = itemcell:clone()

				richText:setAnchorPoint(cc.p(0, 0))
				richText:setPosition(cc.p(0, 5))
				richText:addTo(item)
				richText:setName("richText")
				richText:renderContent(itemcell:getContentSize().width + widthOffset, 0, true)
				item:setContentSize(itemcell:getContentSize().width + widthOffset, richText:getContentSize().height + 10)

				item.orgSize = itemcell:getContentSize()

				if #listView:getItems() > 30 then
					local itemIndex = #listView:getItems() - 30

					for i = 1, itemIndex + 1 do
						listView:removeItem(i - 1)
						listView:jumpToBottom()
					end
				end

				listView:pushBackCustomItem(item)
				listView:jumpToBottom()

				self._logItems[#self._logItems + 1] = item

				if os.clock() - time > 0.03333333333333333 then
					time = os.clock()

					coroutine.yield("too cost time")
				end
			end

			coroutine.yield("wait")
		end
	end)
end

function WordPeaceBattleMediator:update()
	if self._syncLoadNoticMessage then
		coroutine.resume(self._syncLoadNoticMessage)
	end

	if self._syncLoadLogMessage then
		coroutine.resume(self._syncLoadLogMessage)
	end
end

function WordPeaceBattleMediator:showInfoForBoss()
	self._catchCampInfos = self._catchCampInfos or {}

	if #self._catchCampInfos <= 0 then
		return
	end

	if self._catchCampRuning then
		return
	end

	self._catchCampRuning = true

	local param = self._catchCampInfos[#self._catchCampInfos]
	local tips = self:getView():getChildByFullName("tips")
	local content = self:getView():getChildByFullName("tips.content")
	local strformat = Strings:get(param.trans, param)
	local bg = self:getView():getChildByFullName("tips.bg")

	if not self._tipsViews then
		local richText = ccui.RichText:createWithXML(strformat, {})

		richText:setAnchorPoint(cc.p(0, 0))

		self._tipsViews = richText

		self._tipsViews:addTo(bg)
		richText:setScaleY(-1)
	end

	local bossCfg = ConfigReader:getRecordById("ClubMapBoss", self._bossId)

	for k, v in pairs(bossCfg.OccupyDialogue) do
		if tonumber(v.params) == tonumber(param.truereason) then
			self._tipsViews:setString(Strings:get(v.trans, param))
		end
	end

	self._tipsViews:renderContent(content:getContentSize().width, 0, true)
	bg:setContentSize(cc.size(bg:getContentSize().width, self._tipsViews:getContentSize().height + 50))
	content:setString("")
	tips:setVisible(true)
	tips:setOpacity(0)
	self._tipsViews:center(bg:getContentSize())
	self._tipsViews:offset(5, -10)

	local duration = 0.15
	local fadeIn = cc.FadeIn:create(duration)
	local scaleTo1 = cc.ScaleTo:create(duration, 1.17)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local easeInOut = cc.EaseInOut:create(spawn, 1)
	local scaleTo2 = cc.ScaleTo:create(duration, 1)
	local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)
	local delay = cc.DelayTime:create(1)
	local delay2 = cc.DelayTime:create(5)
	local action = cc.Sequence:create(delay, easeInOut, easeInOut1, delay2, cc.CallFunc:create(function()
		self._catchCampRuning = false

		tips:setVisible(false)
	end))

	tips:runAction(action)
end

function WordPeaceBattleMediator:onHuiShou(bossId)
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

	self:runSupportAnim()

	if self._worldPeaceHandWidget then
		local selectNode = self._worldPeaceHandWidget:getSelectNode()

		if selectNode then
			local teamInfo = selectNode.teamInfo

			self._worldPeaceSystem:recallTeam({
				teamId = teamInfo.teamKey
			}, true, function(response)
				if response.resCode == 0 then
					local boss = self._worldPeaceSystem:getBattlefield():getBossById((not bossId or nil) and self._bossId)

					boss:getDTeams()[teamInfo.teamKey] = nil
					boss:getATeams()[teamInfo.teamKey] = nil

					print("回卡操作")
					self:backToCard(teamInfo.teamKey)
					self._view:getChildByName("btngo_0"):setVisible(false)
					self:refreshOprateBtn()
				end
			end)
		end
	end
end

function WordPeaceBattleMediator:onInfoBtn()
	local selectNode = self._worldPeaceHandWidget:getSelectNode()

	if selectNode then
		local dispatcher = DmGame:getInstance()
		local view = dispatcher._injector:getInstance("WordPeaceTeamInfoView")

		dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, selectNode.teamInfo))
	end
end

function WordPeaceBattleMediator:refreshOprateBtn()
	local selectNode = self._worldPeaceHandWidget:getSelectNode()

	if not selectNode then
		return
	end

	local v = selectNode.teamInfo
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local isOwn = self._worldPeaceSystem:checkBossOwnBy(self._bossId)

	if isOwn then
		if self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.REST then
			self._view:getChildByName("btngo"):loadTexture("CB_btn_zhiyuan.png", ccui.TextureResType.plistType)
			self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Reinforce"))
			self._view:getChildByName("btngo"):setVisible(true)
			self._view:getChildByName("btngo_0"):setVisible(false)
		elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.BATTLEING then
			self._view:getChildByName("btngo"):loadTexture("CB_btn_gongji.png", ccui.TextureResType.plistType)
			self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Speedup"))
			self._view:getChildByName("btngo"):setVisible(true)
			self._view:getChildByName("btngo_0"):setVisible(true)
		elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.PROTECTING then
			self._view:getChildByName("btngo"):setVisible(false)
			self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Protecting"))
			self._view:getChildByName("btngo_0"):setVisible(true)
		end
	elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.REST then
		self._view:getChildByName("btngo"):loadTexture("CB_btn_gongji.png", ccui.TextureResType.plistType)
		self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Attack"))
		self._view:getChildByName("btngo"):setVisible(true)
		self._view:getChildByName("btngo_0"):setVisible(false)
	elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.BATTLEING then
		self._view:getChildByName("btngo"):loadTexture("CB_btn_gongji.png", ccui.TextureResType.plistType)
		self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Speedup"))
		self._view:getChildByName("btngo"):setVisible(true)
		self._view:getChildByName("btngo_0"):setVisible(true)
	elseif self._worldPeaceSystem:getTeamState(v.teamKey) == k_TEAM_STATE.PROTECTING then
		self._view:getChildByName("btngo"):setVisible(false)
		self._view:getChildByName("btngo"):getChildByName("Text_68"):setString(Strings:get("ClubMapBoss_Button_Protecting"))
		self._view:getChildByName("btngo_0"):setVisible(true)
	end

	local canAttack = self._worldPeaceSystem:checkCanAttack(self._bossId, v.camp)

	if canAttack then
		self._view:getChildByName("btngo"):setVisible(true)
	else
		self._view:getChildByName("btngo"):setVisible(false)
	end
end

function WordPeaceBattleMediator:isBattleTime()
	return self._worldPeaceSystem:getStatus() == WPStatus.kBattle
end

function WordPeaceBattleMediator:checkTeamState(selectNode, teamInfo)
	if not selectNode.teamHpEnough then
		local dispatcher = DmGame:getInstance()
		local view = dispatcher._injector:getInstance("WordPeaceTeamInfoView")

		dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, teamInfo))

		return false
	end

	if not selectNode.masterHpEnough then
		local dispatcher = DmGame:getInstance()
		local view = dispatcher._injector:getInstance("WordPeacePlayerInfoView")

		dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view))

		return false
	end

	return true
end

function WordPeaceBattleMediator:onSupport()
	if self._btnAnimRun then
		return
	end

	if not self:isBattleTime() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Error_80604")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if self._worldPeaceHandWidget then
		local selectNode = self._worldPeaceHandWidget:getSelectNode()

		if selectNode then
			local playerInfo = self._worldPeaceSystem:getMainPlayer()
			local teamInfo = selectNode.teamInfo

			if self._worldPeaceSystem:getTeamState(teamInfo.teamKey) == k_TEAM_STATE.BATTLEING then
				self:runSupportAnim()

				self._view:getChildByName("btngo").__cntnum = self._view:getChildByName("btngo").__cntnum or 0
				self._view:getChildByName("btngo").__cntnum = self._view:getChildByName("btngo").__cntnum + 1

				local delay = cc.DelayTime:create(5)
				local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
					self._view:getChildByName("btngo").__cntnum = 0
				end))

				self._view:getChildByName("btngo"):runAction(sequence)

				local memeber = self._wordPeaceGame:getMemberFactory():getMemberById(teamInfo.teamKey)

				if self._view:getChildByName("btngo").__cntnum >= 0 or memeber and memeber:getSp() == 1 then
					if memeber then
						local sp = memeber:getSp()

						if sp < 3 then
							self:getSpeedUpFunction()(self._worldPeaceSystem, {
								teamId = teamInfo.teamKey,
								speed = sp + 1
							}, true, function(response)
								if response.resCode == 0 then
									local memeber = self._wordPeaceGame:getMemberFactory():getMemberById(teamInfo.teamKey)

									if memeber then
										memeber:setSp(sp + 1)
										memeber:resetTrans()

										if memeber:getState() ~= K_WORLD_MEMBER_SATGE.Protect and memeber:getState() ~= K_WORLD_MEMBER_SATGE.Protecting then
											memeber:setState(K_WORLD_MEMBER_SATGE.Attack)
										end

										self:refreshOprateBtn()
									end
								end
							end)
						end
					end

					self._view:getChildByName("btngo").__cntnum = 0
				end

				return
			end

			if self._worldPeaceSystem:getTeamState(teamInfo.teamKey) ~= k_TEAM_STATE.REST then
				return
			end

			if not self:checkTeamState(selectNode, teamInfo) then
				return
			end

			self:runSupportAnim()
			self:getAttackFunction()(self._worldPeaceSystem, {
				bossId = self._bossId,
				teamId = teamInfo.teamKey
			}, true, function(response)
				if response.resCode == 0 then
					if DisposableObject:isDisposed(self) then
						return
					end

					local playerInfo = self._worldPeaceSystem:getMainPlayer()
					local developSystem = DmGame:getInstance()._injector:getInstance(DevelopSystem)
					local player = developSystem:getPlayer()
					local heroCfg = ConfigReader:getRecordById("HeroBase", teamInfo.topHero)
					local debugData = {
						def = 0,
						sp = 1,
						isMyth = true,
						gId = "3",
						nickName = player:getNickName(),
						teamKey = teamInfo.teamKey,
						atk = playerInfo:getHeroCombat()[teamInfo.topHero],
						heroId = teamInfo.topHero,
						hpr = selectNode.curHp,
						st = teamInfo.st,
						ra = teamInfo.ra,
						cPos = playerInfo:getCPos(),
						mPhase = playerInfo:getMPhase()
					}
					local boss = self._worldPeaceSystem:getBattlefield():getBossById(self._bossId)

					if response.data.indef then
						local bossInstance = self._wordPeaceGame:getMemberFactory():getMemberById(self._bossId)

						boss:getDTeams()[teamInfo.teamKey] = Boll:new(teamInfo.teamKey)

						boss:getDTeams()[teamInfo.teamKey]:synchronize(debugData)
						boss:getDTeams()[teamInfo.teamKey]:setIsProtect(true)
						boss:getDTeams()[teamInfo.teamKey]:setGInfo(playerInfo:getGroupInfo())

						local protect = bossInstance:getProtects()

						boss:getDTeams()[teamInfo.teamKey]:setOrder(#protect + 1)
						self._wordPeaceGame:addBollForBoss(self._bossId, boss:getDTeamByKey(teamInfo.teamKey), 0.7)
						self._view:getChildByName("btngo_0"):setVisible(true)
					else
						local boss = self._worldPeaceSystem:getBattlefield():getBossById(self._bossId)

						boss:getATeams()[teamInfo.teamKey] = Boll:new(teamInfo.teamKey)

						boss:getATeams()[teamInfo.teamKey]:synchronize(debugData)
						boss:getATeams()[teamInfo.teamKey]:setGInfo(playerInfo:getGroupInfo())
						boss:getATeams()[teamInfo.teamKey]:setIsProtect(false)
						boss:getATeams()[teamInfo.teamKey]:setOrder(1)

						local bossInstance = self._wordPeaceGame:getMemberFactory():getMemberById(self._bossId)

						self._wordPeaceGame:addBollForBossRightNow({
							isAtk = true,
							scale = 0.8,
							boss = bossInstance,
							bolldata = boss:getATeams()[teamInfo.teamKey]
						})
					end

					self._worldPeaceHandWidget:updateInfo(playerInfo)
					self._view:getChildByName("btngo_0"):setVisible(true)
					self:refreshOprateBtn()
				end
			end)
		end
	end
end

function WordPeaceBattleMediator:getSpeedUpFunction()
	return self._worldPeaceSystem.speedUp
end

function WordPeaceBattleMediator:getAttackFunction()
	return self._worldPeaceSystem.attackBoss
end

function WordPeaceBattleMediator:getBossLayer()
	return self:getView():getChildByName("bosstouchlayer")
end

function WordPeaceBattleMediator:setUpBottomView()
	local bottomnode = self:getView():getChildByName("bottomnode")
	local worldPeaceHandWidget = WorldPeaceHandInWidget:new(bottomnode, self)

	self:getInjector():injectInto(worldPeaceHandWidget)

	self._worldPeaceHandWidget = worldPeaceHandWidget

	self:updateBottomView()
end

function WordPeaceBattleMediator:updateBottomView()
	local playerInfo = self._worldPeaceSystem:getMainPlayer()

	self._worldPeaceHandWidget:updateInfo(playerInfo)
end

function WordPeaceBattleMediator:resumeWithData()
	self._worldPeaceSystem:setWordPeaceGame(self._wordPeaceGame)
end

function WordPeaceBattleMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kClubMapPotion
		},
		title = Strings:get("ClubMapBoss_Title03"),
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
	LabelLayer = 10,
	BollLayer = 5,
	UnderLayer = 1,
	BossLayer = 3,
	EffectLayer = 20,
	UILayer = 30,
	TipsLayer = 40
}

function WordPeaceBattleMediator:initBattleLayer()
	self._touchPoint = {}
	self._touchHeroInfo = nil
	self._canTouchScaleSta = false
	self._mapTouchMove = false
	self._scrollView = self:getView():getChildByName("map")
	self._innnerContainer = self._scrollView:getInnerContainer()

	self._scrollView:setScrollBarEnabled(false)

	local node = cc.Node:create()

	node:setName("UnderLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.UnderLayer)

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

	local node = cc.Node:create()

	node:setName("UILayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.UILayer)

	local node = cc.Node:create()

	node:setName("TipsLayer")
	node:addTo(self._innnerContainer)
	node:setLocalZOrder(WorldPeaceLayer.TipsLayer)
end

function WordPeaceBattleMediator:startMainLoop()
	self._wordPeaceGame:setHandLogic(self._worldPeaceHandWidget)

	self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(dt)
		self._wordPeaceGame:step(dt)
		self._worldPeaceSystem:step(dt)
		self:update()
	end, 0.03333333333333333, false)

	local battleField = self._worldPeaceSystem:getBattlefield()
	local bossData = battleField:getBossById(self._bossId)

	self._wordPeaceGame:createBattleFieldByBoss(bossData, cc.p(520, 380), {
		1,
		0.7
	})

	local dieQueques = battleField:getDieQueques()

	self._wordPeaceGame:createBattleShadows(dieQueques, self._bossId)
end

function WordPeaceBattleMediator:onClickBack()
	if self._closeCallBack then
		self._closeCallBack()
	end

	self:dismiss()
end

function WordPeaceBattleMediator:setupView()
	local infopanel = self._view:getChildByFullName("infopanel")
	local node = infopanel:getChildByFullName("infopanel")

	if not node then
		return
	end

	local btnGroup = node:getChildByFullName("btnGroup")
	local cursor = btnGroup:getChildByFullName("cursor")
	local cursor_0 = btnGroup:getChildByFullName("cursor_0")
	local t1 = btnGroup:getChildByFullName("t1")
	local t2 = btnGroup:getChildByFullName("t2")
	local listView = node:getChildByFullName("noticinfo")
	local listViewLog = node:getChildByFullName("noticinfo_log")

	listViewLog:setVisible(false)
	listView:setVisible(true)
	cursor:setVisible(false)
	setTextWithFontStyle(t2, "FontTipsTextHei")
	btnGroup:addClickEventListener(function()
		if listView:isVisible() then
			setTextWithFontStyle(t1, "FontTipsTextHei")
			setTextWithFontStyle(t2, "FontTipsText")
			listViewLog:setVisible(true)
			listView:setVisible(false)
			cursor:setVisible(true)
			cursor_0:setVisible(false)
		else
			setTextWithFontStyle(t2, "FontTipsTextHei")
			setTextWithFontStyle(t1, "FontTipsText")
			listViewLog:setVisible(false)
			listView:setVisible(true)
			cursor:setVisible(false)
			cursor_0:setVisible(true)
		end
	end)

	local arrow = infopanel:getChildByFullName("arrow")
	local arrow1 = infopanel:getChildByFullName("arrow1")
	local line = infopanel:getChildByFullName("line")

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
end

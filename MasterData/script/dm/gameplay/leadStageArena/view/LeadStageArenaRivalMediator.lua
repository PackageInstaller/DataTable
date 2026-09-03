-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaRivalMediator.lua

LeadStageArenaRivalMediator = class("LeadStageArenaRivalMediator", DmAreaViewMediator, _M)

LeadStageArenaRivalMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaRivalMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
LeadStageArenaRivalMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local kBtnHandlers = {
	btn_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["main.bg_bottom.btn_rank"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRank"
	},
	["main.bg_bottom.btn_reward"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	},
	["main.bg_bottom.btn_report"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReport"
	},
	["main.bg_bottom.btn_shop"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickShop"
	},
	["main.bg_bottom.btn_team"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTeam"
	},
	["main.node_right.max_btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedMaxBtn"
	},
	["main.btn_cheers"] = {
		clickAudio = "Se_Click_BYYYC_Cheers",
		func = "onClickCheers"
	}
}

function LeadStageArenaRivalMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaRivalMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function LeadStageArenaRivalMediator:onRegister()
	super.onRegister(self)

	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._shopSystem = self._developSystem:getShopSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._rewardRedPoint = self._main:getChildByName("bg_bottom"):getChildByFullName("btn_reward.redPoint")

	self:refreshRewardRedPoint()
end

function LeadStageArenaRivalMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:mapEventListeners()

	self._powerMax = self._leadStageArena:getConfig().ChipMax
	self._cupNum = 1
	self._isreFreshing = false

	self:setupView()
	self:setClickEnv()
end

function LeadStageArenaRivalMediator:resumeWithData(data)
	super.resumeWithData(self, data)

	self._isreFreshing = false

	self._jinbiNode:removeAllChildren()
	self._numAnimNode:removeAllChildren()
	self:refreshRivalView()
	self:refreshRivalTeamView()
	self:refreshRightView()
	self:refreshCupNum()
	self:refreshRedPoint()
end

function LeadStageArenaRivalMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTAGE_AEANA_SEASONINFO, self, self.refreshViewDone)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewDone)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REFRESHVIEW, self, self.refreshRewardRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTAGE_AEANA_REFRESH_INFO, self, self.refreshRivalViewDone)
end

function LeadStageArenaRivalMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(999)

	local infoConfig = {
		CurrencyIdKind.kDiamond,
		CurrencyIdKind.kStageArenaPower,
		CurrencyIdKind.kStageArenaOldCoin
	}
	local config = {
		style = 1,
		currencyInfo = infoConfig,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StageArena_PartyUI01")
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function LeadStageArenaRivalMediator:setupView()
	self:initWidgetView()
	self:refreshRivalView()
	self:refreshRivalTeamView()
	self:refreshRightView()
	self:refreshCupNum()
	self:refreshRedPoint()
	self._leadStageArenaSystem:setOldCoinAdd(0)
	self._nodeEffect:removeAllChildren()

	local anim = cc.MovieClip:create("zhu_youyichuanruchang")

	anim:addTo(self._nodeEffect)

	local anim = cc.MovieClip:create("beizi_youyichuanruchang")
	local mc_bei = anim:getChildByFullName("mc_beizi")

	self._imgEnterBtn:changeParent(mc_bei):center(mc_bei:getContentSize())
	anim:addTo(self._nodeEffect)
	self:showRivalLeadStageLv()
end

function LeadStageArenaRivalMediator:refreshViewDone()
	self:refreshRivalView()
	self:refreshRivalTeamView()
	self:refreshRightView()
	self:refreshRedPoint()
end

function LeadStageArenaRivalMediator:refreshRivalViewDone()
	self._isreFreshing = true
	self._cupNum = 1

	self._slider:setPercent(0)
	self:refreshRedPoint()
	self:showRivalLeadStageLv()
	self._main:stopAllActions()

	local rivalTeamInfo = self._leadStageArena:getRival().rivalTeams

	for i = 1, 3 do
		local function callback(i)
			local node = self._middleNode:getChildByFullName("roleNode" .. i)
			local teamInfo = rivalTeamInfo["STAGE_ARENA_" .. i]
			local rivalAnim = cc.MovieClip:create("duishuaxin_buyeyouyichuanjinchangshuaxin")

			rivalAnim:addTo(node):offset(450, 66)
			rivalAnim:gotoAndPlay(0)
			rivalAnim:setPlaySpeed(1.6)
			rivalAnim:addCallbackAtFrame(5, function(cid, mc)
				self:refreshRivalTeamView(i)
			end)

			local nodeToActionMap = {}

			if teamInfo ~= nil then
				local herosList = node:getChildByFullName("team_bg")
				local length = 10

				for i = 1, length do
					local mc_pet = rivalAnim:getChildByFullName("mc_pet" .. i)
					local petNode = herosList:getChildByFullName("pet_" .. i)

					nodeToActionMap[petNode] = mc_pet
				end

				local mc_master = rivalAnim:getChildByFullName("mc_master")
				local maserNode = node:getChildByFullName("roleNode")

				nodeToActionMap[maserNode] = mc_master

				local mc_di = rivalAnim:getChildByFullName("mc_di")
				local diNode = node:getChildByFullName("Image_147")

				nodeToActionMap[diNode] = mc_di

				local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, node)

				startFunc()
				rivalAnim:addEndCallback(function()
					rivalAnim:stop()
					stopFunc()
				end)
			end
		end

		performWithDelay(self:getView(), function()
			callback(i)
		end, 0.06666666666666667 * (i - 1))
	end

	performWithDelay(self:getView(), function()
		self._isreFreshing = false
	end, 0.3)

	local roleNode = self._rivalNode:getChildByFullName("roleNode")

	self:refreshRivalView()

	local animNode = self._rivalNode:getChildByFullName("Node_1")

	animNode:removeAllChildren()

	local rivalAnim = cc.MovieClip:create("renwushuaxin_buyeyouyichuanjinchangshuaxin")
	local mc_roleNode = rivalAnim:getChildByFullName("mc_newRole")
	local mc_oldRole = rivalAnim:getChildByFullName("mc_role")

	rivalAnim:addTo(animNode):offset(200, 200)
	rivalAnim:gotoAndPlay(0)
	rivalAnim:addEndCallback(function()
		rivalAnim:stop()
	end)

	local nodeToActionMap = {}

	nodeToActionMap[roleNode] = mc_roleNode

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, animNode)

	startFunc()
	rivalAnim:addEndCallback(function()
		rivalAnim:stop()
		stopFunc()
	end)

	self._winCoin = self._rightNode:getChildByFullName("text_win")
	self._cupNumText = self._rightNode:getChildByFullName("changetime_text_cur_count")

	self._winCoin:setString("")

	local rivalData = self._leadStageArena:getRival()
	local powerRate = self._leadStageArena:getConfig().StaminaMultiple
	local winGold = math.modf(self._cupNum * powerRate * rivalData.rivalBaseGold)
	local isAdd = winGold > self._oldWinGold

	self._oldWinGold = winGold

	self._jinbiNode:removeAllChildren()

	local rivalAnim = cc.MovieClip:create("jinbishuaxintx_buyeyouyichuanjinchangshuaxin")

	rivalAnim:addTo(self._jinbiNode):offset(70, -34)
	rivalAnim:gotoAndPlay(0)
	rivalAnim:addCallbackAtFrame(12, function(cid, mc)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_PartyUI13")
		}))
	end)
	rivalAnim:addEndCallback(function()
		rivalAnim:stop()
	end)
	self._numAnimNode:removeAllChildren()

	local jinbiAnim = cc.MovieClip:create("jinbishuaxin_buyeyouyichuanjinchangshuaxin")

	jinbiAnim:addTo(self._numAnimNode):offset(116, 0)
	jinbiAnim:gotoAndPlay(0)
	jinbiAnim:addEndCallback(function()
		jinbiAnim:stop()
	end)

	winGold = tostring(winGold)

	local winNumLen = string.len(winGold)
	local startX = 6 - winNumLen

	jinbiAnim:offset(-23 * startX)

	for i = 1, winNumLen do
		startX = startX + 1

		local mc_num = jinbiAnim:getChildByFullName("mc_num" .. startX)

		mc_num:gotoAndStop(0)
		jinbiAnim:addCallbackAtFrame(7 - i, function(cid, mc)
			mc_num:gotoAndPlay(0)
		end)
		mc_num:addEndCallback(function()
			mc_num:stop()
		end)

		local mc_n1 = mc_num:getChildByFullName("mc_n1")
		local mc_n2 = mc_num:getChildByFullName("mc_n2")
		local num = string.sub(tostring(winGold), i, i)
		local numtext = self._winCoin:clone()

		numtext:setString(num)
		numtext:addTo(mc_n1):center(mc_n1:getContentSize())

		local numtext = self._winCoin:clone()

		numtext:setString(num)
		numtext:addTo(mc_n2):center(mc_n2:getContentSize())
	end

	if isAdd then
		local mc_up = jinbiAnim:getChildByFullName("mc_jiantou")
		local imgUp = self._imgUp:clone()

		imgUp:setVisible(true)
		imgUp:addTo(mc_up):center(mc_up:getContentSize())
	end

	do return end

	local offset1, offset2 = cc.p(-1200, 0), cc.p(1200, 0)
	local call = cc.CallFunc:create(function()
		self._cupNum = 1

		self._slider:setPercent(0)
		self:refreshRivalView()
		self:refreshRivalTeamView()
		self:refreshRightView()
		self:refreshRedPoint()
		self:showRivalLeadStageLv()
	end)
	local call1 = cc.CallFunc:create(function()
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_PartyUI13")
		}))
	end)

	self._rightNode:runAction(cc.Sequence:create(cc.MoveBy:create(0.1, offset1), cc.DelayTime:create(0.2), cc.MoveBy:create(0.2, offset2)))
	self._middleNode:runAction(cc.Sequence:create(cc.MoveBy:create(0.1, offset1), cc.DelayTime:create(0.2), cc.MoveBy:create(0.2, offset2)))
	self._rivalNode:runAction(cc.Sequence:create(cc.MoveBy:create(0.1, offset1), call, cc.DelayTime:create(0.2), cc.MoveBy:create(0.2, offset2), call1))
end

function LeadStageArenaRivalMediator:refreshRewardRedPoint()
	local val = self._leadStageArenaSystem:checkRewardRedpoint()

	self._rewardRedPoint:setVisible(val)
end

function LeadStageArenaRivalMediator:initWidgetView()
	self._bg = self._main:getChildByFullName("bg")
	self._rivalNode = self._main:getChildByFullName("node_rival")
	self._middleNode = self._main:getChildByFullName("node_middle")
	self._rightNode = self._main:getChildByFullName("node_right")
	self._slider = self._rightNode:getChildByFullName("slider")
	self._redPoint = self._main:getChildByFullName("btn_cheers.redPoint")
	self._nodeEffect = self._main:getChildByFullName("btn_cheers.node_effect")
	self._imgEnterBtn = self._main:getChildByFullName("btn_cheers.Image_178")
	self._imgUp = self._rightNode:getChildByFullName("up")
	self._jinbiNode = self._rightNode:getChildByFullName("jinbiAnim")
	self._numAnimNode = self._rightNode:getChildByFullName("numAnim")

	self._numAnimNode:removeAllChildren()
	self._jinbiNode:removeAllChildren()
	self._imgUp:setVisible(false)
	self._redPoint:setVisible(false)
	self._bg:ignoreContentAdaptWithSize(true)
	self._bg:loadTexture("asset/scene/scene_stagearena_1.jpg")

	local ruImg = self._main:getChildByFullName("btn_cheers.Image_319")

	ruImg:ignoreContentAdaptWithSize(true)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		ruImg:setPosition(cc.p(90, 80))
	end

	local imgbg = self._main:getChildByFullName("Image_83_0")
	local winSize = cc.Director:getInstance():getWinSize()

	imgbg:setContentSize(cc.size(imgbg:getContentSize().width, winSize.height - 91 - 60))

	self._btnFresh = self:bindWidget("main.node_right.btn_fresh", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_2",
			func = bind1(self.onClickBtnFresh, self)
		}
	})

	self._btnFresh:setButtonName(Strings:get("StageArena_PartyUI25"), "")
	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self._curPower = self._bagSystem:getPowerByCurrencyId(CurrencyIdKind.kStageArenaPower)

			local curMax = math.min(self._powerMax, self._curPower)

			if self._cupNum == 0 then
				self._slider:setPercent(0)
			else
				local percent = self._slider:getPercent()

				if percent == 0 then
					self._cupNum = 1
				else
					local count = math.ceil(percent / 100 * curMax)

					self._cupNum = math.min(count, curMax)
				end

				self:refreshRightView()
			end
		end
	end)
end

function LeadStageArenaRivalMediator:refreshRedPoint()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self._redPoint:setVisible(false)

		return
	end

	local isPowerRed = self._leadStageArenaSystem:checkPowerShowRed()

	self._redPoint:setVisible(isPowerRed)
end

function LeadStageArenaRivalMediator:refreshRivalView()
	local rivalData = self._leadStageArena:getRival()
	local roleNode = self._rivalNode:getChildByFullName("roleNode")
	local imgCoin = self._rivalNode:getChildByFullName("img_money")
	local textName = self._rivalNode:getChildByFullName("text_name")
	local textCoin = self._rivalNode:getChildByFullName("text_money")
	local imgCost = self._rightNode:getChildByFullName("img_cost")
	local textCost = self._rightNode:getChildByFullName("text_cost")

	self._oldRole = rivalData.rivalShowId

	textName:setString(rivalData.rivalNickname .. " Lv." .. rivalData.rivalLevel)
	textCoin:setString(rivalData.rivalRlyehCoin)

	local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

	imgCoin:removeAllChildren()
	icon:setScale(0.4)
	icon:addTo(imgCoin):center(imgCoin:getContentSize())

	local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

	imgCost:removeAllChildren()
	icon:setScale(0.3)
	icon:addTo(imgCost):offset(22, 22)

	local costNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_RefreshCost", "content")
	local have = self._leadStageArenaSystem:getOldCoin()

	textCost:setString(costNum)
	textCost:setColor(costNum <= have and cc.c3b(255, 255, 255) or cc.c3b(255, 0, 0))
	roleNode:removeAllChildren()

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", rivalData.rivalShowId)
	local heroIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel
	})

	roleNode:addChild(heroIcon)
	heroIcon:setPosition(cc.p(400, 80))

	if self._rivalNode:getChildByName("title") then
		self._rivalNode:removeChildByName("title")
	end

	if rivalData.rivalTitle ~= nil and rivalData.rivalTitle ~= "" then
		local icon = IconFactory:createTitleIcon({
			id = rivalData.rivalTitle
		})

		icon:addTo(self._rivalNode):posite(68, 184)
		icon:setName("title")
		icon:setScale(0.9)
	end
end

function LeadStageArenaRivalMediator:refreshRivalTeamView(index)
	local rivalTeamInfo = self._leadStageArena:getRival().rivalTeams
	local maxPetNum = self._leadStageArena:getPositionNum()

	local function callback(i)
		local node = self._middleNode:getChildByFullName("roleNode" .. i)
		local teamInfo = rivalTeamInfo["STAGE_ARENA_" .. i]

		if teamInfo ~= nil then
			local textIndex = node:getChildByFullName("roleNode.text_index")
			local roleNode = node:getChildByFullName("roleNode.masterPanel")
			local nodeLeadStage = node:getChildByFullName("roleNode.node_leadStage")
			local textHide = node:getChildByFullName("roleNode.text_hide")
			local herosList = node:getChildByFullName("team_bg")
			local imgHide = node:getChildByFullName("roleNode.img_heidi")

			textHide:setVisible(false)
			textIndex:setString(Strings:get("StageArena_PartyUI0" .. 1 + i))
			roleNode:removeAllChildren()

			local roleModel = self._masterSystem:getMasterLeadStageModel(teamInfo.masterId, teamInfo.leadId)
			local sprite = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe6_1",
				id = roleModel
			})

			roleNode:addChild(sprite)
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setPosition(cc.p(0, 0))
			sprite:setScale(0.54)
			nodeLeadStage:removeAllChildren()

			local hidden = self._leadStageArenaSystem:getRivalHidden()

			if table.indexof(hidden, i) then
				textHide:setPositionX(70)
				textHide:setVisible(true)
				imgHide:setVisible(true)
			elseif teamInfo.leadId and teamInfo.leadId ~= "" then
				local icon = IconFactory:createLeadStageIconVer(teamInfo.leadId, teamInfo.leadLv, {
					needBg = 0
				})

				if icon then
					icon:addTo(nodeLeadStage):offset(-3, 8)
					icon:setAnchorPoint(cc.p(0.5, 0.5))
					icon:setScale(0.8)
					imgHide:setVisible(true)
				end
			end

			local showHeros = {}

			for i, v in pairs(teamInfo.heroes) do
				showHeros[#showHeros + 1] = v
			end

			self:sortOnTeamPets(showHeros)

			local length = 10

			for i = 1, length do
				local iconPanel = herosList:getChildByFullName("pet_" .. i)

				iconPanel:removeAllChildren()

				if showHeros[i] then
					local heroInfo = {
						id = showHeros[i]
					}
					local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
						hideStar = true,
						hideName = true,
						rarityAnim = false,
						hideLevel = true
					})

					petNode:setScale(0.4)
					petNode:addTo(iconPanel):center(iconPanel:getContentSize())
					petNode:offset(0, -9)
				else
					local emptyIcon = GameStyle:createEmptyIcon(true)

					emptyIcon:addTo(iconPanel):center(iconPanel:getContentSize())
					emptyIcon:setScale(0.6)

					if i > maxPetNum then
						local tipLabel = emptyIcon:getChildByName("TipText")

						tipLabel:setString(Strings:get("StageArena_PartyUI09"))
					end
				end
			end
		end
	end

	if index then
		callback(index)
	else
		for i = 1, 3 do
			callback(i)
		end
	end
end

function LeadStageArenaRivalMediator:refreshRightView()
	local imgCoin = self._rightNode:getChildByFullName("img_oldcoin")

	self._winCoin = self._rightNode:getChildByFullName("text_win")
	self._cupNumText = self._rightNode:getChildByFullName("changetime_text_cur_count")

	imgCoin:setVisible(true)
	imgCoin:removeAllChildren()

	local icon = ccui.ImageView:create("ico_m_stagearenagold_1.png", ccui.TextureResType.plistType)

	icon:setScale(0.55)
	icon:addTo(imgCoin):offset(20, 20)
end

function LeadStageArenaRivalMediator:refreshCupNum()
	local rivalData = self._leadStageArena:getRival()

	self._cupNumText:setString(self._cupNum)

	local powerRate = self._leadStageArena:getConfig().StaminaMultiple
	local winGold = math.modf(self._cupNum * powerRate * rivalData.rivalBaseGold)

	self._oldWinGold = winGold

	self._winCoin:setString(winGold)
end

function LeadStageArenaRivalMediator:sortOnTeamPets(hros)
	self._heroSystem:sortOnTeamPets(hros)
end

function LeadStageArenaRivalMediator:onClickedMaxBtn()
	self._curPower = self._bagSystem:getPowerByCurrencyId(CurrencyIdKind.kStageArenaPower)

	local maxChip = math.min(self._powerMax, self._curPower)

	if self._cupNum >= self._powerMax then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI40", {
				num = self._powerMax
			})
		}))
	end

	if maxChip <= self._cupNum then
		self._cupNum = maxChip
	end

	self._cupNum = math.max(maxChip, 1)

	self._slider:setPercent(100)
	self:refreshCupNum()
end

function LeadStageArenaRivalMediator:onClickRank()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local view = self:getInjector():getInstance("LeadStageArenaRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}, nil))
end

function LeadStageArenaRivalMediator:onClickReward()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterRewardView()
end

function LeadStageArenaRivalMediator:onClickShop()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterShopView()
end

function LeadStageArenaRivalMediator:onClickReport()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterReportView()
end

function LeadStageArenaRivalMediator:onClickCheers()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._curPower = self._bagSystem:getPowerByCurrencyId(CurrencyIdKind.kStageArenaPower)

	if self._curPower < 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI31")
		}))

		return
	end

	self._leadStageArenaSystem:enterTeamListView(self._cupNum)
end

function LeadStageArenaRivalMediator:onClickBtnFresh()
	if self._isreFreshing then
		return
	end

	local data = self._developSystem:getPlayer():getPlayerStageArena()
	local costNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_RefreshCost", "content")
	local have = self._leadStageArenaSystem:getOldCoin()

	if have < costNum then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_PartyUI10")
		}))

		return
	end

	self._leadStageArenaSystem:requestRefreshRival()
end

function LeadStageArenaRivalMediator:enterRivalView()
	self._leadStageArenaSystem:enterRivalView()
end

function LeadStageArenaRivalMediator:onClickRule()
	local st = TimeUtil:localDate("%Y.%m.%d", self._leadStageArena:getStartTime())
	local et = TimeUtil:localDate("%Y.%m.%d", self._leadStageArena:getEndTime())
	local oldCoin = self._leadStageArenaSystem:getOldCoin()
	local powerMax = self._leadStageArena:getConfig().ChipMax
	local reset = ConfigReader:getRecordById("Reset", "StageArenaStamina_Reset").ResetSystem
	local ruleReplaceInfo = {
		starttime = st,
		endtime = et,
		gold = oldCoin,
		min = reset.cd / 60 .. Strings:get("Arena_UI109"),
		num = reset.limit,
		max = powerMax
	}
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		useParam = true,
		rule = Rule.Desc,
		extraParams = ruleReplaceInfo
	}, nil)

	self:dispatch(event)
end

function LeadStageArenaRivalMediator:stopTimer()
	return
end

function LeadStageArenaRivalMediator:onClickBack()
	self:stopTimer()
	self:dismiss()
end

function LeadStageArenaRivalMediator:onClickTeam()
	if status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI25")
		}))

		return
	end

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterTeamView(1)
end

function LeadStageArenaRivalMediator:showRivalLeadStageLv()
	if DEBUG == 2 then
		local rivalInfo = self._leadStageArena:getRival()

		if rivalInfo.rivalMaxLeadLv then
			local str = "对手最高源阶等级：" .. (rivalInfo.rivalMaxLeadLv or 0)
			local label = self._rightNode:getChildByFullName("debuglabel")

			if not label then
				label = ccui.Text:create("", TTF_FONT_FZYH_M, 20)

				label:addTo(self._rightNode)
				label:setPosition(self._winCoin:getPosition())
				label:offset(0, 126)
				label:setName("debuglabel")
			end

			label:setString(str)
		end
	end
end

function LeadStageArenaRivalMediator:setClickEnv()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guide_team = self:getView():getChildByFullName("guide_team")
		local guide_coin = self:getView():getChildByFullName("guide_coin")
		local guide_refresh = self:getView():getChildByFullName("guide_refresh")
		local guide_info = self:getView():getChildByFullName("guide_info")

		if guide_team then
			storyDirector:setClickEnv("LeadStageArenaRivalMediator.guide_team", guide_team, nil)
		end

		if guide_coin then
			storyDirector:setClickEnv("LeadStageArenaRivalMediator.guide_coin", guide_coin, nil)
		end

		if guide_refresh then
			storyDirector:setClickEnv("LeadStageArenaRivalMediator.guide_refresh", guide_refresh, nil)
		end

		if guide_info then
			storyDirector:setClickEnv("LeadStageArenaRivalMediator.guide_info", guide_info, nil)
		end

		storyDirector:notifyWaiting("enter_LeadStageArenaRival_view")
	end))

	self:getView():runAction(sequence)
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaMainMediator.lua

LeadStageArenaMainMediator = class("LeadStageArenaMainMediator", DmAreaViewMediator, _M)

LeadStageArenaMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
LeadStageArenaMainMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
LeadStageArenaMainMediator:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")
LeadStageArenaMainMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")

leadStageArenaPicPath = "ico_m_stagearenagold_2.png"

local kBtnHandlers = {
	btn_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	},
	["bg_bottom.btn_rank"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRank"
	},
	["bg_bottom.btn_reward"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	},
	["bg_bottom.btn_report"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReport"
	},
	["bg_bottom.btn_shop"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickShop"
	},
	["bg_bottom.btn_team"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTeam"
	},
	["main.node_rank.btn_smallrank"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSmallRank"
	},
	["main.btn_enter"] = {
		clickAudio = "Se_Effect_BYYYC_Entrance",
		func = "onClickEnter"
	}
}
local remainHour = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_SeasonShowTime", "content")
local StageArena_RealTimeFresh = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_RealTimeFresh", "content")

function LeadStageArenaMainMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaMainMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function LeadStageArenaMainMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._shopSystem = self._developSystem:getShopSystem()
	self._rankType = RankType.KStageAreana
	self._leadStageArena = self._leadStageArenaSystem:getLeadStageArena()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._bg = self._main:getChildByFullName("bg")
	self._nodeRank = self._main:getChildByFullName("node_rank")
	self._smallRankBtn = self._nodeRank:getChildByFullName("btn_smallrank")
	self._redPoint = self._main:getChildByFullName("btn_enter.redPoint")

	self._redPoint:setVisible(false)

	self._rewardRedPoint = self:getView():getChildByName("bg_bottom"):getChildByFullName("btn_reward.redPoint")

	self:refreshRewardRedPoint()
end

function LeadStageArenaMainMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:mapEventListeners()
	self:showNewSeasonView()
	self:setupView()
	self:scheduleFreshView()
	self:setClickEnv()
end

function LeadStageArenaMainMediator:resumeWithData(data)
	super.resumeWithData(self, data)
	self:refreshRankView()
	self:refreshRedPoint()
	self:refreshRoleNameInfo()
	self:refreshOldCoinAnim()
end

function LeadStageArenaMainMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEADSTAGE_AEANA_SEASONINFO, self, self.refreshViewDone)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_REFRESHVIEW, self, self.refreshRewardRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewDone)
end

function LeadStageArenaMainMediator:setupTopInfoWidget()
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
		title = Strings:get("StageArena_SystemName")
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function LeadStageArenaMainMediator:showNewSeasonView()
	if self._leadStageArenaSystem:checkIsNewseason() then
		self._leadStageArenaSystem:setNewSeasonKeyValue()
	end
end

function LeadStageArenaMainMediator:setupView()
	self:initWidgetView()

	local animNode = self._main:getChildByFullName("Node_anim")
	local anim = cc.MovieClip:create("buyeyihouchuan_buyeyiyouchuanchangjing")

	anim:addTo(animNode)

	local mc_bg = anim:getChildByFullName("mc_bg.mc_bg")
	local mc_jiaban = anim:getChildByFullName("mc_jiaban.mc_banzi")
	local imgBg = ccui.ImageView:create("asset/scene/scene_stagearena_bg.jpg")
	local imgJiaban = ccui.ImageView:create("asset/sceneStory/scene_stagearena_jiaban.png")

	imgBg:addTo(mc_bg)
	imgJiaban:addTo(mc_jiaban)
	self:refreshSeasonTimeView()
	self:refreshRankView()
	self:addRole()
	self._nodeEffect:removeAllChildren()

	local anim = cc.MovieClip:create("zhu_youyichuanruchang")

	anim:addTo(self._nodeEffect)
	anim:setName("zhu")

	local anim = cc.MovieClip:create("beizi_youyichuanruchang")
	local mc_bei = anim:getChildByFullName("mc_beizi")

	self._imgEnterBtn:changeParent(mc_bei):center(mc_bei:getContentSize())
	anim:addTo(self._nodeEffect)
	anim:setName("beizi")
	self._leadStageArenaSystem:setOldCoinAdd(0)
end

function LeadStageArenaMainMediator:initWidgetView()
	self._roleNode = self._main:getChildByFullName("roleNode")
	self._btnEnter = self._main:getChildByFullName("btn_enter")
	self._nodeEffect = self._main:getChildByFullName("btn_enter.node_effect")
	self._imgEnterBtn = self._main:getChildByFullName("btn_enter.Image_178")

	local ruImg = self._main:getChildByFullName("btn_enter.Image_191")

	ruImg:ignoreContentAdaptWithSize(true)

	if getCurrentLanguage() ~= GameLanguageType.CN then
		ruImg:setPosition(cc.p(90, 80))
	end
end

function LeadStageArenaMainMediator:refreshViewDone()
	self:refreshRedPoint()
end

function LeadStageArenaMainMediator:refreshRewardRedPoint()
	local val = self._leadStageArenaSystem:checkRewardRedpoint()

	self._rewardRedPoint:setVisible(val)
end

function LeadStageArenaMainMediator:refreshSeasonTimeView()
	local timeText = self._main:getChildByFullName("node_time.text_time")
	local imgTime = self._main:getChildByFullName("node_time.Image_253")

	local function update()
		local curTime = self._gameServerAgent:remoteTimestamp()
		local status = self._leadStageArena:getCurStatus()

		if status == LeadStageArenaState.KReset then
			timeText:setString(Strings:get("StageArena_MainUI30"))
			self:stopTimer()
		elseif status == LeadStageArenaState.KShow then
			local remainTime = self._leadStageArena:getCloseTime() - curTime

			if remainTime <= 0 then
				self._leadStageArenaSystem:requestGetSeasonInfo(nil, false)
			end

			timeText:setString(Strings:get("StageArena_MainUI11"))
		elseif status == LeadStageArenaState.kFighting then
			local remainTime = self._leadStageArena:getEndTime() - curTime

			if remainTime > remainHour * 3600 then
				local endTime = TimeUtil:localDate("%Y-%m-%d", self._leadStageArena:getEndTime())

				timeText:setString(Strings:get("StageArena_Main_SeasonTime") .. "  " .. endTime)
			else
				local str = ""
				local fmtStr = "${d}:${HH}:${M}:${SS}"
				local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
				local parts = string.split(timeStr, ":", nil, true)
				local timeTab = {}

				timeTab.day = tonumber(parts[1])
				timeTab.hour = tonumber(parts[2])
				timeTab.min = tonumber(parts[3])
				timeTab.sec = tonumber(parts[4])
				str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("RTPK_TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min > 0 and timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec") or timeTab.sec .. Strings:get("TimeUtil_Sec")

				timeText:setString(Strings:get("StageArena_MainUI03", {
					countdown = str
				}))

				if remainTime <= 0 then
					self._leadStageArenaSystem:requestGetSeasonInfo(nil, false)
				end
			end
		end

		imgTime:setContentSize(cc.size(timeText:getContentSize().width + 50, imgTime:getContentSize().height))
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, false)

	update()
end

function LeadStageArenaMainMediator:refreshRankView()
	local isOpen = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.KLeadStageAreanaRankState, true)

	self._smallRankBtn:setFlippedX(not isOpen)
	self._nodeRank:setPositionX(isOpen and 0 or -220)

	local rankInfoPanel = self._nodeRank:getChildByFullName("rankPanel")

	rankInfoPanel:removeAllChildren()

	local rankPanelClone = self._nodeRank:getChildByFullName("panel1")

	rankPanelClone:setVisible(false)

	local function callback()
		if not checkDependInstance(self) then
			return
		end

		self._rankList = self._rankSystem:getRankListByType(self._rankType)

		for i = 1, 3 do
			local rankPanel = rankPanelClone:clone()

			rankPanel:setVisible(true)
			rankPanel:addTo(rankInfoPanel):posite(0, 210 - i * 68)

			local rankIndex = rankPanel:getChildByFullName("Image_257")
			local roleIcon = rankPanel:getChildByFullName("Image_258")
			local roleName = rankPanel:getChildByFullName("text_name")
			local coinIcon = rankPanel:getChildByFullName("Panel_234")
			local coinNum = rankPanel:getChildByFullName("text_coin")
			local imgEmpty = rankPanel:getChildByFullName("img_empty")

			rankIndex:loadTexture(RankTopImage[i], 1)

			local record = self._rankList[i]

			roleIcon:setVisible(record ~= nil)
			roleName:setVisible(record ~= nil)
			coinIcon:setVisible(record ~= nil)
			coinNum:setVisible(record ~= nil)
			imgEmpty:setVisible(record == nil)

			if record then
				roleIcon:removeAllChildren()

				local headInfo = {
					clipType = 4,
					id = record:getHeadId(),
					headFrameId = record:getHeadFrame(),
					size = cc.size(93, 94)
				}
				local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

				headIcon:addTo(roleIcon):center(roleIcon:getContentSize()):offset(2, -2)
				headIcon:setScale(0.6)
				oldIcon:setScale(0.5)
				roleName:setString(record:getName())

				local icon = ccui.ImageView:create(leadStageArenaPicPath, ccui.TextureResType.plistType)

				coinIcon:removeAllChildren()
				icon:setScale(0.3)
				icon:addTo(coinIcon):offset(15, 15)
				coinNum:setString(record:getOldCoin())
			end
		end

		local myselfData = self._rankSystem:getMyselfDataByType(self._rankType)
		local r = myselfData and myselfData:getRank() or self._leadStageArena:getGlobalRank()
		local myrank = self._nodeRank:getChildByFullName("text_myrank")

		if r <= 0 or not r then
			::label_16_0::

			local rtext = Strings:get("StageArena_MainUI19")

			myrank:setString(Strings:get("StageArena_MainUI09", {
				rank = rtext
			}))
		end
	end

	self:requestRankData(callback)
end

function LeadStageArenaMainMediator:refreshRedPoint()
	self:refreshBtnState()

	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self._redPoint:setVisible(false)

		return
	end

	local isPowerRed = self._leadStageArenaSystem:checkPowerShowRed()

	self._redPoint:setVisible(isPowerRed)
end

function LeadStageArenaMainMediator:refreshBtnState()
	local status = self._leadStageArenaSystem:getArenaState()
	local curPower = self._bagSystem:getPowerByCurrencyId(CurrencyIdKind.kStageArenaPower)

	if curPower < 1 or status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self._btnEnter:setGray(true)

		local anim = self._nodeEffect:getChildByFullName("beizi")

		anim:gotoAndStop(1)

		local anim = self._nodeEffect:getChildByFullName("zhu")
		local guang = anim:getChildByFullName("guang")

		guang:setVisible(false)
	else
		self._btnEnter:setGray(false)

		local anim = self._nodeEffect:getChildByFullName("beizi")

		anim:gotoAndPlay(1)

		local anim = self._nodeEffect:getChildByFullName("zhu")
		local guang = anim:getChildByFullName("guang")

		guang:setVisible(true)
	end
end

function LeadStageArenaMainMediator:scheduleFreshView()
	local function update()
		self:refreshRankView()
		self:refreshRedPoint()
	end

	self._scheduleTimer = LuaScheduler:getInstance():schedule(update, StageArena_RealTimeFresh, false)
end

function LeadStageArenaMainMediator:onClickRank()
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

function LeadStageArenaMainMediator:onClickReport()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterReportView()
end

function LeadStageArenaMainMediator:onClickShop()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterShopView()
end

function LeadStageArenaMainMediator:onClickSmallRank()
	local isOpen = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.KLeadStageAreanaRankState, true)

	isOpen = not isOpen

	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.KLeadStageAreanaRankState, isOpen)
	self._smallRankBtn:setFlippedX(not isOpen)

	local moveto = cc.MoveTo:create(0.2, cc.p(isOpen and 0 or -220, self._nodeRank:getPositionY()))

	self._nodeRank:runAction(moveto)
end

function LeadStageArenaMainMediator:onClickEnter()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason or status == LeadStageArenaState.KShow then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	local curPower = self._bagSystem:getPowerByCurrencyId(CurrencyIdKind.kStageArenaPower)

	if curPower < 1 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI31")
		}))

		return
	end

	local data = self._developSystem:getPlayer():getPlayerStageArena()

	if data.rivalRid and data.rivalRid == "" then
		self._leadStageArenaSystem:requestEnter()

		local view = self:getInjector():getInstance("LeadStageArenaLoadingView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			outself = self
		}))
	else
		self:enterRivalView()
	end
end

function LeadStageArenaMainMediator:onClickReward()
	local status = self._leadStageArenaSystem:getArenaState()

	if status == LeadStageArenaState.KReset or status == LeadStageArenaState.KNoSeason then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("StageArena_MainUI18")
		}))

		return
	end

	self._leadStageArenaSystem:enterRewardView()
end

function LeadStageArenaMainMediator:enterRivalView()
	local function callback()
		self._leadStageArenaSystem:enterRivalView()
	end

	self._leadStageArenaSystem:requestEnter(callback, true)
end

function LeadStageArenaMainMediator:enterRivalViewNoReq()
	self._leadStageArenaSystem:enterRivalView()
end

function LeadStageArenaMainMediator:refreshTopInfo()
	local infoConfig = {
		CurrencyIdKind.kStageArenaPower,
		CurrencyIdKind.kStageArenaOldCoin
	}
	local config = {
		style = 1,
		stopAnim = true,
		currencyInfo = infoConfig,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StageArena_SystemName")
	}

	self._topInfoWidget:updateView(config)
end

function LeadStageArenaMainMediator:refreshOldCoinAnim()
	if self._leadStageArenaSystem:getOldCoinAdd() > 0 then
		self:refreshTopInfo()

		local topInfoNode = self:getView():getChildByFullName("goldAnimNode")

		topInfoNode:setLocalZOrder(1000)

		local anim = cc.MovieClip:create("jinbihuode_buyeyiyouchuanjinbi")

		anim:addTo(topInfoNode):posite(0, 0)
		anim:setScale(0.98)
		anim:offset(24, 130)
		anim:gotoAndPlay(0)
		anim:addCallbackAtFrame(60, function(cid, mc)
			self._leadStageArenaSystem:setOldCoinAdd(0)
			self:refreshTopInfo()
		end)
		anim:addEndCallback(function()
			anim:stop()
		end)
	end
end

function LeadStageArenaMainMediator:onClickTeam()
	local status = self._leadStageArenaSystem:getArenaState()

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

function LeadStageArenaMainMediator:onClickRule()
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

function LeadStageArenaMainMediator:requestRankData(callback)
	self._rankSystem:cleanUpRankListByType(self._rankType)

	local sendData = {
		rankStart = 1,
		rankEnd = 3,
		type = self._rankType
	}

	self._rankSystem:requestStageAreanaAllServerRankData(sendData, callback)
end

function LeadStageArenaMainMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._scheduleTimer then
		self._scheduleTimer:stop()

		self._scheduleTimer = nil
	end
end

function LeadStageArenaMainMediator:onClickBack()
	self:stopTimer()
	self:dismiss()
end

function LeadStageArenaMainMediator:instantiateBuildingHero(node)
	return self:getInjector():instantiate("LeadStageArenaHero", {
		view = node
	})
end

local posList = {
	cc.p(130, 200),
	cc.p(130, 100),
	cc.p(390, 200),
	cc.p(390, 100),
	cc.p(650, 200),
	cc.p(650, 100),
	cc.p(930, 200),
	cc.p(930, 100)
}

function LeadStageArenaMainMediator:addRole()
	self._heroList = {}

	local panel = self._roleNode
	local roles = self._developSystem:getPlayer():getStageArenafriends()
	local roleList = {
		self._leadStageArena:getMyInfo()
	}

	for i, v in ipairs(roles) do
		roleList[#roleList + 1] = v
	end

	if not next(roleList) then
		return
	end

	local random = math.random(1, #roleList)

	local function hasHero(index)
		for i, hero in pairs(self._heroList) do
			local posIndex = hero:getPosIndex()

			if index == posIndex then
				return true
			end
		end
	end

	local function getCreatePosIndex()
		local list = {}

		for i, v in pairs(posList) do
			if not hasHero(i) and i ~= self._oldPos then
				list[#list + 1] = v
			end
		end

		local random = math.random(1, #list)

		for k, v in pairs(posList) do
			if v.x == list[random].x and v.y == list[random].y then
				return k
			end
		end
	end

	local function createRole(index, posIndex)
		local roleInfo = roleList[index]

		if roleInfo then
			local node = cc.Node:create():addTo(panel)
			local buildingHero = self:instantiateBuildingHero(node)

			node.__mediator = buildingHero

			buildingHero:setHeroInfo(roleInfo, self)

			self._heroList[roleInfo:getRid()] = buildingHero

			local createPos = posIndex or getCreatePosIndex()

			self._oldPos = createPos

			buildingHero:enterWithData(createPos)
		end
	end

	local function getRoleIndex()
		local random = math.random(1, #roleList)
		local roleInfo = roleList[random]

		if table.nums(self._heroList) >= #roleList then
			return 0
		end

		if self._heroList[roleInfo:getRid()] == nil then
			return random
		else
			return getRoleIndex()
		end
	end

	local spwanSec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_ModelSpwanSec", "content")

	local function action()
		local delay = cc.DelayTime:create(spwanSec)
		local call = cc.CallFunc:create(function()
			local roleIndex = getRoleIndex()

			if roleIndex > 0 then
				createRole(roleIndex)
				action()
			end
		end)

		self:getView():runAction(cc.Sequence:create(delay, call))
	end

	local createPos = math.random(1, #posList)

	self._oldPos = createPos

	createRole(random, createPos)
	action()
end

function LeadStageArenaMainMediator:hasHeroStay(posIndex)
	for i, v in pairs(self._heroList) do
		if posIndex == v:getPosIndex() then
			return true
		end
	end

	return false
end

function LeadStageArenaMainMediator:refreshRoleNameInfo()
	for i, v in pairs(self._heroList) do
		v:refreshNameInfo()
	end
end

function LeadStageArenaMainMediator:setClickEnv()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local btn_enter = self:getView():getChildByFullName("main.btn_enter")
		local guide_power = self:getView():getChildByFullName("guide_power")
		local guide_coin = self:getView():getChildByFullName("guide_coin")

		if guide_power then
			storyDirector:setClickEnv("LeadStageArenaMainMediator.info_power", guide_power, nil)
		end

		if guide_coin then
			storyDirector:setClickEnv("LeadStageArenaMainMediator.info_coin", guide_coin, nil)
		end

		storyDirector:setClickEnv("LeadStageArenaMainMediator.enter", btn_enter, function(sender, eventType)
			self:onClickEnter()
		end)

		if btn_enter then
			storyDirector:setClickEnv("LeadStageArenaMainMediator.enter1", btn_enter, nil)
		end

		storyDirector:notifyWaiting("enter_LeadStageArenaMain_view")
	end))

	self:getView():runAction(sequence)
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewMediator.lua

require("dm.gameplay.arena.view.component.ArenaRoleInfoCell")

ArenaNewMediator = class("ArenaNewMediator", DmAreaViewMediator, _M)

ArenaNewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaNewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ArenaNewMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

local kBtnHandlers = {
	button_rule = {
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
	}
}
local rankAnim = {
	"eff_paiming1_mengjingjichang",
	"eff_paiming2_mengjingjichang",
	"eff_paiming3_mengjingjichang"
}
local textRankColor = {
	cc.c3b(103, 94, 130),
	cc.c3b(130, 94, 94),
	cc.c3b(103, 94, 130),
	cc.c3b(255, 255, 255)
}
local maxPower = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_MaxTimes", "content")

function ArenaNewMediator:initialize()
	super.initialize(self)
end

function ArenaNewMediator:stopTimer()
	if self._bubbleTimer then
		self._bubbleTimer:stop()

		self._bubbleTimer = nil
	end

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._main.timer then
		self._main.timer:stop()

		self._main.timer = nil
	end
end

function ArenaNewMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function ArenaNewMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ArenaNewMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_NEW_ARENA_FRESH_RIVAL, self, self.updateView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshChallageNum)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_NEW_ARENA_REWAERD_INFO, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PUSH_PACAKGE_DONE, self, self.createPushBackBoxIcon)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.createPushBackBoxIcon)
end

function ArenaNewMediator:updateView()
	self:refreshRivalView()
	self:refreshLeftView()

	self._bubbleTable = {
		1,
		2,
		3
	}

	self:refreshBubbleShow()
end

function ArenaNewMediator:resumeWithData(viewData)
	self:refreshLeftView()
	self:refreshRedPoint()
	self:setupClickEnvs()
end

function ArenaNewMediator:enterWithData(data)
	self._bubbleTable = {
		1,
		2,
		3
	}

	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:refreshLeftView()
	self:refreshBottomView()
	self:refreshRivalView()
	self:refreshChallageNum()
	self:initBubble()
	self:refreshBubbleShow()
	self:refreshSeasonTimeView()
	self._arenaNewSystem:showNewseasonView()
	self:refreshRedPoint()

	if data and data.pushPacakge then
		self._developSystem:requstNotEnoughItem("ARENA_FAIL", CurrencyIdKind.kDiamond)
	end

	self:createPushBackBoxIcon()
end

function ArenaNewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("ChessArena_System")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("ARENA_TITLE")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ArenaNewMediator:initWidgetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._leftPanel = self._main:getChildByFullName("leftPanel")
	self._rightPanel = self._main:getChildByFullName("rightPanel")
	self._bottomPanel = self:getView():getChildByFullName("bg_bottom")
	self._clonePanel = self._rightPanel:getChildByFullName("Panel_clone")

	self._clonePanel:setVisible(false)

	self._rewardPoint = self._bottomPanel:getChildByFullName("btn_reward.redPoint")

	local btns = {
		"btn_report",
		"btn_rank",
		"btn_reward",
		"btn_team",
		"btn_shop"
	}

	for i = 1, #btns do
		local lineGradiantVec2 = {
			{
				ratio = 0.3,
				color = cc.c4b(255, 255, 255, 255)
			},
			{
				ratio = 0.7,
				color = cc.c4b(167, 186, 255, 255)
			}
		}
		local lineGradiantDir2 = {
			x = 0,
			y = -1
		}
		local btn = self._bottomPanel:getChildByFullName(btns[i])

		btn:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir2))
	end

	self._rightPanel:getChildByFullName("Image_280"):addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:refreshRival(function()
			if not checkDependInstance(self) then
				return
			end

			self:dispatch(ShowTipEvent({
				tip = Strings:get("ClassArena_UI72")
			}))
		end)
	end)
	self._rightPanel:getChildByFullName("Image_280_0"):addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local cur = self._developSystem:getPlayer():getChessArena().challengeTime.value

		if cur < 1 then
			self:showChallageNumNotEnough()
		else
			self:dispatch(ShowTipEvent({
				tip = Strings:get("ClassArena_UI81")
			}))
		end
	end)

	local bg = self._main:getChildByFullName("Image_316")
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	bg:setContentSize(cc.size(bg:getContentSize().width, winSize.height - 118))
end

function ArenaNewMediator:refreshRedPoint()
	self._rewardPoint:setVisible(self._arenaNewSystem:checkNewArenaRewardRedpoint())
end

function ArenaNewMediator:refreshLeftView()
	local panelRank = self._leftPanel:getChildByFullName("Panel_rank")
	local imgRankDi = self._leftPanel:getChildByFullName("Image_rankDi")
	local textCombat = self._leftPanel:getChildByFullName("text_combat")
	local textMaxRank = self._leftPanel:getChildByFullName("text_maxRank")
	local rewardPanel1 = self._leftPanel:getChildByFullName("Panel_reward1")
	local nodeRank = self._leftPanel:getChildByFullName("Node_rank")
	local Panel_head = self._leftPanel:getChildByFullName("Panel_head")
	local text_noreward = self._leftPanel:getChildByFullName("text_noreward")
	local panelRankReward = self._leftPanel:getChildByFullName("Panel_83")
	local textCombatTitle = self._leftPanel:getChildByFullName("text_combatTitle")
	local textMaxRankTitle = self._leftPanel:getChildByFullName("text_maxRankTitle")

	nodeRank:removeAllChildren()
	imgRankDi:setVisible(false)
	panelRank:setVisible(false)
	text_noreward:setVisible(false)
	panelRankReward:setVisible(false)

	local myRank = self._arenaNewSystem:getArenaNew():getCurRank()
	local myMaxRank = self._developSystem:getPlayer():getChessArena().maxRank
	local myCombat = self._developSystem:getTeamByType(StageTeamType.STAGE_NORMAL):getCombat()
	local rankClone = panelRank:clone()

	rankClone:setVisible(true)

	local rankIndex = rankClone:getChildByFullName("text_rank")
	local rankTitle = rankClone:getChildByFullName("text_rank_title")

	rankTitle:setTextColor(textRankColor[myRank] or textRankColor[4])
	rankIndex:setString(myRank < 1 and Strings:get("StageArena_MainUI19") or myRank)

	if myRank <= 3 and myRank > 0 then
		rankIndex:setFontSize(44)

		local anim = cc.MovieClip:create(rankAnim[myRank])

		anim:addTo(nodeRank)

		local mcRank = anim:getChildByFullName("mc_rank")

		rankClone:addTo(mcRank):center(mcRank:getContentSize()):offset(10, 0)
	else
		rankIndex:setFontSize(28)
		imgRankDi:setVisible(true)
		rankClone:addTo(nodeRank):center(nodeRank:getContentSize()):offset(10, 0)
		rankTitle:setPositionX(rankIndex:getPositionX() + rankIndex:getContentSize().width / 2)
		rankTitle:setVisible(myRank > 0 and true or false)
	end

	Panel_head:removeAllChildren()

	local var_15_1 = {
		clipType = 4,
		id = self._developSystem:getheadId()
	}

	var_15_1.headFrameId = self._developSystem:getPlayer():getCurHeadFrame()
	var_15_1.size = cc.size(93, 94)

	local headInfo = var_15_1
	local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

	headIcon:addTo(Panel_head):center(Panel_head:getContentSize()):offset(2, -2)
	headIcon:setScale(0.8)
	oldIcon:setScale(0.5)
	textCombat:setString(myCombat)
	textMaxRank:setString(myMaxRank > 0 and myMaxRank or Strings:get("StageArena_MainUI19"))

	if self._leftPanel:getChildByName("title") then
		self._leftPanel:removeChildByName("title")
	end

	if self._developSystem:getPlayer():getCurTitleId() ~= "" then
		local var_15_2 = {}

		var_15_2.id = self._developSystem:getPlayer():getCurTitleId()

		local icon = IconFactory:createTitleIcon(var_15_2)

		icon:addTo(self._leftPanel):posite(190, 355)
		icon:setName("title")
		icon:setScale(0.51)
		textCombat:setPositionY(403)
		textMaxRank:setPositionY(377)
		textCombatTitle:setPositionY(403)
		textMaxRankTitle:setPositionY(377)
	else
		textCombat:setPositionY(391)
		textMaxRank:setPositionY(361)
		textCombatTitle:setPositionY(391)
		textMaxRankTitle:setPositionY(361)
	end

	rewardPanel1:removeAllChildren()

	local rewardConfig = self._arenaNewSystem:getDailyRewardConfigByRank(myRank)

	if rewardConfig then
		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardConfig.DailyReward, "Content") or {}

		for i = 1, #rewards do
			local icon = IconFactory:createRewardIcon(rewards[i], {
				showAmount = true,
				isWidget = true
			})

			icon:addTo(rewardPanel1)
			icon:setScale(0.65)
			icon:setPosition(cc.p(50 + (i - 1) * 105, rewardPanel1:getContentSize().height / 2 - 7))
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
				needDelay = true
			})
		end
	else
		text_noreward:setVisible(true)
	end

	local allRewardConfig = self._arenaNewSystem:getAllRewardConfig()
	local sort
	local lastConfig = allRewardConfig[rewardConfig and rewardConfig.Sort - 1 or #allRewardConfig]

	if lastConfig then
		local textTarget = panelRankReward:getChildByFullName("text_target")
		local panelReward = panelRankReward:getChildByFullName("Panel_reward2")

		panelReward:removeAllChildren()
		panelRankReward:setVisible(true)
		textTarget:setString("")

		if not self._richText then
			self._richText = ccui.RichText:createWithXML("", {})

			self._richText:setAnchorPoint(textTarget:getAnchorPoint())
			self._richText:setPosition(cc.p(textTarget:getPosition()))
			self._richText:addTo(textTarget:getParent())
		end

		self._richText:setString(Strings:get("ClassArena_UI07", {
			fontSize = 18,
			Num = lastConfig.RankRange[2],
			fontName = TTF_FONT_FZYH_M
		}))

		local rewards = ConfigReader:getDataByNameIdAndKey("Reward", lastConfig.DailyReward, "Content") or {}

		for i = 1, #rewards do
			local icon = IconFactory:createRewardIcon(rewards[i], {
				showAmount = true,
				isWidget = true
			})

			icon:addTo(panelReward)
			icon:setScale(0.65)
			icon:setPosition(cc.p(50 + (i - 1) * 105, panelReward:getContentSize().height / 2 - 7))
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
				needDelay = true
			})
		end
	end
end

function ArenaNewMediator:refreshBottomView()
	local buffConfig = self._arenaNewSystem:getCurSeasonSkillData()

	for i = 1, 2 do
		local buffPanel = self._bottomPanel:getChildByFullName("buff" .. i)
		local buffImage = buffPanel:getChildByFullName("Image_icon")
		local buffInfo = buffPanel:getChildByFullName("Text_name")
		local config = buffConfig[i]

		buffImage:loadTexture("asset/skillIcon/" .. config.Icon .. ".png", ccui.TextureResType.localType)
		buffInfo:setString(Strings:get(config.Name))
		buffImage:addTouchEventListener(function(sender, eventType)
			local text = Strings:get(config.Desc, {
				fontSize = 16,
				fontName = TTF_FONT_FZYH_M
			})

			self:onClickBuff(sender, eventType, text)
		end)
	end

	local text_areana = self._bottomPanel:getChildByFullName("text_areana")
	local gid = self._developSystem:getPlayer():getChessArena().groupId
	local parts = string.split(gid, "_")
	local sid, gid = "", ""

	for i = 1, 3 do
		local s = string.sub(parts[4], i, i) ~= "" and string.sub(parts[4], i, i) or 0

		sid = sid .. s

		local s = string.sub(parts[3], i, i) ~= "" and string.sub(parts[3], i, i) or 0

		gid = gid .. s
	end

	text_areana:setString(Strings:get("ClassArena_UI09", {
		Num = sid .. gid
	}))
end

function ArenaNewMediator:refreshSeasonTimeView()
	local showHour = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ChessArena_ChangeShowTime", "content")
	local timeText = self:getView():getChildByFullName("bg_bottom.Text_time")

	local function update()
		local curTime = self._gameServerAgent:remoteTimestamp()
		local remainTime = self._arenaNewSystem:getEndTime() - curTime

		if remainTime > showHour * 3600 then
			local endTime = TimeUtil:localDate("%Y-%m-%d", self._arenaNewSystem:getEndTime())

			timeText:setString(Strings:get("ClassArena_UI67") .. "  " .. endTime)
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

			timeText:setString(Strings:get("ClassArena_UI08", {
				Time = str
			}))

			if remainTime <= 0 then
				self._arenaNewSystem:checkSeasonData()
				performWithDelay(self:getView(), function()
					self._arenaNewSystem:goBackToMainView()
				end, 0.5)
			end
		end
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, false)

	update()
end

function ArenaNewMediator:onClickBuff(sender, eventType, desc)
	local buffTipPanel = self:getView():getChildByFullName("buffTipPanel")

	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local targetPos = sender:getParent():convertToWorldSpace(cc.p(sender:getPosition()))

		buffTipPanel:setVisible(true)
		buffTipPanel:setPositionX(buffTipPanel:getParent():convertToNodeSpace(targetPos).x - 30)
		buffTipPanel:setPositionY(buffTipPanel:getParent():convertToNodeSpace(targetPos).y + 30)

		local buttText = buffTipPanel:getChildByFullName("text")
		local buttImg = buffTipPanel:getChildByFullName("imageBg")

		buttText:setString("")
		buffTipPanel:removeChildByName("richText")

		local richText = ccui.RichText:createWithXML(desc, {})

		richText:setAnchorPoint(buttText:getAnchorPoint())
		richText:setPosition(cc.p(buttText:getPosition()))
		richText:addTo(buttText:getParent())
		richText:renderContent(250, 0)
		richText:setName("richText")
		buttImg:setContentSize(cc.size(260, richText:getContentSize().height + 10))
		richText:setPositionY(buttImg:getContentSize().height - 5)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		buffTipPanel:setVisible(false)
	end
end

function ArenaNewMediator:refreshChallageNum()
	local img = self._rightPanel:getChildByFullName("Image_280_0")
	local cur = self._developSystem:getPlayer():getChessArena().challengeTime.value
	local text = self._rightPanel:getChildByFullName("text_title3_0")

	text:setString(Strings:get("ClassArena_UI02", {
		Num1 = cur,
		Num2 = maxPower
	}))
	img:setGray(cur > 0)
end

function ArenaNewMediator:refreshRivalView()
	local layout = self._rightPanel:getChildByFullName("Panel_150")

	layout:removeAllChildren()

	self._cellList = {}

	local rivals = self._arenaNewSystem:getArenaNew():getRivalList()
	local unlock, tip = self._systemKeeper:isUnlock("ArenaRush")

	for i = 1, 3 do
		local rivalInfo = rivals[i]
		local panel = self._clonePanel:clone()

		self._cellList[#self._cellList + 1] = panel

		panel:setVisible(true)
		panel:addTo(layout)
		panel:setPositionX(30 + (i - 1) * 250)

		local function callFunc(sender, eventType)
			self:onClickRival(i)
		end

		mapButtonHandlerClick(nil, panel:getChildByFullName("Panel_169_0"), {
			func = callFunc
		})

		local function callFunc(sender, eventType)
			self:onClickRival(i, true)
		end

		local button = panel:getChildByFullName("Panel_169")

		if unlock then
			local quickPassBtn = ccui.ImageView:create("gongdou_but_jujue.png", 1)
			local quickPassIcon = ccui.ImageView:create("main_txt_btn_kstz.png", 1)

			quickPassBtn:setTouchEnabled(true)
			quickPassBtn:setScale(0.58)
			quickPassBtn:addTo(panel)
			quickPassIcon:addTo(quickPassBtn)
			quickPassIcon:center(quickPassBtn:getContentSize())
			quickPassIcon:offset(0, 3)
			quickPassIcon:setScale(1)
			quickPassBtn:setPosition(cc.p(190, 25))
			quickPassBtn:addClickEventListener(function(sender, eventType)
				self:quickCrossPoint(i)
			end)
			button:setScale(0.7)
		end

		mapButtonHandlerClick(nil, button, {
			func = callFunc
		})

		local textRank = panel:getChildByFullName("text_rank")

		textRank:setString(rivalInfo:getRank())

		local textRankTitle = panel:getChildByFullName("text_rank_text")

		textRank:setPositionX(textRankTitle:getPositionX() - textRankTitle:getContentSize().width)

		local Panel_head = panel:getChildByFullName("Panel_head")

		Panel_head:removeAllChildren()

		local headInfo = {
			clipType = 4,
			id = rivalInfo:getHeadImg(),
			headFrameId = rivalInfo:getHeadFrame(),
			size = cc.size(93, 94)
		}
		local headIcon, oldIcon = IconFactory:createPlayerIcon(headInfo)

		headIcon:addTo(Panel_head):center(Panel_head:getContentSize()):offset(2, -2)
		headIcon:setScale(0.8)
		oldIcon:setScale(0.5)

		local roleName = panel:getChildByFullName("role_name")

		roleName:setString(rivalInfo:getNickName())

		local combat = panel:getChildByFullName("text_combatTitle")

		combat:setString(Strings:get("ClassArena_UI04", {
			Num = rivalInfo:getCombat()
		}))

		if panel:getChildByName("title") then
			panel:removeChildByName("title")
		end

		local combatDi = panel:getChildByName("Image_44")

		if rivalInfo:getTitle() ~= "" then
			local icon = IconFactory:createTitleIcon({
				id = rivalInfo:getTitle()
			})

			icon:addTo(panel):posite(116, 298)
			icon:setName("title")
			icon:setScale(0.53)
			combat:setPositionY(253)
			roleName:setPositionY(275)
			combatDi:setPositionY(253)
			Panel_head:setPositionY(308)
			combat:setScale(0.9)
			combatDi:setScale(0.9)
			Panel_head:setScale(0.9)
		else
			combat:setPositionY(258)
			roleName:setPositionY(285)
			combatDi:setPositionY(258)
			Panel_head:setPositionY(298)
		end

		local masterPanel = panel:getChildByFullName("Panel_role")
		local master = rivalInfo:getMaster()
		local roleModle = self._masterSystem:getMasterLeadStageModel(master[1], rivalInfo:getLeadStageId() or "")
		local masterIcon = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe4_5",
			id = roleModle
		})

		masterPanel:removeAllChildren()
		masterIcon:addTo(masterPanel):setPosition(100, 30)

		local panelStage = panel:getChildByFullName("Panel_leadStage")
		local icon = IconFactory:createLeadStageIconHor(rivalInfo:getLeadStageId(), rivalInfo:getLeadStageLevel())

		if icon then
			icon:addTo(panelStage):offset(10, 14)
		end

		local panelTeam = panel:getChildByFullName("Panel_team")

		panelTeam:removeAllChildren()

		local heroIds = rivalInfo:getHeroes()

		for i = 1, 4 do
			if heroIds[i] then
				local heroInfo = {
					id = heroIds[i][1]
				}
				local petNode = IconFactory:createHeroLargeIcon(heroInfo, {
					hideAll = true
				})

				petNode:setScale(0.32)
				petNode:addTo(panelTeam):posite(40 + (i - 1) * 52, 20)
			else
				local emptyIcon = GameStyle:createEmptyIcon(true)

				emptyIcon:setScale(0.5)
				emptyIcon:addTo(panelTeam):posite(40 + (i - 1) * 52, 24)
			end
		end
	end
end

function ArenaNewMediator:onClickRival(index, isEnterTeam)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local cur = self._developSystem:getPlayer():getChessArena().challengeTime.value

	if cur < 1 then
		self:showChallageNumNotEnough()
	else
		self._arenaNewSystem:queryRivalRank(index, function(response)
			local curRank = response.data.rank
			local rival = self._arenaNewSystem:getArenaNew():getRivalList()[index]
			local rank = rival:getRank()

			if curRank ~= rank then
				local myRank = self._arenaNewSystem:getArenaNew():getCurRank()

				if self._arenaNewSystem:getRivalMatchOffset(myRank, curRank) then
					self:showMatchOffset()
				else
					self:showDiffRankAlert(index)
				end
			else
				local data = self._arenaNewSystem:getArenaNew():getRivalList()[index]

				data.index = index

				if isEnterTeam then
					self:onClickFight(index)
				else
					local view = self:getInjector():getInstance("ArenaNewRivalView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, data, nil))
				end
			end
		end)
	end
end

function ArenaNewMediator:showMatchOffset()
	local data = {
		title = Strings:get("Tip_Remind"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("ClassArena_UI82"),
		sureBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf:refreshRival()
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ArenaNewMediator:showDiffRankAlert()
	local data = {
		title = Strings:get("Tip_Remind"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("ClassArena_UI73"),
		sureBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf:refreshRival()
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ArenaNewMediator:refreshRival(callback)
	self._arenaNewSystem:requestGainChessArena(callback, true)
end

function ArenaNewMediator:showChallageNumNotEnough()
	local diamondCost = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_BuyTimesCost", "content")
	local data = {
		isRich = true,
		title = Strings:get("Tip_Remind"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("ClassArena_UI41", {
			num = diamondCost,
			fontName = TTF_FONT_FZYH_M
		}),
		sureBtn = {},
		cancelBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			outSelf:onclickOk()
		end
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ArenaNewMediator:onclickOk()
	local diamondCost = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_BuyTimesCost", "content")
	local hasnum = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)
	local canBuy = diamondCost <= hasnum

	if canBuy then
		self._arenaNewSystem:resetChallengeTime()
	else
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf._arenaNewSystem:enterShopView("Shop_Mall")
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title1 = "Tips",
			title = Strings:get("Tip_Remind"),
			content = Strings:get("CooperateBoss_DimondTip"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end

function ArenaNewMediator:quickCrossPoint(index)
	local remainTimes = self._developSystem:getPlayer():getChessArena().challengeTime.value

	if remainTimes <= 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:showChallageNumNotEnough()

		return
	end

	local anim = cc.MovieClip:create("dajia_zhujuedajia")

	anim:addTo(self:getView()):center(self:getView():getContentSize())

	local delay = cc.DelayTime:create(2)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		self._arenaNewSystem:requestBeginBattle(index, true, function(battleData, reportData)
			if not battleData then
				return
			end

			local result = battleData.result

			if result == 1 then
				local battleStatist = battleData.statist.players
				local view = self:getInjector():getInstance("ArenaVictoryView")
				local userData = {
					isFromNewArena = true,
					replayType = ArenaBattlePlayType.kReport,
					resultData = reportData,
					battleStatist = battleStatist,
					rewards = reportData:getReward(),
					retData = {
						refreshRival = true
					}
				}

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {}, userData, self))
			else
				local id = battleData.playersInfo.challenger.rid
				local loseData = {
					refreshRival = true,
					popName = "ArenaNewView",
					battleStatist = battleData.statist.players,
					resultData = reportData,
					title = Strings:get("ARENA_Defeat_Text"),
					loseId = id
				}

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("ArenaNewLoseView"), {}, loseData, self))
			end
		end)
		anim:setVisible(false)
	end))

	self:getView():runAction(sequence)
end

function ArenaNewMediator:onClickFight(index)
	local remainTimes = self._developSystem:getPlayer():getChessArena().challengeTime.value

	if remainTimes <= 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:showChallageNumNotEnough()

		return
	end

	local view = self:getInjector():getInstance("ArenaNewTeamView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = StageTeamType.CHESS_ARENA_ATK,
		rivalIndex = index
	}))
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
end

local bubblePosX = {
	200,
	450,
	700
}

function ArenaNewMediator:initBubble()
	self._bubbleNode = ccui.Widget:create()

	self._bubbleNode:setCascadeOpacityEnabled(true)
	self._bubbleNode:addTo(self._rightPanel):posite(50, 450)

	local bubbleImg = ccui.Scale9Sprite:createWithSpriteFrameName("zhandou_bg_qipao_1.png")

	bubbleImg:setCapInsets(cc.rect(40, 21, 10, 5))
	bubbleImg:setContentSize(cc.size(200, 96))
	bubbleImg:addTo(self._bubbleNode)
	bubbleImg:setName("bubbleImg")
	bubbleImg:setAnchorPoint(0, 0)
	bubbleImg:setFlippedX(true)
	bubbleImg:setPositionY(-25)

	local bubbleText = ccui.Text:create("", TTF_FONT_FZYH_M, 18)

	bubbleText:setColor(cc.c3b(0, 0, 0))
	bubbleText:getVirtualRenderer():setDimensions(190, 0)
	bubbleText:addTo(self._bubbleNode):posite(12, -8)
	bubbleText:setName("bubbleText")
	bubbleText:setAnchorPoint(0, 0)
	self._bubbleNode:setVisible(false)
end

function ArenaNewMediator:showBubble(index)
	if self._bubbleNode:isVisible() then
		return
	end

	local rival = self._arenaNewSystem:getArenaNew():getRivalList()[index]
	local text = rival:getBubble()
	local staySec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_Autograph", "content")

	self._bubbleNode:setPositionX(bubblePosX[index])
	self._bubbleNode:setVisible(true)
	self._bubbleNode:setOpacity(0)

	local bubbleText = self._bubbleNode:getChildByName("bubbleText")

	if rival:getIsRobot() then
		bubbleText:setString(Strings:get(text))
	else
		if text == "Player_Slogan" then
			text = Strings:get(text)
		end

		bubbleText:setString(text)
	end

	local size = bubbleText:getContentSize()
	local bubbleImg = self._bubbleNode:getChildByName("bubbleImg")
	local height = math.max(41, size.height + 25)
	local strlen = utf8.len(text) * 18
	local w = math.min(210, strlen + 30)

	bubbleText:setPositionX(-w + 15)
	bubbleImg:setContentSize(cc.size(w, height))

	local fadeIn = cc.FadeIn:create(0.2)
	local delay = cc.DelayTime:create(staySec[2])
	local callback = cc.CallFunc:create(function()
		self._bubbleNode:setVisible(false)
	end)

	self._bubbleNode:runAction(cc.Sequence:create(fadeIn, delay, callback))
end

function ArenaNewMediator:refreshBubbleShow()
	local staySec = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_Autograph", "content")

	if self._bubbleTimer then
		self._bubbleTimer:stop()

		self._bubbleTimer = nil
	end

	local function checkTimeFunc()
		if not next(self._bubbleTable) then
			self._bubbleTable = {
				1,
				2,
				3
			}
		end

		local i = math.random(1, #self._bubbleTable)
		local index = self._bubbleTable[i]

		table.remove(self._bubbleTable, i)
		self:showBubble(index)
	end

	self._bubbleTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, staySec[1], false)
end

function ArenaNewMediator:onClickRank()
	local data = {}
	local view = self:getInjector():getInstance("ArenaNewRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function ArenaNewMediator:onClickReport()
	self._arenaNewSystem:requestReport(function()
		local view = self:getInjector():getInstance("ArenaNewReportMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil))
	end)
end

function ArenaNewMediator:onClickShop()
	self._arenaNewSystem:enterShopView("Shop_Normal")
end

function ArenaNewMediator:onClickReward()
	local data = {}
	local view = self:getInjector():getInstance("ArenaNewRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, nil))
end

function ArenaNewMediator:onClickTeam()
	local view = self:getInjector():getInstance("ArenaNewDefendTeamView")
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = StageTeamType.CHESS_ARENA_DEF,
		outself = self
	})

	self:dispatch(event)
end

function ArenaNewMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClassArena_RuleTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		useParam = true,
		rule = Rule,
		param1 = TimeUtil:getSystemResetDate()
	}))
end

function ArenaNewMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function ArenaNewMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("ArenaNewMediator")
	end))

	self:getView():runAction(sequence)
end

function ArenaNewMediator:createPushBackBoxIcon(parentNode, pos, sceneId)
	local sceneId = KShopPushPackageScene.KARENA_FAIL

	IconFactory:createPushBackBoxIcon(self._main, {
		280,
		480
	}, sceneId)
end

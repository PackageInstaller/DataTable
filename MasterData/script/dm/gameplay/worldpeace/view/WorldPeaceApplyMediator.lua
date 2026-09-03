-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceApplyMediator.lua

WorldPeaceApplyMediator = class("WorldPeaceApplyMediator", DmAreaViewMediator, _M)

WorldPeaceApplyMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceApplyMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")
WorldPeaceApplyMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
WorldPeaceApplyMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

local kBtnHandlers = {
	["Panel_bottom.btn_reward"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["Panel_bottom.btn_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	},
	guide = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGuide"
	}
}
local CampImage = {
	"CB_img_zhenying_hong.png",
	"CB_img_zhenying_huang.png",
	"CB_img_zhenying_lan.png"
}

function WorldPeaceApplyMediator:initialize()
	super.initialize(self)
end

function WorldPeaceApplyMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldPeaceApplyMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._bottom = self:getView():getChildByName("Panel_bottom")
	self._applyPanel = self._main:getChildByName("Node_apply")
	self._matchPanel = self._main:getChildByName("Node_match")
	self._condiClone = self._main:getChildByName("Panel_condi")

	self._main:getChildByName("Text_title"):setVisible(false)
	self._condiClone:setVisible(false)

	self._clubClone = self._main:getChildByName("Panel_club")

	self._clubClone:setVisible(false)

	self._applyBtn = self:bindWidget("main.btn_apply", OneLevelMainButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickApply, self)
		}
	})
	self._timeText = self._main:getChildByName("Text_time")
	self._timeDesc = self._main:getChildByName("Text_timeDesc")

	self._timeDesc:setVisible(false)
	self._bottom:getChildByName("btn_rule"):setVisible(false)
end

function WorldPeaceApplyMediator:enterWithData()
	self._worldPeace = self._worldPeaceSystem:getWorldPeace()
	self._timeList = self._worldPeaceSystem:getTimeList()
	self._matchSucc = false

	self:setupTopInfoWidget()
	self:showChat()
	self:setupView()
	self:refreshRedPoint()
	self:mapEventListeners()
	self:startTimer()
end

function WorldPeaceApplyMediator:resumeWithData()
	return
end

function WorldPeaceApplyMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORLDPEACE_APPLY_SUCC, self, self.setupView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_WORLDPEACE_MATCH_END, self, self.setupView)
end

function WorldPeaceApplyMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kClubMapPotion
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("ClubMapBoss_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function WorldPeaceApplyMediator:onClickGuide()
	local view = self:getInjector():getInstance("WordPeaceGuideView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function WorldPeaceApplyMediator:showChat()
	local view = self:getInjector():getInstance("SmallChat")

	if view then
		self:getView():addChild(view)
		AdjustUtils.adjustLayoutByType(view, AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:setMessageBoxType(ChatTabType.kUnion)
			mediator:enterWithData(nil)
			mediator:setMessageBoxType(ChatTabType.kWordPeace)
		end

		if self._worldPeaceSystem:getStatus() ~= WPStatus.kApply then
			self._chatSystem:getHistoryByChannel(ChannelId.kWordPeace)
		else
			self._chatSystem:getChat():getChannel(ChannelId.kWordPeace):clear()
			self._chatSystem:getHistoryByChannel(ChannelId.kWordPeace)
		end
	end
end

function WorldPeaceApplyMediator:setupView()
	self._applyPanel:setVisible(not self._worldPeace:getIsSign())
	self._matchPanel:setVisible(self._worldPeace:getIsSign())

	if self._worldPeace:getIsSign() then
		self:showMatchView()
	else
		self:showAppleView()
	end

	if not CommonUtils.GetSwitch("fn_worldpeace_apply") then
		self._applyBtn:setButtonName(Strings:get("ClubMapBoss_Result_Pause3"))
		self._applyBtn:getView():setGray(true)
	end
end

function WorldPeaceApplyMediator:showAppleView()
	self._condiReach = true

	local needLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition2", "content")
	local condiPanel1 = self._condiClone:clone()

	condiPanel1:setVisible(true)
	condiPanel1:getChildByName("Text_desc"):setString(Strings:get("ClubMapBoss_Required_Desc1", {
		num = needLevel
	}))
	condiPanel1:getChildByName("Image_reach"):setVisible(needLevel <= self._worldPeace:getClubLevel())
	condiPanel1:addTo(self._applyPanel):posite(730, 302)

	if needLevel > self._worldPeace:getClubLevel() then
		self._condiReach = false
	end

	local needCon = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapApplyCondition3", "content")
	local condiPanel2 = self._condiClone:clone()

	condiPanel2:setVisible(true)
	condiPanel2:getChildByName("Text_desc"):setString(Strings:get("ClubMapBoss_Required_Desc2", {
		num = needCon
	}))
	condiPanel2:getChildByName("Image_reach"):setVisible(needCon <= self._worldPeace:getClubCon())
	condiPanel2:addTo(self._applyPanel):posite(730, 260)

	if needCon > self._worldPeace:getClubCon() then
		self._condiReach = false
	end

	self._applyBtn:setButtonName(Strings:get("ClubMapBoss_Match_Button"))
end

function WorldPeaceApplyMediator:showMatchView()
	if not self._clubPanelArr then
		self._clubPanelArr = {}

		for i = 1, 3 do
			local clubPanel = self._clubClone:clone()

			clubPanel:setVisible(false)
			clubPanel:addTo(self._matchPanel:getChildByName("Panel_96")):posite(0, 100 - (i - 1) * 45)

			self._clubPanelArr[#self._clubPanelArr + 1] = clubPanel
		end
	end

	local matchGroup = self._worldPeace:getMatchGroup()

	if #matchGroup > 0 then
		self._matchSucc = true
	end

	if self._matchSucc then
		if self._groupArr then
			for i, v in pairs(self._groupArr) do
				v:stopAllActions()
				v:removeFromParent()

				v = nil
			end

			self._groupArr = {}
		end

		local matchGroup = self._worldPeace:getMatchGroup()

		if matchGroup then
			self._worldPeaceSystem:setCampIndex(matchGroup)

			for i, panel in pairs(self._clubPanelArr) do
				local data = matchGroup[i]

				if data then
					panel:setVisible(true)
					panel:getChildByName("Image_camp"):setVisible(true)
					panel:getChildByName("Image_camp"):loadTexture(CampImage[data.camp], 1)

					local nameText = panel:getChildByName("Text_name")

					nameText:setPositionX(114)
					nameText:setString(data.name)

					local temp = string.split(data.gId, "_")
					local serverText = panel:getChildByName("Text_server")

					serverText:setString("S" .. temp[2])
					panel:setTouchEnabled(true)
				end
			end

			self._applyBtn:setButtonName(Strings:get(""))
			self._timeDesc:setVisible(true)
			self._timeText:setPositionY(170)
			self._timeText:setFontSize(16)
			self._timeDesc:setAnchorPoint(0.5, 0.5)
			self._timeDesc:posite(908, 198)
			self._timeDesc:setString(Strings:get("ClubMapBoss_Countdown_Finish"))

			local curTime = self._gameServerAgent:remoteTimestamp()
			local remainTime = math.max(self._timeList.chatTime1 - curTime, 0)

			self._timeText:setString(TimeUtil:formatTimeStr(remainTime, 2))
		end
	else
		local groupNames = self._worldPeace:getShowGroupNames()

		if not self._groupArr then
			self._groupArr = {}

			for i = 1, #groupNames do
				local panel = self._clubClone:clone()

				panel:setVisible(true)
				panel:addTo(self._matchPanel:getChildByName("Panel_96")):posite(0, 100 - (i - 1) * 25)
				panel:getChildByName("Image_camp"):setVisible(false)

				local nameText = panel:getChildByName("Text_name")
				local serverText = panel:getChildByName("Text_server")

				serverText:setString("")
				nameText:setPositionX(40)
				panel:setTouchEnabled(false)
				nameText:setString(groupNames[i])

				self._groupArr[#self._groupArr + 1] = panel
			end
		end

		local enterTime = self._timeList.battleStartTime
		local date = TimeUtil:localDate("*t", enterTime)
		local week = date.wday == 1 and 7 or date.wday - 1
		local weekStr = GameStyle:getWeekStr(week)

		self._timeText:setVisible(true)
		self._timeText:setString(Strings:get("ClubMapBoss_OpenTime", {
			day = weekStr,
			time = string.format("%02d", date.hour) .. ":" .. string.format("%02d", date.min)
		}))
		self:runRollAction()
		self._applyBtn:setButtonName(Strings:get("ClubMapBoss_Matching"))
		self._timeDesc:setVisible(true)
		self._timeDesc:setAnchorPoint(0, 0.5)
		self._timeDesc:posite(940, 175)
	end
end

function WorldPeaceApplyMediator:runRollAction()
	for i, v in pairs(self._groupArr) do
		v:stopAllActions()
	end

	local moveSpeed = 0.1
	local count = #self._groupArr

	for i, panel in pairs(self._groupArr) do
		local action = cc.MoveBy:create(moveSpeed, cc.p(0, 25))
		local callfunc = cc.CallFunc:create(function()
			local y = panel:getPositionY()

			if y >= 200 then
				panel:setPositionY(y - count * 25)
			end
		end)

		panel:runAction(cc.RepeatForever:create(cc.Sequence:create(action, callfunc)))
	end
end

function WorldPeaceApplyMediator:startTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	local applyTime = self._timeList.applyTime
	local battleEnterTime = self._timeList.battleStartTime
	local chatTime1 = self._timeList.chatTime1
	local chatTime1PRE = self._timeList.chatTime1PRE
	local count = 1

	local function update()
		local curTime = self._gameServerAgent:remoteTimestamp()

		if not self._worldPeace:getIsSign() then
			self._timeText:setVisible(true)

			local remainTime = math.max(applyTime - curTime, 0)

			if remainTime >= 86400 then
				local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

				self._timeText:setString(Strings:get("ClubMapBoss_Match_Time") .. timeStr)
			else
				local format = Strings:get("Common_Time_07")

				self._timeText:setString(Strings:get("ClubMapBoss_Match_Time") .. TimeUtil:formatTime(format, remainTime))
			end
		else
			if not self._matchEnd then
				if not self._matchSucc then
					if curTime > applyTime + 60 then
						self._worldPeaceSystem:requestUpdateData(function()
							if checkDependInstance(self) then
								self:showMatchView()

								self._matchEnd = true
							end
						end, false)
					end
				else
					self._matchEnd = true
				end
			elseif self._matchSucc then
				local format = Strings:get("Common_Time_07")
				local remainTime = math.max(chatTime1 - curTime, 0)

				if remainTime >= 86400 then
					local timeStr = TimeUtil:formatTimeStr(remainTime, 1)

					self._timeText:setString(timeStr)
				else
					local format = Strings:get("Common_Time_07")

					self._timeText:setString(TimeUtil:formatTime(format, remainTime))
				end
			else
				local str = ""

				for i = 1, count do
					str = str .. "."
				end

				self._timeDesc:setString(str)

				count = count + 1

				if count > 3 then
					count = 1
				end
			end

			if curTime >= battleEnterTime + 2 then
				if self._timer then
					self._timer:stop()

					self._timer = nil
				end

				self._worldPeaceSystem:tryEnterMap(function()
					if checkDependInstance(self) then
						self:dismiss()
					end
				end)
			elseif curTime >= chatTime1PRE then
				local isMatch = self._worldPeaceSystem:getWorldPeace():getMatchGroup()

				if #isMatch > 0 then
					local isChatTime = curTime < self._timeList.battleStartTime and curTime > self._timeList.chatTime1PRE

					if isChatTime then
						self._worldPeaceSystem:tryEnterSwearMain(function()
							if checkDependInstance(self) then
								self:dismiss()
							end
						end)
					end
				end
			end
		end
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

function WorldPeaceApplyMediator:refreshRedPoint()
	local rewardBtn = self._bottom:getChildByName("btn_reward")
	local resPoint = rewardBtn:getChildByName("redPoint")

	resPoint:setVisible(false)
end

function WorldPeaceApplyMediator:onClickBack()
	self:dismiss()
end

function WorldPeaceApplyMediator:onClickReward()
	self._worldPeaceSystem:tryEnterRankView()
end

function WorldPeaceApplyMediator:onClickApply()
	return
end

function WorldPeaceApplyMediator:onClickClubPanel(index)
	local matchGroup = self._worldPeace:getMatchGroup()
	local data = matchGroup[index]

	self._clubSystem:requestClubDetailInfoData(data.gId, {
		remainLastView = true,
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, nil)
end

function WorldPeaceApplyMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ClubMapBossRules", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule
	}))
end

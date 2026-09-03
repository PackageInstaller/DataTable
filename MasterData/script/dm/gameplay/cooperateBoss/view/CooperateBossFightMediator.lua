-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/view/CooperateBossFightMediator.lua

CooperateBossFightMediator = class("CooperateBossFightMediator", DmPopupViewMediator)

CooperateBossFightMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CooperateBossFightMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
CooperateBossFightMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCloseClicked"
	}
}

function CooperateBossFightMediator:initialize()
	super.initialize(self)
end

function CooperateBossFightMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self:getView():stopAllActions()
	super.dispose(self)
end

function CooperateBossFightMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function CooperateBossFightMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_BUYTIME, self, self.refreshTimes)
end

function CooperateBossFightMediator:enterWithData(data)
	self:initView()
	self:initData(data)
	self:refreashView()
	performWithDelay(self:getView(), function()
		self:dispatch(Event:new(EVT_COOPERATE_CLOSE_SWEEP))
	end, 0.5)
end

function CooperateBossFightMediator:resumeWithData()
	return
end

function CooperateBossFightMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._bossPanel = self._main:getChildByFullName("bossPanel")
	self._bossName = self._main:getChildByFullName("BgBottom.name")
	self._bossLevel = self._main:getChildByFullName("BgBottom.level")
	self._remainTime = self._main:getChildByFullName("TimeDi.time")
	self._fightBtn = self._main:getChildByFullName("fight")
	self._fifhtNum = self._main:getChildByFullName("Text_Num")
	self._des = self._main:getChildByFullName("BgBottom.text1")
	self._qipaoText = self._main:getChildByFullName("qipao.text")

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(235, 58, 151, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(135, 0, 29, 255)
		}
	}
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(0, 0, 0, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(60, 1, 21, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._bossName:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))
	self._des:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	self._fightBtn:addClickEventListener(function()
		self:onFigthClicked()
	end)
end

function CooperateBossFightMediator:initData(data)
	self._cooperatorBoss = self._cooperateBossSystem:getCooperateBoss()
	self._mineBoss = self._cooperatorBoss:getMineBoss()
	self._bossCraeteTime = self._mineBoss.bossCreateTime
	self._configBossId = self._mineBoss.confId
	self._bossConfig = ConfigReader:getRecordById("CooperateBossMain", self._configBossId)
	self._bossId = self._mineBoss.bossId
end

function CooperateBossFightMediator:refreashView()
	local text1 = self._main:getChildByFullName("BgBottom.text1")

	self._bossName:setString(self._cooperateBossSystem:getBossName(self._configBossId))
	self._bossName:setPositionX(text1:getContentSize().width + text1:getPositionX() + 20)
	self._bossLevel:setPositionX(self._bossName:getContentSize().width + self._bossName:getPositionX() + 20)

	local model = self._cooperatorBoss:getRoleModelId()
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = model
	})

	img:addTo(self._bossPanel)
	img:setPosition(cc.p(330, 250))
	img:setScale(0.78)

	local endTime = self._bossCraeteTime + self._cooperatorBoss:getBossLiveTime()

	local function checkTimeFunc()
		remoteTimestamp = self._gameServerAgent:remoteTimestamp()

		local remainTime = endTime - remoteTimestamp

		if remainTime < 0 then
			self._timer:stop()

			self._timer = nil

			self:onCloseClicked()

			return
		end

		local fmtStr = "${d}:${H}:${M}:${S}"
		local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
		local parts = string.split(timeStr, ":", nil, true)
		local timeTab = {}

		timeTab.hour = tonumber(parts[2])
		timeTab.min = tonumber(parts[3])
		timeTab.sec = tonumber(parts[4])

		local time = string.format("%02d:%02d:%02d", timeTab.hour, timeTab.min, timeTab.sec)

		self._remainTime:setString(Strings:get("CooperateBoss_Trigger_UI02", {
			countdown = time
		}))
	end

	if self._timer == nil then
		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end

	local player = self._developSystem:getPlayer()
	local level = player:getLevel()
	local bossLevel = self._cooperatorBoss:getBossLevel(level)

	self._bossLevel:setString(Strings:get("CooperateBoss_Invite_UI32", {
		level = bossLevel
	}))

	local num1 = self._cooperatorBoss:getBossFightTimes().value or 0
	local num2 = self._cooperatorBoss:getFightNumMax()

	self._fifhtNum:setString(tostring(num1) .. "/" .. tostring(num2))

	if num1 <= 0 then
		self._fifhtNum:setTextColor(cc.c3b(255, 117, 117))
	else
		self._fifhtNum:setTextColor(cc.c3b(255, 255, 255))
	end

	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:setPosition(cc.p(100, 100))
	self._fightBtn:addChild(mc)
	self._fightBtn:setOpacity(0)

	local act = cc.Sequence:create(cc.DelayTime:create(0.4375), cc.FadeIn:create(0.3125))

	self._fightBtn:runAction(act:clone())

	local inviteBubble = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_MyBossBubble", "content")

	self._qipaoText:setString(Strings:get(inviteBubble[math.random(1, #inviteBubble)]))
end

function CooperateBossFightMediator:refreshTimes()
	local num1 = self._cooperatorBoss:getBossFightTimes().value or 0
	local num2 = self._cooperatorBoss:getFightNumMax()

	self._fifhtNum:setString(tostring(num1) .. "/" .. tostring(num2))

	if num1 <= 0 then
		self._fifhtNum:setTextColor(cc.c3b(255, 117, 117))
	else
		self._fifhtNum:setTextColor(cc.c3b(255, 255, 255))
	end
end

function CooperateBossFightMediator:onFigthClicked()
	local state, buytime = self._cooperateBossSystem:CanJoinCooperateBoss()

	if state == kCooperateBossFightTimeState.kCanFight then
		self:onCloseClicked()
		self._cooperateBossSystem:enterCooperateBossInviteFriendView(self._bossId)
	elseif state == kCooperateBossFightTimeState.kBuyTime then
		local view = self:getInjector():getInstance("CooperateBossBuyTimeView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, nil))
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("CooperateBoss_UI05")
		}))
	end

	print("onFigthClicked")
end

function CooperateBossFightMediator:onCloseClicked(sender, eventType)
	self:close()
end

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/home/PlayerInfoWidget.lua

PlayerInfoWidget = class("PlayerInfoWidget", BaseWidget, _M)

PlayerInfoWidget:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
PlayerInfoWidget:has("_headId", {
	is = "rw"
})
PlayerInfoWidget:has("_time", {
	is = "rw"
})
PlayerInfoWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlayerInfoWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
PlayerInfoWidget:has("_passSystem", {
	is = "r"
}):injectWith("PassSystem")
PlayerInfoWidget:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

function PlayerInfoWidget.class:createWidgetNode()
	local resFile = "asset/ui/PlayerInfoWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function PlayerInfoWidget:initialize(view)
	super.initialize(self, view)

	self._view = view
end

function PlayerInfoWidget:dispose()
	if self._netInfoWidget then
		self._netInfoWidget:dispose()

		self._netInfoWidget = nil
	end

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._batteryTimer then
		LuaScheduler:getInstance():unschedule(self._batteryTimer)

		self._batteryTimer = nil
	end

	self:getEventDispatcher():removeEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
	self:getEventDispatcher():removeEventListener(EVT_BUY_MONTHCARD_SUCC, self, self.setMonthCardState)
	self:getEventDispatcher():removeEventListener(EVT_RESET_DONE, self, self.setMonthCardState)
	super.dispose(self)
end

function PlayerInfoWidget:initSubviews()
	local winSize = cc.Director:getInstance():getWinSize()

	self._main = self._view:getChildByName("main")
	self._infoPanel = self._main:getChildByFullName("info_panel")
	self._name = self._infoPanel:getChildByFullName("name_text")
	self._touchPanel = self._infoPanel:getChildByFullName("touchPanel")
	self._progressTip = self._infoPanel:getChildByFullName("progressTip")

	self._progressTip:setVisible(false)

	self._level = self._infoPanel:getChildByFullName("level_text")
	self._vipLevel = self._infoPanel:getChildByFullName("vip_level")
	self._headRectNode = self._infoPanel:getChildByFullName("head_icon")

	self._headRectNode:setContentSize(cc.size(88, 88))
	self._headRectNode:setTouchEnabled(true)
	self._headRectNode:addTouchEventListener(function(sender, eventType)
		self:onClickHead(sender, eventType)
	end)

	self._expBar = self._infoPanel:getChildByFullName("progressBg.exBar")
	self._vipNode = self._infoPanel:getChildByFullName("vipnode")
	self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidget:new(self._vipNode))
	self._batteryPower = self._main:getChildByFullName("node.battery.power")
	self._timeText = self._main:getChildByFullName("node.time")

	self._timeText:enableShadow(cc.c4b(0, 0, 0, 90), cc.size(0, -2), 1)

	self._combat = self._infoPanel:getChildByName("combatText")

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(148, 148, 148, 255)
		}
	}

	self._combat:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	local function callFunc(sender, eventType)
		return
	end

	for i = 1, 3 do
		local _monthCard = self._infoPanel:getChildByName("monthCard" .. i)

		mapButtonHandlerClick(nil, _monthCard, {
			func = callFunc
		})
	end

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self._progressTip:setVisible(true)
		elseif eventType == ccui.TouchEventType.ended or eventType == ccui.TouchEventType.canceled then
			self._progressTip:setVisible(false)
		end
	end)
end

function PlayerInfoWidget:setNetInfoNodePos(position)
	local targetNode = self._main:getChildByName("node")

	targetNode:setPosition(position)
	AdjustUtils.adjustLayoutByType(targetNode, AdjustUtils.kAdjustType.Right)
	AdjustUtils.adjustLayoutByType(targetNode, AdjustUtils.kAdjustType.Top)
end

function PlayerInfoWidget:setNetInfoNodeDefault()
	local targetNode = self._main:getChildByName("node")

	targetNode:setPosition(cc.p(-8.6, 564))
	AdjustUtils.adjustLayoutByType(targetNode, AdjustUtils.kAdjustType.Left)
	AdjustUtils.adjustLayoutByType(targetNode, AdjustUtils.kAdjustType.Top)
end

function PlayerInfoWidget:registerTimerEvent(callFunc)
	self._registerTimerEvent = true
	self._timerCallFunc = callFunc and callFunc or function()
		return
	end
end

function PlayerInfoWidget:unregisterTimerEvent()
	self._registerTimerEvent = false

	function self._timerCallFunc()
		return
	end
end

function PlayerInfoWidget:setName(name)
	if self._name then
		self._name:setString(name or "")

		local nameWidth = self._name:getContentSize().width
		local offsetX = self._name:getPositionX() + nameWidth + 8

		self._vipNode:setPositionX(offsetX)
	end
end

function PlayerInfoWidget:setCombat(combat)
	if self._combat then
		self._combat:setString(combat or 0)
	end
end

function PlayerInfoWidget:setLevel(level)
	self._level:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)

	local progressBg = self._infoPanel:getChildByFullName("progressBg")
end

function PlayerInfoWidget:setVipLevel(level)
	if self._playerVipWidget then
		level = level or 0

		self._playerVipWidget:updateView(level)
	end
end

function PlayerInfoWidget:setHeadId(headId)
	if self._headRectNode then
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local player = developSystem:getPlayer()
		local rectNode = self._headRectNode

		rectNode:removeAllChildren(true)

		local headicon, oldIcon = IconFactory:createPlayerIcon({
			clipType = 4,
			id = player:getHeadId(),
			size = cc.size(93, 94),
			headFrameId = player:getCurHeadFrame()
		})

		headicon:setScale(1.15)
		oldIcon:setScale(0.5)
		rectNode:setScale(0.7)
		headicon:addTo(rectNode):center(rectNode:getContentSize())
	end
end

function PlayerInfoWidget:setMonthCardState()
	self._progressTip:setVisible(false)

	local rechargeAndVipSystem = self:getInjector():getInstance(RechargeAndVipSystem)
	local model = rechargeAndVipSystem:getRechargeAndVipModel()
	local cardList = model:getMonthCardList()
	local monthCardCount = 0

	for i = 1, #cardList do
		local curTime = self._gameServer:remoteTimeMillis()

		if curTime < cardList[i]:getEndTimes() then
			monthCardCount = monthCardCount + 1
		end

		local _monthCardIcon = self._infoPanel:getChildByName("monthCard" .. i)

		_monthCardIcon:setVisible(false)
	end

	local monthCardIcon = self._infoPanel:getChildByName("monthCard" .. monthCardCount)

	if monthCardIcon then
		monthCardIcon:setVisible(false)
	end
end

function PlayerInfoWidget:setBatteryPower()
	if device.platform ~= "mac" then
		local percent = app.getDevice():getBatteryLevel()

		if self._batteryPower then
			self._batteryPower:setPercent(percent or 100)
		end
	end
end

function PlayerInfoWidget:addBatteryTimerSchedule()
	if self._batteryTimer == nil then
		local function update()
			self:setBatteryPower()
		end

		self._batteryTimer = LuaScheduler:getInstance():schedule(update, 10, true)

		self:setBatteryPower()
	end
end

function PlayerInfoWidget:setExpProgress()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local player = developSystem:getPlayer()
	local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
	local currentExp = player:getExp()
	local percent = currentExp / config.PlayerExp * 100

	self._expBar:setPercent(percent)

	local bg = self._progressTip:getChildByFullName("bg")
	local exp1 = self._progressTip:getChildByFullName("exp1")
	local exp2 = self._progressTip:getChildByFullName("exp2")

	exp1:setString(currentExp)
	exp2:setString("/" .. config.PlayerExp)

	local exp1Width = exp1:getContentSize().width
	local exp2Width = exp2:getContentSize().width

	exp2:setPositionX(exp1:getPositionX() + exp1Width)
	bg:setContentSize(cc.size(82 + exp1Width + exp2Width, 33))
end

function PlayerInfoWidget:clock()
	if self._timeText and self._timer == nil then
		local isShowSemicolon = true

		local function update()
			local serverTime = self:getGameServer():remoteTimestamp()

			if isShowSemicolon then
				self._timeText:setString(os.date("%H:%M", serverTime))
			else
				self._timeText:setString(os.date("%H:%M", serverTime))
			end

			isShowSemicolon = not isShowSemicolon

			self._timeText:setString(TimeUtil:localDate("%H:%M", serverTime))

			if self._registerTimerEvent then
				self._timerCallFunc()
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(update, 2, true)
	end
end

function PlayerInfoWidget:setupNetInfoWidget()
	local netInfoView = self._main:getChildByFullName("node.netinfo_node")
	local netInfoWidget = NetInfoWidget:new(netInfoView)

	self:getInjector():injectInto(netInfoWidget)
	netInfoWidget:setupView()

	self._netInfoWidget = netInfoWidget
end

function PlayerInfoWidget:setupView()
	self:clock()
	self:setupNetInfoWidget()
	self:addBatteryTimerSchedule()
	self:updateView()
	self:setMonthCardState()
	self:getEventDispatcher():addEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
	self:getEventDispatcher():addEventListener(EVT_BUY_MONTHCARD_SUCC, self, self.setMonthCardState)
	self:getEventDispatcher():addEventListener(EVT_RESET_DONE, self, self.setMonthCardState)
end

function PlayerInfoWidget:onBatteryChange(event)
	local data = event:getData()

	if data and data.batteryLevel then
		self:setBatteryPower(data.batteryLevel)
	end
end

function PlayerInfoWidget:updateView()
	self._progressTip:setVisible(false)

	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local team = developSystem:getTeamByType(StageTeamType.STAGE_NORMAL)
	local heros = team:getHeroes()
	local masterId = team:getMasterId()
	local leadConfig = developSystem._masterSystem:getMasterCurLeadStageConfig(masterId)

	if leadConfig then
		if not leadConfig.LeadFightHero then
			local addPercent = 0
			local totalCombat = 0

			for k, v in pairs(heros) do
				local heroInfo = developSystem._heroSystem:getHeroById(v)

				totalCombat = totalCombat + heroInfo:getSceneCombatByType(SceneCombatsType.kAll)
			end

			totalCombat = leadConfig and math.ceil((addPercent + 1) * totalCombat) or totalCombat

			local masterData = developSystem._masterSystem:getMasterById(masterId)

			totalCombat = masterData and totalCombat + masterData:getCombat() or totalCombat

			local info = {
				name = developSystem:getNickName(),
				headId = developSystem:getheadId(),
				vipLevel = developSystem:getVipLevel(),
				combat = totalCombat,
				level = developSystem:getLevel()
			}

			self:setName(info.name)
			self:setCombat(info.combat)
			self:setLevel(info.level)
			self:setVipLevel(info.vipLevel)
			self:setHeadId(info.headId)
			self:setExpProgress()
		end
	end
end

function PlayerInfoWidget:onClickHead(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Open_1", false)

		local player = self._developSystem:getPlayer()

		self._settingSystem:tryEnter(player:getRid())
	end
end

function PlayerInfoWidget:initAnim()
	return
end

function PlayerInfoWidget:replayAnim()
	return
end

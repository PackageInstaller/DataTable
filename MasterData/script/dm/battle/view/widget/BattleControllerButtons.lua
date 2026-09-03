-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleControllerButtons.lua

local __BattleControllerSpeed = {
	1,
	2
}

BattleControllerButtons = class("BattleControllerButtons", BattleWidget, _M)

function BattleControllerButtons:initialize(view)
	super.initialize(self, view)
end

function BattleControllerButtons:initWithData(args)
	self._listener = args.listener
	self._auto = not not args.btnsState.auto.state
	self._canChangeSpeed = args.canChangeSpeedLevel
	self._canChangeAuto = true
	self._btnsState = args.btnsState
	self.speedConfig = GameConfigs.battleControllerSpeed or self._btnsState.speed.speedConfig or __BattleControllerSpeed
	self.speedShowConfig = GameConfigs.battleControllerSpeed or self._btnsState.speed.speedShowConfig or __BattleControllerSpeed

	if self._btnsState.auto and self._btnsState.auto.canChangeAuto ~= nil then
		self._canChangeAuto = self._btnsState.auto.canChangeAuto
	end

	if args.isReplay then
		self._auto = true
		self._canChangeAuto = false
	end

	self._speedLevel = self.speedConfig[1]

	if self._btnsState.speed and self._btnsState.speed.visible and not self._btnsState.speed.lock and self._btnsState.speed.timeScale then
		self._speedLevel = self._btnsState.speed.timeScale
	end

	self._autoButtons = {}

	self:_setupView()
end

function BattleControllerButtons:setListener(listener)
	self._listener = listener
end

function BattleControllerButtons:setTouchEnabled(enabled)
	self._touchPanel:setTouchEnabled(not enabled)
end

function BattleControllerButtons:isTouchEnabled()
	return not self._touchPanel:isTouchEnabled()
end

function BattleControllerButtons:_setupView()
	self._touchPanel = self:getView():getChildByName("touch_panel")

	local autoPanel = self:getView():getChildByName("auto_panel")

	self._autoLabelNode = autoPanel:getChildByName("label_node")
	self._autoLabels = {
		self._autoLabelNode:getChildByName("auto_enabled"),
		self._autoLabelNode:getChildByName("auto_disabled")
	}

	local auto_enabled = autoPanel:getChildByName("auto_enabled")

	auto_enabled:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:_resetAutoBtns(sender)
		end
	end)

	self._autoButtons[#self._autoButtons + 1] = auto_enabled

	local auto_disabled = autoPanel:getChildByName("auto_disabled")

	auto_disabled:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			local systemKeeper = self._listener:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("AutoFight")

			if not unlock then
				self._listener:getDispatcher():dispatch(ShowTipEvent({
					duration = 0.2,
					tip = tips
				}))

				return
			end

			self:_resetAutoBtns(sender)
		end
	end)

	self._autoButtons[#self._autoButtons + 1] = auto_disabled

	local pausePanel = self:getView():getChildByName("pause_panel")

	self._pauseBtn = pausePanel:getChildByName("pause_btn")

	self._pauseBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self._listener:onPause()
		end
	end)

	local restraint_panel = self:getView():getChildByName("restraint_panel")

	self._restraintBtn = restraint_panel:getChildByName("btn")

	self._restraintBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			local systemKeeper = self._listener:getInjector():getInstance("SystemKeeper")
			local unlock, tips = systemKeeper:isUnlock("Button_CombateDominating")

			if not unlock then
				self._listener:getDispatcher():dispatch(ShowTipEvent({
					duration = 0.2,
					tip = tips
				}))

				return
			end

			self._listener:onRestraint()
		end
	end)

	self._speedPanel = self:getView():getChildByName("speed_panel")
	self._speedLabel = self._speedPanel:getChildByName("label1")
	self._speedLabel1 = self._speedPanel:getChildByName("label2")

	local localLanguage = getCurrentLanguage()

	if localLanguage ~= GameLanguageType.CN then
		self._speedLabel:setVisible(false)
		self._speedLabel1:setVisible(false)

		self._speedLabel = self._speedPanel:getChildByName("label3")

		self._speedLabel:setVisible(true)
	else
		self._speedPanel:getChildByName("label3"):setVisible(false)
	end

	self._speedBtn = self._speedPanel:getChildByName("speed_btn")

	self._speedBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:_resetSpeedBtns(sender)
		end
	end)
	self:_initSpeedBtns()

	local skipPanel = self:getView():getChildByName("skip_panel")
	local label1 = skipPanel:getChildByName("label")
	local label2 = skipPanel:getChildByName("label2")
	local label3 = skipPanel:getChildByName("label3")
	local localLanguage = getCurrentLanguage()

	if localLanguage ~= GameLanguageType.CN then
		label1:setVisible(false)
		label2:setVisible(false)
		label3:setVisible(true)
	else
		label3:setVisible(false)
		label1:setVisible(true)
		label2:setVisible(true)
	end

	self._skipBtn = skipPanel:getChildByFullName("skip_btn")

	self._skipBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			if self._skipWaiting then
				local tips = self._btnsState.skip.waitTips

				if tips then
					self._listener:getDispatcher():dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:get(tips, {
							num = math.ceil(self._waitTime)
						})
					}))
				end

				return
			end

			if self._skipLocked then
				return
			end

			self._listener:onSkip()
		end
	end)

	local btns = {
		{
			key = "pause",
			node = pausePanel,
			touch = {
				self._pauseBtn
			}
		},
		{
			key = "skip",
			node = skipPanel,
			touch = {
				self._skipBtn
			},
			lock = skipPanel:getChildByName("lock")
		},
		{
			key = "auto",
			node = autoPanel,
			touch = self._autoButtons,
			lock = autoPanel:getChildByName("lock")
		},
		{
			key = "speed",
			node = self._speedPanel,
			touch = {
				self._speedBtn
			},
			lock = self._speedPanel:getChildByName("lock")
		},
		{
			key = "speed",
			node = self._speedPanel,
			touch = {
				self._speedBtn
			},
			lock = self._speedPanel:getChildByName("lock")
		},
		{
			key = "restraint",
			node = restraint_panel,
			touch = {
				self._restraintBtn
			},
			lock = restraint_panel:getChildByName("lock")
		}
	}

	self:_setBtnsPosition(btns)
	self:_setupSkipBtn()
	self:_setupAutoBtns()
end

function BattleControllerButtons:_setBtnsPosition(btns)
	local btnsState = self._btnsState

	for _, cfg in ipairs(btns) do
		local node = cfg.node
		local state = btnsState[cfg.key]

		if state and btnsState[cfg.key].visible ~= false then
			node:setVisible(true)
		else
			node:setVisible(false)
		end

		if state then
			if state.enable == false and cfg.touch then
				for _, touch in ipairs(cfg.touch) do
					touch:setTouchEnabled(false)
				end
			end

			if state.lock then
				if cfg.lock then
					self["_" .. cfg.key .. "Locked"] = true

					cfg.lock:setVisible(true)
				end
			elseif cfg.lock then
				cfg.lock:setVisible(false)
			end
		end
	end
end

function BattleControllerButtons:_setupSkipBtn()
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 219, 177, 255)
		}
	}
	local skipPanel = self:getView():getChildByName("skip_panel")
	local label1 = skipPanel:getChildByFullName("label")

	label1:enableOutline(cc.c4b(255, 255, 255, 153), 1)

	local label2 = skipPanel:getChildByName("label2")

	label2:enableOutline(cc.c4b(255, 255, 255, 153), 1)

	local label3 = skipPanel:getChildByName("label3")

	label3:enableOutline(cc.c4b(255, 255, 255, 153), 1)

	local function setSkipLabelVisible(visible)
		local localLanguage = getCurrentLanguage()

		if localLanguage ~= GameLanguageType.CN then
			label1:setVisible(false)
			label2:setVisible(false)
			label3:setVisible(visible)
		else
			label3:setVisible(false)
			label1:setVisible(visible)
			label2:setVisible(visible)
		end
	end

	local state = self._btnsState.skip

	if state.skipTime and state.enable and skipPanel:isVisible() then
		self._waitTime = state.skipTime

		setSkipLabelVisible(false)

		local timeLabel = cc.Label:createWithTTF(tostring(math.ceil(self._waitTime)), TTF_FONT_FZYH_R, 20)

		timeLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
			x = 0,
			y = -1
		}))
		timeLabel:enableOutline(cc.c4b(35, 15, 5, 153), 2)
		timeLabel:addTo(self._skipBtn, 1):center(self._skipBtn:getContentSize()):offset(-3, 1)

		self._skipLabel = timeLabel
		self._skipWaiting = true
		self._increasingTask = self._listener:getScheduler():schedule(function(task, dt)
			if self._waitTime <= 0 then
				return
			end

			if not self._listener.isReady or not self._listener:isReady() then
				return
			end

			local integer = math.floor(self._waitTime)
			local point = self._waitTime - integer

			point = point - dt
			self._waitTime = integer + point

			if point <= 0 then
				self._skipLabel:setString(tostring(math.ceil(self._waitTime)))

				if self._waitTime <= 0 then
					self._skipLabel:removeFromParent()

					self._skipLabel = nil
					self._skipWaiting = false

					setSkipLabelVisible(true)
				end
			end
		end)
	else
		setSkipLabelVisible(true)
	end
end

function BattleControllerButtons:_setupAutoBtns()
	if self._auto then
		self:_resetSpeedBtnsByAuto()
	end

	local curBtnName = self._auto and "auto_enabled" or "auto_disabled"
	local curBtn

	for _, btn in ipairs(self._autoButtons) do
		if btn:getName() == curBtnName then
			btn:setVisible(true)

			curBtn = btn
		else
			btn:setVisible(false)
		end
	end

	if curBtn and not self._canChangeAuto then
		curBtn:setEnabled(false)
	end

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 219, 177, 255)
		}
	}

	for _, labelnode in ipairs(self._autoLabels) do
		local label1 = labelnode:getChildByName("label")

		label1:enableOutline(cc.c4b(255, 255, 255, 153), 1)

		local label2 = labelnode:getChildByName("label2")

		label2:enableOutline(cc.c4b(255, 255, 255, 153), 1)

		local label3 = labelnode:getChildByName("label3")

		label3:enableOutline(cc.c4b(255, 255, 255, 153), 1)

		local localLanguage = getCurrentLanguage()

		if localLanguage ~= GameLanguageType.CN then
			label1:setVisible(false)
			label2:setVisible(false)
			label3:setVisible(true)
		else
			label3:setVisible(false)
		end

		labelnode:setVisible(labelnode:getName() == curBtnName)
	end

	self._listener:onAutoChanged(self._auto == true)

	self._autoEffect = cc.MovieClip:create("zidongxunhuan_xitonganniu")

	self._autoEffect:addTo(self:getView():getChildByName("auto_panel")):posite(curBtn:getPosition()):offset(-2, 1.5):setVisible(self._auto == true)
end

function BattleControllerButtons:_resetAutoBtns(sender)
	if sender:getName() == "auto_disabled" then
		self:_resetSpeedBtnsByAuto()
	end

	local nextButton

	for i, button in ipairs(self._autoButtons) do
		if button:getName() == sender:getName() then
			nextButton = i + 1 <= #self._autoButtons and self._autoButtons[i + 1] or self._autoButtons[1]

			button:setVisible(false)
			nextButton:setVisible(false)

			self._auto = nextButton:getName() == "auto_enabled"

			local curLabel = self._autoLabelNode:getChildByName(button:getName())
			local nextLabel = self._autoLabelNode:getChildByName(nextButton:getName())

			nextLabel:setVisible(true)
			curLabel:setVisible(true)
			self._autoEffect:setVisible(false)

			local anim = cc.MovieClip:create("dha_xitonganniu")

			anim:addCallbackAtFrame(11, function(cid, mc)
				mc:stop()
				mc:removeFromParent()
				curLabel:posite(0, 0):changeParent(self._autoLabelNode)
				curLabel:setVisible(false)
				nextLabel:posite(0, 0):changeParent(self._autoLabelNode)
				nextButton:setVisible(true)
				self._autoEffect:setVisible(self._auto)
			end)
			anim:play()
			anim:posite(26, 26.5):addTo(self:getView():getChildByName("auto_panel"))
			curLabel:posite(1.2999999999999998, -2.1):changeParent(anim:getChildByFullName("oldlabel"))
			nextLabel:posite(0.6, -0.45):changeParent(anim:getChildByFullName("newlabel"))

			break
		end
	end

	if self._listener.onAutoBtnClick then
		self._listener.onAutoBtnClick()
	end

	self._listener:onAutoChanged(self._auto)
end

function BattleControllerButtons:_initSpeedBtns()
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 219, 177, 255)
		}
	}

	self._speedLabel:enableOutline(cc.c4b(255, 255, 255, 153), 1)
	self._speedLabel1:enableOutline(cc.c4b(255, 255, 255, 153), 1)

	self._speedEffect = cc.MovieClip:create("zidongxunhuan_xitonganniu")

	self._speedEffect:addTo(self._speedPanel):offset(25, 28)
	self:resetSpeedLable()
	self._listener:onSpeedLevelChanged(self._speedLevel)

	if GameConfigs.battleControllerSpeed or DEBUG and DEBUG > 1 then
		self._speedPanel:setVisible(true)
	else
		self._speedPanel:setVisible(false)
	end
end

function BattleControllerButtons:_resetSpeedBtns(sender, isForce)
	if not self:isTouchEnabled() and not isForce then
		return
	end

	if self._btnsState.speed and self._btnsState.speed.lock then
		local var_21_0 = {
			duration = 0.2
		}

		var_21_0.tip = self._btnsState.speed.tip or ""

		self._listener:getDispatcher():dispatch(ShowTipEvent(var_21_0))

		return
	end

	local n = #self.speedConfig

	for i = 1, n do
		local speedLevel = self.speedConfig[i]

		if speedLevel == self._speedLevel then
			self._speedLevel = self.speedConfig[i % n + 1]

			break
		end
	end

	self:resetSpeedLable()
	self._listener:onSpeedLevelChanged(self._speedLevel)
end

function BattleControllerButtons:_resetSpeedBtnsByAuto()
	local speedLevel = self.speedConfig[1]

	if speedLevel == self._speedLevel then
		self:_resetSpeedBtns(nil, true)
	end
end

function BattleControllerButtons:resetSpeedLable()
	local n = #self.speedConfig
	local lvShow = self._speedLevel

	for i = 1, n do
		local speedLevel = self.speedConfig[i]

		if speedLevel == self._speedLevel then
			lvShow = self.speedShowConfig[i] or speedLevel

			break
		end
	end

	if lvShow == 1 then
		self._speedLabel:setString(Strings:get("BattleSpeedUpWord_Normal_1"))
		self._speedLabel1:setString(Strings:get("BattleSpeedUpWord_Normal_2"))
		self._speedEffect:setVisible(false)
	else
		self._speedLabel:setString(Strings:get("BattleSpeedUpWord_SpeedUp_1"))
		self._speedLabel1:setString(Strings:get("BattleSpeedUpWord_SpeedUp_2"))
		self._speedEffect:setVisible(true)
	end
end

function BattleControllerButtons:guideChangeAutoBtns(state)
	local node = cc.Node:create()

	if state then
		node:setName("auto_disabled")
		self:_resetAutoBtns(node)
	else
		node:setName("auto_enabled")
		self:_resetAutoBtns(node)
	end
end

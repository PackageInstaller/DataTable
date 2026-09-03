-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleTimerWidget.lua

BattleTimerWidget = class("BattleTimerWidget", BattleWidget, _M)

function BattleTimerWidget:initialize(view, scheduler)
	super.initialize(self, view)

	self._timelimit = 0

	local minLabel = view:getChildByFullName("min.lab")
	local secLabel = view:getChildByFullName("sec.lab")

	minLabel:setAdditionalKerning(8)
	secLabel:setAdditionalKerning(8)
	self:_setupCountdown(view, scheduler)
	view:setVisible(false)
end

function BattleTimerWidget:dispose()
	if self._countdown then
		self._countdown:stop()

		self._countdown = nil
	end

	if self._newPhaseTask then
		self._newPhaseTask:stop()

		self._newPhaseTask = nil
	end

	super.dispose(self)
end

function BattleTimerWidget:setTimelimit(timelimit)
	self._timelimit = timelimit
end

function BattleTimerWidget:_setupCountdown(view, scheduler)
	local minLabel = view:getChildByFullName("min.lab")

	minLabel:setString("00:")

	self._minLabel = minLabel

	local secLabel = view:getChildByFullName("sec.lab")

	secLabel:setString("00")

	self._secLabel = secLabel
	self._minStr = "00:"
	self._secStr = "00"
	self._minNode = view:getChildByName("min")
	self._secNode = view:getChildByName("sec")
	self._secAnim = cc.MovieClip:create("dh_daojishi", "BattleMCGroup")

	self._secAnim:addTo(self._secNode):addCallbackAtFrame(11, function(cid, mc)
		mc:stop()
	end)

	self._secAnimNode = self._secAnim:getChildByFullName("num")

	self._secLabel:changeParent(self._secAnimNode)
	self._secAnim:gotoAndStop(11)

	self._countdown = Countdown:new(function(sender, leftSeconds)
		if leftSeconds < self._timelimit then
			leftSeconds = self._timelimit
		end

		local min = math.floor(leftSeconds / 60)
		local sec = math.floor(leftSeconds - min * 60)
		local minStr = string.format("%02d:", min)
		local secStr = string.format("%02d", sec)
		local changed = false

		if self._minStr ~= minStr then
			changed = true

			minLabel:setString(minStr)

			self._minStr = minStr
		end

		if self._secStr ~= secStr then
			changed = true

			secLabel:setString(secStr)

			self._secStr = secStr

			if min == 0 and sec < 10 then
				self._secAnim:gotoAndPlay(1)
			else
				self._secAnim:gotoAndStop(11)
			end
		end

		if changed then
			self._minNode:setPositionX(2 - secLabel:getContentSize().width / 2)
			self._secNode:setPositionX(minLabel:getContentSize().width / 2 + 2)
		end
	end, scheduler)
end

function BattleTimerWidget:showNewPhaseLabel(phase, energySpeed)
	local newPhase = self:getView():getChildByName("newPhase")
	local label = newPhase:getChildByName("label")
	local energyLabel = newPhase:getChildByName("energy")

	label:setString(Strings:get("BATTLE_ROUND_LABEL", {
		value = phase
	}))
	energyLabel:setString(Strings:get("BATTLE_ENERGYSPEED_LABEL", {
		value = math.floor(energySpeed * 100)
	}))

	local width1 = label:getContentSize().width
	local width2 = energyLabel:getContentSize().width

	newPhase:setPositionX((width1 - width2) / 2)
	newPhase:setVisible(true)

	if self._newPhaseTask then
		self._newPhaseTask:stop()
	end

	self._newPhaseTask = self._scheduler:schedule(function(task, dt)
		newPhase:setVisible(false)
		task:stop()

		self._newPhaseTask = nil
	end, 4, false)

	AudioEngine:getInstance():playEffect("Se_Alert_Speedup")
end

function BattleTimerWidget:setUrgentState(urgent)
	if urgent == self._isUrgentState then
		return
	end

	if urgent and not self._isUrgentState then
		local anim = cc.MovieClip:create("a_daojishi")

		anim:addTo(self._minNode):setName("anim")
		self._minLabel:changeParent(anim:getChildByFullName("num"))
		anim:play()

		local anim = cc.MovieClip:create("b_daojishi")

		anim:addTo(self._secAnimNode):setName("anim")
		self._secLabel:changeParent(anim:getChildByFullName("num"))
		anim:play()
	elseif not urgent then
		self._minLabel:changeParent(self._minNode)
		self._secLabel:changeParent(self._secAnimNode)
		self._minNode:removeChildByName("anim")
		self._secAnimNode:removeChildByName("anim")
	end

	self._isUrgentState = urgent
end

function BattleTimerWidget:setScheduler(scheduler)
	self._scheduler = scheduler

	self._countdown:setScheduler(scheduler)
end

function BattleTimerWidget:start()
	self._countdown:start()
end

function BattleTimerWidget:stop()
	self._countdown:pause()
end

function BattleTimerWidget:reset(seconds)
	self._countdown:reset(seconds)
	self._view:setVisible(true)
end

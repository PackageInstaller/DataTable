-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceBattleUIMediator.lua

PetRaceBattleUIMediator = class("PetRaceBattleUIMediator", BaseViewMediator, _M)

PetRaceBattleUIMediator:has("_mainMediator", {
	is = "rw"
})
PetRaceBattleUIMediator:has("_battleGround", {
	is = "rw"
})
PetRaceBattleUIMediator:has("_viewContext", {
	is = "r"
})
PetRaceBattleUIMediator:has("_ctrlButtons", {
	is = "r"
})
PetRaceBattleUIMediator:has("_leftHeadWidget", {
	is = "r"
})
PetRaceBattleUIMediator:has("_rightHeadWidget", {
	is = "r"
})

function PetRaceBattleUIMediator:initialize()
	super.initialize(self)
end

function PetRaceBattleUIMediator:dispose()
	super.dispose(self)
end

function PetRaceBattleUIMediator:onRegister()
	super.onRegister(self)
	self:setupSubWidgets()
end

function PetRaceBattleUIMediator:adjustLayout(targetFrame)
	local view = self:getView()
	local header = view:getChildByName("header")
	local leftHead = header:getChildByName("leftHead")
	local rightHead = header:getChildByName("rightHead")

	AdjustUtils.adjustLayoutUIByRootNode(view)
	AdjustUtils.ignorSafeAreaRectForNode(leftHead, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(rightHead, AdjustUtils.kAdjustType.Right)
end

function PetRaceBattleUIMediator:setupSubWidgets()
	local view = self:getView()
	local header = view:getChildByName("header")
	local timerNode = header:getChildByName("timer")

	self._timerWidget = self:autoManageObject(BattleTimerWidget:new(timerNode))

	local roundNode = header:getChildByName("round")

	self._roundWidget = self:autoManageObject(RoundInfoWidget:new(roundNode))

	local leftHead = header:getChildByName("leftHead")

	self._leftHeadWidget = self:autoManageObject(PetRaceBattleHeadWidget:new(leftHead, true))

	local rightHead = header:getChildByName("rightHead")

	self._rightHeadWidget = self:autoManageObject(PetRaceBattleHeadWidget:new(rightHead))

	local tip = view:getChildByName("skillTip")

	self._tipWidget = self:autoManageObject(BattleSkillTipWidget:new(tip))

	local btnsNode = view:getChildByName("buttons")

	self._ctrlButtons = self:autoManageObject(BattleControllerButtons:new(btnsNode))
	self.Text_des = header:getChildByName("Text_des")
end

function PetRaceBattleUIMediator:willStartEnterTransition()
	local offset1, offset2, offset3 = cc.p(0, 124), cc.p(0, -143), cc.p(0, 19)

	if self._timerWidget then
		local view = self._timerWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._leftHeadWidget then
		local view = self._leftHeadWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._rightHeadWidget then
		local view = self._rightHeadWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	local offset1, offset2, offset3 = cc.p(100, 0), cc.p(-123, 0), cc.p(23, 0)

	if self._ctrlButtons then
		local view = self._ctrlButtons:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end
end

function PetRaceBattleUIMediator:initWithContext(viewContext)
	self._viewContext = viewContext

	if self._timerWidget then
		self._timerWidget:setScheduler(viewContext:getScalableScheduler())
	end
end

function PetRaceBattleUIMediator:setupViewConfig(viewConfig, isReplay)
	if self._ctrlButtons then
		local ctrlBtnsListener, mainMediator = {}, self._mainMediator

		function ctrlBtnsListener:onSpeedLevelChanged(speed)
			mainMediator:setTimeScale(speed)
		end

		function ctrlBtnsListener:onPause()
			mainMediator:onPause()
		end

		function ctrlBtnsListener:onRestraint()
			mainMediator:onRestraint()
		end

		function ctrlBtnsListener:onSkip()
			mainMediator:onSkip()
		end

		function ctrlBtnsListener:onAutoChanged(isAuto)
			mainMediator:setMainPlayerIsAuto(isAuto)
			mainMediator:onAMChanged(isAuto)
		end

		function ctrlBtnsListener:getDispatcher()
			return mainMediator
		end

		function ctrlBtnsListener:getInjector()
			return mainMediator:getInjector()
		end

		local speed = self._viewContext:getTimeScale()
		local data = {
			listener = ctrlBtnsListener,
			btnsState = viewConfig.btnsShow,
			isReplay = isReplay,
			canChangeSpeed = viewConfig.canChangeSpeedLevel,
			speedLevel = viewConfig.canChangeSpeedLevel and speed or 1
		}

		self._ctrlButtons:initWithData(data)
	end

	if self._ctrlButtons then
		self._ctrlButtons:setTouchEnabled(false)
	end

	self.Text_des:setString(viewConfig.Text_titleDes or "")
end

function PetRaceBattleUIMediator:startNewPhase(phase, duration, elapsed, energySpeed, timelimit)
	local timerWidget = self._timerWidget

	if timerWidget then
		local seconds = (duration - elapsed) / 1000

		timerWidget:reset(seconds)
		timerWidget:setTimelimit(seconds - timelimit / 1000)

		if phase == 3 then
			timerWidget:setUrgentState(true)
		else
			timerWidget:setUrgentState(false)
		end

		timerWidget:start()
	end

	if phase == 1 then
		self._ctrlButtons:setTouchEnabled(true)
	end

	if phase == 5 then
		-- block empty
	end
end

function PetRaceBattleUIMediator:pauseTiming()
	if self._timerWidget then
		self._timerWidget:stop()
	end
end

function PetRaceBattleUIMediator:resumeTiming()
	if self._timerWidget then
		self._timerWidget:start()
	end
end

function PetRaceBattleUIMediator:resetTiming(time)
	if self._timerWidget then
		self._timerWidget:reset(time)
	end
end

function PetRaceBattleUIMediator:roundChanged(roundNumber, maxRounds)
	if self._roundWidget then
		self._roundWidget:setCurrentRoundNum(roundNumber, maxRounds)
	end
end

function PetRaceBattleUIMediator:showSkillTip(skillId, level, pos)
	return
end

function PetRaceBattleUIMediator:hideSkillTip()
	return
end

function PetRaceBattleUIMediator:setTouchEnabled(touchEnable)
	return
end

function PetRaceBattleUIMediator:removeCards()
	return
end

function PetRaceBattleUIMediator:updateCardArray(cards, remain, next)
	return
end

function PetRaceBattleUIMediator:updateExtraCardArray(cards, remain, next)
	return
end

function PetRaceBattleUIMediator:replaceExtraPreview(cards, idx)
	return
end

function PetRaceBattleUIMediator:syncEnergy(energy, remain, speed)
	return
end

function PetRaceBattleUIMediator:enableCtrlButton(...)
	if self._ctrlButtons then
		self._ctrlButtons:setTouchEnabled(true)
	end
end

function PetRaceBattleUIMediator:disableCtrlButton(...)
	self._ctrlButtons:setTouchEnabled(false)
end

function PetRaceBattleUIMediator:pauseEnergyIncreasing()
	return
end

function PetRaceBattleUIMediator:resumeEnergyIncreasing()
	return
end

function PetRaceBattleUIMediator:hideHeroTip()
	return
end

function PetRaceBattleUIMediator:stopBulletTime()
	self._mainMediator:setBulletTime(1)
end

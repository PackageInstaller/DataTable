-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleUIMediator.lua

require("dm.battle.view.widget.BattleWidget")
require("dm.battle.view.widget.PhaseInfoWidget")
require("dm.battle.view.widget.WaveAnimWidget")
require("dm.battle.view.widget.EscapeInfoWidget")
require("dm.battle.view.widget.FleeInfoWidget")
require("dm.battle.view.widget.EquipHpWidget")

BattleUIMediator = class("BattleUIMediator", BaseViewMediator, _M)

BattleUIMediator:has("_mainMediator", {
	is = "rw"
})
BattleUIMediator:has("_battleGround", {
	is = "rw"
})
BattleUIMediator:has("_viewContext", {
	is = "r"
})
BattleUIMediator:has("_masterWidget", {
	is = "r"
})
BattleUIMediator:has("_ctrlButtons", {
	is = "r"
})
BattleUIMediator:has("_cardArray", {
	is = "r"
})
BattleUIMediator:has("_leftHeadWidget", {
	is = "r"
})
BattleUIMediator:has("_rightHeadWidget", {
	is = "r"
})
BattleUIMediator:has("_fleeWidget", {
	is = "r"
})
BattleUIMediator:has("_equipHpWidget", {
	is = "r"
})
BattleUIMediator:has("_skillRefreshBtn", {
	is = "r"
})

function BattleUIMediator:initialize()
	super.initialize(self)
end

function BattleUIMediator:dispose()
	super.dispose(self)

	if self._chatFlowWidget then
		self._chatFlowWidget:dispose()

		self._chatFlowWidget = nil
	end
end

function BattleUIMediator:onRegister()
	super.onRegister(self)
	self:setupSubWidgets()
	self:setupChatFlowWidget()
end

function BattleUIMediator:setBattleType(battleType)
	self._battleType = battleType

	if self._battleType ~= "rtpvp" then
		self._speedupBtn:hide()
	end
end

function BattleUIMediator:adjustLayout(targetFrame)
	local view = self:getView()
	local header = view:getChildByName("header")
	local leftHead = header:getChildByName("leftHead")
	local rightHead = header:getChildByName("rightHead")

	AdjustUtils.adjustLayoutUIByRootNode(view)
	AdjustUtils.ignorSafeAreaRectForNode(leftHead, AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(rightHead, AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(header:getChildByName("goods"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(header:getChildByName("change"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(header:getChildByName("leftPassiveSkill"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(header:getChildByName("rightPassiveSkill"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(header:getChildByName("leftStageLevel"), AdjustUtils.kAdjustType.Left)
	AdjustUtils.ignorSafeAreaRectForNode(header:getChildByName("rightStageLevel"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.ignorSafeAreaRectForNode(view:getChildByName("edge_left"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(view:getChildByName("edge_right"), AdjustUtils.kAdjustType.Right + AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(view:getChildByName("edge_bottom"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Bottom)
	AdjustUtils.ignorSafeAreaRectForNode(view:getChildByName("edge_top"), AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)

	local winSize = cc.Director:getInstance():getWinSize()

	view:getChildByName("edge_bottom"):setContentSize(cc.size(winSize.width, view:getChildByName("edge_bottom"):getContentSize().height))
	view:getChildByName("edge_top"):setContentSize(cc.size(winSize.width, view:getChildByName("edge_top"):getContentSize().height))
	view:getChildByName("edge_left"):setContentSize(cc.size(view:getChildByName("edge_left"):getContentSize().width, winSize.height))
	view:getChildByName("edge_right"):setContentSize(cc.size(view:getChildByName("edge_right"):getContentSize().width, winSize.height))
	view:getChildByName("edge_bottom"):setLocalZOrder(-2)
	view:getChildByName("edge_top"):setLocalZOrder(-2)
	view:getChildByName("edge_left"):setLocalZOrder(-2)
	view:getChildByName("edge_right"):setLocalZOrder(-2)
end

function BattleUIMediator:setupSubWidgets()
	local view = self:getView()
	local header = view:getChildByName("header")
	local timerNode = header:getChildByName("timer")

	self._timerWidget = self:autoManageObject(BattleTimerWidget:new(timerNode))

	local deadCountNode = header:getChildByName("deathcnt")

	self._deadCountWidget = self:autoManageObject(BattleDeadCountWidget:new(deadCountNode))

	local roundNode = header:getChildByFullName("round")

	self._roundWidget = self:autoManageObject(RoundInfoWidget:new(roundNode))

	local escapeNode = header:getChildByName("escape")

	self._escapeWidget = self:autoManageObject(EscapeInfoWidget:new(escapeNode))

	local phaseAnimNode = header:getChildByFullName("phase_anim.phase")

	self._phaseAnimWidget = self:autoManageObject(PhaseInfoWidget:new(phaseAnimNode))

	local waveAnimNode = header:getChildByFullName("wave_anim.wave")

	self._waveAnimWidget = self:autoManageObject(WaveAnimWidget:new(waveAnimNode))

	local leftHead = header:getChildByName("leftHead")

	self._leftHeadWidget = self:autoManageObject(BattleHeadWidget:new(leftHead, true))

	local rightHead = header:getChildByName("rightHead")

	self._rightHeadWidget = self:autoManageObject(BattleHeadWidget:new(rightHead))

	local fleeNode = header:getChildByName("flee")

	self._fleeWidget = self:autoManageObject(FleeInfoWidget:new(fleeNode))

	local equipHpNode = header:getChildByName("equipHp")

	self._equipHpWidget = self:autoManageObject(EquipHpWidget:new(equipHpNode))

	local lootsNode = header:getChildByName("goods")

	if lootsNode then
		self._lootsWidget = self:autoManageObject(BattleLootWidget:new(lootsNode))
	end

	local waveNode = header:getChildByName("wave")

	if waveNode then
		self._waveWidget = self:autoManageObject(BattleWaveWidget:new(waveNode))
	end

	local changeNode = header:getChildByName("change")

	if changeNode then
		self._changeWidget = self:autoManageObject(BattleChangeWidget:new(changeNode))
	end

	local tip = view:getChildByName("skillTip")

	self._tipWidget = self:autoManageObject(BattleSkillTipWidget:new(tip))

	local skillCardTip = view:getChildByName("skillCardTip")

	self._skillCardTipWidget = self:autoManageObject(BattleSkillTipWidget:new(skillCardTip))

	local bottom = view:getChildByName("bottom")
	local masterNode = bottom:getChildByName("master")

	self._masterWidget = self:autoManageObject(BattleMasterWidget:new(masterNode))

	self._masterWidget:setListener(self)

	local cardsNode = bottom:getChildByName("card_array")

	self._cardArray = self:autoManageObject(CardArrayWidget:new(cardsNode))

	self._cardArray:setListener(self)

	local energyNode = bottom:getChildByName("energy_bar")

	self._energyBar = self:autoManageObject(BattleEnergyBar:new(energyNode))

	local btnsNode = view:getChildByName("buttons")

	self._ctrlButtons = self:autoManageObject(BattleControllerButtons:new(btnsNode))
	self._bottomTouchPanel = bottom:getChildByName("touch_panel")
	self._autoCover = self._bottomTouchPanel:getChildByFullName("cover_node.auto_text")

	local skillRefresh_btn = bottom:getChildByName("skillRefresh_btn")

	self._skillRefreshBtn = self:autoManageObject(BattleSkillCardRefreshButton:new(skillRefresh_btn))

	self._skillRefreshBtn:setListener(self)
	self._skillRefreshBtn:hide()

	local leftPassiveSkill = header:getChildByName("leftPassiveSkill")

	self._leftPassiveSkill = self:autoManageObject(BattlePassiveSkillWidget:new(leftPassiveSkill, true))

	self._leftPassiveSkill:setListener(self)

	local rightPassiveSkill = header:getChildByName("rightPassiveSkill")

	self._rightPassiveSkill = self:autoManageObject(BattlePassiveSkillWidget:new(rightPassiveSkill))

	self._rightPassiveSkill:setListener(self)

	local passiveSkillTip = view:getChildByName("passiveSkillTip")

	self._passiveSkillTip = self:autoManageObject(BattlePassiveSkillTip:new(passiveSkillTip))

	self._passiveSkillTip:setListener(self)

	local rtpkEmojiNode = header:getChildByName("emoji")

	self._rtpkEmojiWidget = self:autoManageObject(BattleRTPKEmojiPanelWidget:new(rtpkEmojiNode))

	self._rtpkEmojiWidget:setListener(self)

	local leftStageLevel = header:getChildByName("leftStageLevel")

	self._leftStageLevel = self:autoManageObject(LeadStagePassiveSkillWidget:new(leftStageLevel, true))

	self._leftStageLevel:setListener(self)

	local rightStageLevel = header:getChildByName("rightStageLevel")

	self._rightStageLevel = self:autoManageObject(LeadStagePassiveSkillWidget:new(rightStageLevel))

	self._rightStageLevel:setListener(self)
	self._leftStageLevel:setVisible(false)
	self._rightStageLevel:setVisible(false)

	local speedupBtn = header:getChildByName("speedup")

	self._speedupBtn = self:autoManageObject(BattlePvpSpeedUpWidget:new(speedupBtn))

	self._speedupBtn:hide()

	local noticeEnhance = header:getChildByName("notice")

	self._noticeEnhance = self:autoManageObject(BattleNoticeEnhanceWidget:new(noticeEnhance))

	self._noticeEnhance:hide()
end

function BattleUIMediator:pvpSpeedUp(arg1, arg2)
	if self._speedupBtn then
		self._speedupBtn:active(arg1, arg2)
	end
end

function BattleUIMediator:showNoticeEnhance(arg1, arg2)
	if self._noticeEnhance then
		self._noticeEnhance:active(arg1, arg2)
	end
end

function BattleUIMediator:hideNoticeEnhance()
	if self._noticeEnhance then
		self._noticeEnhance:hide()
	end
end

function BattleUIMediator:willStartEnterTransition()
	local offset1, offset2, offset3 = cc.p(0, 124), cc.p(0, -143), cc.p(0, 19)

	if self._timerWidget then
		local view = self._timerWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._deadCountWidget then
		local view = self._deadCountWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._speedupBtn then
		local view = self._speedupBtn:getView()

		view:runAction(cc.Sequence:create(cc.DelayTime:create(6), cc.FadeIn:create(0.1)))
	end

	if self._noticeEnhance then
		local view = self._noticeEnhance:getView()

		view:runAction(cc.Sequence:create(cc.DelayTime:create(6), cc.FadeIn:create(0.1)))
	end

	if self._rtpkEmojiWidget then
		local view = self._rtpkEmojiWidget:getView()

		view:runAction(cc.Sequence:create(cc.DelayTime:create(6), cc.FadeIn:create(0.1)))
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

	local offset1, offset2, offset3 = cc.p(-267, 0), cc.p(295, 0), cc.p(-28, 0)

	if self._masterWidget then
		local view = self._masterWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	local offset1, offset2, offset3 = cc.p(0, -226), cc.p(0, 262), cc.p(0, -36)

	if self._cardArray then
		local view = self._cardArray:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._energyBar then
		local view = self._energyBar:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end
end

function BattleUIMediator:fade()
	self:setTouchEnabled(false)
	self:disableCtrlButton()

	local duration = 0.3

	if self._timerWidget then
		local view = self._timerWidget:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._deadCountWidget then
		local view = self._deadCountWidget:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._leftHeadWidget then
		local view = self._leftHeadWidget:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._rightHeadWidget then
		local view = self._rightHeadWidget:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._ctrlButtons then
		local view = self._ctrlButtons:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._skillRefreshBtn then
		local view = self._skillRefreshBtn:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._masterWidget then
		local view = self._masterWidget:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._cardArray then
		local view = self._cardArray:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._energyBar then
		local view = self._energyBar:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._leftPassiveSkill then
		local view = self._leftPassiveSkill:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._rightPassiveSkill then
		local view = self._rightPassiveSkill:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._leftStageLevel then
		local view = self._leftStageLevel:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._rightStageLevel then
		local view = self._rightStageLevel:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._changeWidget then
		local view = self._changeWidget:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._passiveSkillTip then
		self._passiveSkillTip:hide()
	end

	if self._rtpkEmojiWidget then
		-- block empty
	end

	if self._speedupBtn then
		local view = self._speedupBtn:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	if self._noticeEnhance then
		local view = self._noticeEnhance:getView()

		view:stopAllActions()
		view:runAction(cc.FadeOut:create(duration))
	end

	local waitTime = 10

	performWithDelay(self:getView(), function()
		self:setTouchEnabled(true)
		self:enableCtrlButton()

		local duration = 0.3

		if self._timerWidget then
			local view = self._timerWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._deadCountWidget then
			local view = self._deadCountWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._leftHeadWidget then
			local view = self._leftHeadWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._rightHeadWidget then
			local view = self._rightHeadWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._ctrlButtons then
			local view = self._ctrlButtons:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._skillRefreshBtn then
			local view = self._skillRefreshBtn:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._masterWidget then
			local view = self._masterWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._cardArray then
			local view = self._cardArray:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._energyBar then
			local view = self._energyBar:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._leftPassiveSkill then
			local view = self._leftPassiveSkill:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._rightPassiveSkill then
			local view = self._rightPassiveSkill:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._changeWidget then
			local view = self._changeWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._leftStageLevel then
			local view = self._leftStageLevel:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._rightStageLevel then
			local view = self._rightStageLevel:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._speedupBtn then
			local view = self._speedupBtn:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._noticeEnhance then
			local view = self._noticeEnhance:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end

		if self._rtpkEmojiWidget then
			local view = self._rtpkEmojiWidget:getView()

			view:stopAllActions()
			view:runAction(cc.FadeIn:create(duration))
		end
	end, waitTime)
end

function BattleUIMediator:initWithContext(viewContext)
	self._viewContext = viewContext

	if self._lootsWidget then
		viewContext:setValue("BattleLootWidget", self._lootsWidget)
	end

	if self._waveWidget then
		viewContext:setValue("BattleWaveWidget", self._waveWidget)
	end

	if self._changeWidget then
		viewContext:setValue("BattleChangeWidget", self._changeWidget)
	end

	if self._timerWidget then
		self._timerWidget:setScheduler(viewContext:getScalableScheduler())
	end

	if self._energyBar then
		local energyBarListener, uiMediator = {}, self

		function energyBarListener:onEnergyChanged(energy, remain)
			if uiMediator._cardArray then
				uiMediator._cardArray:freshEnergyStatus(energy, remain)
			end
		end

		self._energyBar:setListener(energyBarListener)
		self._energyBar:startIncreasing(viewContext:getScalableScheduler())
	end

	if self._cardArray then
		self._cardArray:setTouchEnabled(false)
	end

	if self._masterWidget then
		self._masterWidget:setTouchEnabled(false)
	end

	if self._battleGround then
		self._battleGround:setTouchEnabled(false)
	end

	if self._leftPassiveSkill then
		self._leftPassiveSkill:setTouchEnabled(false)
	end

	if self._rightPassiveSkill then
		self._rightPassiveSkill:setTouchEnabled(false)
	end

	if self._leftStageLevel then
		self._leftStageLevel:setTouchEnabled(false)
	end

	if self._rightStageLevel then
		self._rightStageLevel:setTouchEnabled(false)
	end
end

function BattleUIMediator:setupChatFlowWidget()
	local chatFLowNode = self:getView():getChildByName("chat_flow_node")

	chatFLowNode:setVisible(true)
	chatFLowNode:setLocalZOrder(9999)

	local chatFlowWidget = ChatFlowWidget:new(chatFLowNode)

	self:getInjector():injectInto(chatFlowWidget)

	self._chatFlowWidget = chatFlowWidget

	chatFLowNode:getChildByName("layout"):setTouchEnabled(false)
end

function BattleUIMediator:setupViewConfig(viewConfig, isReplay)
	self._disableHeroTip = viewConfig.disableHeroTip

	if viewConfig.enemyIcon and self._rightHeadWidget.setSpecificIcon then
		self._rightHeadWidget:setSpecificIcon(viewConfig.enemyIcon)
	end

	if self._ctrlButtons then
		local outSelf = self
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

			if outSelf._bottomTouchPanel then
				outSelf._bottomTouchPanel:setVisible(isAuto)

				if outSelf._autoCover then
					outSelf._autoCover:stopAllActions()

					if isAuto then
						local auto_text = Strings:get("BATTLE_AUTO_COVER")
						local interval = 0.4
						local dotCount = 0
						local limit = 3
						local append = ""

						local function setAutoText()
							if dotCount >= limit then
								dotCount = 0
								append = ""
							else
								dotCount = dotCount + 1
								append = append .. "."
							end

							outSelf._autoCover:setString(auto_text .. (append or ""))
						end

						outSelf._autoCover:setVisible(true)
						outSelf._autoCover:setString(auto_text)
						outSelf._autoCover:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(setAutoText), cc.DelayTime:create(interval))))
					end
				end
			end

			if outSelf._puttingCard and outSelf._puttingCard:getType() == "skill" then
				outSelf._cardArray:resetActiveCard()
			end

			if isAuto then
				mainMediator:releaseGuideLayer()
			end
		end

		function ctrlBtnsListener:onAutoBtnClick()
			mainMediator:changeMainPlayerAi()
		end

		function ctrlBtnsListener:isReady()
			return outSelf._afterReadyStart
		end

		function ctrlBtnsListener:getScheduler()
			return outSelf._viewContext:getScalableScheduler()
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

	if self._escapeWidget and viewConfig.showEscape then
		self._escapeWidget:shine()
	end

	if self._fleeWidget and viewConfig.fleeInfo and viewConfig.fleeInfo.count > 0 then
		self._fleeWidget:init(viewConfig.fleeInfo)
	end

	if self._equipHpWidget and viewConfig.eupipInfo then
		self._equipHpWidget:init(viewConfig.eupipInfo)
	end

	if self._skillRefreshBtn and viewConfig.refreshCost then
		self._skillRefreshBtn:init(viewConfig.refreshCost)
	end

	if self._leftPassiveSkill and viewConfig.passiveSkill then
		self._leftPassiveSkill:init(viewConfig.passiveSkill.playerShow)
	end

	if self._rightPassiveSkill and viewConfig.passiveSkill then
		self._rightPassiveSkill:init(viewConfig.passiveSkill.enemyShow)
	end

	if self._leftStageLevel and viewConfig.passiveSkill and viewConfig.passiveSkill.playerStagePassShow then
		self._leftStageLevel:setVisible(true)
		self._leftStageLevel:init(viewConfig.passiveSkill.playerStagePassShow)
	end

	if self._rightStageLevel and viewConfig.passiveSkill and viewConfig.passiveSkill.enemyStagePassShow then
		self._rightStageLevel:setVisible(true)
		self._rightStageLevel:init(viewConfig.passiveSkill.enemyStagePassShow)
	end

	if self._changeWidget and viewConfig.changeMaxNum then
		self._changeWidget:init(viewConfig.changeMaxNum)
	end

	if self._chatFlowWidget and viewConfig.chatFlow then
		self._chatFlowWidget:start(viewConfig.chatFlow)
	end

	if viewConfig.noHpFormat then
		self._leftHeadWidget:setHpFormat(false)
		self._rightHeadWidget:setHpFormat(false)
	end

	if viewConfig.isShowEmoji then
		if self._rtpkEmojiWidget then
			self._rtpkEmojiWidget:getView():setVisible(true)
		end
	elseif self._rtpkEmojiWidget then
		self._rtpkEmojiWidget:getView():setVisible(false)
	end

	self._deadCountWidget:enabled(false)

	self._deadCountCfg = self:getDeadCountVectorCfg()

	if self._deadCountCfg then
		self._deadCountWidget:setMaxNum(self._deadCountCfg.factor.count)
		self._deadCountWidget:enabled(true)
	end
end

function BattleUIMediator:getDeadCountVectorCfg()
	local var_29_0

	if not self._mainMediator:getBattleConfig() then
		do return nil end

		var_29_0 = self._mainMediator:getBattleConfig().victoryCfg or {}
	end

	for k, v in pairs(var_29_0) do
		if v.type == "KillNum" then
			return v
		end
	end
end

function BattleUIMediator:afterReadyStart()
	self._afterReadyStart = true
end

function BattleUIMediator:getReadyStartSta()
	return self._afterReadyStart
end

function BattleUIMediator:enableBottomButton()
	self:getView():getChildByFullName("bottom.touch_panel_start"):setVisible(false)
end

function BattleUIMediator:startBulletTime()
	self._mainMediator:setBulletTime(0.1)
end

function BattleUIMediator:stopBulletTime()
	self._mainMediator:setBulletTime(1)
end

function BattleUIMediator:dragBegan(cardArray, activeCard, touchPoint)
	if self._battleGround then
		self._battleGround:onHeroCardTouchBegan()
		activeCard:getView():setScale(0.8)

		activeCard.tmpCellId = nil
	end

	self:startBulletTime()

	if activeCard:getType() == "hero" then
		self:showHeroTip(activeCard, 2)

		local anim = cc.MovieClip:create("kkk_yinghunshangchang")
		local cardNode = activeCard:getView()
		local parent = cardNode:getParent()

		anim:addTo(parent):posite(cardNode:getPositionX(), cardNode:getPositionY() + 20)
		anim:addEndCallback(function(cid, mc)
			mc:stop()
			mc:removeFromParent()
		end)
	end

	self._activeCard = activeCard
end

function BattleUIMediator:dragMoved(cardArray, activeCard, touchPoint)
	if self._battleGround then
		local col, cellId = self._battleGround:checkTouchCollision(activeCard, touchPoint)

		if col then
			activeCard:getView():setVisible(false)

			local targetPreview = activeCard:getTargetPreview()

			if targetPreview and cellId ~= activeCard.tmpCellId then
				activeCard.tmpCellId = cellId

				local unitManager = self._viewContext:getValue("BattleUnitManager")
				local result = unitManager:checkTargetPreview(targetPreview, cellId)

				self._battleGround:previewTargets(result)
				self._battleGround:attachSpine(activeCard:getModelId(), cellId, touchPoint)
				self._battleGround:scaleCell(cellId)
				self._battleGround:showProfessionalRestraint(activeCard:getHeroInfo().genre, result)
			else
				self._battleGround:attachSpine(activeCard:getModelId(), cellId, touchPoint)
			end
		else
			activeCard.tmpCellId = nil

			activeCard:getView():setVisible(false)
			self._battleGround:attachSpine(activeCard:getModelId(), nil, touchPoint)
			self._battleGround:resumePreviews()
			self._battleGround:resumeProfessionalRestraint()
		end
	end
end

function BattleUIMediator:dragExtraSkillBegan(cardArray, activeCard, touchPoint)
	self._extraAreaTouch = nil
	self._extraSkillParam = false
	self._extraSkillZone = false

	self:dragBegan(cardArray, activeCard, touchPoint)

	local unitManager = self._viewContext:getValue("BattleUnitManager")
	local result = unitManager:checkTargetPreview(activeCard:getCollesionRule(), -1)

	self._battleGround:previewTargets(result, true)

	self._extraAreaTouch = result
end

function BattleUIMediator:retsetAllCell(cellId)
	for i = 1, 9 do
		if cellId ~= i then
			local targetCell = self._battleGround:getCellById(i)

			targetCell:getDisplayNode():setScale(1)

			local targetCell = self._battleGround:getCellById(0 - i)

			targetCell:getDisplayNode():setScale(1)
		end
	end
end

function BattleUIMediator:dragExtraSkillMoved(cardArray, activeCard, touchPoint)
	if self._battleGround then
		local col, cellId, isLeft = self._battleGround:checkTouchCollision(activeCard, touchPoint, self._extraAreaTouch)

		if col then
			if cellId ~= activeCard.tmpCellId then
				activeCard.tmpCellId = cellId
				self._extraSkillParam = {
					col,
					cellId,
					isLeft
				}

				local targetCell = self._battleGround:getCellById(isLeft and cellId or 0 - cellId)

				targetCell:getDisplayNode():runAction(cc.ScaleTo:create(0.2, 1.2))
			else
				self:retsetAllCell(cellId)
			end
		else
			self:retsetAllCell()

			self._extraSkillParam = nil
			activeCard.tmpCellId = nil
		end
	end
end

function BattleUIMediator:dragExtraSkillEnded(cardArray, activeCard, touchPoint)
	if self._battleGround then
		if self._viewContext == nil then
			return
		end

		if self._battleGround == nil then
			return
		end

		self._battleGround:resumePreviews()
		self._battleGround:onHeroCardTouchEnded()
		self:stopBulletTime()
		self:hideHeroTip()
		self._battleGround:resumeProfessionalRestraint()
		self._battleGround:resumeCellLocks()
		self:retsetAllCell()

		while true do
			if not self._extraSkillParam then
				break
			end

			if self._viewContext:isBattleFinished() then
				break
			end

			local cost = activeCard:getCost()

			if not self._energyBar:isEnergyEnough(cost) then
				break
			end

			self:applySkillCard(cardArray, activeCard, touchPoint, {
				cellId = self._extraSkillParam[2],
				isLeft = self._extraSkillParam[3]
			})

			return
		end

		activeCard:restoreNormalState(cc.p(0, 0))
		self._battleGround:resumePreviews()

		self._extraAreaTouch = nil
	end
end

function BattleUIMediator:dragEnded(cardArray, activeCard, touchPoint)
	if self._viewContext == nil then
		return
	end

	if self._battleGround == nil then
		return
	end

	activeCard:getView():setScale(1)
	activeCard:getView():setVisible(true)
	self._battleGround:resumePreviews()
	self._battleGround:onHeroCardTouchEnded()
	self:stopBulletTime()
	self:hideHeroTip()
	self._battleGround:resumeProfessionalRestraint()

	while true do
		local canPush, posIdx = self._battleGround:checkCanPushHero(activeCard, touchPoint)

		if not canPush then
			break
		end

		if self._viewContext:isBattleFinished() then
			break
		end

		local cost = activeCard:getCost()

		if not self._energyBar:isEnergyEnough(cost) then
			break
		end

		self:applyHeroCard(cardArray, activeCard, posIdx)

		return
	end

	self._battleGround:hideUnrealSpine()
	activeCard:restoreNormalState(cc.p(0, 0))

	self._activeCard = nil
end

function BattleUIMediator:usedCard(cardId)
	if self._activeCard and self._activeCard:getCardId() == cardId then
		self:dragCancelled()

		self._activeCard = nil
	end
end

function BattleUIMediator:dragCancelled()
	local hittedSta = self._cardArray:resetHittedCard()

	if hittedSta then
		self._battleGround:resumePreviews()
		self._battleGround:onHeroCardTouchEnded()
		self:stopBulletTime()
		self:hideHeroTip()
		self._battleGround:hideUnrealSpine()
	end

	self._activeCard = nil
end

function BattleUIMediator:startPut(cardArray, card)
	self._puttingCard = card

	if self._battleGround then
		if card:getType() == "hero" then
			self._battleGround:onHeroCardTouchBegan(bind1(self.applyHeroCard, self), cardArray, card)
			self._battleGround:setCancelHeroCardCallback(function()
				self._cardArray:resetActiveCard()
			end)
			self._battleGround:setTouchEnabled(true)
		elseif card:getType() == "skill" then
			local function applaySkillCard()
				return
			end

			self._battleGround:onHeroCardTouchBegan(bind1(applaySkillCard, self), cardArray, card)
			self._battleGround:setCancelHeroCardCallback(function()
				self._cardArray:resetActiveCard()
			end)
			self._battleGround:setTouchEnabled(true)
		end
	end

	self:startBulletTime()

	if card:getType() == "hero" then
		self:showHeroTip(card, 1)
	elseif card:getType() == "skill" then
		local parentView = card:getView():getParent()
		local pos = parentView:convertToWorldSpace(cc.p(card:getView():getPosition()))

		self:showSkillCardTip(card:getSkillId(), card:getSkillLevel(), cc.p(pos.x, pos.y + 100))
	end
end

function BattleUIMediator:cancelPut()
	self._puttingCard = nil

	if self._battleGround then
		self._battleGround:onHeroCardTouchEnded()
		self._battleGround:setTouchEnabled(false)
	end

	self:stopBulletTime()

	local scheduler = self._viewContext:getScalableScheduler()

	self._hideHeroTipEntry = scheduler:schedule(function(task, dt)
		self:hideHeroTip()
		task:stop()

		self._hideHeroTipEntry = nil
	end, 0, false)
end

function BattleUIMediator:setTouchEnabled(touchEnable)
	if self._cardArray then
		self._cardArray:setTouchEnabled(touchEnable)

		if not touchEnable then
			self._battleGround:hideUnrealSpine()
			self._cardArray:resetHittedCard()
			self._cardArray:resetActiveCard()
			self._battleGround:onHeroCardTouchEnded()
			self._battleGround:resumePreviews()
		end
	end

	if self._masterWidget then
		self._masterWidget:setTouchEnabled(touchEnable)
	end

	if self._leftPassiveSkill then
		self._leftPassiveSkill:setTouchEnabled(touchEnable)
	end

	if self._rightPassiveSkill then
		self._rightPassiveSkill:setTouchEnabled(touchEnable)
	end

	if self._leftStageLevel then
		self._leftStageLevel:setTouchEnabled(touchEnable)
	end

	if self._rightStageLevel then
		self._rightStageLevel:setTouchEnabled(touchEnable)
	end

	self._touchEnalbed = touchEnable
end

function BattleUIMediator:enableCtrlButton(...)
	if self._ctrlButtons then
		self._ctrlButtons:setTouchEnabled(true)
	end
end

function BattleUIMediator:disableCtrlButton(...)
	if self._ctrlButtons then
		self._ctrlButtons:setTouchEnabled(false)
	end
end

function BattleUIMediator:isTouchEnabled()
	return self._touchEnalbed
end

function BattleUIMediator:onEmojiSelect(emojiId)
	local args = {
		emojiId = emojiId
	}

	self._mainMediator:sendMessage("emojiUsed", args, function(isOK, reason)
		return
	end)
end

function BattleUIMediator:applyHeroCard(cardArray, card, targetPositionIndex)
	if self._viewContext == nil then
		return
	end

	card:setStatus("in-use")

	local args = {
		idx = card:getIndex(),
		card = card:getCardId(),
		cellNo = targetPositionIndex
	}

	card:getView():setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Click_Putdown", false)
	self._mainMediator:sendMessage("heroCard", args, function(isOK, reason)
		if not isOK then
			cclog("warning", "spawn unit failure: %s", reason)
			card:getView():setVisible(true)
			card:setStatus("norm")
			card:restoreNormalState(cc.p(0, 0))
		else
			cardArray:clearActiveCard()
			self:cancelPut()

			if self._mainMediator then
				self._mainMediator:releaseGuideLayer()
			end
		end

		self._battleGround:hideUnrealSpine()
	end)
end

function BattleUIMediator:refreshSkillCard()
	if self._viewContext == nil then
		return
	end

	local args = {}

	if self._puttingCard then
		self:hideSkillCardTip()
		self:cancelPut()
	end

	self._mainMediator:sendMessage("refreshSkillCard", args, function(isOK, reason)
		if not isOK then
			-- block empty
		end
	end)
end

function BattleUIMediator:applySkillCard(cardArray, card, touchPoint, extra)
	if self._viewContext == nil then
		return
	end

	card:setStatus("in-use")

	local canRelease = self._battleGround:checkCanPushSkill(card, touchPoint, extra)

	if not canRelease and not extra then
		card:getView():setVisible(true)
		card:setStatus("norm")
		card:restoreNormalState(cc.p(0, 0))

		return
	end

	local args = {
		idx = card:getIndex(),
		card = card:getCardId(),
		extra = extra
	}

	card:getView():setVisible(false)
	self._mainMediator:sendMessage("skillCard", args, function(isOK, reason)
		if not isOK then
			cclog("warning", "skill card failure: %s", reason)
			card:getView():setVisible(true)
			card:setStatus("norm")
			card:restoreNormalState(cc.p(0, 0))

			return
		end
	end)
end

function BattleUIMediator:applyMasterSkill(sender, skillType)
	local args = {
		type = skillType
	}

	self._mainMediator:sendMessage("doskill", args, function(isOK, reason)
		if not isOK then
			cclog("warning", "use skill failure: %s", reason)

			if reason == "AlreadyInProcess" then
				self:cancelMasterSkill(sender, skillType)
			end

			sender:setSkillTouchEnabled(true)

			return
		else
			sender:setSkillTouchEnabled(true)
			sender:willExecute()
		end
	end)
end

function BattleUIMediator:checkSkillState(sender)
	if self._viewContext == nil then
		return
	end

	local mainPlayerController = self._viewContext:getValue("MainPlayerController")

	if not mainPlayerController then
		return
	end

	self._mainMediator:sendMessage("checkMasterSkillState", args, function(isOK, reason)
		return
	end)
end

function BattleUIMediator:cancelMasterSkill(sender, skillType)
	local args = {
		type = skillType
	}

	self._mainMediator:sendMessage("cancelskill", args, function(isOK, reason)
		print(isOK, reason)

		if not isOK then
			sender:setSkillTouchEnabled(true)
			cclog("warning", "cancel skill failure: %s", reason)
		else
			sender:setSkillTouchEnabled(true)
		end
	end)
end

function BattleUIMediator:showNewWaveLabel(wave)
	if self._waveAnimWidget then
		self._waveAnimWidget:showNewWaveLabel(wave)
	end
end

function BattleUIMediator:setTotalTime(time)
	if time and self._timerWidget then
		self._timerWidget:reset(time / 1000)
	end
end

function BattleUIMediator:increaseDead(unit)
	if self._deadCountCfg and self._deadCountWidget then
		self._deadCountWidget:increaseDead()
	end
end

function BattleUIMediator:startNewPhase(phase, duration, elapsed, energySpeed, timelimit)
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

		if phase > 1 and energySpeed and self._phaseAnimWidget then
			self._phaseAnimWidget:showNewPhaseLabel(phase, energySpeed)
		end

		timerWidget:start()
	end

	if phase == 0 or phase == 1 then
		if self._touchEnalbed then
			self._cardArray:setTouchEnabled(true)
			self._masterWidget:setTouchEnabled(true)

			self._touchEnalbed = true
		end

		self._ctrlButtons:setTouchEnabled(true)

		if self._leftPassiveSkill then
			self._leftPassiveSkill:setTouchEnabled(true)
		end

		if self._rightPassiveSkill then
			self._rightPassiveSkill:setTouchEnabled(true)
		end

		if self._leftStageLevel then
			self._leftStageLevel:setTouchEnabled(true)
		end

		if self._rightStageLevel then
			self._rightStageLevel:setTouchEnabled(true)
		end
	end

	if phase == 5 then
		-- block empty
	end
end

function BattleUIMediator:pauseTiming()
	if self._timerWidget then
		self._timerWidget:stop()
	end
end

function BattleUIMediator:resumeTiming()
	if self._timerWidget then
		self._timerWidget:start()
	end
end

function BattleUIMediator:resetTiming(time)
	if self._timerWidget then
		self._timerWidget:reset(time)
	end
end

function BattleUIMediator:roundChanged(roundNumber, maxRounds)
	if self._roundWidget then
		self._roundWidget:setCurrentRoundNum(roundNumber, maxRounds)
	end
end

function BattleUIMediator:syncEnergy(energy, remain, speed)
	if self._energyBar then
		self._energyBar:syncEnergy(energy, remain, speed)
	end

	if self._skillRefreshBtn then
		self._skillRefreshBtn:syncEnergy(energy)
	end
end

function BattleUIMediator:showGrayEnergyEffect(isShow)
	if self._energyBar then
		self._energyBar:setBarGray(isShow)
	end
end

function BattleUIMediator:showFrazeEnergyEffect(isShow)
	if self._energyBar then
		self._energyBar:setBarFraze(isShow)
	end
end

function BattleUIMediator:showRecoveryEnergyAnim()
	if self._energyBar then
		self._energyBar:showRecoveryEnergyAnim()
	end
end

function BattleUIMediator:pauseEnergyIncreasing()
	if self._energyBar then
		self._energyBar:pauseIncreasing()
	end
end

function BattleUIMediator:resumeEnergyIncreasing()
	if self._energyBar then
		self._energyBar:resumeIncreasing()
	end
end

function BattleUIMediator:replaceCard(idxInSlot, card, next)
	if idxInSlot > 4 then
		return
	end

	self._cardArray:setCardAtIndex(idxInSlot, nil)

	local timeScale = self._viewContext:getTimeScale()
	local previewCard = self._cardArray:putPreviewCardAtIndex(idxInSlot, 0, timeScale)

	if previewCard and type(previewCard) == "table" then
		previewCard:updateCardInfo(card)
	end

	if type(next) == "table" then
		if next.type == "skill" then
			if not SkillCardWidget then
				do
					local cardWidget = HeroCardWidget
					local view = cardWidget:createWidgetNode()
					local card = cardWidget:new(view)

					card:updateCardInfo(next)
					self._cardArray:pushPreviewCard(card)
				end

				if self._cardArray then
					local remain = self._cardArray:getRemainingCount() - 1

					self._cardArray:setRemainingCount(math.max(remain, 0))
				end
			end
		end
	end
end

function BattleUIMediator:swapCard(idxInSlot, cardData)
	self._cardArray:setCardAtIndex(idxInSlot, nil)

	local timeScale = self._viewContext:getTimeScale()

	if type(cardData) == "table" then
		if cardData.type == "skill" then
			if not SkillCardWidget then
				local cardWidget = HeroCardWidget
				local view = cardWidget:createWidgetNode()
				local card = cardWidget:new(view)

				card:updateCardInfo(cardData)
				self._cardArray:pushPreviewCard(card)
			end
		end
	end

	self._cardArray:putPreviewCardAtIndex(idxInSlot, 0, timeScale)
end

function BattleUIMediator:replacePreview(preview)
	if preview then
		self._cardArray:disposePreviewCard()

		if type(preview) == "table" then
			if preview.type == "skill" then
				if not SkillCardWidget then
					do
						local cardWidget = HeroCardWidget
						local view = cardWidget:createWidgetNode()
						local card = cardWidget:new(view)

						card:updateCardInfo(preview)
						self._cardArray:pushPreviewCard(card)
					end

					if self._cardArray then
						local remain = self._cardArray:getRemainingCount() - 1

						self._cardArray:setRemainingCount(math.max(remain, 0))
					end
				end
			end
		end
	end
end

function BattleUIMediator:updateCardArray(cards, remain, next)
	local timeScale = self._viewContext:getTimeScale()

	if type(next) == "table" then
		if next.type == "skill" then
			if not SkillCardWidget then
				do
					local cardWidget = HeroCardWidget
					local view = cardWidget:createWidgetNode()
					local card = cardWidget:new(view)

					card:updateCardInfo(next)
					self._cardArray:pushPreviewCard(card)
				end

				local count = 0

				for i = math.min(4, #cards), 1, -1 do
					local cardInfo = cards[i]

					if type(cardInfo) == "table" then
						if cardInfo.type == "skill" then
							if not SkillCardWidget then
								local cardWidget = HeroCardWidget
								local view = cardWidget:createWidgetNode()
								local card = cardWidget:new(view)

								card:updateCardInfo(cardInfo)
								self._cardArray:pushPreviewCard(card)

								count = count + 1
							end
						end
					end
				end

				for i = 1, count do
					local delay = 0.3 * (i - 1) * timeScale

					self._cardArray:putPreviewCardAtIndex(i, delay, timeScale)
				end

				self._cardArray:setRemainingCount(math.max(remain - 4, 0))
			end
		end
	end
end

function BattleUIMediator:updateExtraCardArray(cards, remain)
	cards = cards or {}

	local timeScale = self._viewContext:getTimeScale()
	local count = 0

	for i = math.min(2, #cards), 1, -1 do
		local cardInfo = cards[i]

		if type(cardInfo) == "table" then
			if cardInfo.type == "skill" then
				if not ExtraSkillCardWidget then
					local cardWidget = ExtraHeroCardWidget
					local view = cardWidget:createWidgetNode()
					local card = cardWidget:new(view)

					card:updateCardInfo(cardInfo)
					self._cardArray:pushPreviewCard(card)

					count = count + 1
				end
			end
		end
	end

	for i = 1, count do
		local delay = 0.3 * (i - 1) * timeScale

		self._cardArray:putPreviewCardAtIndex(4 + i, delay, timeScale)
	end
end

function BattleUIMediator:replaceExtraPreview(preview, index)
	if preview and type(preview) == "table" then
		if preview.type == "skill" then
			if not ExtraSkillCardWidget then
				do
					local cardWidget = ExtraHeroCardWidget
					local view = cardWidget:createWidgetNode()
					local card = cardWidget:new(view)

					card:updateCardInfo(preview)
					self._cardArray:pushPreviewCard(card)
				end

				local timeScale = self._viewContext:getTimeScale()

				self._cardArray:putPreviewCardAtIndex(index, 0, timeScale)
			end
		end
	end
end

function BattleUIMediator:removeCards()
	self._cardArray:clearAll()
end

function BattleUIMediator:checkEnergy(cost)
	if self._energyBar:isEnergyEnough(cost) then
		return true
	end
end

function BattleUIMediator:shineEnergyBar(dur)
	self._energyBar:shine()
end

function BattleUIMediator:showSkillTip(skillId, level, pos)
	self._tipWidget:showSkillTip(skillId, level or 1)
	self._tipWidget:setPosition(pos)
end

function BattleUIMediator:hideSkillTip()
	self._tipWidget:hide()
end

function BattleUIMediator:showSkillCardTip(skillId, level, pos)
	self._skillCardTipWidget:showSkillTip(skillId, level or 1)
	self._skillCardTipWidget:setPosition(pos)
end

function BattleUIMediator:hideSkillCardTip()
	self._skillCardTipWidget:hide()
end

function BattleUIMediator:focusLeft()
	local heightOffset = 100
	local targetPos = self._battleGround:relPosWithZoneAndOffset(1, 2, 3)
	local point = self._battleGround:convertRelPos2WorldSpace(targetPos)
	local camera = self._viewContext:getValue("Camera")

	camera:focusOn(point.x, point.y + heightOffset, 1.05, 0.02)
end

function BattleUIMediator:cancelFocus()
	local camera = self._viewContext:getValue("Camera")

	camera:focusOn(display.cx, display.cy, 1, 0.1)
end

function BattleUIMediator:createHeroTip()
	if self._heroTipAnim then
		return
	end

	local anim = cc.MovieClip:create("zdhb_yinghunshangchang")
	local viewNode = cc.CSLoader:createNode("asset/ui/HeroCardTipsWidget.csb")

	anim:posite(568, 320)
	anim:addTo(self:getView(), -1)
	AdjustUtils.adjustLayoutByType(anim, AdjustUtils.kAdjustType.Left + AdjustUtils.kAdjustType.Top)

	self._heroTipWidget = BattleHeroTipWidget:new(viewNode)

	viewNode:addTo(anim:getChildByFullName("widget")):offset(-119, -267)

	self._heroTipAnim = anim
	self._heroTipAimPic = anim:getChildByFullName("heroPic")

	anim:addCallbackByLabel("startclick2", function(cid, mc, label)
		mc:stop()
	end)
	anim:addCallbackByLabel("endclick2", function(cid, mc, label)
		mc:stop()
		mc:setVisible(false)
	end)
	anim:addCallbackByLabel("click2drag2", function(cid, mc, label)
		mc:stop()
	end)
	anim:addCallbackByLabel("enddrag2", function(cid, mc, label)
		mc:stop()
		mc:setVisible(false)
	end)
	anim:addCallbackByLabel("startdrag2", function(cid, mc, label)
		mc:stop()
	end)
	anim:stop()
end

function BattleUIMediator:showHeroTip(card, showType)
	local info = card:getHeroInfo()

	if self._disableHeroTip then
		return
	end

	if not self._heroTipAnim then
		self:createHeroTip()
	end

	if self._hideHeroTipEntry then
		self._hideHeroTipEntry:stop()

		self._hideHeroTipEntry = nil
	end

	self._heroTipAnim:setVisible(true)

	if info ~= self._prevHeroInfo then
		self._prevHeroInfo = info

		self._heroTipWidget:setupHeroInfo(card:getCardInfo())
		self._heroTipAimPic:removeAllChildren()

		local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", info.model, "Bust15")

		if rolePicId ~= nil and rolePicId ~= "" then
			local mid = info.model
			local configShow = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Bust_Inbattle_Show", "content") or {}

			if table.indexof(configShow, info.model) then
				local linkMid = ConfigReader:getDataByNameIdAndKey("RoleModel", info.model, "BattleShow")

				if linkMid and linkMid ~= "" then
					mid = linkMid
				end
			end

			local portrait = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe15",
				id = mid
			})

			portrait:addTo(self._heroTipAimPic)
			portrait:offset(200, -110)
		end
	elseif self._prevHeroShowType ~= showType then
		if self._prevHeroShowType == 1 and showType == 2 then
			self._heroTipAnim:gotoAndPlay("click2drag1")

			self._prevHeroShowType = 2

			return
		end
	else
		return
	end

	self:focusLeft()

	if showType == 1 then
		self._heroTipAnim:gotoAndPlay("startclick1")

		self._prevHeroShowType = 1
	else
		self._heroTipAnim:gotoAndPlay("startdrag1")

		self._prevHeroShowType = 2
	end

	self._masterWidget:getView():stopAllActions()
	self._masterWidget:getView():runAction(cc.FadeTo:create(0.1, 0))
end

function BattleUIMediator:hideHeroTip()
	if self._disableHeroTip then
		return
	end

	if not self._heroTipAnim then
		return
	end

	self._masterWidget:getView():stopAllActions()
	self._masterWidget:getView():runAction(cc.FadeTo:create(0.1, 255))
	self:cancelFocus()

	if self._prevHeroShowType == 1 then
		self._heroTipAnim:gotoAndPlay("endclick1")

		self._prevHeroShowType = nil
	elseif self._prevHeroShowType == 2 then
		self._heroTipAnim:gotoAndPlay("enddrag1")

		self._prevHeroShowType = nil
	else
		self._heroTipAnim:setVisible(false)
	end
end

function BattleUIMediator:adjustCardCost(idxInSlot, detail)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		card:adjustCost(detail)
	end
end

function BattleUIMediator:updateCardInfo(idxInSlot, detail)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		card:updateCardInfo(detail)
	end
end

function BattleUIMediator:updateCardWeight(idxInSlot, card, weight)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		card:updateCardWeight(weight)
	end
end

function BattleUIMediator:maxCardWeight(idxInSlot)
	for i = 1, 4 do
		local card = self._cardArray:getCardAtIndex(i)

		if card then
			if i == idxInSlot then
				card:maxCardWeight(1)
			else
				card:maxCardWeight(0)
			end
		end
	end
end

function BattleUIMediator:updateCurrentBattleSt(status)
	if not self._statusLabel then
		self._statusLabel = cc.Label:createWithTTF(weight, TTF_FONT_FZYH_M, 18)

		self._statusLabel:addTo(self:getView()):offset(50, 200)
		self._statusLabel:setColor(cc.c3b(0, 255, 0))
	end

	local keys = {
		"FriendMasterHP",
		"EnemyMasterHP",
		"PaddingCard",
		"UniqueRatio",
		"Curse",
		"Cost",
		"CardForce"
	}
	local statues = ""

	self._statusLabel:setString(statues)

	for k, v in pairs(status) do
		statues = statues .. string.format(keys[k] .. ":%.02f", v) .. "\n"
	end

	self._statusLabel:setString(statues)
end

function BattleUIMediator:flyBallToCard(role, idxInSlot)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		local posx, posy = role:getView():getPosition()
		local pos_org_word = role:getView():getParent():convertToWorldSpace(cc.p(posx, posy + 80))
		local posx, posy = card:getView():getPosition()
		local pos_des_word = card:getView():getParent():convertToWorldSpace(cc.p(posx, posy + 15))
		local rootNode = cc.Node:create()
		local content = cc.Node:create()

		content:addTo(rootNode)
		content:center(rootNode:getContentSize())

		local flyBall = cc.MovieClip:create("guangqiu_lindaguangquan", "BattleMCGroup")

		flyBall:addTo(content)
		flyBall:offset(110, -20)
		content:setRotation(4)
		flyBall:addCallbackAtFrame(45, function()
			flyBall:stop()
		end)

		local director = cc.Director:getInstance()
		local pos_01 = cc.Node:create()

		pos_01:setPosition(pos_org_word)
		pos_01:addTo(director:getRunningScene())

		local pos_02 = cc.Node:create()

		pos_02:setPosition(pos_des_word)
		pos_02:addTo(director:getRunningScene())
		rootNode:addTo(pos_01)
		rootNode:center(pos_01:getContentSize())

		local position_01 = cc.p(pos_01:getPosition())
		local position_02 = cc.p(pos_02:getPosition())
		local radio = math.abs(position_02.x - position_01.x) / math.abs(position_02.y - position_01.y)
		local direction = position_02.x - position_01.x < 0 and 1 or -1
		local distance = math.sqrt(math.pow(math.abs(position_02.x - position_01.x), 2) + math.pow(math.abs(position_02.y - position_01.y), 2))
		local distance = distance - 240

		rootNode:setRotation(math.atan(radio * direction) * 180 / math.pi)

		local delay01 = cc.DelayTime:create(0.3333333333333333)
		local delay02 = cc.DelayTime:create(0.16666666666666666)
		local sequence = cc.Sequence:create(delay01, cc.MoveTo:create(0.16666666666666666, cc.p(0, -distance)), cc.CallFunc:create(function()
			if not tolua.isnull(card:getView()) then
				card:getView():runAction(cc.Sequence:create(cc.ScaleTo:create(0.08333333333333333, 1.12, 1.12), cc.ScaleTo:create(0.03333333333333333, 1, 1)))
			end
		end), delay02, cc.CallFunc:create(function()
			if not tolua.isnull(rootNode) then
				rootNode:removeFromParent()
				pos_01:removeFromParent()
				pos_02:removeFromParent()
			end
		end))

		content:runAction(sequence)
	end
end

function BattleUIMediator:adjustCardBuff(idxInSlot, anim)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		card:playAddBuffAnim(anim)
	end
end

function BattleUIMediator:forbidSkillChange(args)
	if self._masterWidget then
		self._masterWidget:forbidSkillChange(args)
	end
end

function BattleUIMediator:stackSkillLayer(skillId, stacknum, totalnum)
	if self._masterWidget then
		self._masterWidget:StackSkill(skillId, stacknum, totalnum)
	end
end

function BattleUIMediator:showPassiveSkillTip(passiveSkill, isLeft)
	if self._puttingCard then
		self._cardArray:resetActiveCard()
	end

	self._passiveSkillTip:show(passiveSkill, isLeft)
	self:startBulletTime()
end

function BattleUIMediator:hidePassiveSkillTip()
	self._passiveSkillTip:hide()
	self:stopBulletTime()
end

function BattleUIMediator:showMaster(friend, enemy)
	local bossView = self:getInjector():getInstance("MasterCutInView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
		friend = friend,
		enemy = enemy
	}, popupDelegate))
end

function BattleUIMediator:showLockAnim(idxInSlot, args)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		card:playLockAnim(args)
	end
end

function BattleUIMediator:hideLockAnim(idxInSlot, args)
	local card = self._cardArray:getCardAtIndex(idxInSlot)

	if card then
		card:hideLockAnim()
	end
end

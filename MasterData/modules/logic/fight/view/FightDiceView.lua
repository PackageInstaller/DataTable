-- chunkname: @modules/logic/fight/view/FightDiceView.lua

module("modules.logic.fight.view.FightDiceView", package.seeall)

local FightDiceView = class("FightDiceView", BaseView)
local FirstInterval = 3.27
local NotFirstInterval = 1.66

function FightDiceView:onInitView()
	self._movieGO = gohelper.findChild(self.viewGO, "dicemovie")
	self._resultGO = gohelper.findChild(self.viewGO, "diceresult")
	self._movieEnemyGO = gohelper.findChild(self.viewGO, "dicemovie/dice/#go_enemy")
	self._movieFriendGO = gohelper.findChild(self.viewGO, "dicemovie/dice/#go_friend")
	self._resultEnemyGO = gohelper.findChild(self.viewGO, "diceresult/#go_enemy")
	self._resultFriendGO = gohelper.findChild(self.viewGO, "diceresult/#go_friend")
	self._txtMovieEnemyDice = gohelper.findChildText(self.viewGO, "dicemovie/dice/#go_enemy/#txt_enemyroundcount")
	self._txtMovieEnemyDice2 = gohelper.findChildText(self.viewGO, "dicemovie/dice/#go_enemy/#txt_enemyroundcount_copy")
	self._txtMovieFriendDice = gohelper.findChildText(self.viewGO, "dicemovie/dice/#go_friend/#txt_friendroundcount")
	self._txtMovieFriendDice2 = gohelper.findChildText(self.viewGO, "dicemovie/dice/#go_friend/#txt_friendroundcount_copy")
	self._txtResultEnemyDice = gohelper.findChildText(self.viewGO, "diceresult/#go_enemy/#txt_enemyroundcount")
	self._txtResultEnemyDice2 = gohelper.findChildText(self.viewGO, "diceresult/#go_enemy/#txt_enemyroundcount_copy02")
	self._txtResultFriendDice = gohelper.findChildText(self.viewGO, "diceresult/#go_friend/#txt_friendroundcount")
	self._txtResultFriendDice2 = gohelper.findChildText(self.viewGO, "diceresult/#go_friend/#txt_friendroundcount_copy02")
	self._txtResultEnemyDesc = gohelper.findChildText(self.viewGO, "diceresult/#go_enemy/#txt_enemybuffdes")
	self._txtResultFriendDesc = gohelper.findChildText(self.viewGO, "diceresult/#go_friend/#txt_friendbuffdes")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "dicemovie/#simage_bg")
	self._simageenemybg = gohelper.findChildSingleImage(self.viewGO, "dicemovie/dice/#go_enemy/#simage_enemybg")
	self._simagefriendbg = gohelper.findChildSingleImage(self.viewGO, "dicemovie/dice/#go_friend/#simage_friendbg")
	self._simageenemyresultbg = gohelper.findChildSingleImage(self.viewGO, "diceresult/#go_enemy/#simage_enemybg")
	self._simagefriendresultbg = gohelper.findChildSingleImage(self.viewGO, "diceresult/#go_friend/#simage_friendbg")

	self._simagebg:LoadImage(ResUrl.getFightDiceBg("full/bg_bj"))
	self._simageenemybg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	self._simagefriendbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	self._simageenemyresultbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	self._simagefriendresultbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))

	self._firstRoundAnimation = self._movieGO:GetComponent(gohelper.Type_Animation)
	self.enemyAnimator = self._resultEnemyGO:GetComponent(gohelper.Type_Animator)
	self.friendAnimator = self._resultFriendGO:GetComponent(gohelper.Type_Animator)
end

function FightDiceView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.PushEndFight, self._onEndFight, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function FightDiceView:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.PushEndFight, self._onEndFight, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function FightDiceView:showDice()
	gohelper.setActiveCanvasGroup(self._movieGO, true)
	gohelper.setActiveCanvasGroup(self._resultGO, true)

	if FightDataHelper.tempMgr.douQuQuDice then
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.DouQuQuDice)
	else
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.Dice)
	end
end

function FightDiceView:hideDice()
	gohelper.setActiveCanvasGroup(self._movieGO, false)
	gohelper.setActiveCanvasGroup(self._resultGO, false)

	if FightDataHelper.tempMgr.douQuQuDice then
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.DouQuQuDice)
	else
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.Dice)
	end
end

function FightDiceView:_onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		self:hideDice()
	end
end

function FightDiceView:_onCloseView(viewName)
	if viewName == ViewName.FightFocusView then
		self:showDice()
	end
end

function FightDiceView:_onRoundSequenceStart()
	self:hideDice()
end

function FightDiceView:_setIsShowUI(isVisible)
	if isVisible then
		self:showDice()
	else
		self:hideDice()
	end
end

function FightDiceView:_onEndFight()
	self:closeThis()
end

function FightDiceView:onOpen()
	self:_setDiceInfo()
	self:_checkPlayDice()
end

function FightDiceView:onUpdateParam()
	self:_setDiceInfo()
	self:_checkPlayDice()
end

function FightDiceView:_setDiceInfo()
	local enemyDiceNum = 0
	local friendDiceNum = 0
	local enemyDiceDesc = ""
	local friendDiceDesc = ""

	if FightDataHelper.tempMgr.douQuQuNewDice then
		friendDiceNum = FightDataHelper.tempMgr.douQuQuNewDiceOffset
		friendDiceDesc = ""

		local checkNum = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.DOUQUQU_DICE]

		if checkNum >= 1 and checkNum <= 6 then
			friendDiceDesc = luaLang("fight_douququ_dice_1_6")
		elseif checkNum >= 7 and checkNum <= 18 then
			friendDiceDesc = luaLang("fight_douququ_dice_7_18")
		elseif checkNum >= 19 and checkNum <= 30 then
			friendDiceDesc = luaLang("fight_douququ_dice_19_30")
		elseif checkNum >= 31 then
			friendDiceDesc = luaLang("fight_douququ_dice_31")
		end
	else
		for _, tb in ipairs(self.viewParam) do
			local fightStepData = tb[1]
			local actEffectData = tb[2]
			local skillId = actEffectData.effectNum
			local diceNum = skillId % 10

			if actEffectData.effectType == FightEnum.EffectType.RANDOMDICEUSESKILL then
				diceNum = actEffectData.effectNum
				skillId = actEffectData.effectNum1
			end

			local skillCO = lua_skill.configDict[skillId]

			if fightStepData.fromId == FightEntityScene.MySideId then
				friendDiceNum = diceNum
				friendDiceDesc = FightConfig.instance:getSkillEffectDesc(nil, skillCO)
			elseif fightStepData.fromId == FightEntityScene.EnemySideId then
				enemyDiceNum = diceNum
				enemyDiceDesc = FightConfig.instance:getSkillEffectDesc(nil, skillCO)
			end
		end
	end

	gohelper.setActive(self._movieEnemyGO, enemyDiceNum > 0)
	gohelper.setActive(self._movieFriendGO, friendDiceNum > 0)
	gohelper.setActive(self._resultEnemyGO, enemyDiceNum > 0)
	gohelper.setActive(self._resultFriendGO, friendDiceNum > 0)

	self._txtMovieEnemyDice.text = enemyDiceNum
	self._txtMovieEnemyDice2.text = enemyDiceNum
	self._txtMovieFriendDice.text = friendDiceNum
	self._txtMovieFriendDice2.text = friendDiceNum
	self._txtResultEnemyDice.text = enemyDiceNum
	self._txtResultEnemyDice2.text = enemyDiceNum
	self._txtResultFriendDice.text = friendDiceNum
	self._txtResultFriendDice2.text = friendDiceNum

	if FightDataHelper.tempMgr.douQuQuNewDice then
		self._txtResultFriendDice.alignment = UnityEngine.TextAnchor.MiddleCenter
		self._txtResultFriendDice2.alignment = UnityEngine.TextAnchor.MiddleCenter
		self._txtResultFriendDice.text = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.DOUQUQU_DICE]
		self._txtResultFriendDice2.text = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.DOUQUQU_DICE]

		recthelper.setAnchorX(self._txtResultFriendDice.transform, 0)
	end

	self._txtResultEnemyDesc.text = enemyDiceDesc
	self._txtResultFriendDesc.text = friendDiceDesc
end

function FightDiceView:_checkPlayDice()
	local fightUISpeed = FightModel.instance:getUISpeed()
	local isFirstRound = not FightModel.instance:isStartFinish()

	if isFirstRound then
		gohelper.setActive(self._movieGO, true)
		gohelper.setActive(self._resultGO, true)
		self:moveFriendGo()
		self._firstRoundAnimation:Play()
		self.enemyAnimator:Play("enemy_open")
		self.friendAnimator:Play("friend_open")
		gohelper.onceAddComponent(self._firstRoundAnimation.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(fightUISpeed)
		TaskDispatcher.runDelay(self._delayFirstRoundDone, self, FirstInterval / fightUISpeed)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice01)
	else
		gohelper.setActive(self._movieGO, false)
		gohelper.setActive(self._resultGO, true)
		self.enemyAnimator:Play("enemy_in")
		self.friendAnimator:Play("friend_in")
		gohelper.onceAddComponent(self.enemyAnimator.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(fightUISpeed)
		gohelper.onceAddComponent(self.friendAnimator.gameObject, typeof(ZProj.EffectTimeScale)):SetTimeScale(fightUISpeed)
		TaskDispatcher.runDelay(self._delayNotFirstRoundDone, self, NotFirstInterval / fightUISpeed)
		gohelper.setActiveCanvasGroup(self._resultGO, false)
		TaskDispatcher.runDelay(self._nextFrameShow, self, 0.01)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice02)
	end
end

function FightDiceView:_nextFrameShow()
	gohelper.setActiveCanvasGroup(self._resultGO, true)
end

function FightDiceView:moveFriendGo()
	local fightViewContainer = ViewMgr.instance:getContainer(ViewName.FightView)
	local layoutView = fightViewContainer.rightElementLayoutView
	local parent = layoutView:getElementContainer(FightRightElementEnum.Elements.Dice)

	gohelper.addChild((FightDataHelper.tempMgr.douQuQuDice or nil) and layoutView:getElementContainer(FightRightElementEnum.Elements.DouQuQuDice), self._resultFriendGO)

	local rectTransform = self._resultFriendGO:GetComponent(gohelper.Type_RectTransform)

	rectTransform.pivot = Vector2(1, 1)
	rectTransform.anchorMin = Vector2(1, 1)
	rectTransform.anchorMax = Vector2(1, 1)

	recthelper.setAnchor(rectTransform, -40, 0)

	if FightDataHelper.tempMgr.douQuQuDice then
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.DouQuQuDice)
	else
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.Dice)
	end
end

function FightDiceView:_delayFirstRoundDone()
	TaskDispatcher.cancelTask(self._delayFirstRoundDone, self)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
	gohelper.setActive(self._movieGO, false)
end

function FightDiceView:_delayNotFirstRoundDone()
	TaskDispatcher.cancelTask(self._delayNotFirstRoundDone, self)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function FightDiceView:onClose()
	TaskDispatcher.cancelTask(self._delayFirstRoundDone, self)
	TaskDispatcher.cancelTask(self._delayNotFirstRoundDone, self)
	TaskDispatcher.cancelTask(self._nextFrameShow, self)
end

function FightDiceView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageenemybg:UnLoadImage()
	self._simagefriendbg:UnLoadImage()
	self._simageenemyresultbg:UnLoadImage()
	self._simagefriendresultbg:UnLoadImage()
end

return FightDiceView

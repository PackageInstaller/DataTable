-- chunkname: @modules/logic/fight/view/FightSeasonDiceView.lua

module("modules.logic.fight.view.FightSeasonDiceView", package.seeall)

local FightSeasonDiceView = class("FightSeasonDiceView", BaseView)
local FirstInterval = 3.27
local NotFirstInterval = 1.66

function FightSeasonDiceView:onInitView()
	self._godicemovie = gohelper.findChild(self.viewGO, "root/#go_dicemovie")
	self._imagewave = gohelper.findChildImage(self.viewGO, "root/#go_dicemovie/center/tv/#image_wave")
	self._txtvalue = gohelper.findChildText(self.viewGO, "root/#go_dicemovie/center/tv/#txt_value")
	self._txtvalueef = gohelper.findChildText(self.viewGO, "root/#go_dicemovie/center/tv/#txt_value_ef")
	self._godiceresult = gohelper.findChild(self.viewGO, "root/#go_diceresult")
	self._gofriend = gohelper.findChild(self.viewGO, "root/#go_diceresult/#go_friend")
	self._txtresultvalue = gohelper.findChildText(self.viewGO, "root/#go_diceresult/#go_friend/tv/#txt_resultvalue")
	self._txtresultvalueef = gohelper.findChildText(self.viewGO, "root/#go_diceresult/#go_friend/tv/#txt_resultvalueef")
	self._txteffectdesc = gohelper.findChildText(self.viewGO, "root/#go_diceresult/#go_friend/effect/layout/#txt_effectdesc")
	self._ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function FightSeasonDiceView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.PushEndFight, self._onEndFight, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function FightSeasonDiceView:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.PushEndFight, self._onEndFight, self)
	self.removeEventCb(self, FightController.instance, FightEvent.SetIsShowUI, self._setIsShowUI, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function FightSeasonDiceView:_onOpenView(viewName)
	if viewName == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(self._godicemovie, false)
		gohelper.setActiveCanvasGroup(self._godiceresult, false)
	end
end

function FightSeasonDiceView:_onCloseView(viewName)
	if viewName == ViewName.FightFocusView then
		gohelper.setActiveCanvasGroup(self._godicemovie, true)
		gohelper.setActiveCanvasGroup(self._godiceresult, true)
	end
end

function FightSeasonDiceView:_onRoundSequenceStart()
	gohelper.setActive(self._godicemovie, false)
	gohelper.setActive(self._godiceresult, false)
end

function FightSeasonDiceView:_setIsShowUI(isVisible)
	self._canvasGroup = self._canvasGroup or gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))

	gohelper.setActiveCanvasGroup(self._canvasGroup, isVisible)
end

function FightSeasonDiceView:_onEndFight()
	self:closeThis()
end

function FightSeasonDiceView:onOpen()
	self:_setDiceInfo()
	self:_checkPlayDice()
end

function FightSeasonDiceView:onUpdateParam()
	self:_setDiceInfo()
	self:_checkPlayDice()
end

function FightSeasonDiceView:_setDiceInfo()
	local friendDiceNum = 0
	local friendDiceDesc = ""

	for _, tb in ipairs(self.viewParam) do
		local fightStepData = tb[1]
		local actEffectData = tb[2]
		local diceNum = actEffectData.effectNum % 10
		local skillCO = lua_skill.configDict[actEffectData.effectNum]

		if fightStepData.fromId == FightEntityScene.MySideId then
			friendDiceNum = diceNum
			friendDiceDesc = skillCO and skillCO.desc
		end
	end

	gohelper.setActive(self._godicemovie, friendDiceNum > 0)
	gohelper.setActive(self._godiceresult, friendDiceNum > 0)

	self._txtvalue.text = friendDiceNum
	self._txtvalueef.text = friendDiceNum
	self._txtresultvalue.text = friendDiceNum
	self._txtresultvalueef.text = friendDiceNum
	self._txteffectdesc.text = friendDiceDesc
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._txteffectdesc.gameObject, FixTmpBreakLine)

	self._fixTmpBreakLine:refreshTmpContent(self._txteffectdesc)
end

function FightSeasonDiceView:_checkPlayDice()
	local fightUISpeed = FightModel.instance:getUISpeed()
	local isFirstRound = not FightModel.instance:isStartFinish()

	if isFirstRound then
		gohelper.setActive(self._godicemovie, true)
		gohelper.setActive(self._godiceresult, true)
		self._ani:Play("open", 0, 0)

		self._ani.speed = fightUISpeed

		TaskDispatcher.runDelay(self._delayFirstRoundDone, self, FirstInterval / fightUISpeed)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice01)
	else
		gohelper.setActive(self._godicemovie, false)
		gohelper.setActive(self._godiceresult, true)
		self._ani:Play("result", 0, 0)

		self._ani.speed = fightUISpeed

		TaskDispatcher.runDelay(self._delayNotFirstRoundDone, self, NotFirstInterval / fightUISpeed)
		gohelper.setActiveCanvasGroup(self._godiceresult, false)
		TaskDispatcher.runDelay(self._nextFrameShow, self, 0.01)
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_luckydice02)
	end
end

function FightSeasonDiceView:_nextFrameShow()
	gohelper.setActiveCanvasGroup(self._godiceresult, true)
end

function FightSeasonDiceView:_delayFirstRoundDone()
	TaskDispatcher.cancelTask(self._delayFirstRoundDone, self)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function FightSeasonDiceView:_delayNotFirstRoundDone()
	TaskDispatcher.cancelTask(self._delayNotFirstRoundDone, self)
	FightController.instance:dispatchEvent(FightEvent.OnDiceEnd)
end

function FightSeasonDiceView:onClose()
	TaskDispatcher.cancelTask(self._delayFirstRoundDone, self)
	TaskDispatcher.cancelTask(self._delayNotFirstRoundDone, self)
	TaskDispatcher.cancelTask(self._nextFrameShow, self)
end

function FightSeasonDiceView:onDestroyView()
	return
end

return FightSeasonDiceView

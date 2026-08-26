-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameView", package.seeall)

local YaXianGameView = class("YaXianGameView", BaseView)

function YaXianGameView:onInitView()
	self._txtEpisodeIndex = gohelper.findChildText(self.viewGO, "root/upleft/bg/#txt_classnum")
	self._txtEpisodeName = gohelper.findChildText(self.viewGO, "root/upleft/bg/#txt_title")
	self._txtroundnum = gohelper.findChildText(self.viewGO, "root/upleft/round/cn/#txt_roundnum")
	self._txtmaxroundnum = gohelper.findChildText(self.viewGO, "root/upleft/round/cn/#txt_roundnum/#txt_fullnum")
	self._btnfallback = gohelper.findChildButtonWithAudio(self.viewGO, "root/upright/#btn_fallback")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "root/upright/#btn_reset")
	self._cloudmask = gohelper.findChildSingleImage(self.viewGO, "cloudmask")
	self._middlemask = gohelper.findChildSingleImage(self.viewGO, "middlemask")
	self._mask = gohelper.findChildSingleImage(self.viewGO, "mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGameView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnfallback:AddClickListener(self._btnfallbackOnClick, self)
end

function YaXianGameView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnfallback:RemoveClickListener()
end

function YaXianGameView:_btnresetOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesclose)
	GameFacade.showMessageBox(MessageBoxIdDefine.PushBoxReset, MsgBoxEnum.BoxType.Yes_No, self.playResetAnimation, nil, nil, self)
end

function YaXianGameView:playResetAnimation()
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Reset)
	UIBlockMgr.instance:startBlock(self.viewName .. "excessive")
	self.viewAnimator:Play("excessive", 0, 0)

	self.resetMap = true

	TaskDispatcher.cancelTask(self.onExcessiveAnimationDone, self)
	TaskDispatcher.runDelay(self.onExcessiveAnimationDone, self, 1)
end

function YaXianGameView:onExcessiveAnimationDone()
	UIBlockMgr.instance:endBlock(self.viewName .. "excessive")
end

function YaXianGameView:startReset()
	YaXianGameController.instance:stopRunningStep()
	ViewMgr.instance:closeView(ViewName.YaXianGameResultView)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnResetView)
	YaXianGameController.instance:enterChessGame(YaXianGameModel.instance:getEpisodeId())
end

function YaXianGameView:_btnfallbackOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continueappear)
	Activity115Rpc.instance:sendAct115RevertRequest(YaXianGameModel.instance:getActId())
end

function YaXianGameView:_onOpenView(viewName)
	if viewName == ViewName.YaXianGameTipView then
		self:setUIVisible(false)
	end
end

function YaXianGameView:_onCloseView(viewName)
	if viewName == ViewName.YaXianGameTipView then
		self:setUIVisible(true)
	end
end

function YaXianGameView:_editableInitView()
	self._cloudmask:LoadImage(ResUrl.getYaXianImage("img_gezi_cloud"))
	self._middlemask:LoadImage(ResUrl.getYaXianImage("img_gezi_deco"))
	self._mask:LoadImage(ResUrl.getYaXianImage("img_gezi_deco2"))

	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.goBtns = gohelper.findChild(self.viewGO, "#go_btns")
	self.conditionItemList = {}
	self.goConditionItem = gohelper.findChild(self.viewGO, "root/upleft/nodelist/condition_item")

	gohelper.setActive(self.goConditionItem, false)

	self.viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.animationEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self.animationEventWrap:AddEventListener("startReset", self.startReset, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.UpdateRound, self.onUpdateRound, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnGameVictory, self.onGameOverCheckGuide, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnGameFail, self.onGameOver, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.QuitGame, self.onQuitGame, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnRevert, self.onRevert, self, LuaEventSystem.High)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)
	self.addEventCb(self, YaXianController.instance, YaXianEvent.OnPlayingClickAnimationValueChange, self.onPlayingClickAnimationValueChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function YaXianGameView:onUpdateParam()
	self:onOpen()
end

function YaXianGameView:onOpen()
	self:initData()

	self._txtEpisodeIndex.text = self.episodeCo.index
	self._txtEpisodeName.text = self.episodeCo.name

	self:refreshRound()
	self:initConditions()
	self:refreshConditionsStatus()
end

function YaXianGameView:initData()
	self.episodeId = YaXianGameModel.instance:getEpisodeId()
	self.actId = YaXianGameModel.instance:getActId()
	self.episodeCo = YaXianConfig.instance:getEpisodeConfig(self.actId, self.episodeId)
	self.conditionList = nil
end

function YaXianGameView:initConditions()
	self.conditionList = YaXianConfig.instance:getConditionList(self.episodeCo)

	local conditionTextList = string.split(self.episodeCo.conditionStr, "|")

	for i, _ in ipairs(self.conditionList) do
		local conditionItem = self.conditionItemList[i]

		if not conditionItem then
			conditionItem = self:createConditionItem()

			table.insert(self.conditionItemList, conditionItem)
		end

		gohelper.setActive(conditionItem.go, true)

		conditionItem.txtCondition.text = conditionTextList[i]
	end
end

function YaXianGameView:createConditionItem()
	local conditionItem = self:getUserDataTb_()

	conditionItem.go = gohelper.cloneInPlace(self.goConditionItem)
	conditionItem.toothLight = gohelper.findChild(conditionItem.go, "#go_toothlight")
	conditionItem.toothDark = gohelper.findChild(conditionItem.go, "#go_toothdark")
	conditionItem.txtCondition = gohelper.findChildText(conditionItem.go, "#txt_condition")

	return conditionItem
end

function YaXianGameView:refreshConditionsStatus()
	for i, condition in ipairs(self.conditionList) do
		local conditionItem = self.conditionItemList[i]
		local finish = YaXianGameModel.instance:checkFinishCondition(condition[1], condition[2])

		gohelper.setActive(conditionItem.toothLight, finish)
		gohelper.setActive(conditionItem.toothDark, not finish)
	end
end

function YaXianGameView:refreshRound()
	self._txtroundnum.text = YaXianGameModel.instance:getRound()
	self._txtmaxroundnum.text = "/" .. self.episodeCo.maxRound
end

function YaXianGameView:onUpdateRound()
	self:refreshRound()
	self:refreshConditionsStatus()
end

function YaXianGameView:onGameOverCheckGuide()
	local episodeId = YaXianGameModel.instance:getEpisodeId()
	local v1 = "OnChessResultViewPause"
	local v2 = GuideEvent[v1]
	local v3 = GuideEvent.OnChessResultViewContinue
	local v4 = YaXianGameView.onGameOver
	local v5 = self

	GuideController.instance:GuideFlowPauseAndContinue(v1, v2, v3, v4, v5)
end

function YaXianGameView:onGameOver()
	self:refreshConditionsStatus()

	local isWin = YaXianGameModel.instance:getResult()

	if isWin then
		local unlockToothId = self.episodeCo.tooth

		if unlockToothId ~= 0 then
			local toothConfig = YaXianConfig.instance:getToothConfig(unlockToothId)

			if not StoryModel.instance:isStoryFinished(toothConfig.story) then
				self.flow = FlowSequence.New()

				self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.YaXianFindToothView, {
					toothId = unlockToothId
				}))
				self.flow:addWork(PlayStoryWork.New(toothConfig.story))
				self.flow:registerDoneListener(self.openGameResultView, self)
				self.flow:start()

				return
			end
		end
	end

	self:openGameResultView()
end

function YaXianGameView:openGameResultView()
	local episodeConfig = YaXianGameModel.instance:getEpisodeCo()
	local result = YaXianGameModel.instance:getResult()

	if episodeConfig == nil then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)

		return
	end

	ViewMgr.instance:openView(ViewName.YaXianGameResultView, {
		result = result,
		episodeConfig = episodeConfig
	})
end

function YaXianGameView:onQuitGame()
	self:closeThis()
end

function YaXianGameView:setUIVisible(isShow)
	gohelper.setActive(self.goRoot, isShow)
	gohelper.setActive(self.goBtns, isShow)
end

function YaXianGameView:onRevert()
	self:onUpdateRound()

	self.revertMap = true
end

function YaXianGameView:onGameLoadDone()
	if self.resetMap or self.revertMap then
		self.resetMap = nil
		self.revertMap = nil

		return
	end

	self:onPlayingClickAnimationValueChange()
end

function YaXianGameView:onPlayingClickAnimationValueChange()
	self.viewContainer:refreshViewGo()

	local playing = YaXianModel.instance:checkIsPlayingClickAnimation()

	if not playing and not self.playedOpenAnimation then
		self.viewAnimator:Play(UIAnimationName.Open, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.YaXian.EnterYaXianGame)

		self.playedOpenAnimation = true
	end
end

function YaXianGameView:onClose()
	TaskDispatcher.cancelTask(self.onExcessiveAnimationDone, self)

	if self.flow then
		self.flow:destroy()
	end

	ViewMgr.instance:closeView(ViewName.YaXianGameTipView)
end

function YaXianGameView:onDestroyView()
	self.animationEventWrap:RemoveAllEventListener()
	self._cloudmask:UnLoadImage()
	self._middlemask:UnLoadImage()
	self._mask:UnLoadImage()
end

return YaXianGameView

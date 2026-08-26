-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameContainer.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameContainer", package.seeall)

local YaXianGameContainer = class("YaXianGameContainer", BaseViewContainer)

function YaXianGameContainer:buildViews()
	local views = {}

	table.insert(views, YaXianGameSceneView.New())
	table.insert(views, YaXianGameTipAreaView.New())
	table.insert(views, YaXianGamePathView.New())
	table.insert(views, YaXianGameView.New())
	table.insert(views, YaXianGameSkillView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function YaXianGameContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.YaxianChessHelp)

		navigateView:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			navigateView
		}
	end
end

function YaXianGameContainer:onContainerInit()
	self:refreshViewGo()
end

function YaXianGameContainer:refreshViewGo()
	gohelper.setActive(self.viewGO, not YaXianModel.instance:checkIsPlayingClickAnimation())
end

function YaXianGameContainer:onContainerOpen()
	local episodeCo = YaXianGameModel.instance:getEpisodeCo()
	local chapterCo = YaXianConfig.instance:getChapterConfig(episodeCo.chapterId)

	AudioMgr.instance:trigger(chapterCo.ambientAudio)
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_decrease)
end

function YaXianGameContainer:onContainerClose()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_redecrease)
	ViewMgr.instance:closeView(ViewName.YaXianGameResultView)
end

function YaXianGameContainer:onContainerCloseFinish()
	YaXianGameController.instance:release()
	YaXianGameModel.instance:release()
end

function YaXianGameContainer:setRootSceneGo(sceneGo)
	self.sceneGo = sceneGo
end

function YaXianGameContainer:getRootSceneGo()
	return self.sceneGo
end

function YaXianGameContainer:getScenePosOffsetY()
	if self.sceneOffsetY then
		return self.sceneOffsetY
	end

	local _, offsetY, _ = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	self.sceneOffsetY = offsetY

	return self.sceneOffsetY
end

function YaXianGameContainer:playOpenTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	self:onPlayOpenTransitionFinish()
end

function YaXianGameContainer:playCloseTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()

	local animatorPlayer = self:__getAnimatorPlayer()

	animatorPlayer:Play("close", self.onPlayCloseTransitionFinish, self)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 2)
end

function YaXianGameContainer:overrideOnCloseClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, self.yesCallback, nil, nil, self)
end

function YaXianGameContainer:yesCallback()
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Abort)
	self:closeThis()
end

return YaXianGameContainer

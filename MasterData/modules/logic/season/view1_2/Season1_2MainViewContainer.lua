-- chunkname: @modules/logic/season/view1_2/Season1_2MainViewContainer.lua

module("modules.logic.season.view1_2.Season1_2MainViewContainer", package.seeall)

local Season1_2MainViewContainer = class("Season1_2MainViewContainer", BaseViewContainer)

function Season1_2MainViewContainer:buildViews()
	local views = {}

	self.scene = Season1_2MainScene.New()
	self.view = Season1_2MainView.New()

	table.insert(views, self.scene)
	table.insert(views, self.view)
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function Season1_2MainViewContainer:getScene()
	return self.scene
end

function Season1_2MainViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)
	self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_2MainViewHelp)

	return {
		self._navigateButtonView
	}
end

function Season1_2MainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Season
	})
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_goldcup_open)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act104)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act104
	})
end

function Season1_2MainViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio()
end

function Season1_2MainViewContainer:_closeCallback()
	return
end

function Season1_2MainViewContainer:_homeCallback()
	self:closeThis()
end

function Season1_2MainViewContainer:stopUI()
	self:setVisibleInternal(true)

	self._anim.speed = 0
	self._animRetail.speed = 0

	self.view:activeMask(true)
end

function Season1_2MainViewContainer:playUI()
	self:setVisibleInternal(true)

	self._anim.speed = 1
	self._animRetail.speed = 1

	self.view:activeMask(false)
end

function Season1_2MainViewContainer:setVisibleInternal(isVisible)
	if not self.viewGO then
		return
	end

	self._anim = self._anim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if isVisible then
		self:_setVisible(true)
		self._anim:Play(UIAnimationName.Switch, 0, 0)

		if not self._animRetail then
			local goretail = gohelper.findChild(self.viewGO, "rightbtns/#go_retail")

			self._animRetail = goretail:GetComponent(typeof(UnityEngine.Animator))
		end

		self._animRetail:Play(UIAnimationName.Switch, 0, 0)

		if self.scene then
			self.scene:initCamera()
		end
	else
		self:_setVisible(false)
		self._anim:Play(UIAnimationName.Close)
	end
end

return Season1_2MainViewContainer

-- chunkname: @modules/logic/season/view3_0/Season3_0MainViewContainer.lua

module("modules.logic.season.view3_0.Season3_0MainViewContainer", package.seeall)

local Season3_0MainViewContainer = class("Season3_0MainViewContainer", BaseViewContainer)

function Season3_0MainViewContainer:buildViews()
	local views = {}

	self.scene = Season3_0MainScene.New()
	self.view = Season3_0MainView.New()

	table.insert(views, self.scene)
	table.insert(views, self.view)
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function Season3_0MainViewContainer:getScene()
	return self.scene
end

function Season3_0MainViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, self._closeCallback, self._homeCallback, nil, self)

	self._navigateButtonView:setOverrideClose(self._overrideClose, self)
	self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season3_0MainViewHelp)

	return {
		self._navigateButtonView
	}
end

function Season3_0MainViewContainer:onContainerInit()
	local actId = Activity104Model.instance:getCurSeasonId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

function Season3_0MainViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio()
end

function Season3_0MainViewContainer:_closeCallback()
	return
end

function Season3_0MainViewContainer:_homeCallback()
	self:closeThis()
end

function Season3_0MainViewContainer:stopUI()
	self:setVisibleInternal(true)

	self._anim.speed = 0
	self._animRetail.speed = 0

	self.view:activeMask(true)
end

function Season3_0MainViewContainer:playUI()
	self:setVisibleInternal(true)

	self._anim.speed = 1
	self._animRetail.speed = 1

	self.view:activeMask(false)
end

function Season3_0MainViewContainer:setVisibleInternal(isVisible)
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

return Season3_0MainViewContainer

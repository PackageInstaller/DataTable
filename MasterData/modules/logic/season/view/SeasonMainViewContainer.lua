-- chunkname: @modules/logic/season/view/SeasonMainViewContainer.lua

module("modules.logic.season.view.SeasonMainViewContainer", package.seeall)

local SeasonMainViewContainer = class("SeasonMainViewContainer", BaseViewContainer)

function SeasonMainViewContainer:buildViews()
	local views = {}

	self.scene = SeasonMainScene.New()
	self.view = SeasonMainView.New()

	table.insert(views, self.scene)
	table.insert(views, self.view)
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function SeasonMainViewContainer:getScene()
	return self.scene
end

function SeasonMainViewContainer:buildTabViews(tabContainerId)
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

function SeasonMainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act104)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act104
	})
end

function SeasonMainViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio()
end

function SeasonMainViewContainer:_closeCallback()
	return
end

function SeasonMainViewContainer:_homeCallback()
	self:closeThis()
end

function SeasonMainViewContainer:stopUI()
	self:setVisibleInternal(true)

	self._anim.speed = 0
	self._animRetail.speed = 0

	self.view:activeMask(true)
end

function SeasonMainViewContainer:playUI()
	self:setVisibleInternal(true)

	self._anim.speed = 1
	self._animRetail.speed = 1

	self.view:activeMask(false)
end

function SeasonMainViewContainer:setVisibleInternal(isVisible)
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

return SeasonMainViewContainer

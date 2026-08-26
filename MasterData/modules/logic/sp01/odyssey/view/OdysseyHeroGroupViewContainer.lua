-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupViewContainer", package.seeall)

local OdysseyHeroGroupViewContainer = class("OdysseyHeroGroupViewContainer", BaseViewContainer)

function OdysseyHeroGroupViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyHeroGroupView.New())
	table.insert(views, OdysseyHeroListView.New())
	table.insert(views, OdysseySuitListView.New())
	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(views, CheckActivityEndView.New())

	return views
end

function OdysseyHeroGroupViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.OdysseyHeroGroup, self._closeCallback, self._closeHomeCallback, nil, self)

		self.navigateView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self.navigateView
		}
	end
end

function OdysseyHeroGroupViewContainer:_closeCallback()
	self:closeThis()

	if self:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function OdysseyHeroGroupViewContainer:_closeHomeCallback()
	self:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function OdysseyHeroGroupViewContainer:handleVersionActivityCloseCall()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		return true
	end

	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return OdysseyHeroGroupViewContainer

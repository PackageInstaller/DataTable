-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupViewContainer.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupViewContainer", package.seeall)

local TowerComposeHeroGroupViewContainer = class("TowerComposeHeroGroupViewContainer", BaseViewContainer)

function TowerComposeHeroGroupViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeHeroGroupView.New())
	table.insert(views, TowerComposeHeroGroupRuleView.New())
	table.insert(views, TowerComposeHeroGroupPlaneRuleView.New())
	table.insert(views, TowerComposeHeroGroupListView.New())
	table.insert(views, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))

	return views
end

function TowerComposeHeroGroupViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local helpId = self:getHelpId()

		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			helpId ~= nil
		}, helpId, self._closeCallback, nil, nil, self)

		return {
			self._navigateButtonsView
		}
	end
end

function TowerComposeHeroGroupViewContainer:getHelpId()
	local helpId
	local normalGuideId = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)

	return (GuideModel.instance:isGuideFinish(normalGuideId) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupNormal) or nil) and HelpEnum.HelpId.HeroGroupNormal
end

function TowerComposeHeroGroupViewContainer:_closeCallback()
	self:closeThis()
	MainController.instance:enterMainScene(true, false)
end

return TowerComposeHeroGroupViewContainer

-- chunkname: @modules/logic/towercompose/view/TowerComposeModEquipViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeModEquipViewContainer", package.seeall)

local TowerComposeModEquipViewContainer = class("TowerComposeModEquipViewContainer", BaseViewContainer)

function TowerComposeModEquipViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeModEquipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerComposeModEquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerComposeModEquip)

		self.navigateView:setOverrideClose(self.overrideClose, self)
		self.navigateView:setOverrideHome(self.overrideHome, self)

		return {
			self.navigateView
		}
	end
end

function TowerComposeModEquipViewContainer:overrideClose()
	local themeId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo.lock then
		TowerComposeRpc.instance:sendTowerComposeCancelReChallengeRequest(themeId)
	end

	self:closeThis()
end

function TowerComposeModEquipViewContainer:overrideHome()
	local themeId = TowerComposeModel.instance:getCurThemeIdAndLayer()
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo.lock then
		TowerComposeRpc.instance:sendTowerComposeCancelReChallengeRequest(themeId)
	end

	NavigateButtonsView.homeClick()
end

return TowerComposeModEquipViewContainer

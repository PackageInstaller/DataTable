-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2StoreViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreViewContainer", package.seeall)

local VersionActivity1_2StoreViewContainer = class("VersionActivity1_2StoreViewContainer", BaseViewContainer)

function VersionActivity1_2StoreViewContainer:buildViews()
	return {
		VersionActivity1_2StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivity1_2StoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.LvHuEMen
			})
		}
	end
end

return VersionActivity1_2StoreViewContainer

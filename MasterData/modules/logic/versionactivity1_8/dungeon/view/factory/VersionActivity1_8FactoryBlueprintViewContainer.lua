-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryBlueprintViewContainer.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintViewContainer", package.seeall)

local VersionActivity1_8FactoryBlueprintViewContainer = class("VersionActivity1_8FactoryBlueprintViewContainer", BaseViewContainer)

function VersionActivity1_8FactoryBlueprintViewContainer:buildViews()
	return {
		VersionActivity1_8FactoryBlueprintView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function VersionActivity1_8FactoryBlueprintViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			navigateView
		}
	elseif tabContainerId == 2 then
		self._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V1a8FactoryPart
		})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function VersionActivity1_8FactoryBlueprintViewContainer:setCurrencyType(currencyTypeParam)
	if not self._currencyView then
		return
	end

	self._currencyView:setCurrencyType(currencyTypeParam)
end

return VersionActivity1_8FactoryBlueprintViewContainer

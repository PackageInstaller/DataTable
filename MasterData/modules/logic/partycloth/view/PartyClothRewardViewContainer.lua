-- chunkname: @modules/logic/partycloth/view/PartyClothRewardViewContainer.lua

module("modules.logic.partycloth.view.PartyClothRewardViewContainer", package.seeall)

local PartyClothRewardViewContainer = class("PartyClothRewardViewContainer", BaseViewContainer)

function PartyClothRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyClothRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function PartyClothRewardViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local currencyParam = {
			CurrencyEnum.CurrencyType.V3a9PartyGameStoreCoin
		}

		return {
			CurrencyView.New(currencyParam)
		}
	end
end

return PartyClothRewardViewContainer

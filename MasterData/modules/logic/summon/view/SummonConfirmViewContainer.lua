-- chunkname: @modules/logic/summon/view/SummonConfirmViewContainer.lua

module("modules.logic.summon.view.SummonConfirmViewContainer", package.seeall)

local SummonConfirmViewContainer = class("SummonConfirmViewContainer", BaseViewContainer)

function SummonConfirmViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, SummonConfirmView.New())

	return views
end

function SummonConfirmViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local pool = SummonMainModel.instance:getCurPool()

		if pool then
			local result = {}
			local costSet = {}

			SummonMainModel.addCurrencyByCostStr(result, pool.cost1, costSet)
			table.insert(result, CurrencyEnum.CurrencyType.Diamond)
			table.insert(result, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

			self._currencyView = CurrencyView.New(result, nil, nil, nil, true)
		else
			self._currencyView = CurrencyView.New({
				{
					id = 140001,
					isIcon = true,
					type = MaterialEnum.MaterialType.Item
				},
				CurrencyEnum.CurrencyType.FreeDiamondCoupon
			}, nil, nil, nil, true)
		end

		return {
			self._currencyView
		}
	end
end

return SummonConfirmViewContainer

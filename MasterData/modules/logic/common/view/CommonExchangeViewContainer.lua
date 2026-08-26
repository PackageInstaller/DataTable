-- chunkname: @modules/logic/common/view/CommonExchangeViewContainer.lua

module("modules.logic.common.view.CommonExchangeViewContainer", package.seeall)

local CommonExchangeViewContainer = class("CommonExchangeViewContainer", BaseViewContainer)

function CommonExchangeViewContainer:buildViews()
	local views = {}

	table.insert(views, CommonExchangeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function CommonExchangeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return self:_buildCurrency()
	end
end

function CommonExchangeViewContainer:_buildCurrency()
	local costMatData = self.viewParam.costMatData

	self._currencyView = CurrencyView.New({
		{
			isHideAddBtn = true,
			type = costMatData.materilType,
			id = costMatData.materilId
		}
	}, nil, nil, nil, true)

	return {
		self._currencyView
	}
end

return CommonExchangeViewContainer

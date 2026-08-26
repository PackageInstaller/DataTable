-- chunkname: @modules/logic/versionactivity2_5/challenge/view/store/Act183CurrencyReplaceTipsViewContainer.lua

module("modules.logic.versionactivity2_5.challenge.view.store.Act183CurrencyReplaceTipsViewContainer", package.seeall)

local Act183CurrencyReplaceTipsViewContainer = class("Act183CurrencyReplaceTipsViewContainer", BaseViewContainer)

function Act183CurrencyReplaceTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Act183CurrencyReplaceTipsView.New())

	return views
end

return Act183CurrencyReplaceTipsViewContainer

-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3StoreViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3StoreViewContainer", package.seeall)

local Turnback3StoreViewContainer = class("Turnback3StoreViewContainer", BaseViewContainer)

function Turnback3StoreViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3StoreView.New())
	table.insert(views, Turnback3StoreRecommendView.New())

	return views
end

return Turnback3StoreViewContainer

-- chunkname: @modules/logic/sodache/view/outside/SodacheCardDetailViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheCardDetailViewContainer", package.seeall)

local SodacheCardDetailViewContainer = class("SodacheCardDetailViewContainer", BaseViewContainer)

function SodacheCardDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheCardDetailView.New())

	return views
end

return SodacheCardDetailViewContainer

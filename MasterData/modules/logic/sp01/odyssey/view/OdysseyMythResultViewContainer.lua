-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythResultViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythResultViewContainer", package.seeall)

local OdysseyMythResultViewContainer = class("OdysseyMythResultViewContainer", BaseViewContainer)

function OdysseyMythResultViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyMythResultView.New())

	return views
end

return OdysseyMythResultViewContainer

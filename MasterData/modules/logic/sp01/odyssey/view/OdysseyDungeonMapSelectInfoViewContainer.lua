-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonMapSelectInfoViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectInfoViewContainer", package.seeall)

local OdysseyDungeonMapSelectInfoViewContainer = class("OdysseyDungeonMapSelectInfoViewContainer", BaseViewContainer)

function OdysseyDungeonMapSelectInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyDungeonMapSelectInfoView.New())

	return views
end

return OdysseyDungeonMapSelectInfoViewContainer

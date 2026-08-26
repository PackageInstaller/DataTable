-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonRewardViewContainer.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonRewardViewContainer", package.seeall)

local OdysseyDungeonRewardViewContainer = class("OdysseyDungeonRewardViewContainer", BaseViewContainer)

function OdysseyDungeonRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyDungeonRewardView.New())

	return views
end

return OdysseyDungeonRewardViewContainer

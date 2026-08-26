-- chunkname: @modules/logic/activitywelfare/subview/DestinyStoneGiftPickChoiceViewContainer.lua

module("modules.logic.activitywelfare.subview.DestinyStoneGiftPickChoiceViewContainer", package.seeall)

local DestinyStoneGiftPickChoiceViewContainer = class("DestinyStoneGiftPickChoiceViewContainer", BaseViewContainer)

function DestinyStoneGiftPickChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, DestinyStoneGiftPickChoiceView.New())

	return views
end

return DestinyStoneGiftPickChoiceViewContainer

-- chunkname: @modules/logic/versionactivity2_4/act181/view/Activity181RewardViewContainer.lua

module("modules.logic.versionactivity2_4.act181.view.Activity181RewardViewContainer", package.seeall)

local Activity181RewardViewContainer = class("Activity181RewardViewContainer", BaseViewContainer)

function Activity181RewardViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity181RewardView.New())

	return views
end

return Activity181RewardViewContainer

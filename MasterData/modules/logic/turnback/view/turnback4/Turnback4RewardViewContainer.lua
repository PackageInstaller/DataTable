-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4RewardViewContainer.lua

module("modules.logic.turnback.view.turnback4.Turnback4RewardViewContainer", package.seeall)

local Turnback4RewardViewContainer = class("Turnback4RewardViewContainer", BaseViewContainer)

function Turnback4RewardViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback4RewardView.New())

	return views
end

return Turnback4RewardViewContainer

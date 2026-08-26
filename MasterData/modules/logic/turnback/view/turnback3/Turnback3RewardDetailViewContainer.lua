-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3RewardDetailViewContainer.lua

module("modules.logic.turnback.view.turnback3.Turnback3RewardDetailViewContainer", package.seeall)

local Turnback3RewardDetailViewContainer = class("Turnback3RewardDetailViewContainer", BaseViewContainer)

function Turnback3RewardDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Turnback3RewardDetailView.New())

	return views
end

return Turnback3RewardDetailViewContainer

-- chunkname: @modules/logic/autochess/main/view/v4a0/AutoChessAdventureViewContainer.lua

module("modules.logic.autochess.main.view.v4a0.AutoChessAdventureViewContainer", package.seeall)

local AutoChessAdventureViewContainer = class("AutoChessAdventureViewContainer", BaseViewContainer)

function AutoChessAdventureViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessAdventureView.New())

	return views
end

return AutoChessAdventureViewContainer

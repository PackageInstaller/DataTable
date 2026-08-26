-- chunkname: @modules/logic/fight/view/Fight3_7QteViewContainer.lua

module("modules.logic.fight.view.Fight3_7QteViewContainer", package.seeall)

local Fight3_7QteViewContainer = class("Fight3_7QteViewContainer", BaseViewContainer)

function Fight3_7QteViewContainer:buildViews()
	local views = {}

	table.insert(views, Fight3_7QteView.New())

	return views
end

return Fight3_7QteViewContainer

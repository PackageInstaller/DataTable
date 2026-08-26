-- chunkname: @modules/logic/heroexpbox/view/HeroExpBoxPanelViewContainer.lua

module("modules.logic.heroexpbox.view.HeroExpBoxPanelViewContainer", package.seeall)

local HeroExpBoxPanelViewContainer = class("HeroExpBoxPanelViewContainer", BaseViewContainer)

function HeroExpBoxPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, HeroExpBoxPanelView.New())

	return views
end

return HeroExpBoxPanelViewContainer

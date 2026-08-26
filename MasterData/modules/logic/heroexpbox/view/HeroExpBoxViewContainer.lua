-- chunkname: @modules/logic/heroexpbox/view/HeroExpBoxViewContainer.lua

module("modules.logic.heroexpbox.view.HeroExpBoxViewContainer", package.seeall)

local HeroExpBoxViewContainer = class("HeroExpBoxViewContainer", BaseViewContainer)

function HeroExpBoxViewContainer:buildViews()
	local views = {}

	table.insert(views, HeroExpBoxView.New())

	return views
end

return HeroExpBoxViewContainer

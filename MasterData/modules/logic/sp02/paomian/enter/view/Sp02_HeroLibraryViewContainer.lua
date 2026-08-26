-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_HeroLibraryViewContainer.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_HeroLibraryViewContainer", package.seeall)

local Sp02_HeroLibraryViewContainer = class("Sp02_HeroLibraryViewContainer", BaseViewContainer)

function Sp02_HeroLibraryViewContainer:buildViews()
	local views = {}

	table.insert(views, Sp02_HeroLibraryView.New())

	return views
end

return Sp02_HeroLibraryViewContainer

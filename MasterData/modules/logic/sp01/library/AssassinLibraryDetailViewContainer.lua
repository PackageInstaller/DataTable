-- chunkname: @modules/logic/sp01/library/AssassinLibraryDetailViewContainer.lua

module("modules.logic.sp01.library.AssassinLibraryDetailViewContainer", package.seeall)

local AssassinLibraryDetailViewContainer = class("AssassinLibraryDetailViewContainer", BaseViewContainer)

function AssassinLibraryDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinLibraryDetailView.New())

	return views
end

return AssassinLibraryDetailViewContainer

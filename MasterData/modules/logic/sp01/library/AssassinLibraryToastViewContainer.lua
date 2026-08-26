-- chunkname: @modules/logic/sp01/library/AssassinLibraryToastViewContainer.lua

module("modules.logic.sp01.library.AssassinLibraryToastViewContainer", package.seeall)

local AssassinLibraryToastViewContainer = class("AssassinLibraryToastViewContainer", BaseViewContainer)

function AssassinLibraryToastViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinLibraryToastView.New())

	return views
end

return AssassinLibraryToastViewContainer

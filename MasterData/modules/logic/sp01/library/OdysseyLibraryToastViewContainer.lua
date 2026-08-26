-- chunkname: @modules/logic/sp01/library/OdysseyLibraryToastViewContainer.lua

module("modules.logic.sp01.library.OdysseyLibraryToastViewContainer", package.seeall)

local OdysseyLibraryToastViewContainer = class("OdysseyLibraryToastViewContainer", BaseViewContainer)

function OdysseyLibraryToastViewContainer:buildViews()
	local views = {}

	table.insert(views, OdysseyLibraryToastView.New())

	return views
end

return OdysseyLibraryToastViewContainer

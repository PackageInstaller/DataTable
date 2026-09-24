-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterGetViewContainer.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterGetViewContainer", package.seeall)

local SonnetInterchapterGetViewContainer = class("SonnetInterchapterGetViewContainer", BaseViewContainer)

function SonnetInterchapterGetViewContainer:buildViews()
	local views = {}

	table.insert(views, SonnetInterchapterGetView.New())

	return views
end

return SonnetInterchapterGetViewContainer

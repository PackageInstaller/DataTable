-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/DebugViewBtlPresentor.lua

module("logic.extensions.gm.view.DebugViewBtlPresentor", package.seeall)

local DebugViewBtlPresentor = class("DebugViewBtlPresentor", ViewPresentor)

function DebugViewBtlPresentor:ctor()
	DebugViewBtlPresentor.super.ctor(self)
end

function DebugViewBtlPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DebugViewBtlPresentor:dependWhatResources()
	return {
		"ui/views/gm/view_btl_debug.prefab"
	}
end

function DebugViewBtlPresentor:buildViews()
	local views = {}
	local debugView = DebugViewBtlView.New()

	table.insert(views, debugView)

	return views
end

return DebugViewBtlPresentor

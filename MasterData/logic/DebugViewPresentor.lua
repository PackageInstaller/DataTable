-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/DebugViewPresentor.lua

module("logic.extensions.gm.view.DebugViewPresentor", package.seeall)

local DebugViewPresentor = class("DebugViewPresentor", ViewPresentor)

function DebugViewPresentor:ctor()
	DebugViewPresentor.super.ctor(self)
end

function DebugViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DebugViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/debugpanel.prefab"
	}
end

function DebugViewPresentor:buildViews()
	local views = {}
	local debugView = DebugView.New()
	local editView = FightEditView.New()
	local summonView = SummonDebugView.New()

	table.insert(views, debugView)
	table.insert(views, editView)
	table.insert(views, summonView)

	return views
end

return DebugViewPresentor

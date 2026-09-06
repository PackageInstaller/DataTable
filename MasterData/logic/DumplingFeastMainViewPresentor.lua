-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastMainViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastMainViewPresentor", package.seeall)

local DumplingFeastMainViewPresentor = class("DumplingFeastMainViewPresentor", ViewPresentor)

function DumplingFeastMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DumplingFeastMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastmainview.prefab"
	}
end

function DumplingFeastMainViewPresentor:buildViews()
	return {
		DumplingFeastMainView.New()
	}
end

return DumplingFeastMainViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastFeedViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastFeedViewPresentor", package.seeall)

local DumplingFeastFeedViewPresentor = class("DumplingFeastFeedViewPresentor", ViewPresentor)

function DumplingFeastFeedViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DumplingFeastFeedViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastfeedview.prefab"
	}
end

function DumplingFeastFeedViewPresentor:buildViews()
	return {
		DumplingFeastFeedView.New()
	}
end

return DumplingFeastFeedViewPresentor

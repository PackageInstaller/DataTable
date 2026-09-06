-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastRankViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastRankViewPresentor", package.seeall)

local DumplingFeastRankViewPresentor = class("DumplingFeastRankViewPresentor", ViewPresentor)

function DumplingFeastRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DumplingFeastRankViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastrankview.prefab"
	}
end

function DumplingFeastRankViewPresentor:buildViews()
	return {
		DumplingFeastRankView.New()
	}
end

return DumplingFeastRankViewPresentor

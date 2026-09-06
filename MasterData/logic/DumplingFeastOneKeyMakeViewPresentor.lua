-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastOneKeyMakeViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastOneKeyMakeViewPresentor", package.seeall)

local DumplingFeastOneKeyMakeViewPresentor = class("DumplingFeastOneKeyMakeViewPresentor", ViewPresentor)

function DumplingFeastOneKeyMakeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DumplingFeastOneKeyMakeViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastonekeymakeview.prefab"
	}
end

function DumplingFeastOneKeyMakeViewPresentor:buildViews()
	return {
		DumplingFeastOneKeyMakeView.New()
	}
end

return DumplingFeastOneKeyMakeViewPresentor

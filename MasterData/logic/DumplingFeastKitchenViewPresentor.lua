-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastKitchenViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastKitchenViewPresentor", package.seeall)

local DumplingFeastKitchenViewPresentor = class("DumplingFeastKitchenViewPresentor", ViewPresentor)

function DumplingFeastKitchenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DumplingFeastKitchenViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastkitchenview.prefab"
	}
end

function DumplingFeastKitchenViewPresentor:buildViews()
	return {
		DumplingFeastKitchenView.New()
	}
end

return DumplingFeastKitchenViewPresentor

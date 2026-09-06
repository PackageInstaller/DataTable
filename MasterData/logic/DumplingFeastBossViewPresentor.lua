-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastBossViewPresentor.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastBossViewPresentor", package.seeall)

local DumplingFeastBossViewPresentor = class("DumplingFeastBossViewPresentor", ViewPresentor)

function DumplingFeastBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DumplingFeastBossViewPresentor:dependWhatResources()
	return {
		"ui/views/dumplingfeast/dumplingfeastbossview.prefab"
	}
end

function DumplingFeastBossViewPresentor:buildViews()
	return {
		DumplingFeastBossView.New()
	}
end

return DumplingFeastBossViewPresentor

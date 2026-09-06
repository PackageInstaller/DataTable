-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleBossResultViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleBossResultViewPresentor", package.seeall)

local StarBattleBossResultViewPresentor = class("StarBattleBossResultViewPresentor", ViewPresentor)

function StarBattleBossResultViewPresentor:ctor()
	StarBattleBossResultViewPresentor.super.ctor(self)
end

function StarBattleBossResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleBossResultViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlebossresultview.prefab"
	}
end

function StarBattleBossResultViewPresentor:buildViews()
	return {
		StarBattleBossResultView.New()
	}
end

return StarBattleBossResultViewPresentor

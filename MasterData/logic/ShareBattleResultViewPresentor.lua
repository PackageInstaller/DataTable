-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/ShareBattleResultViewPresentor.lua

module("logic.extensions.sharetask.view.ShareBattleResultViewPresentor", package.seeall)

local ShareBattleResultViewPresentor = class("ShareBattleResultViewPresentor", ViewPresentor)

function ShareBattleResultViewPresentor:ctor()
	ShareBattleResultViewPresentor.super.ctor(self)
end

function ShareBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShareBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/sharetask/sharebattleresultview.prefab"
	}
end

function ShareBattleResultViewPresentor:buildViews()
	return {
		ShareBattleResultView.New()
	}
end

return ShareBattleResultViewPresentor

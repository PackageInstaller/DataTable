-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/view/KingIsaacClgMainViewPresentor.lua

module("logic.extensions.kingisaacclg.view.KingIsaacClgMainViewPresentor", package.seeall)

local KingIsaacClgMainViewPresentor = class("KingIsaacClgMainViewPresentor", ViewPresentor)

function KingIsaacClgMainViewPresentor:ctor()
	KingIsaacClgMainViewPresentor.super.ctor(self)
end

function KingIsaacClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingIsaacClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingisaacclg/kingisaacclgmainview.prefab"
	}
end

function KingIsaacClgMainViewPresentor:buildViews()
	return {
		KingIsaacClgMainView.New()
	}
end

return KingIsaacClgMainViewPresentor

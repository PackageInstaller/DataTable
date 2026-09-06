-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaPrizeTabViewPresentor.lua

module("logic.extensions.kingarena.view.prize.KingArenaPrizeTabViewPresentor", package.seeall)

local KingArenaPrizeTabViewPresentor = class("KingArenaPrizeTabViewPresentor", ViewPresentor)

function KingArenaPrizeTabViewPresentor:ctor()
	KingArenaPrizeTabViewPresentor.super.ctor(self)
end

function KingArenaPrizeTabViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingArenaPrizeTabViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/prize/kingarenaprizetabview.prefab"
	}
end

function KingArenaPrizeTabViewPresentor:buildViews()
	return {
		KingArenaPrizeTabView.New()
	}
end

return KingArenaPrizeTabViewPresentor

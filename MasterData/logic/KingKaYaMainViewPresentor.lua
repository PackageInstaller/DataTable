-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaMainViewPresentor.lua

module("logic.extensions.kingkaya.view.KingKaYaMainViewPresentor", package.seeall)

local KingKaYaMainViewPresentor = class("KingKaYaMainViewPresentor", ViewPresentor)

function KingKaYaMainViewPresentor:ctor()
	KingKaYaMainViewPresentor.super.ctor(self)
end

function KingKaYaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingKaYaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingkaya/kingkayamainview.prefab"
	}
end

function KingKaYaMainViewPresentor:buildViews()
	return {
		KingKaYaMainView.New()
	}
end

return KingKaYaMainViewPresentor

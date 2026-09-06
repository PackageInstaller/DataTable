-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaExtViewPresentor.lua

module("logic.extensions.kingkaya.view.KingKaYaExtViewPresentor", package.seeall)

local KingKaYaExtViewPresentor = class("KingKaYaExtViewPresentor", ViewPresentor)

function KingKaYaExtViewPresentor:ctor()
	KingKaYaExtViewPresentor.super.ctor(self)
end

function KingKaYaExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingKaYaExtViewPresentor:dependWhatResources()
	return {
		"ui/views/kingkaya/kingkayaextview.prefab"
	}
end

function KingKaYaExtViewPresentor:buildViews()
	return {
		KingKaYaExtView.New()
	}
end

return KingKaYaExtViewPresentor

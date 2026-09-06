-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaExtClgResultViewPresentor.lua

module("logic.extensions.kingkaya.view.KingKaYaExtClgResultViewPresentor", package.seeall)

local KingKaYaExtClgResultViewPresentor = class("KingKaYaExtClgResultViewPresentor", ViewPresentor)

function KingKaYaExtClgResultViewPresentor:ctor()
	KingKaYaExtClgResultViewPresentor.super.ctor(self)
end

function KingKaYaExtClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingKaYaExtClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/kingkaya/kingkayaextclgresultview.prefab"
	}
end

function KingKaYaExtClgResultViewPresentor:buildViews()
	return {
		KingKaYaExtClgResultView.New()
	}
end

return KingKaYaExtClgResultViewPresentor

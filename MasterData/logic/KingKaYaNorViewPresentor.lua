-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaNorViewPresentor.lua

module("logic.extensions.kingkaya.view.KingKaYaNorViewPresentor", package.seeall)

local KingKaYaNorViewPresentor = class("KingKaYaNorViewPresentor", ViewPresentor)

function KingKaYaNorViewPresentor:ctor()
	KingKaYaNorViewPresentor.super.ctor(self)
end

function KingKaYaNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingKaYaNorViewPresentor:dependWhatResources()
	return {
		"ui/views/kingkaya/kingkayanorview.prefab"
	}
end

function KingKaYaNorViewPresentor:buildViews()
	return {
		KingKaYaNorView.New()
	}
end

return KingKaYaNorViewPresentor

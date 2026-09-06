-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaFmtExtisonViewPresentor.lua

module("logic.extensions.kingisaacclg.view.KingKaYaFmtExtisonViewPresentor", package.seeall)

local KingKaYaFmtExtisonViewPresentor = class("KingKaYaFmtExtisonViewPresentor", ViewPresentor)

function KingKaYaFmtExtisonViewPresentor:ctor()
	KingKaYaFmtExtisonViewPresentor.super.ctor(self)
end

function KingKaYaFmtExtisonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingKaYaFmtExtisonViewPresentor:dependWhatResources()
	return {
		"ui/views/kingkaya/kingkayafmtextisonview.prefab"
	}
end

function KingKaYaFmtExtisonViewPresentor:buildViews()
	return {
		KingKaYaFmtExtisonView.New()
	}
end

function KingKaYaFmtExtisonViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingKaYaFmtExtisonViewPresentor

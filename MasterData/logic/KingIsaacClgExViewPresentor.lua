-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/view/KingIsaacClgExViewPresentor.lua

module("logic.extensions.kingisaacclg.view.KingIsaacClgExViewPresentor", package.seeall)

local KingIsaacClgExViewPresentor = class("KingIsaacClgExViewPresentor", ViewPresentor)

function KingIsaacClgExViewPresentor:ctor()
	KingIsaacClgExViewPresentor.super.ctor(self)
end

function KingIsaacClgExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingIsaacClgExViewPresentor:dependWhatResources()
	return {
		"ui/views/kingisaacclg/kingisaacclgexview.prefab"
	}
end

function KingIsaacClgExViewPresentor:buildViews()
	return {
		KingIsaacClgExView.New()
	}
end

function KingIsaacClgExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingIsaacClgExViewPresentor

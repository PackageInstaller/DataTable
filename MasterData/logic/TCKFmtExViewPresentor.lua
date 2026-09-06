-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFmtExViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKFmtExViewPresentor", package.seeall)

local TCKFmtExViewPresentor = class("TCKFmtExViewPresentor", ViewPresentor)

function TCKFmtExViewPresentor:ctor()
	TCKFmtExViewPresentor.super.ctor(self)
end

function TCKFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckfmtexview.prefab"
	}
end

function TCKFmtExViewPresentor:buildViews()
	return {
		TCKFmtExView.New()
	}
end

function TCKFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKFmtExViewPresentor

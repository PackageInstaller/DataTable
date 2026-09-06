-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestDeFmtExViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialContestDeFmtExViewPresentor", package.seeall)

local MartialContestDeFmtExViewPresentor = class("MartialContestDeFmtExViewPresentor", ViewPresentor)

function MartialContestDeFmtExViewPresentor:ctor()
	MartialContestDeFmtExViewPresentor.super.ctor(self)
end

function MartialContestDeFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialContestDeFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestdefmtexview.prefab"
	}
end

function MartialContestDeFmtExViewPresentor:buildViews()
	return {
		MartialContestDeFmtExView.New()
	}
end

function MartialContestDeFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MartialContestDeFmtExViewPresentor

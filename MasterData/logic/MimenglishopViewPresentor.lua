-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglishopViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglishopViewPresentor", package.seeall)

local MimenglishopViewPresentor = class("MimenglishopViewPresentor", ViewPresentor)

function MimenglishopViewPresentor:ctor()
	MimenglishopViewPresentor.super.ctor(self)
end

function MimenglishopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglishopViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglishopview.prefab"
	}
end

function MimenglishopViewPresentor:buildViews()
	return {
		MimenglishopView.New()
	}
end

function MimenglishopViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MimenglishopViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/view/OriginAsheClgFmtViewPresentor.lua

module("logic.extensions.originasheclg.view.OriginAsheClgFmtViewPresentor", package.seeall)

local OriginAsheClgFmtViewPresentor = class("OriginAsheClgFmtViewPresentor", ViewPresentor)

function OriginAsheClgFmtViewPresentor:ctor()
	OriginAsheClgFmtViewPresentor.super.ctor(self)
end

function OriginAsheClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAsheClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originasheclg/originasheclgfmtview.prefab"
	}
end

function OriginAsheClgFmtViewPresentor:buildViews()
	return {
		OriginAsheClgFmtView.New()
	}
end

function OriginAsheClgFmtViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return OriginAsheClgFmtViewPresentor

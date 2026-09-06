-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiaresultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.CynthiaresultViewPresentor", package.seeall)

local CynthiaresultViewPresentor = class("CynthiaresultViewPresentor", ViewPresentor)

function CynthiaresultViewPresentor:ctor()
	CynthiaresultViewPresentor.super.ctor(self)
end

function CynthiaresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CynthiaresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/xinxiya/xxyresultview.prefab"
	}
end

function CynthiaresultViewPresentor:buildViews()
	return {
		CynthiaresultView.New()
	}
end

return CynthiaresultViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazypartnerresultViewPresentor.lua

module("logic.extensions.crazypartner.view.CrazypartnerresultViewPresentor", package.seeall)

local CrazypartnerresultViewPresentor = class("CrazypartnerresultViewPresentor", ViewPresentor)

function CrazypartnerresultViewPresentor:ctor()
	CrazypartnerresultViewPresentor.super.ctor(self)
end

function CrazypartnerresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CrazypartnerresultViewPresentor:dependWhatResources()
	return {
		"ui/views/crazypartner/crazypartnerresultview.prefab"
	}
end

function CrazypartnerresultViewPresentor:buildViews()
	return {
		CrazyPartnerResultView.New()
	}
end

return CrazypartnerresultViewPresentor

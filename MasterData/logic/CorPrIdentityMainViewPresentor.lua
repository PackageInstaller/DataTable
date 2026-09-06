-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrIdentityMainViewPresentor.lua

module("logic.extensions.corpr.view.CorPrIdentityMainViewPresentor", package.seeall)

local CorPrIdentityMainViewPresentor = class("CorPrIdentityMainViewPresentor", ViewPresentor)

function CorPrIdentityMainViewPresentor:ctor()
	CorPrIdentityMainViewPresentor.super.ctor(self)
end

function CorPrIdentityMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CorPrIdentityMainViewPresentor:dependWhatResources()
	return {
		"ui/views/corpr/corpridentitymainview.prefab"
	}
end

function CorPrIdentityMainViewPresentor:buildViews()
	return {
		CorPrIdentityMainView.New()
	}
end

return CorPrIdentityMainViewPresentor

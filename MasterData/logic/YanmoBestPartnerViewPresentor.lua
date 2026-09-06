-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yanmobestpartner/view/YanmoBestPartnerViewPresentor.lua

module("logic.extensions.yanmobestpartner.view.YanmoBestPartnerViewPresentor", package.seeall)

local YanmoBestPartnerViewPresentor = class("YanmoBestPartnerViewPresentor", ViewPresentor)

function YanmoBestPartnerViewPresentor:ctor()
	YanmoBestPartnerViewPresentor.super.ctor(self)
end

function YanmoBestPartnerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YanmoBestPartnerViewPresentor:dependWhatResources()
	return {
		"ui/views/yanmobestpartner/yanmobestpartnerview.prefab"
	}
end

function YanmoBestPartnerViewPresentor:buildViews()
	return {
		YanmoBestPartnerView.New()
	}
end

return YanmoBestPartnerViewPresentor

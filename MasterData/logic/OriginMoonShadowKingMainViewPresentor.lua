-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingMainViewPresentor.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingMainViewPresentor", package.seeall)

local OriginMoonShadowKingMainViewPresentor = class("OriginMoonShadowKingMainViewPresentor", ViewPresentor)

function OriginMoonShadowKingMainViewPresentor:ctor()
	OriginMoonShadowKingMainViewPresentor.super.ctor(self)
end

function OriginMoonShadowKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginMoonShadowKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originmoonshadowking/originmoonshadowkingmainview.prefab"
	}
end

function OriginMoonShadowKingMainViewPresentor:buildViews()
	return {
		OriginMoonShadowKingMainView.New()
	}
end

return OriginMoonShadowKingMainViewPresentor

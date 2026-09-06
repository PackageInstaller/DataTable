-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingSelectViewPresentor.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingSelectViewPresentor", package.seeall)

local OriginMoonShadowKingSelectViewPresentor = class("OriginMoonShadowKingSelectViewPresentor", ViewPresentor)

function OriginMoonShadowKingSelectViewPresentor:ctor()
	OriginMoonShadowKingSelectViewPresentor.super.ctor(self)
end

function OriginMoonShadowKingSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginMoonShadowKingSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/originmoonshadowking/originmoonshadowkingselectview.prefab"
	}
end

function OriginMoonShadowKingSelectViewPresentor:buildViews()
	return {
		OriginMoonShadowKingSelectView.New()
	}
end

return OriginMoonShadowKingSelectViewPresentor

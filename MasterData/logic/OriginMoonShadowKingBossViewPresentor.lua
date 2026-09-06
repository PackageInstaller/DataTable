-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingBossViewPresentor.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingBossViewPresentor", package.seeall)

local OriginMoonShadowKingBossViewPresentor = class("OriginMoonShadowKingBossViewPresentor", ViewPresentor)

function OriginMoonShadowKingBossViewPresentor:ctor()
	OriginMoonShadowKingBossViewPresentor.super.ctor(self)
end

function OriginMoonShadowKingBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginMoonShadowKingBossViewPresentor:dependWhatResources()
	return {
		"ui/views/originmoonshadowking/originmoonshadowkingbossview.prefab"
	}
end

function OriginMoonShadowKingBossViewPresentor:buildViews()
	return {
		OriginMoonShadowKingBossView.New()
	}
end

return OriginMoonShadowKingBossViewPresentor

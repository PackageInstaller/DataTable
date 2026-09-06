-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingBossPassViewPresentor.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingBossPassViewPresentor", package.seeall)

local OriginMoonShadowKingBossPassViewPresentor = class("OriginMoonShadowKingBossPassViewPresentor", ViewPresentor)

function OriginMoonShadowKingBossPassViewPresentor:ctor()
	OriginMoonShadowKingBossPassViewPresentor.super.ctor(self)
end

function OriginMoonShadowKingBossPassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginMoonShadowKingBossPassViewPresentor:dependWhatResources()
	return {
		"ui/views/originmoonshadowking/originmoonshadowkingbosspassview.prefab"
	}
end

function OriginMoonShadowKingBossPassViewPresentor:buildViews()
	return {
		OriginMoonShadowKingBossPassView.New()
	}
end

return OriginMoonShadowKingBossPassViewPresentor

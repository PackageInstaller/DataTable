-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgLevelViewPresentor.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgLevelViewPresentor", package.seeall)

local OriginKingMoYanClgLevelViewPresentor = class("OriginKingMoYanClgLevelViewPresentor", ViewPresentor)

function OriginKingMoYanClgLevelViewPresentor:ctor()
	OriginKingMoYanClgLevelViewPresentor.super.ctor(self)
end

function OriginKingMoYanClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMoYanClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmoyanclg/originkingmoyanclglevelview.prefab"
	}
end

function OriginKingMoYanClgLevelViewPresentor:buildViews()
	return {
		OriginKingMoYanClgLevelView.New()
	}
end

return OriginKingMoYanClgLevelViewPresentor

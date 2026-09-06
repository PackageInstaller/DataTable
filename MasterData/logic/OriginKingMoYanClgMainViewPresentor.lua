-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgMainViewPresentor.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgMainViewPresentor", package.seeall)

local OriginKingMoYanClgMainViewPresentor = class("OriginKingMoYanClgMainViewPresentor", ViewPresentor)

function OriginKingMoYanClgMainViewPresentor:ctor()
	OriginKingMoYanClgMainViewPresentor.super.ctor(self)
end

function OriginKingMoYanClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMoYanClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmoyanclg/originkingmoyanclgmainview.prefab"
	}
end

function OriginKingMoYanClgMainViewPresentor:buildViews()
	return {
		OriginKingMoYanClgMainView.New()
	}
end

return OriginKingMoYanClgMainViewPresentor

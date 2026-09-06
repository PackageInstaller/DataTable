-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgFmtViewPresentor.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgFmtViewPresentor", package.seeall)

local OriginKingMoYanClgFmtViewPresentor = class("OriginKingMoYanClgFmtViewPresentor", ViewPresentor)

function OriginKingMoYanClgFmtViewPresentor:ctor()
	OriginKingMoYanClgFmtViewPresentor.super.ctor(self)
end

function OriginKingMoYanClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMoYanClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmoyanclg/originkingmoyanclgfmtview.prefab"
	}
end

function OriginKingMoYanClgFmtViewPresentor:buildViews()
	return {
		OriginKingMoYanClgFmtView.New()
	}
end

return OriginKingMoYanClgFmtViewPresentor

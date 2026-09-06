-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/view/OriginMiMengLiStageViewPresentor.lua

module("logic.extensions.originmimengli.view.OriginMiMengLiStageViewPresentor", package.seeall)

local OriginMiMengLiStageViewPresentor = class("OriginMiMengLiStageViewPresentor", ViewPresentor)

function OriginMiMengLiStageViewPresentor:ctor()
	OriginMiMengLiStageViewPresentor.super.ctor(self)
end

function OriginMiMengLiStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginMiMengLiStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originmimengli/originmimenglistageview.prefab"
	}
end

function OriginMiMengLiStageViewPresentor:buildViews()
	return {
		OriginMiMengLiStageView.New()
	}
end

return OriginMiMengLiStageViewPresentor

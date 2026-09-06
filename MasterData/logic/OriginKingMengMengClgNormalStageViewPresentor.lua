-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgNormalStageViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgNormalStageViewPresentor", package.seeall)

local OriginKingMengMengClgNormalStageViewPresentor = class("OriginKingMengMengClgNormalStageViewPresentor", ViewPresentor)

function OriginKingMengMengClgNormalStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMengMengClgNormalStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgnormalstageview.prefab"
	}
end

function OriginKingMengMengClgNormalStageViewPresentor:buildViews()
	return {
		OriginKingMengMengClgNormalStageView.New()
	}
end

return OriginKingMengMengClgNormalStageViewPresentor

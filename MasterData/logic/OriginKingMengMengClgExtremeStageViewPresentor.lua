-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeStageViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeStageViewPresentor", package.seeall)

local OriginKingMengMengClgExtremeStageViewPresentor = class("OriginKingMengMengClgExtremeStageViewPresentor", ViewPresentor)

function OriginKingMengMengClgExtremeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMengMengClgExtremeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgextremestageview.prefab"
	}
end

function OriginKingMengMengClgExtremeStageViewPresentor:buildViews()
	return {
		OriginKingMengMengClgExtremeStageView.New()
	}
end

return OriginKingMengMengClgExtremeStageViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeStageInfoPopViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeStageInfoPopViewPresentor", package.seeall)

local OriginKingMengMengClgExtremeStageInfoPopViewPresentor = class("OriginKingMengMengClgExtremeStageInfoPopViewPresentor", ViewPresentor)

function OriginKingMengMengClgExtremeStageInfoPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingMengMengClgExtremeStageInfoPopViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgextremestageinfopopview.prefab"
	}
end

function OriginKingMengMengClgExtremeStageInfoPopViewPresentor:buildViews()
	return {
		OriginKingMengMengClgExtremeStageInfoPopView.New()
	}
end

return OriginKingMengMengClgExtremeStageInfoPopViewPresentor

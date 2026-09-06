-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeResultViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeResultViewPresentor", package.seeall)

local OriginKingMengMengClgExtremeResultViewPresentor = class("OriginKingMengMengClgExtremeResultViewPresentor", ViewPresentor)

function OriginKingMengMengClgExtremeResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingMengMengClgExtremeResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgextremesresultview.prefab"
	}
end

function OriginKingMengMengClgExtremeResultViewPresentor:buildViews()
	return {
		OriginKingMengMengClgExtremeResultView.New()
	}
end

return OriginKingMengMengClgExtremeResultViewPresentor

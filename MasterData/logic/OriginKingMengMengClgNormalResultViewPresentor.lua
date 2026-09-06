-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgNormalResultViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgNormalResultViewPresentor", package.seeall)

local OriginKingMengMengClgNormalResultViewPresentor = class("OriginKingMengMengClgNormalResultViewPresentor", ViewPresentor)

function OriginKingMengMengClgNormalResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingMengMengClgNormalResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgnormalresultview.prefab"
	}
end

function OriginKingMengMengClgNormalResultViewPresentor:buildViews()
	return {
		OriginKingMengMengClgNormalResultView.New()
	}
end

return OriginKingMengMengClgNormalResultViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeEnterPopViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeEnterPopViewPresentor", package.seeall)

local OriginKingMengMengClgExtremeEnterPopViewPresentor = class("OriginKingMengMengClgExtremeEnterPopViewPresentor", ViewPresentor)

function OriginKingMengMengClgExtremeEnterPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginKingMengMengClgExtremeEnterPopViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgextremeenterpopview.prefab"
	}
end

function OriginKingMengMengClgExtremeEnterPopViewPresentor:buildViews()
	return {
		OriginKingMengMengClgExtremeEnterPopView.New()
	}
end

return OriginKingMengMengClgExtremeEnterPopViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgMainViewPresentor.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgMainViewPresentor", package.seeall)

local OriginKingMengMengClgMainViewPresentor = class("OriginKingMengMengClgMainViewPresentor", ViewPresentor)

function OriginKingMengMengClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginKingMengMengClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originkingmengmengclg/originkingmengmengclgmainview.prefab"
	}
end

function OriginKingMengMengClgMainViewPresentor:buildViews()
	return {
		OriginKingMengMengClgMainView.New()
	}
end

return OriginKingMengMengClgMainViewPresentor

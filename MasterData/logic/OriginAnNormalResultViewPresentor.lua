-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnNormalResultViewPresentor.lua

module("logic.extensions.originan.view.OriginAnNormalResultViewPresentor", package.seeall)

local OriginAnNormalResultViewPresentor = class("OriginAnNormalResultViewPresentor", ViewPresentor)

function OriginAnNormalResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAnNormalResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originannormalresultview.prefab"
	}
end

function OriginAnNormalResultViewPresentor:buildViews()
	return {
		OriginAnNormalResultView.New()
	}
end

return OriginAnNormalResultViewPresentor

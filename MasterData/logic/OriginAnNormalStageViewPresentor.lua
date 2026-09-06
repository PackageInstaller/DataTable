-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnNormalStageViewPresentor.lua

module("logic.extensions.originan.view.OriginAnNormalStageViewPresentor", package.seeall)

local OriginAnNormalStageViewPresentor = class("OriginAnNormalStageViewPresentor", ViewPresentor)

function OriginAnNormalStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnNormalStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originannormalstageview.prefab"
	}
end

function OriginAnNormalStageViewPresentor:buildViews()
	return {
		OriginAnNormalStageView.New()
	}
end

return OriginAnNormalStageViewPresentor

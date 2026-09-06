-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeStageViewPresentor.lua

module("logic.extensions.originan.view.OriginAnExtremeStageViewPresentor", package.seeall)

local OriginAnExtremeStageViewPresentor = class("OriginAnExtremeStageViewPresentor", ViewPresentor)

function OriginAnExtremeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnExtremeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originanextremestageview.prefab"
	}
end

function OriginAnExtremeStageViewPresentor:buildViews()
	return {
		OriginAnExtremeStageView.New()
	}
end

return OriginAnExtremeStageViewPresentor

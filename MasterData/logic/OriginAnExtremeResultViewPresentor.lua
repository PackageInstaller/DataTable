-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeResultViewPresentor.lua

module("logic.extensions.originan.view.OriginAnExtremeResultViewPresentor", package.seeall)

local OriginAnExtremeResultViewPresentor = class("OriginAnExtremeResultViewPresentor", ViewPresentor)

function OriginAnExtremeResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAnExtremeResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originanextremeresultview.prefab"
	}
end

function OriginAnExtremeResultViewPresentor:buildViews()
	return {
		OriginAnExtremeResultView.New()
	}
end

return OriginAnExtremeResultViewPresentor

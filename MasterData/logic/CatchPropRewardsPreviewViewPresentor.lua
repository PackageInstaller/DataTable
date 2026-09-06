-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropRewardsPreviewViewPresentor.lua

module("logic.extensions.catchprops.view.CatchPropRewardsPreviewViewPresentor", package.seeall)

local CatchPropRewardsPreviewViewPresentor = class("CatchPropRewardsPreviewViewPresentor", ViewPresentor)

function CatchPropRewardsPreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CatchPropRewardsPreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/catchprops/catchpropsrewardpreviewview.prefab"
	}
end

function CatchPropRewardsPreviewViewPresentor:buildViews()
	return {
		CatchPropRewardsPreviewView.New()
	}
end

return CatchPropRewardsPreviewViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotCopyViewPresentor.lua

module("logic.extensions.plotcopy.view.PlotCopyViewPresentor", package.seeall)

local PlotCopyViewPresentor = class("PlotCopyViewPresentor", ViewWithGuidePresentor)

function PlotCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlotCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/plotcopy/plotcopyview.prefab"
	}
end

function PlotCopyViewPresentor:buildViews()
	return {
		PlotCopyMapView.New(),
		PlotCopyView.New()
	}
end

function PlotCopyViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_suoding/fx_ui_suoding_smoke01.prefab"),
		UIEffectManager.instance:getEffectPath("fx_scene_dachangjing/fx_scene_dachangjing.prefab")
	}
end

function PlotCopyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PlotCopyViewPresentor

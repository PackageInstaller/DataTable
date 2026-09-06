-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/view/DivineGasiriStageViewPresentor.lua

module("logic.extensions.divinegasiri.view.DivineGasiriStageViewPresentor", package.seeall)

local DivineGasiriStageViewPresentor = class("DivineGasiriStageViewPresentor", ViewPresentor)

function DivineGasiriStageViewPresentor:ctor()
	DivineGasiriStageViewPresentor.super.ctor(self)
end

function DivineGasiriStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineGasiriStageViewPresentor:dependWhatResources()
	return {
		"ui/views/divinegasiri/divinegasiristageview.prefab"
	}
end

function DivineGasiriStageViewPresentor:buildViews()
	return {
		DivineGasiriStageView.New()
	}
end

return DivineGasiriStageViewPresentor

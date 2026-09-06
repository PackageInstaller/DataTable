-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/view/DivineGasiriRewardViewPresentor.lua

module("logic.extensions.divinegasiri.view.DivineGasiriRewardViewPresentor", package.seeall)

local DivineGasiriRewardViewPresentor = class("DivineGasiriRewardViewPresentor", ViewPresentor)

function DivineGasiriRewardViewPresentor:ctor()
	DivineGasiriRewardViewPresentor.super.ctor(self)
end

function DivineGasiriRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineGasiriRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/divinegasiri/divinegasirirewardview.prefab"
	}
end

function DivineGasiriRewardViewPresentor:buildViews()
	return {
		DivineGasiriRewardView.New()
	}
end

return DivineGasiriRewardViewPresentor

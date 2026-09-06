-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettimemachine/view/PettimemachinepopViewPresentor.lua

module("logic.extensions.pettimemachine.view.PettimemachinepopViewPresentor", package.seeall)

local PettimemachinepopViewPresentor = class("PettimemachinepopViewPresentor", ViewPresentor)

function PettimemachinepopViewPresentor:ctor()
	PettimemachinepopViewPresentor.super.ctor(self)
end

function PettimemachinepopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PettimemachinepopViewPresentor:dependWhatResources()
	return {
		"ui/views/pettimemachine/pettimemachinepopview.prefab"
	}
end

function PettimemachinepopViewPresentor:buildViews()
	return {
		PettimemachinepopView.New()
	}
end

return PettimemachinepopViewPresentor

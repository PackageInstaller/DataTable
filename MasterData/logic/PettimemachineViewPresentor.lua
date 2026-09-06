-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettimemachine/view/PettimemachineViewPresentor.lua

module("logic.extensions.pettimemachine.view.PettimemachineViewPresentor", package.seeall)

local PettimemachineViewPresentor = class("PettimemachineViewPresentor", ViewPresentor)

function PettimemachineViewPresentor:ctor()
	PettimemachineViewPresentor.super.ctor(self)
end

function PettimemachineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PettimemachineViewPresentor:dependWhatResources()
	return {
		"ui/views/pettimemachine/pettimemachineview.prefab"
	}
end

function PettimemachineViewPresentor:buildViews()
	return {
		PettimemachineView.New()
	}
end

return PettimemachineViewPresentor

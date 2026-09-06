-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettimemachine/view/PettiselectViewPresentor.lua

module("logic.extensions.pettimemachine.view.PettiselectViewPresentor", package.seeall)

local PettiselectViewPresentor = class("PettiselectViewPresentor", ViewPresentor)

function PettiselectViewPresentor:ctor()
	PettiselectViewPresentor.super.ctor(self)
end

function PettiselectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PettiselectViewPresentor:dependWhatResources()
	return {
		"ui/views/pettimemachine/pettiselectview.prefab"
	}
end

function PettiselectViewPresentor:buildViews()
	return {
		PettiselectView.New()
	}
end

return PettiselectViewPresentor

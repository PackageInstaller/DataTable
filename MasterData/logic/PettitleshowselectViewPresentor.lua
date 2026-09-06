-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettitle/view/PettitleshowselectViewPresentor.lua

module("logic.extensions.pettitle.view.PettitleshowselectViewPresentor", package.seeall)

local PettitleshowselectViewPresentor = class("PettitleshowselectViewPresentor", ViewPresentor)

function PettitleshowselectViewPresentor:ctor()
	PettitleshowselectViewPresentor.super.ctor(self)
end

function PettitleshowselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PettitleshowselectViewPresentor:dependWhatResources()
	return {
		"ui/views/pettitle/pettitleshowselectview.prefab"
	}
end

function PettitleshowselectViewPresentor:buildViews()
	return {
		PetTitleShowSelectView.New()
	}
end

return PettitleshowselectViewPresentor

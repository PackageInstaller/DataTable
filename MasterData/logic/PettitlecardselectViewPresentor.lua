-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/PettitlecardselectViewPresentor.lua

module("logic.extensions.roleinfo.view.PettitlecardselectViewPresentor", package.seeall)

local PettitlecardselectViewPresentor = class("PettitlecardselectViewPresentor", ViewPresentor)

function PettitlecardselectViewPresentor:ctor()
	PettitlecardselectViewPresentor.super.ctor(self)
end

function PettitlecardselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PettitlecardselectViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/pettitlecardselectview.prefab"
	}
end

function PettitlecardselectViewPresentor:buildViews()
	return {
		PetTitleCardSelectView.New()
	}
end

return PettitlecardselectViewPresentor

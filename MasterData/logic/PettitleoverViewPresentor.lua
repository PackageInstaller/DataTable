-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/PettitleoverViewPresentor.lua

module("logic.extensions.roleinfo.view.PettitleoverViewPresentor", package.seeall)

local PettitleoverViewPresentor = class("PettitleoverViewPresentor", ViewPresentor)

function PettitleoverViewPresentor:ctor()
	PettitleoverViewPresentor.super.ctor(self)
end

function PettitleoverViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PettitleoverViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/pettitleoverview.prefab"
	}
end

function PettitleoverViewPresentor:buildViews()
	return {
		PetTitleOverView.New()
	}
end

return PettitleoverViewPresentor

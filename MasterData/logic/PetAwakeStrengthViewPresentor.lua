-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetAwakeStrengthViewPresentor.lua

module("logic.extensions.bag.view.PetAwakeStrengthViewPresentor", package.seeall)

local PetAwakeStrengthViewPresentor = class("PetAwakeStrengthViewPresentor", ViewPresentor)

function PetAwakeStrengthViewPresentor:ctor()
	PetAwakeStrengthViewPresentor.super.ctor(self)
end

function PetAwakeStrengthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetAwakeStrengthViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petbookstrengthview.prefab"
	}
end

function PetAwakeStrengthViewPresentor:buildViews()
	return {
		PetAwakeStrengthView.New()
	}
end

return PetAwakeStrengthViewPresentor

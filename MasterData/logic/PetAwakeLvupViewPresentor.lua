-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeLvupViewPresentor.lua

module("logic.extensions.bag.view.stack.PetAwakeLvupViewPresentor", package.seeall)

local PetAwakeLvupViewPresentor = class("PetAwakeLvupViewPresentor", ViewPresentor)

function PetAwakeLvupViewPresentor:ctor()
	PetAwakeLvupViewPresentor.super.ctor(self)
end

function PetAwakeLvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetAwakeLvupViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petawakelvupview.prefab"
	}
end

function PetAwakeLvupViewPresentor:buildViews()
	return {
		PetAwakeLvupView.New()
	}
end

return PetAwakeLvupViewPresentor

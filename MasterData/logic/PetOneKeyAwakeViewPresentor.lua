-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetOneKeyAwakeViewPresentor.lua

module("logic.extensions.bag.view.stack.PetOneKeyAwakeViewPresentor", package.seeall)

local PetOneKeyAwakeViewPresentor = class("PetOneKeyAwakeViewPresentor", ViewPresentor)

function PetOneKeyAwakeViewPresentor:ctor()
	PetOneKeyAwakeViewPresentor.super.ctor(self)
end

function PetOneKeyAwakeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetOneKeyAwakeViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petonekeyawakeview.prefab"
	}
end

function PetOneKeyAwakeViewPresentor:buildViews()
	return {
		PetOneKeyAwakeView.New()
	}
end

return PetOneKeyAwakeViewPresentor

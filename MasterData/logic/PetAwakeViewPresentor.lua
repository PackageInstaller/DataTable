-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeViewPresentor.lua

module("logic.extensions.bag.view.stack.PetAwakeViewPresentor", package.seeall)

local PetAwakeViewPresentor = class("PetAwakeViewPresentor", ViewWithGuidePresentor)

function PetAwakeViewPresentor:ctor()
	PetAwakeViewPresentor.super.ctor(self)
end

function PetAwakeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetAwakeViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petawakeview_new.prefab",
		ItemPet.ResPath
	}
end

function PetAwakeViewPresentor:buildViews()
	return {
		PetAwakeView.New()
	}
end

return PetAwakeViewPresentor

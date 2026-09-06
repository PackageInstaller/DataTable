-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeSelectViewPresentor.lua

module("logic.extensions.bag.view.stack.PetAwakeSelectViewPresentor", package.seeall)

local PetAwakeSelectViewPresentor = class("PetAwakeSelectViewPresentor", ViewPresentor)

function PetAwakeSelectViewPresentor:ctor()
	PetAwakeSelectViewPresentor.super.ctor(self)
end

function PetAwakeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetAwakeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petawakeselectview.prefab"
	}
end

function PetAwakeSelectViewPresentor:buildViews()
	return {
		PetAwakeSelectView.New()
	}
end

return PetAwakeSelectViewPresentor

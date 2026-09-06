-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/PetFilterViewPresentor.lua

module("logic.extensions.bag.panel.PetFilterViewPresentor", package.seeall)

local PetFilterViewPresentor = class("PetFilterViewPresentor", ViewPresentor)

function PetFilterViewPresentor:ctor()
	PetFilterViewPresentor.super.ctor(self)
end

function PetFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function PetFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/common/pet_filter.prefab"
	}
end

function PetFilterViewPresentor:buildViews()
	return {
		PetFilterView.New()
	}
end

return PetFilterViewPresentor

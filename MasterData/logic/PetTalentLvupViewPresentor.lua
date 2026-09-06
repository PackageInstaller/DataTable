-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetTalentLvupViewPresentor.lua

module("logic.extensions.bag.view.stack.PetTalentLvupViewPresentor", package.seeall)

local PetTalentLvupViewPresentor = class("PetTalentLvupViewPresentor", ViewPresentor)

function PetTalentLvupViewPresentor:ctor()
	PetTalentLvupViewPresentor.super.ctor(self)
end

function PetTalentLvupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetTalentLvupViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/pettalentlvupview.prefab"
	}
end

function PetTalentLvupViewPresentor:buildViews()
	return {
		PetTalentLvupView.New()
	}
end

return PetTalentLvupViewPresentor

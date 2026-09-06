-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyInstructionViewPresentor.lua

module("logic.extensions.newfamily.view.FamilyInstructionViewPresentor", package.seeall)

local FamilyInstructionViewPresentor = class("FamilyInstructionViewPresentor", ViewPresentor)

function FamilyInstructionViewPresentor:ctor()
	FamilyInstructionViewPresentor.super.ctor(self)
end

function FamilyInstructionViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function FamilyInstructionViewPresentor:dependWhatResources()
	return {
		"ui/views/newfamily/callorder/familyinstruction.prefab"
	}
end

function FamilyInstructionViewPresentor:buildViews()
	return {
		FamilyInstructionView.New()
	}
end

return FamilyInstructionViewPresentor

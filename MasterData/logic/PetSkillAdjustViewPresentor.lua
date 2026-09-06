-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetSkillAdjustViewPresentor.lua

module("logic.extensions.recommendfmt.view.PetSkillAdjustViewPresentor", package.seeall)

local PetSkillAdjustViewPresentor = class("PetSkillAdjustViewPresentor", ViewPresentor)

function PetSkillAdjustViewPresentor:ctor()
	PetSkillAdjustViewPresentor.super.ctor(self)
end

function PetSkillAdjustViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetSkillAdjustViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/petskilladjustview.prefab"
	}
end

function PetSkillAdjustViewPresentor:buildViews()
	return {
		PetSkillAdjustView.New()
	}
end

return PetSkillAdjustViewPresentor

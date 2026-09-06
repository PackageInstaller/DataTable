-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegetipViewInBattlePresentor.lua

module("logic.extensions.petcollege.view.PetcollegetipViewInBattlePresentor", package.seeall)

local PetcollegetipViewInBattlePresentor = class("PetcollegetipViewInBattlePresentor", ViewWithGuidePresentor)

function PetcollegetipViewInBattlePresentor:ctor()
	PetcollegetipViewInBattlePresentor.super.ctor(self)
end

function PetcollegetipViewInBattlePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetcollegetipViewInBattlePresentor:dependWhatResources()
	return {
		"ui/views/petcollege/petcollegetip.prefab"
	}
end

function PetcollegetipViewInBattlePresentor:buildViews()
	return {
		PetcollegetipInBattleView.New()
	}
end

return PetcollegetipViewInBattlePresentor

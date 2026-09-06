-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilybossbattlesuccessPresentor.lua

module("logic.extensions.family.view.FamilybossbattlesuccessPresentor", package.seeall)

local FamilybossbattlesuccessPresentor = class("FamilybossbattlesuccessPresentor", ViewPresentor)

function FamilybossbattlesuccessPresentor:ctor()
	FamilybossbattlesuccessPresentor.super.ctor(self)
end

function FamilybossbattlesuccessPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FamilybossbattlesuccessPresentor:dependWhatResources()
	return {
		"ui/views/family/familybossbattlesuccess.prefab"
	}
end

function FamilybossbattlesuccessPresentor:buildViews()
	return {
		FamilybossbattlesuccessView.New()
	}
end

return FamilybossbattlesuccessPresentor

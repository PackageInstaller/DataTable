-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/panel/stack/PetShowTalentPersentor.lua

module("logic.extensions.bag.panel.stack.PetShowTalentPersentor", package.seeall)

local PetShowTalentPersentor = class("PetShowTalentPersentor", ViewPresentor)

function PetShowTalentPersentor:ctor()
	PetShowTalentPersentor.super.ctor(self)
end

function PetShowTalentPersentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetShowTalentPersentor:dependWhatResources()
	return {
		"ui/views/bag/petshowtalent.prefab"
	}
end

function PetShowTalentPersentor:buildViews()
	return {
		PetShowTalentStack.New()
	}
end

return PetShowTalentPersentor

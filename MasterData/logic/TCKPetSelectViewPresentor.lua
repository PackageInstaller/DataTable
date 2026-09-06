-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKPetSelectViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKPetSelectViewPresentor", package.seeall)

local TCKPetSelectViewPresentor = class("TCKPetSelectViewPresentor", ViewPresentor)

function TCKPetSelectViewPresentor:ctor()
	TCKPetSelectViewPresentor.super.ctor(self)
end

function TCKPetSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKPetSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckpetselectview.prefab"
	}
end

function TCKPetSelectViewPresentor:buildViews()
	return {
		TCKPetSelectView.New()
	}
end

return TCKPetSelectViewPresentor

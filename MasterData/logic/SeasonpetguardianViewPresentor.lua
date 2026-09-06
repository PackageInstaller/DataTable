-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonpetguardianViewPresentor.lua

module("logic.extensions.season.view.SeasonpetguardianViewPresentor", package.seeall)

local SeasonpetguardianViewPresentor = class("SeasonpetguardianViewPresentor", ViewPresentor)

function SeasonpetguardianViewPresentor:ctor()
	SeasonpetguardianViewPresentor.super.ctor(self)
end

function SeasonpetguardianViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonpetguardianViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpetguardianview.prefab"
	}
end

function SeasonpetguardianViewPresentor:buildViews()
	return {
		SeasonPetGuardianView.New()
	}
end

return SeasonpetguardianViewPresentor

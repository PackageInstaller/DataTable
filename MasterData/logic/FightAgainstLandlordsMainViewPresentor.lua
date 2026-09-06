-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FightAgainstLandlordsMainViewPresentor.lua

module("logic.extensions.landlords.view.FightAgainstLandlordsMainViewPresentor", package.seeall)

local FightAgainstLandlordsMainViewPresentor = class("FightAgainstLandlordsMainViewPresentor", ViewPresentor)

function FightAgainstLandlordsMainViewPresentor:ctor()
	FightAgainstLandlordsMainViewPresentor.super.ctor(self)
end

function FightAgainstLandlordsMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FightAgainstLandlordsMainViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/fightagainstlandlordsmainview.prefab"
	}
end

function FightAgainstLandlordsMainViewPresentor:buildViews()
	return {
		FightAgainstLandlordsMainView.New()
	}
end

return FightAgainstLandlordsMainViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeCimeliaInfoViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeCimeliaInfoViewPresentor", package.seeall)

local SunWuKongChallengeCimeliaInfoViewPresentor = class("SunWuKongChallengeCimeliaInfoViewPresentor", ViewPresentor)

function SunWuKongChallengeCimeliaInfoViewPresentor:ctor()
	SunWuKongChallengeCimeliaInfoViewPresentor.super.ctor(self)
end

function SunWuKongChallengeCimeliaInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunWuKongChallengeCimeliaInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengecimeliainfoview.prefab"
	}
end

function SunWuKongChallengeCimeliaInfoViewPresentor:buildViews()
	return {
		SunWuKongChallengeCimeliaInfoView.New()
	}
end

return SunWuKongChallengeCimeliaInfoViewPresentor

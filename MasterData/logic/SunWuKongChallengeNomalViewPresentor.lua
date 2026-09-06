-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeNomalViewPresentor.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeNomalViewPresentor", package.seeall)

local SunWuKongChallengeNomalViewPresentor = class("SunWuKongChallengeNomalViewPresentor", ViewPresentor)

function SunWuKongChallengeNomalViewPresentor:ctor()
	SunWuKongChallengeNomalViewPresentor.super.ctor(self)
end

function SunWuKongChallengeNomalViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunWuKongChallengeNomalViewPresentor:dependWhatResources()
	return {
		"ui/views/sunwukongchallenge/sunwukongchallengenomalview.prefab"
	}
end

function SunWuKongChallengeNomalViewPresentor:buildViews()
	return {
		SunWuKongChallengeNomalView.New()
	}
end

return SunWuKongChallengeNomalViewPresentor

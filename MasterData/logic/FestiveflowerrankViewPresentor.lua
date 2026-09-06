-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveflowerrankViewPresentor.lua

module("logic.extensions.festiveflower.view.FestiveflowerrankViewPresentor", package.seeall)

local FestiveflowerrankViewPresentor = class("FestiveflowerrankViewPresentor", ViewPresentor)

function FestiveflowerrankViewPresentor:ctor()
	FestiveflowerrankViewPresentor.super.ctor(self)
end

function FestiveflowerrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FestiveflowerrankViewPresentor:dependWhatResources()
	return {
		"ui/views/festiveflower/festiveflowerrankview.prefab"
	}
end

function FestiveflowerrankViewPresentor:buildViews()
	return {
		FestiveFlowerRankView.New()
	}
end

return FestiveflowerrankViewPresentor

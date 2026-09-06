-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/view/OriginWelfareRedStarGodViewPresentor.lua

module("logic.extensions.originwelfare.view.OriginWelfareRedStarGodViewPresentor", package.seeall)

local OriginWelfareRedStarGodViewPresentor = class("OriginWelfareRedStarGodViewPresentor", ViewPresentor)

function OriginWelfareRedStarGodViewPresentor:ctor()
	OriginWelfareRedStarGodViewPresentor.super.ctor(self)
end

function OriginWelfareRedStarGodViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginWelfareRedStarGodViewPresentor:dependWhatResources()
	return {
		"ui/views/originwelfare/originwelfareredstargodview.prefab"
	}
end

function OriginWelfareRedStarGodViewPresentor:buildViews()
	return {
		OriginWelfareRedStarGodView.New()
	}
end

return OriginWelfareRedStarGodViewPresentor

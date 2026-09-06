-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckydrawtimestaterankViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckydrawtimestaterankViewPresentor", package.seeall)

local LuckydrawtimestaterankViewPresentor = class("LuckydrawtimestaterankViewPresentor", ViewPresentor)

function LuckydrawtimestaterankViewPresentor:ctor()
	LuckydrawtimestaterankViewPresentor.super.ctor(self)
end

function LuckydrawtimestaterankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckydrawtimestaterankViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawtimestaterankview.prefab"
	}
end

function LuckydrawtimestaterankViewPresentor:buildViews()
	return {
		LuckydrawtimestaterankView.New()
	}
end

return LuckydrawtimestaterankViewPresentor

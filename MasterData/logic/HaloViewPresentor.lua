-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/HaloViewPresentor.lua

module("logic.extensions.lottery.view.paladin.HaloViewPresentor", package.seeall)

local HaloViewPresentor = class("HaloViewPresentor", ViewPresentor)

function HaloViewPresentor:ctor()
	HaloViewPresentor.super.ctor(self)
end

function HaloViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HaloViewPresentor:dependWhatResources()
	return {
		"ui/views/paladinlottery/haloview.prefab"
	}
end

function HaloViewPresentor:buildViews()
	return {
		HaloView.New()
	}
end

return HaloViewPresentor

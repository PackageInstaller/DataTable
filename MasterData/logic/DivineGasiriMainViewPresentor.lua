-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/view/DivineGasiriMainViewPresentor.lua

module("logic.extensions.divinegasiri.view.DivineGasiriMainViewPresentor", package.seeall)

local DivineGasiriMainViewPresentor = class("DivineGasiriMainViewPresentor", ViewPresentor)

function DivineGasiriMainViewPresentor:ctor()
	DivineGasiriMainViewPresentor.super.ctor(self)
end

function DivineGasiriMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineGasiriMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinegasiri/divinegasirimainview.prefab"
	}
end

function DivineGasiriMainViewPresentor:buildViews()
	return {
		DivineGasiriMainView.New()
	}
end

return DivineGasiriMainViewPresentor

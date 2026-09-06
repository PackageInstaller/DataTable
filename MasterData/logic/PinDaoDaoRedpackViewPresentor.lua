-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoRedpackViewPresentor.lua

module("logic.extensions.pindaodao.view.PinDaoDaoRedpackViewPresentor", package.seeall)

local PinDaoDaoRedpackViewPresentor = class("PinDaoDaoRedpackViewPresentor", ViewPresentor)

function PinDaoDaoRedpackViewPresentor:ctor()
	PinDaoDaoRedpackViewPresentor.super.ctor(self)
end

function PinDaoDaoRedpackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinDaoDaoRedpackViewPresentor:dependWhatResources()
	return {
		"ui/views/pindaodao/pindaodaoredpackview.prefab"
	}
end

function PinDaoDaoRedpackViewPresentor:buildViews()
	return {
		PinDaoDaoRedpackView.New()
	}
end

return PinDaoDaoRedpackViewPresentor

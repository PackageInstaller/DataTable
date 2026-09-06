-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoViewPresentor.lua

module("logic.extensions.pindaodao.view.PinDaoDaoViewPresentor", package.seeall)

local PinDaoDaoViewPresentor = class("PinDaoDaoViewPresentor", ViewPresentor)

function PinDaoDaoViewPresentor:ctor()
	PinDaoDaoViewPresentor.super.ctor(self)
end

function PinDaoDaoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinDaoDaoViewPresentor:dependWhatResources()
	return {
		"ui/views/pindaodao/pindaodaoview.prefab"
	}
end

function PinDaoDaoViewPresentor:buildViews()
	return {
		PinDaoDaoView.New()
	}
end

return PinDaoDaoViewPresentor

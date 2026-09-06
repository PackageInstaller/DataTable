-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pindaodao/view/PinDaoDaoSelectViewPresentor.lua

module("logic.extensions.pindaodao.view.PinDaoDaoSelectViewPresentor", package.seeall)

local PinDaoDaoSelectViewPresentor = class("PinDaoDaoSelectViewPresentor", ViewPresentor)

function PinDaoDaoSelectViewPresentor:ctor()
	PinDaoDaoSelectViewPresentor.super.ctor(self)
end

function PinDaoDaoSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinDaoDaoSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/pindaodao/pindaodaoselectview.prefab"
	}
end

function PinDaoDaoSelectViewPresentor:buildViews()
	return {
		PinDaoDaoSelectView.New()
	}
end

return PinDaoDaoSelectViewPresentor

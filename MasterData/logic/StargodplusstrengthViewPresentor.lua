-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusstrengthViewPresentor.lua

module("logic.extensions.stargodplus.view.StargodplusstrengthViewPresentor", package.seeall)

local StargodplusstrengthViewPresentor = class("StargodplusstrengthViewPresentor", ViewPresentor)

function StargodplusstrengthViewPresentor:ctor()
	StargodplusstrengthViewPresentor.super.ctor(self)
end

function StargodplusstrengthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StargodplusstrengthViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplus/stargodplusstrengthview.prefab"
	}
end

function StargodplusstrengthViewPresentor:buildViews()
	return {
		StargodplusstrengthView.New()
	}
end

return StargodplusstrengthViewPresentor

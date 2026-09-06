-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigskinrenameViewPresentor.lua

module("logic.extensions.pigraise.view.PigskinrenameViewPresentor", package.seeall)

local PigskinrenameViewPresentor = class("PigskinrenameViewPresentor", ViewPresentor)

function PigskinrenameViewPresentor:ctor()
	PigskinrenameViewPresentor.super.ctor(self)
end

function PigskinrenameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigskinrenameViewPresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigskinrenameview.prefab"
	}
end

function PigskinrenameViewPresentor:buildViews()
	return {
		PigskinrenameView.New()
	}
end

return PigskinrenameViewPresentor

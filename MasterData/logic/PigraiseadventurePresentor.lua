-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseadventurePresentor.lua

module("logic.extensions.pigraise.view.PigraiseadventurePresentor", package.seeall)

local PigraiseadventurePresentor = class("PigraiseadventurePresentor", ViewPresentor)

function PigraiseadventurePresentor:ctor()
	PigraiseadventurePresentor.super.ctor(self)
end

function PigraiseadventurePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigraiseadventurePresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigraiseadventureview.prefab"
	}
end

function PigraiseadventurePresentor:buildViews()
	return {
		PigraiseadventureView.New()
	}
end

return PigraiseadventurePresentor

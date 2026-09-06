-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigraiseadoptPresentor.lua

module("logic.extensions.pigraise.view.PigraiseadoptPresentor", package.seeall)

local PigraiseadoptPresentor = class("PigraiseadoptPresentor", ViewPresentor)

function PigraiseadoptPresentor:ctor()
	PigraiseadoptPresentor.super.ctor(self)
end

function PigraiseadoptPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PigraiseadoptPresentor:dependWhatResources()
	return {
		"ui/views/pigraise/pigraiseadoptview.prefab"
	}
end

function PigraiseadoptPresentor:buildViews()
	return {
		PigraiseadoptView.New(),
		PigraiseNamingView.New()
	}
end

return PigraiseadoptPresentor

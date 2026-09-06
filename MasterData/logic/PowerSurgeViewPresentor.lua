-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/powersurge/PowerSurgeViewPresentor.lua

module("logic.extensions.bonus.view.powersurge.PowerSurgeViewPresentor", package.seeall)

local PowerSurgeViewPresentor = class("PowerSurgeViewPresentor", ViewPresentor)

function PowerSurgeViewPresentor:ctor()
	PowerSurgeViewPresentor.super.ctor(self)
end

function PowerSurgeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerSurgeViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/powersurge/powersurgeview.prefab"
	}
end

function PowerSurgeViewPresentor:buildViews()
	return {
		PowerSurgeView.New()
	}
end

return PowerSurgeViewPresentor

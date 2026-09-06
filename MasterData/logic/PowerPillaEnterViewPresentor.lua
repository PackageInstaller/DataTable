-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaEnterViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaEnterViewPresentor", package.seeall)

local PowerPillaEnterViewPresentor = class("PowerPillaEnterViewPresentor", ViewPresentor)

function PowerPillaEnterViewPresentor:ctor()
	PowerPillaEnterViewPresentor.super.ctor(self)
end

function PowerPillaEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/maintainpowerpilla/powerpillaenterview.prefab"
	}
end

function PowerPillaEnterViewPresentor:buildViews()
	return {
		PowerPillaEnterView.New()
	}
end

return PowerPillaEnterViewPresentor

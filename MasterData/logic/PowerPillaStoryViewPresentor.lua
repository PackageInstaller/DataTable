-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaStoryViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaStoryViewPresentor", package.seeall)

local PowerPillaStoryViewPresentor = class("PowerPillaStoryViewPresentor", ViewPresentor)

function PowerPillaStoryViewPresentor:ctor()
	PowerPillaStoryViewPresentor.super.ctor(self)
end

function PowerPillaStoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaStoryViewPresentor:dependWhatResources()
	return {
		"ui/views/maintainpowerpilla/powerpillastoryview.prefab"
	}
end

function PowerPillaStoryViewPresentor:buildViews()
	return {
		PowerPillaStoryView.New()
	}
end

return PowerPillaStoryViewPresentor

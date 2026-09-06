-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaBuffViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaBuffViewPresentor", package.seeall)

local PowerPillaBuffViewPresentor = class("PowerPillaBuffViewPresentor", ViewPresentor)

function PowerPillaBuffViewPresentor:ctor()
	PowerPillaBuffViewPresentor.super.ctor(self)
end

function PowerPillaBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/maintainpowerpilla/powerpillabuffview.prefab"
	}
end

function PowerPillaBuffViewPresentor:buildViews()
	return {
		PowerPillaBuffView.New()
	}
end

return PowerPillaBuffViewPresentor

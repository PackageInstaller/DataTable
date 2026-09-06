-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaPrizeViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaPrizeViewPresentor", package.seeall)

local PowerPillaPrizeViewPresentor = class("PowerPillaPrizeViewPresentor", ViewPresentor)

function PowerPillaPrizeViewPresentor:ctor()
	PowerPillaPrizeViewPresentor.super.ctor(self)
end

function PowerPillaPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/maintainpowerpilla/powerpillaprizeview.prefab"
	}
end

function PowerPillaPrizeViewPresentor:buildViews()
	return {
		PowerPillaPrizeView.New()
	}
end

return PowerPillaPrizeViewPresentor

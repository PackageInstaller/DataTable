-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaBossTipsViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaBossTipsViewPresentor", package.seeall)

local PowerPillaBossTipsViewPresentor = class("PowerPillaBossTipsViewPresentor", ViewPresentor)

function PowerPillaBossTipsViewPresentor:ctor()
	PowerPillaBossTipsViewPresentor.super.ctor(self)
end

function PowerPillaBossTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaBossTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/maintainpowerpilla/powerpillabosstipsview.prefab"
	}
end

function PowerPillaBossTipsViewPresentor:buildViews()
	return {
		PowerPillaBossTipsView.New()
	}
end

return PowerPillaBossTipsViewPresentor

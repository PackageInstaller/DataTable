-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PowerPillaBuffTreeViewPresentor.lua

module("logic.extensions.maintainpowerpilla.view.PowerPillaBuffTreeViewPresentor", package.seeall)

local PowerPillaBuffTreeViewPresentor = class("PowerPillaBuffTreeViewPresentor", ViewPresentor)

function PowerPillaBuffTreeViewPresentor:ctor()
	PowerPillaBuffTreeViewPresentor.super.ctor(self)
end

function PowerPillaBuffTreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerPillaBuffTreeViewPresentor:dependWhatResources()
	return {
		"ui/views/maintainpowerpilla/powerpillabufftreeview.prefab"
	}
end

function PowerPillaBuffTreeViewPresentor:buildViews()
	return {
		PowerPillaBuffTreeView.New()
	}
end

function PowerPillaBuffTreeViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PowerPillaBuffTreeViewPresentor

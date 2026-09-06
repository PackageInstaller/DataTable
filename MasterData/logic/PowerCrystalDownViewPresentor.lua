-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalDownViewPresentor.lua

module("logic.extensions.powercrystal.view.PowerCrystalDownViewPresentor", package.seeall)

local PowerCrystalDownViewPresentor = class("PowerCrystalDownViewPresentor", ViewPresentor)

function PowerCrystalDownViewPresentor:ctor()
	PowerCrystalDownViewPresentor.super.ctor(self)
end

function PowerCrystalDownViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PowerCrystalDownViewPresentor:dependWhatResources()
	return {
		"ui/views/powercrystal/powercrystaldownview.prefab"
	}
end

function PowerCrystalDownViewPresentor:buildViews()
	return {
		PowerCrystalDownView.New()
	}
end

function PowerCrystalDownViewPresentor:onClickOutside()
	ViewMgr.instance:close(self.viewName)
end

return PowerCrystalDownViewPresentor

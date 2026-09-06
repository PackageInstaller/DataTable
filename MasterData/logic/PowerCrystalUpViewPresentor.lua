-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalUpViewPresentor.lua

module("logic.extensions.powercrystal.view.PowerCrystalUpViewPresentor", package.seeall)

local PowerCrystalUpViewPresentor = class("PowerCrystalUpViewPresentor", ViewPresentor)

function PowerCrystalUpViewPresentor:ctor()
	PowerCrystalUpViewPresentor.super.ctor(self)
end

function PowerCrystalUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PowerCrystalUpViewPresentor:dependWhatResources()
	return {
		"ui/views/powercrystal/powercrystalupview.prefab"
	}
end

function PowerCrystalUpViewPresentor:buildViews()
	return {
		PowerCrystalUpView.New()
	}
end

function PowerCrystalUpViewPresentor:onClickOutside()
	ViewMgr.instance:close(self.viewName)
end

return PowerCrystalUpViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineevolvepluspopupViewPresentor.lua

module("logic.extensions.divineevolveplus.view.DivineevolvepluspopupViewPresentor", package.seeall)

local DivineevolvepluspopupViewPresentor = class("DivineevolvepluspopupViewPresentor", ViewPresentor)

function DivineevolvepluspopupViewPresentor:ctor()
	DivineevolvepluspopupViewPresentor.super.ctor(self)
end

function DivineevolvepluspopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineevolvepluspopupViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolveplus/divineevolvepluspopupview.prefab"
	}
end

function DivineevolvepluspopupViewPresentor:buildViews()
	return {
		DivineevolvepluspopupView.New()
	}
end

return DivineevolvepluspopupViewPresentor

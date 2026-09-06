-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineEvolvePlusViewPresentor.lua

module("logic.extensions.divineevolveplus.view.DivineEvolvePlusViewPresentor", package.seeall)

local DivineEvolvePlusViewPresentor = class("DivineEvolvePlusViewPresentor", ViewPresentor)

function DivineEvolvePlusViewPresentor:ctor()
	DivineEvolvePlusViewPresentor.super.ctor(self)
end

function DivineEvolvePlusViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolvePlusViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolveplus/divineevolveplusview.prefab"
	}
end

function DivineEvolvePlusViewPresentor:buildViews()
	return {
		DivineEvolvePlusView.New()
	}
end

return DivineEvolvePlusViewPresentor

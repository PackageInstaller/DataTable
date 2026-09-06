-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveLookViewPresentor.lua

module("logic.extensions.divineevolve.view.DivineEvolveLookViewPresentor", package.seeall)

local DivineEvolveLookViewPresentor = class("DivineEvolveLookViewPresentor", ViewPresentor)

function DivineEvolveLookViewPresentor:ctor()
	DivineEvolveLookViewPresentor.super.ctor(self)
end

function DivineEvolveLookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolveLookViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolve/divineevolvelookview.prefab"
	}
end

function DivineEvolveLookViewPresentor:buildViews()
	return {
		DivineEvolveLookView.New()
	}
end

return DivineEvolveLookViewPresentor

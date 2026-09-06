-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineEvolvePlusLookViewPresentor.lua

module("logic.extensions.divineevolveplus.view.DivineEvolvePlusLookViewPresentor", package.seeall)

local DivineEvolvePlusLookViewPresentor = class("DivineEvolvePlusLookViewPresentor", ViewPresentor)

function DivineEvolvePlusLookViewPresentor:ctor()
	DivineEvolvePlusLookViewPresentor.super.ctor(self)
end

function DivineEvolvePlusLookViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineEvolvePlusLookViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolveplus/divineevolvepluslookview.prefab"
	}
end

function DivineEvolvePlusLookViewPresentor:buildViews()
	return {
		DivineEvolvePlusLookView.New()
	}
end

return DivineEvolvePlusLookViewPresentor

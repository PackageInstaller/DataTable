-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineEvolvePlusDisplayViewPresentor.lua

module("logic.extensions.divineevolveplus.view.DivineEvolvePlusDisplayViewPresentor", package.seeall)

local DivineEvolvePlusDisplayViewPresentor = class("DivineEvolvePlusDisplayViewPresentor", ViewPresentor)

DivineEvolvePlusDisplayViewPresentor.EffectPath = "fx_ui_shenqijinhua/fx_shenqijinhua_tx01.prefab"

function DivineEvolvePlusDisplayViewPresentor:ctor()
	DivineEvolvePlusDisplayViewPresentor.super.ctor(self)
end

function DivineEvolvePlusDisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolvePlusDisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolveplus/divineevolveplusdisplayview.prefab"
	}
end

function DivineEvolvePlusDisplayViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(DivineEvolvePlusDisplayViewPresentor.EffectPath)
	}
end

function DivineEvolvePlusDisplayViewPresentor:buildViews()
	return {
		DivineEvolvePlusDisplayView.New()
	}
end

return DivineEvolvePlusDisplayViewPresentor

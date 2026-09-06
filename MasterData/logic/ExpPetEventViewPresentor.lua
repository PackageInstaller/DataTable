-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpPetEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpPetEventViewPresentor", package.seeall)

local ExpPetEventViewPresentor = class("ExpPetEventViewPresentor", ViewPresentor)

function ExpPetEventViewPresentor:ctor()
	ExpPetEventViewPresentor.super.ctor(self)
end

function ExpPetEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpPetEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/peteventview.prefab"
	}
end

function ExpPetEventViewPresentor:buildViews()
	return {
		ExpPetEventView.New()
	}
end

function ExpPetEventViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab")
	}
end

return ExpPetEventViewPresentor

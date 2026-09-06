-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpBuffEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpBuffEventViewPresentor", package.seeall)

local ExpBuffEventViewPresentor = class("ExpBuffEventViewPresentor", ViewPresentor)

function ExpBuffEventViewPresentor:ctor()
	ExpBuffEventViewPresentor.super.ctor(self)
end

function ExpBuffEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpBuffEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/buffeventview.prefab"
	}
end

function ExpBuffEventViewPresentor:buildViews()
	return {
		ExpBuffEventView.New()
	}
end

function ExpBuffEventViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab")
	}
end

function ExpBuffEventViewPresentor:setGrayMaskGO(grayMaskGO)
	ExpBuffEventViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return ExpBuffEventViewPresentor

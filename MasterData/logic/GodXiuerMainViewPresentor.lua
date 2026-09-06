-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/view/GodXiuerMainViewPresentor.lua

module("logic.extensions.godxiuerchallenge.view.GodXiuerMainViewPresentor", package.seeall)

local GodXiuerMainViewPresentor = class("GodXiuerMainViewPresentor", ViewPresentor)

GodXiuerMainViewPresentor.Effect1 = "20221223/shenqixiuer/fx_ui_xiuer_fw_zhujiemian.prefab"
GodXiuerMainViewPresentor.Effect2 = "20221223/shenqixiuer/fx_ui_xiuer_fw_shuimian.prefab"
GodXiuerMainViewPresentor.Effect3 = "20221223/shenqixiuer/fx_ui_xiuer_fw_dianji.prefab"

function GodXiuerMainViewPresentor:ctor()
	GodXiuerMainViewPresentor.super.ctor(self)
end

function GodXiuerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodXiuerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/godxiuerchallenge/godxiuermainview.prefab"
	}
end

function GodXiuerMainViewPresentor:buildViews()
	return {
		GodXiuerMainView.New()
	}
end

function GodXiuerMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(GodXiuerMainViewPresentor.Effect1),
		UIEffectManager.instance:getEffectPath(GodXiuerMainViewPresentor.Effect2),
		UIEffectManager.instance:getEffectPath(GodXiuerMainViewPresentor.Effect3)
	}
end

return GodXiuerMainViewPresentor

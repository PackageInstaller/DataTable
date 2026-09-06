-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godxiuerchallenge/view/GodXiuerRightWrongViewPresentor.lua

module("logic.extensions.godxiuerchallenge.view.GodXiuerRightWrongViewPresentor", package.seeall)

local GodXiuerRightWrongViewPresentor = class("GodXiuerRightWrongViewPresentor", ViewPresentor)

GodXiuerRightWrongViewPresentor.Effect1 = "20221223/shenqixiuer/fx_ui_xiuer_fw_xuanzhong.prefab"

function GodXiuerRightWrongViewPresentor:ctor()
	GodXiuerRightWrongViewPresentor.super.ctor(self)
end

function GodXiuerRightWrongViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodXiuerRightWrongViewPresentor:dependWhatResources()
	return {
		"ui/views/godxiuerchallenge/godxiuerrightwrongview.prefab"
	}
end

function GodXiuerRightWrongViewPresentor:buildViews()
	return {
		GodXiuerRightWrongView.New()
	}
end

function GodXiuerRightWrongViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(GodXiuerRightWrongViewPresentor.Effect1)
	}
end

return GodXiuerRightWrongViewPresentor

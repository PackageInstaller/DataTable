-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleBuffViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleBuffViewPresentor", package.seeall)

local ScuffleBuffViewPresentor = class("ScuffleBuffViewPresentor", ViewPresentor)

function ScuffleBuffViewPresentor:ctor()
	ScuffleBuffViewPresentor.super.ctor(self)
end

function ScuffleBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ScuffleBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflebuffview.prefab"
	}
end

function ScuffleBuffViewPresentor:buildViews()
	return {
		ScuffleBuffView.New()
	}
end

function ScuffleBuffViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab")
	}
end

function ScuffleBuffViewPresentor:setGrayMaskGO(grayMaskGO)
	ScuffleBuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return ScuffleBuffViewPresentor

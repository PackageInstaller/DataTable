-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/view/DivineasheslessdragonlevelViewPresentor.lua

module("logic.extensions.divineasheslessdragon.view.DivineasheslessdragonlevelViewPresentor", package.seeall)

local DivineasheslessdragonlevelViewPresentor = class("DivineasheslessdragonlevelViewPresentor", ViewPresentor)

DivineasheslessdragonlevelViewPresentor.Effect1 = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_huang.prefab"
DivineasheslessdragonlevelViewPresentor.Effect2 = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_hong.prefab"
DivineasheslessdragonlevelViewPresentor.Effect3 = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_zi.prefab"

function DivineasheslessdragonlevelViewPresentor:ctor()
	DivineasheslessdragonlevelViewPresentor.super.ctor(self)
end

function DivineasheslessdragonlevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineasheslessdragonlevelViewPresentor:dependWhatResources()
	return {
		"ui/views/divineasheslessdragon/divineasheslessdragonlevelview.prefab"
	}
end

function DivineasheslessdragonlevelViewPresentor:buildViews()
	return {
		DivineasheslessdragonlevelView.New()
	}
end

return DivineasheslessdragonlevelViewPresentor

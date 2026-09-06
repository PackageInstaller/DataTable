-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveTipViewPresentor.lua

module("logic.extensions.divineevolve.view.DivineEvolveTipViewPresentor", package.seeall)

local DivineEvolveTipViewPresentor = class("DivineEvolveTipViewPresentor", ViewPresentor)

function DivineEvolveTipViewPresentor:ctor()
	DivineEvolveTipViewPresentor.super.ctor(self)
end

function DivineEvolveTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineEvolveTipViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolve/divineevolvetipview.prefab"
	}
end

function DivineEvolveTipViewPresentor:buildViews()
	return {
		DivineEvolveTipView.New()
	}
end

return DivineEvolveTipViewPresentor

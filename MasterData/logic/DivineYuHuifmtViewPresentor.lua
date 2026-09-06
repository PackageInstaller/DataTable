-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuifmtViewPresentor.lua

module("logic.extensions.divineyuhui.view.DivineYuHuifmtViewPresentor", package.seeall)

local DivineYuHuifmtViewPresentor = class("DivineYuHuifmtViewPresentor", ViewPresentor)

function DivineYuHuifmtViewPresentor:ctor()
	DivineYuHuifmtViewPresentor.super.ctor(self)
end

function DivineYuHuifmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineYuHuifmtViewPresentor:dependWhatResources()
	return {
		"ui/views/divineyuhui/divineyuhuifmtview.prefab"
	}
end

function DivineYuHuifmtViewPresentor:buildViews()
	return {
		DivineYuHuifmtView.New()
	}
end

return DivineYuHuifmtViewPresentor

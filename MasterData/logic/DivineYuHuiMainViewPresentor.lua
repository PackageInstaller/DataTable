-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiMainViewPresentor.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiMainViewPresentor", package.seeall)

local DivineYuHuiMainViewPresentor = class("DivineYuHuiMainViewPresentor", ViewPresentor)

function DivineYuHuiMainViewPresentor:ctor()
	DivineYuHuiMainViewPresentor.super.ctor(self)
end

function DivineYuHuiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineYuHuiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineyuhui/divineyuhuimainview.prefab"
	}
end

function DivineYuHuiMainViewPresentor:buildViews()
	return {
		DivineYuHuiMainView.New()
	}
end

return DivineYuHuiMainViewPresentor

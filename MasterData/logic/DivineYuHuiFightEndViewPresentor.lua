-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiFightEndViewPresentor.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiFightEndViewPresentor", package.seeall)

local DivineYuHuiFightEndViewPresentor = class("DivineYuHuiFightEndViewPresentor", ViewPresentor)

function DivineYuHuiFightEndViewPresentor:ctor()
	DivineYuHuiFightEndViewPresentor.super.ctor(self)
end

function DivineYuHuiFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineYuHuiFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/divineyuhui/divineyuhuifightendview.prefab"
	}
end

function DivineYuHuiFightEndViewPresentor:buildViews()
	return {
		DivineYuHuiFightEndView.New()
	}
end

return DivineYuHuiFightEndViewPresentor

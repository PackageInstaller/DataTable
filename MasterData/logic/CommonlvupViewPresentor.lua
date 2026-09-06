-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CommonlvupViewPresentor.lua

module("logic.extensions.common.view.CommonlvupViewPresentor", package.seeall)

local CommonlvupViewPresentor = class("CommonlvupViewPresentor", ViewPresentor)

function CommonlvupViewPresentor:ctor()
	CommonlvupViewPresentor.super.ctor(self)
end

function CommonlvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function CommonlvupViewPresentor:dependWhatResources()
	return {
		"ui/views/common/commonlvupview.prefab"
	}
end

function CommonlvupViewPresentor:buildViews()
	return {
		CommonlvupView.New()
	}
end

function CommonlvupViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return CommonlvupViewPresentor

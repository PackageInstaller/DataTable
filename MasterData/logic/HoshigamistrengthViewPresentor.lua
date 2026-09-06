-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamistrengthViewPresentor.lua

module("logic.extensions.hoshigami.view.HoshigamistrengthViewPresentor", package.seeall)

local HoshigamistrengthViewPresentor = class("HoshigamistrengthViewPresentor", ViewPresentor)

function HoshigamistrengthViewPresentor:ctor()
	HoshigamistrengthViewPresentor.super.ctor(self)
end

function HoshigamistrengthViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HoshigamistrengthViewPresentor:dependWhatResources()
	return {
		"ui/views/hoshigami/hoshigamistrengthview.prefab"
	}
end

function HoshigamistrengthViewPresentor:buildViews()
	return {
		HoshigamistrengthView.New()
	}
end

function HoshigamistrengthViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return HoshigamistrengthViewPresentor

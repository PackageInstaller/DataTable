-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanbaochongeventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanbaochongeventViewPresentor", package.seeall)

local RmxplanbaochongeventViewPresentor = class("RmxplanbaochongeventViewPresentor", ViewPresentor)

function RmxplanbaochongeventViewPresentor:ctor()
	RmxplanbaochongeventViewPresentor.super.ctor(self)
end

function RmxplanbaochongeventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanbaochongeventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanbaochongeventview.prefab"
	}
end

function RmxplanbaochongeventViewPresentor:buildViews()
	return {
		RmxplanbaochongeventView.New()
	}
end

return RmxplanbaochongeventViewPresentor

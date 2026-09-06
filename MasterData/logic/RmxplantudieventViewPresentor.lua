-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplantudieventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplantudieventViewPresentor", package.seeall)

local RmxplantudieventViewPresentor = class("RmxplantudieventViewPresentor", ViewPresentor)

function RmxplantudieventViewPresentor:ctor()
	RmxplantudieventViewPresentor.super.ctor(self)
end

function RmxplantudieventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplantudieventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplantudieventview.prefab"
	}
end

function RmxplantudieventViewPresentor:buildViews()
	return {
		RmxplantudieventView.New()
	}
end

return RmxplantudieventViewPresentor

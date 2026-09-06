-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/view/NiannianwelfareinfoViewPresentor.lua

module("logic.extensions.niannianwelfare.view.NiannianwelfareinfoViewPresentor", package.seeall)

local NiannianwelfareinfoViewPresentor = class("NiannianwelfareinfoViewPresentor", ViewPresentor)

function NiannianwelfareinfoViewPresentor:ctor()
	NiannianwelfareinfoViewPresentor.super.ctor(self)
end

function NiannianwelfareinfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NiannianwelfareinfoViewPresentor:dependWhatResources()
	return {
		"ui/views/niannianwelfare/niannianwelfareinfoview.prefab"
	}
end

function NiannianwelfareinfoViewPresentor:buildViews()
	return {
		NianNianWelfareInfoView.New()
	}
end

return NiannianwelfareinfoViewPresentor

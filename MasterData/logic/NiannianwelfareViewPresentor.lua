-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/view/NiannianwelfareViewPresentor.lua

module("logic.extensions.niannianwelfare.view.NiannianwelfareViewPresentor", package.seeall)

local NiannianwelfareViewPresentor = class("NiannianwelfareViewPresentor", ViewPresentor)

function NiannianwelfareViewPresentor:ctor()
	NiannianwelfareViewPresentor.super.ctor(self)
end

function NiannianwelfareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NiannianwelfareViewPresentor:dependWhatResources()
	return {
		"ui/views/niannianwelfare/niannianwelfareview.prefab"
	}
end

function NiannianwelfareViewPresentor:buildViews()
	return {
		NianNianWelfareView.New()
	}
end

return NiannianwelfareViewPresentor

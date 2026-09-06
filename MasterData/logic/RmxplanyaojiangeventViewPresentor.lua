-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanyaojiangeventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanyaojiangeventViewPresentor", package.seeall)

local RmxplanyaojiangeventViewPresentor = class("RmxplanyaojiangeventViewPresentor", ViewPresentor)

function RmxplanyaojiangeventViewPresentor:ctor()
	RmxplanyaojiangeventViewPresentor.super.ctor(self)
end

function RmxplanyaojiangeventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RmxplanyaojiangeventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanyaojiangeventview.prefab"
	}
end

function RmxplanyaojiangeventViewPresentor:buildViews()
	return {
		RmxplanyaojiangeventView.New()
	}
end

return RmxplanyaojiangeventViewPresentor

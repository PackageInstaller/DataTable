-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/SenluowanxiangresultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.SenluowanxiangresultViewPresentor", package.seeall)

local SenluowanxiangresultViewPresentor = class("SenluowanxiangresultViewPresentor", ViewPresentor)

function SenluowanxiangresultViewPresentor:ctor()
	SenluowanxiangresultViewPresentor.super.ctor(self)
end

function SenluowanxiangresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SenluowanxiangresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmresultview.prefab"
	}
end

function SenluowanxiangresultViewPresentor:buildViews()
	return {
		SenluowanxiangresultView.New()
	}
end

return SenluowanxiangresultViewPresentor

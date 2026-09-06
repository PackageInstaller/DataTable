-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mofang/view/MofangLvupViewPresentor.lua

module("logic.extensions.mofang.view.MofangLvupViewPresentor", package.seeall)

local MofangLvupViewPresentor = class("MofangLvupViewPresentor", ViewPresentor)

function MofangLvupViewPresentor:ctor()
	MofangLvupViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.MofangViewPriority
end

function MofangLvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MofangLvupViewPresentor:dependWhatResources()
	return {
		"ui/views/mofang/mofanglvupview.prefab"
	}
end

function MofangLvupViewPresentor:buildViews()
	return {
		MofangLvupView.New()
	}
end

return MofangLvupViewPresentor

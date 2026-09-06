-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegefreeViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegefreeViewPresentor", package.seeall)

local NewhandprivilegefreeViewPresentor = class("NewhandprivilegefreeViewPresentor", ViewPresentor)

function NewhandprivilegefreeViewPresentor:ctor()
	NewhandprivilegefreeViewPresentor.super.ctor(self)
end

function NewhandprivilegefreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewhandprivilegefreeViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandprivilegeview.prefab"
	}
end

function NewhandprivilegefreeViewPresentor:buildViews()
	return {
		NewhandprivilegefreeView.New()
	}
end

return NewhandprivilegefreeViewPresentor

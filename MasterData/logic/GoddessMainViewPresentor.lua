-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessMainViewPresentor.lua

module("logic.extensions.goddess.view.GoddessMainViewPresentor", package.seeall)

local GoddessMainViewPresentor = class("GoddessMainViewPresentor", ViewPresentor)

function GoddessMainViewPresentor:ctor()
	GoddessMainViewPresentor.super.ctor(self)
end

function GoddessMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddess/goddessmainview.prefab"
	}
end

function GoddessMainViewPresentor:buildViews()
	return {
		GoddessMainView.New()
	}
end

return GoddessMainViewPresentor

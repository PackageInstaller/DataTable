-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessrankViewPresentor.lua

module("logic.extensions.goddess.view.GoddessrankViewPresentor", package.seeall)

local GoddessrankViewPresentor = class("GoddessrankViewPresentor", ViewPresentor)

function GoddessrankViewPresentor:ctor()
	GoddessrankViewPresentor.super.ctor(self)
end

function GoddessrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessrankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddess/goddessrankview.prefab"
	}
end

function GoddessrankViewPresentor:buildViews()
	return {
		GoddessrankView.New()
	}
end

return GoddessrankViewPresentor

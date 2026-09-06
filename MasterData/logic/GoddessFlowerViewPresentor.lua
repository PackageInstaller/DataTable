-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/view/GoddessFlowerViewPresentor.lua

module("logic.extensions.goddess.view.GoddessFlowerViewPresentor", package.seeall)

local GoddessFlowerViewPresentor = class("GoddessFlowerViewPresentor", ViewPresentor)

function GoddessFlowerViewPresentor:ctor()
	GoddessFlowerViewPresentor.super.ctor(self)
end

function GoddessFlowerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddessFlowerViewPresentor:dependWhatResources()
	return {
		"ui/views/goddess/goddessflowerview.prefab"
	}
end

function GoddessFlowerViewPresentor:buildViews()
	return {
		GoddessFlowerView.New()
	}
end

return GoddessFlowerViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/privilege/view/PrivilegePresentor.lua

module("logic.extensions.privilege.view.PrivilegePresentor", package.seeall)

local PrivilegePresentor = class("PrivilegePresentor", ViewPresentor)

function PrivilegePresentor:ctor()
	PrivilegePresentor.super.ctor(self)
end

function PrivilegePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PrivilegePresentor:dependWhatResources()
	return {
		"ui/views/privilege/privilegeview.prefab"
	}
end

function PrivilegePresentor:buildViews()
	return {
		PrivilegeView.New()
	}
end

function PrivilegePresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return PrivilegePresentor

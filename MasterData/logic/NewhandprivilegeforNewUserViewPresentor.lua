-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandprivilegeforNewUserViewPresentor.lua

module("logic.extensions.newhandwelfare.view.NewhandprivilegeforNewUserViewPresentor", package.seeall)

local NewhandprivilegeforNewUserViewPresentor = class("NewhandprivilegeforNewUserViewPresentor", ViewPresentor)

function NewhandprivilegeforNewUserViewPresentor:ctor()
	NewhandprivilegeforNewUserViewPresentor.super.ctor(self)
end

function NewhandprivilegeforNewUserViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NewhandprivilegeforNewUserViewPresentor:dependWhatResources()
	return {
		"ui/views/newhandwelfare/newhandprivilegeview.prefab"
	}
end

function NewhandprivilegeforNewUserViewPresentor:buildViews()
	return {
		NewhandprivilegeforNewUserView.New()
	}
end

return NewhandprivilegeforNewUserViewPresentor

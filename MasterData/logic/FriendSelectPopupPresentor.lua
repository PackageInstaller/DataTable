-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/FriendSelectPopupPresentor.lua

module("logic.extensions.birthdaywishes.view.FriendSelectPopupPresentor", package.seeall)

local FriendSelectPopupPresentor = class("FriendSelectPopupPresentor", ViewWithGuidePresentor)

function FriendSelectPopupPresentor:ctor()
	FriendSelectPopupPresentor.super.ctor(self)
end

function FriendSelectPopupPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FriendSelectPopupPresentor:dependWhatResources()
	return {
		"ui/views/birthdaywishes/friendselectpopup.prefab"
	}
end

function FriendSelectPopupPresentor:buildViews()
	return {
		FriendSelectPopup.New()
	}
end

return FriendSelectPopupPresentor

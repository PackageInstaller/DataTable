-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRewardFriendViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilRewardFriendViewPresentor", package.seeall)

local DestroyEvilRewardFriendViewPresentor = class("DestroyEvilRewardFriendViewPresentor", ViewPresentor)

function DestroyEvilRewardFriendViewPresentor:ctor()
	DestroyEvilRewardFriendViewPresentor.super.ctor(self)
end

function DestroyEvilRewardFriendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilRewardFriendViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilrewardfriendview.prefab"
	}
end

function DestroyEvilRewardFriendViewPresentor:buildViews()
	return {
		DestroyEvilRewardFriendView.New()
	}
end

return DestroyEvilRewardFriendViewPresentor

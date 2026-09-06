-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRewardTabViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilRewardTabViewPresentor", package.seeall)

local DestroyEvilRewardTabViewPresentor = class("DestroyEvilRewardTabViewPresentor", ViewPresentor)

function DestroyEvilRewardTabViewPresentor:ctor()
	DestroyEvilRewardTabViewPresentor.super.ctor(self)
end

function DestroyEvilRewardTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilRewardTabViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilrewardtabview.prefab"
	}
end

function DestroyEvilRewardTabViewPresentor:buildViews()
	return {
		DestroyEvilRewardTabView.New()
	}
end

return DestroyEvilRewardTabViewPresentor

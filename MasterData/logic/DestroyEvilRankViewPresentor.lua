-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRankViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilRankViewPresentor", package.seeall)

local DestroyEvilRankViewPresentor = class("DestroyEvilRankViewPresentor", ViewPresentor)

function DestroyEvilRankViewPresentor:ctor()
	DestroyEvilRankViewPresentor.super.ctor(self)
end

function DestroyEvilRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilRankViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilrankview.prefab"
	}
end

function DestroyEvilRankViewPresentor:buildViews()
	return {
		DestroyEvilRankView.New()
	}
end

return DestroyEvilRankViewPresentor

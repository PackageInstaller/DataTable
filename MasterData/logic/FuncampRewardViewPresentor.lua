-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampRewardViewPresentor.lua

module("logic.extensions.funcamp.view.FuncampRewardViewPresentor", package.seeall)

local FuncampRewardViewPresentor = class("FuncampRewardViewPresentor", ViewPresentor)

function FuncampRewardViewPresentor:ctor()
	FuncampRewardViewPresentor.super.ctor(self)
end

function FuncampRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncampRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcamprewardview.prefab"
	}
end

function FuncampRewardViewPresentor:buildViews()
	return {
		FuncampRewardView.New()
	}
end

return FuncampRewardViewPresentor

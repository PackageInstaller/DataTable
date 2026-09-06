-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampAllRankViewPresentor.lua

module("logic.extensions.funcamp.view.FuncampAllRankViewPresentor", package.seeall)

local FuncampAllRankViewPresentor = class("FuncampAllRankViewPresentor", ViewPresentor)

function FuncampAllRankViewPresentor:ctor()
	FuncampAllRankViewPresentor.super.ctor(self)
end

function FuncampAllRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncampAllRankViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampallrankview.prefab"
	}
end

function FuncampAllRankViewPresentor:buildViews()
	return {
		FuncampAllRankView.New()
	}
end

return FuncampAllRankViewPresentor

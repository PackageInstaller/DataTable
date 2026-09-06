-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampRankViewPresentor.lua

module("logic.extensions.funcamp.view.FuncampRankViewPresentor", package.seeall)

local FuncampRankViewPresentor = class("FuncampRankViewPresentor", ViewPresentor)

function FuncampRankViewPresentor:ctor()
	FuncampRankViewPresentor.super.ctor(self)
end

function FuncampRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FuncampRankViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcamprankview.prefab"
	}
end

function FuncampRankViewPresentor:buildViews()
	return {
		FuncampRankView.New()
	}
end

return FuncampRankViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlelostresultViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlelostresultViewPresentor", package.seeall)

local LotusbattlelostresultViewPresentor = class("LotusbattlelostresultViewPresentor", ViewPresentor)

function LotusbattlelostresultViewPresentor:ctor()
	LotusbattlelostresultViewPresentor.super.ctor(self)
end

function LotusbattlelostresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlelostresultViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlelostresultview.prefab"
	}
end

function LotusbattlelostresultViewPresentor:buildViews()
	return {
		LotusbattlelostresultView.New()
	}
end

return LotusbattlelostresultViewPresentor

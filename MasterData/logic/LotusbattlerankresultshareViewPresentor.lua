-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlerankresultshareViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlerankresultshareViewPresentor", package.seeall)

local LotusbattlerankresultshareViewPresentor = class("LotusbattlerankresultshareViewPresentor", ViewPresentor)

function LotusbattlerankresultshareViewPresentor:ctor()
	LotusbattlerankresultshareViewPresentor.super.ctor(self)
end

function LotusbattlerankresultshareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlerankresultshareViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlerankresultview.prefab"
	}
end

function LotusbattlerankresultshareViewPresentor:buildViews()
	return {
		LotusbattlerankresultshareView.New()
	}
end

return LotusbattlerankresultshareViewPresentor

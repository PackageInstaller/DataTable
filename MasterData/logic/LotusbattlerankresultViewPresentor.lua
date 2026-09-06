-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlerankresultViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlerankresultViewPresentor", package.seeall)

local LotusbattlerankresultViewPresentor = class("LotusbattlerankresultViewPresentor", ViewPresentor)

function LotusbattlerankresultViewPresentor:ctor()
	LotusbattlerankresultViewPresentor.super.ctor(self)
end

function LotusbattlerankresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlerankresultViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlerankresultview.prefab"
	}
end

function LotusbattlerankresultViewPresentor:buildViews()
	return {
		LotusbattlerankresultView.New()
	}
end

return LotusbattlerankresultViewPresentor

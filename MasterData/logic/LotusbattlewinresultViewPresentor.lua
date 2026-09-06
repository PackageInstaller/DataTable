-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlewinresultViewPresentor.lua

module("logic.extensions.lotusbattle.view.LotusbattlewinresultViewPresentor", package.seeall)

local LotusbattlewinresultViewPresentor = class("LotusbattlewinresultViewPresentor", ViewPresentor)

function LotusbattlewinresultViewPresentor:ctor()
	LotusbattlewinresultViewPresentor.super.ctor(self)
end

function LotusbattlewinresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LotusbattlewinresultViewPresentor:dependWhatResources()
	return {
		"ui/views/lotusbattle/lotusbattlewinresultview.prefab"
	}
end

function LotusbattlewinresultViewPresentor:buildViews()
	return {
		LotusbattlewinresultView.New()
	}
end

return LotusbattlewinresultViewPresentor

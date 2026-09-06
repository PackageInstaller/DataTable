-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbbattleresultViewPresentor.lua

module("logic.extensions.fbbchallenge.view.FbbbattleresultViewPresentor", package.seeall)

local FbbbattleresultViewPresentor = class("FbbbattleresultViewPresentor", ViewPresentor)

function FbbbattleresultViewPresentor:ctor()
	FbbbattleresultViewPresentor.super.ctor(self)
end

function FbbbattleresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FbbbattleresultViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbbattleresultview.prefab"
	}
end

function FbbbattleresultViewPresentor:buildViews()
	return {
		FbbbattleresultView.New()
	}
end

return FbbbattleresultViewPresentor

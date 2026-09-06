-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilBattleResultViewPresentor.lua

module("logic.extensions.destroyevil.view.DestroyEvilBattleResultViewPresentor", package.seeall)

local DestroyEvilBattleResultViewPresentor = class("DestroyEvilBattleResultViewPresentor", ViewPresentor)

function DestroyEvilBattleResultViewPresentor:ctor()
	DestroyEvilBattleResultViewPresentor.super.ctor(self)
end

function DestroyEvilBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DestroyEvilBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/destroyevil/destroyevilbattleresultview.prefab"
	}
end

function DestroyEvilBattleResultViewPresentor:buildViews()
	return {
		DestroyEvilBattleResultView.New()
	}
end

return DestroyEvilBattleResultViewPresentor

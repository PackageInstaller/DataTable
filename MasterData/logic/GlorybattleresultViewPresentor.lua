-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleresultViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattleresultViewPresentor", package.seeall)

local GlorybattleresultViewPresentor = class("GlorybattleresultViewPresentor", ViewPresentor)

function GlorybattleresultViewPresentor:ctor()
	GlorybattleresultViewPresentor.super.ctor(self)
end

function GlorybattleresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GlorybattleresultViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattleresultview.prefab"
	}
end

function GlorybattleresultViewPresentor:buildViews()
	return {
		GlorybattleresultView.New()
	}
end

function GlorybattleresultViewPresentor:onClickOutside()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		BattleFacade.instance:endBattle()
	else
		UIStateManager.instance:popByName(ViewName.GlorybattleresultView)
	end
end

return GlorybattleresultViewPresentor

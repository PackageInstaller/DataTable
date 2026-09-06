-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiBattleResultlViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiBattleResultlViewPresentor", package.seeall)

local DivineJiBattleResultlViewPresentor = class("DivineJiBattleResultlViewPresentor", ViewPresentor)

function DivineJiBattleResultlViewPresentor:ctor()
	DivineJiBattleResultlViewPresentor.super.ctor(self)
end

function DivineJiBattleResultlViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineJiBattleResultlViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejibattleresultlview.prefab"
	}
end

function DivineJiBattleResultlViewPresentor:buildViews()
	return {
		DivineJiBattleResultlView.New()
	}
end

return DivineJiBattleResultlViewPresentor

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/view/DivinewatertianyanresultViewPresentor.lua

module("logic.extensions.divinewatertianyan.view.DivinewatertianyanresultViewPresentor", package.seeall)

local DivinewatertianyanresultViewPresentor = class("DivinewatertianyanresultViewPresentor", ViewPresentor)

function DivinewatertianyanresultViewPresentor:ctor()
	DivinewatertianyanresultViewPresentor.super.ctor(self)
end

function DivinewatertianyanresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinewatertianyanresultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinewatertianyan/divinewatertianyanresultview.prefab"
	}
end

function DivinewatertianyanresultViewPresentor:buildViews()
	return {
		DivinewatertianyanresultView.New()
	}
end

function DivinewatertianyanresultViewPresentor:onClickOutside()
	BattleFacade.instance:endBattle()
end

return DivinewatertianyanresultViewPresentor

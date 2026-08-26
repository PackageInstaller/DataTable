-- chunkname: @modules/logic/character/view/CharacterSkinFullScreenViewContainer.lua

module("modules.logic.character.view.CharacterSkinFullScreenViewContainer", package.seeall)

local CharacterSkinFullScreenViewContainer = class("CharacterSkinFullScreenViewContainer", BaseViewContainer)

function CharacterSkinFullScreenViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, CharacterSkinFullScreenView.New())

	return views
end

function CharacterSkinFullScreenViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

function CharacterSkinFullScreenViewContainer:playOpenTransition()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	CharacterSkinFullScreenViewContainer.super.playOpenTransition(self)
end

function CharacterSkinFullScreenViewContainer:onPlayOpenTransitionFinish()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	CharacterSkinFullScreenViewContainer.super.onPlayOpenTransitionFinish(self)
end

return CharacterSkinFullScreenViewContainer

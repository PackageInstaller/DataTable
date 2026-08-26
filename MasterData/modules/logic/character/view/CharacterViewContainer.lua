-- chunkname: @modules/logic/character/view/CharacterViewContainer.lua

module("modules.logic.character.view.CharacterViewContainer", package.seeall)

local CharacterViewContainer = class("CharacterViewContainer", BaseViewContainer)

function CharacterViewContainer:buildViews()
	local views = {}

	self._equipView = CharacterDefaultEquipView.New()
	self._extraView = CharacterDefaultExtraView.New()
	self._destinyView = CharacterDefaultDestinyView.New()

	table.insert(views, CharacterView.New())
	table.insert(views, self._equipView)
	table.insert(views, self._extraView)
	table.insert(views, self._destinyView)
	table.insert(views, CharacterSpineGCView.New())
	table.insert(views, CommonRainEffectView.New("anim/bgcanvas/#go_glowcontainer"))

	self.helpShowView = HelpShowView.New()

	table.insert(views, self.helpShowView)

	return views
end

function CharacterViewContainer:getEquipView()
	return self._equipView
end

function CharacterViewContainer:getDestinyView()
	return self._destinyView
end

function CharacterViewContainer:playOpenTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play(UIAnimationName.Open, self.onOpenAnimDone, self)
	self:startViewOpenBlock()
end

function CharacterViewContainer:onOpenAnimDone()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayOpenTransitionFinish()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
end

function CharacterViewContainer:playCloseTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animator:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
	self:startViewCloseBlock()
end

function CharacterViewContainer:onCloseAnimDone()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
end

function CharacterViewContainer:setIsOwnHero(externalParam)
	self._isOwnHero = externalParam and externalParam.isOwnHero or true
end

function CharacterViewContainer:isOwnHero()
	return self._isOwnHero
end

return CharacterViewContainer

-- chunkname: @modules/logic/characterskin/view/CharacterSkinViewContainer.lua

module("modules.logic.characterskin.view.CharacterSkinViewContainer", package.seeall)

local CharacterSkinViewContainer = class("CharacterSkinViewContainer", BaseViewContainer)

function CharacterSkinViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkinSwitchRightView.New())
	table.insert(views, CharacterSkinLeftView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(views, CharacterSkinSwitchSpineGCView.New())

	return views
end

function CharacterSkinViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function CharacterSkinViewContainer:playOpenTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	if self.viewParam then
		if self.viewParam then
			animator:Play("left_open", self.onOpenAnimDone, self)
		else
			animator:Play(UIAnimationName.Open, self.onOpenAnimDone, self)
		end
	end
end

function CharacterSkinViewContainer:onOpenAnimDone()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayOpenTransitionFinish()
end

function CharacterSkinViewContainer:playCloseTransition()
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")

	local animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	if self.viewParam then
		if self.viewParam then
			animator:Play("left_out", self.onCloseAnimDone, self)
		else
			animator:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
		end
	end
end

function CharacterSkinViewContainer:onCloseAnimDone()
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	self:onPlayCloseTransitionFinish()
end

return CharacterSkinViewContainer

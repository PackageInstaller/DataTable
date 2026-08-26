-- chunkname: @modules/logic/character/view/destiny/CharacterDestinyStoneViewContainer.lua

module("modules.logic.character.view.destiny.CharacterDestinyStoneViewContainer", package.seeall)

local CharacterDestinyStoneViewContainer = class("CharacterDestinyStoneViewContainer", BaseViewContainer)

function CharacterDestinyStoneViewContainer:buildViews()
	local views = {}

	self._stoneView = CharacterDestinyStoneView.New()

	table.insert(views, self._stoneView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CharacterDestinyStoneViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function CharacterDestinyStoneViewContainer:setOpenUnlockStoneView(isOpen)
	self._openUnlockStoneView = isOpen
end

function CharacterDestinyStoneViewContainer:overrideCloseFunc()
	if self._openUnlockStoneView then
		self._stoneView:closeUnlockStoneView()
	else
		self:closeThis()
	end
end

function CharacterDestinyStoneViewContainer:playCloseTransition()
	self._stoneView:playRootOpenCloseAnim(false, self.onCloseAnimDone, self)
end

function CharacterDestinyStoneViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return CharacterDestinyStoneViewContainer

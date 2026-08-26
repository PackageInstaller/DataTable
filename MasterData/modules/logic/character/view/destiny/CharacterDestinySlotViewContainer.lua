-- chunkname: @modules/logic/character/view/destiny/CharacterDestinySlotViewContainer.lua

module("modules.logic.character.view.destiny.CharacterDestinySlotViewContainer", package.seeall)

local CharacterDestinySlotViewContainer = class("CharacterDestinySlotViewContainer", BaseViewContainer)

function CharacterDestinySlotViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterDestinySlotView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CharacterDestinySlotViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function CharacterDestinySlotViewContainer:setCurDestinySlot(destinySlot)
	self._destinySlot = destinySlot
end

function CharacterDestinySlotViewContainer:playCloseTransition()
	if self:_isJustOpenStone() then
		self:onCloseAnimDone()

		return
	end

	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	if self._destinySlot then
		local isUnlock = self._destinySlot:isUnlockSlot()

		if self._destinySlot then
			if not CharacterDestinyEnum.SlotViewAnim.CloseUnlock then
				local animName = CharacterDestinyEnum.SlotViewAnim.CloseLock

				animatorPlayer:Play(animName, self.onCloseAnimDone, self)
			end
		end
	end
end

function CharacterDestinySlotViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()

	self._destinySlot = nil
end

function CharacterDestinySlotViewContainer:_isJustOpenStone()
	local heroMo = self.viewParam.heroMo

	if not heroMo then
		return
	end

	local isOpen = heroMo:isCanOpenDestinySystem()

	return not isOpen
end

return CharacterDestinySlotViewContainer

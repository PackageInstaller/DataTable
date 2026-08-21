-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/widget/GameplayChallengeItem.lua

module("logic.extensions.dungeon.view.entrance.widget.GameplayChallengeItem", package.seeall)

local M = class("GameplayChallengeItem", SimpleCellComponent)

function M:buildUI()
	self._btnClick = self._registry:getBtn("fight_entry_challenge_item_-1375419696")
	self._txtTitle = self._registry:getText("fight_entry_challenge_item_-261087336")
	self._txtName = self._registry:getText("fight_entry_challenge_item_456320823")
	self._txtLimitTime = self._registry:getText("fight_entry_challenge_item_294034653")
	self._txtLock = self._registry:getText("fight_entry_challenge_item_-1739301239")
	self._txtProgress = self._registry:getText("fight_entry_challenge_item_1652098739")
	self._goLimitTime = self._registry:getGo("fight_entry_challenge_item_-331922518")
	self._goAirWorkShop = self._registry:getGo("fight_entry_challenge_item_-1034985993")
	self._goLock = self._registry:getGo("fight_entry_challenge_item_2048328849")
	self._canvasGroup = self._go:GetComponent(ComponentType.CanvasGroup)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	self._callback = nil
end

function M:_onClick()
	if self._callback then
		self._callback()
	end
end

function M:updateData(data)
	self._callback = data.callback

	local isUnlock = data.unlock

	self._canvasGroup.alpha = isUnlock and 1 or 0.85
	self._txtLock.text = data.unlockText

	goutil.setActive(self._goLock, not isUnlock)
end

return M

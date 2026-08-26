-- chunkname: @modules/logic/partygame/view/common/PartyGameRewardCardItem.lua

module("modules.logic.partygame.view.common.PartyGameRewardCardItem", package.seeall)

local PartyGameRewardCardItem = class("PartyGameRewardCardItem", PartyGameCommonCard)

function PartyGameRewardCardItem:_editableInitView()
	PartyGameRewardCardItem.super._editableInitView(self)

	self._goselectframe_reward = gohelper.findChild(self.viewGO, "root/#go_selectframe_reward")
	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self.viewGO)

	self.longPress:SetLongPressTime({
		0.5,
		99999
	})
	self.longPress:AddClickListener(self._click, self)
	self.longPress:AddLongPressListener(self.onLongPress, self)
end

function PartyGameRewardCardItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselectframe_reward, isSelect)
end

function PartyGameRewardCardItem:showSelectFinish(isFinish)
	local needHide = isFinish and not self._isSelect

	self._uiEffect:SetGray(needHide)
end

local OpenParam = {
	offsetX = -20,
	offsetY = 40
}

function PartyGameRewardCardItem:onLongPress()
	OpenParam.cardId = self:getCardId()
	OpenParam.screenPos = recthelper.uiPosToScreenPos(self.viewRectTr)

	ViewMgr.instance:openView(ViewName.CardDropCardTipView, OpenParam)
end

function PartyGameRewardCardItem:_click()
	if not self._canSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_4.PartyGameCommon.play_ui_common_click)
	PartyGameController.instance:dispatchEvent(PartyGameEvent.SelectCard, self.index)
end

function PartyGameRewardCardItem:setCanSelect(state)
	self._canSelect = state
end

function PartyGameRewardCardItem:showNewSelectState(show)
	if self._ani then
		self._ani:Play(show and "appear" or "empty", 0, 0)
	end
end

function PartyGameRewardCardItem:onDestroy()
	if self.longPress then
		self.longPress:RemoveClickListener()
		self.longPress:RemoveLongPressListener()

		self.longPress = nil
	end

	ViewMgr.instance:closeView(ViewName.CardDropCardTipView)
	PartyGameRewardCardItem.super.onDestroy(self)
end

return PartyGameRewardCardItem

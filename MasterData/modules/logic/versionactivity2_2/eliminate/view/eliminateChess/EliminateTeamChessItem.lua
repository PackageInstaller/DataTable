-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateTeamChessItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessItem", package.seeall)

local EliminateTeamChessItem = class("EliminateTeamChessItem", EliminateTeamChessDetailItem)
local UILongPressListener = SLFramework.UGUI.UILongPressListener
local UIDragListener = SLFramework.UGUI.UIDragListener

function EliminateTeamChessItem:_editableInitView()
	self._longClick = UILongPressListener.Get(self.viewGO)

	self._longClick:SetLongPressTime({
		0.5,
		99999
	})

	self._dragClick = UIDragListener.Get(self.viewGO)
end

function EliminateTeamChessItem:_editableAddEvents()
	self._longClick:AddClickListener(self._onLongClick, self)
	self._longClick:AddLongPressListener(self._onLongPress, self)
	self._dragClick:AddDragListener(self._onDrag, self)
	self._dragClick:AddDragBeginListener(self._onDragBegin, self)
	self._dragClick:AddDragEndListener(self._onDragEnd, self)
end

function EliminateTeamChessItem:_editableRemoveEvents()
	if self._longClick then
		self._longClick:RemoveClickListener()
		self._longClick:RemoveLongPressListener()
	end

	if self._dragClick then
		self._dragClick:RemoveDragBeginListener()
		self._dragClick:RemoveDragEndListener()
		self._dragClick:RemoveDragListener()
	end
end

function EliminateTeamChessItem:_onDragBegin(_, eventData)
	if not self._canUse or not self._isLongPress then
		return
	end

	self._beginDragX = eventData.position.x
	self._beginDragY = eventData.position.y

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_mln_drag)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemBeginDrag, self._soliderId, self._beginDragX, self._beginDragY)
end

function EliminateTeamChessItem:_onDrag(_, eventData)
	if not self._canUse or not self._isLongPress or not self._beginDragX or not self._beginDragY then
		return
	end

	local pos = eventData.position
	local x = pos.x
	local y = pos.y
	local offsetX = x - self._beginDragX
	local offsetY = y - self._beginDragY

	if math.abs(offsetX) < 10 and math.abs(offsetY) < 10 then
		return
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDrag, self._soliderId, nil, nil, x, y)
end

function EliminateTeamChessItem:_onDragEnd(_, eventData)
	if not self._canUse or not self._isLongPress or not self._beginDragX or not self._beginDragY then
		return
	end

	local pos = eventData.position
	local x = pos.x
	local y = pos.y

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEnd, self._soliderId, nil, nil, x, y)
end

function EliminateTeamChessItem:_onLongClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessView, self._soliderId, nil, nil, EliminateTeamChessEnum.ChessTipType.showDesc, self, {
		soliderTipOffsetX = EliminateTeamChessEnum.soliderItemTipOffsetX,
		soliderTipOffsetY = EliminateTeamChessEnum.soliderItemTipOffsetY
	})
end

function EliminateTeamChessItem:getPosXYZ()
	return transformhelper.getPos(self.viewGO.transform)
end

function EliminateTeamChessItem:_onLongPress()
	if not self._canUse then
		return
	end

	logNormal("EliminateTeamChessItem:_onLongPress")
end

function EliminateTeamChessItem:setSoliderId(id)
	EliminateTeamChessItem.super.setSoliderId(self, id)

	self._isLongPress = true
end

function EliminateTeamChessItem:setChildIndex(i)
	self.viewGO.transform:SetSiblingIndex(i)
end

function EliminateTeamChessItem:onDestroyView()
	EliminateTeamChessItem.super.onDestroyView(self)

	self._effectCollection = nil
end

return EliminateTeamChessItem

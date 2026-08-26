-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapDialogueItemWork.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapDialogueItemWork", package.seeall)

local Rouge2_MapDialogueItemWork = class("Rouge2_MapDialogueItemWork", BaseWork)

function Rouge2_MapDialogueItemWork:ctor(index)
	self._index = index
	self._tween = false
end

function Rouge2_MapDialogueItemWork:onStart(listComp)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onAddNewDialogue)

	local dialogueItem = listComp:_getOrCreateDialogueItem()

	dialogueItem:initInfo(self._info, self._playType, self._index, self._onDialogueDone, self)
	dialogueItem:play()
end

function Rouge2_MapDialogueItemWork:initInfo(info, playType)
	self._info = info
	self._playType = playType
end

function Rouge2_MapDialogueItemWork:_onDialogueDone()
	self:onDone(true)
end

return Rouge2_MapDialogueItemWork

-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/PuzzleRecordViewItem.lua

module("modules.logic.versionactivity1_4.puzzle.view.PuzzleRecordViewItem", package.seeall)

local PuzzleRecordViewItem = class("PuzzleRecordViewItem", ListScrollCellExtend)

function PuzzleRecordViewItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function PuzzleRecordViewItem:addEvents()
	return
end

function PuzzleRecordViewItem:removeEvents()
	return
end

function PuzzleRecordViewItem:_editableInitView()
	self.txtRecord = gohelper.findChildText(self.viewGO, "")
end

function PuzzleRecordViewItem:_editableAddEvents()
	return
end

function PuzzleRecordViewItem:_editableRemoveEvents()
	return
end

function PuzzleRecordViewItem:onUpdateMO(mo)
	local index = mo:GetIndex()
	local desc = mo:GetRecord()

	self.txtRecord.text = index .. "." .. desc
end

function PuzzleRecordViewItem:onSelect(isSelect)
	return
end

function PuzzleRecordViewItem:onDestroyView()
	return
end

return PuzzleRecordViewItem

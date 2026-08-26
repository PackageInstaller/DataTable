-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/PuzzleRecordItem.lua

module("modules.logic.versionactivity1_4.puzzle.view.PuzzleRecordItem", package.seeall)

local PuzzleRecordItem = class("PuzzleRecordItem", MixScrollCell)

function PuzzleRecordItem:init(go)
	self._txtRecord = gohelper.findChildText(go, "")
	self._txtRecordNum = gohelper.findChildTextMesh(go, "txt_RecordNum")
end

function PuzzleRecordItem:addEvents()
	return
end

function PuzzleRecordItem:removeEvents()
	return
end

function PuzzleRecordItem:_editableInitView()
	return
end

function PuzzleRecordItem:onUpdateMO(mo)
	self._txtRecordNum.text = mo:GetIndex()
	self._txtRecord.text = mo:GetRecord()
end

function PuzzleRecordItem:onSelect(isSelect)
	return
end

function PuzzleRecordItem:onDestroyView()
	return
end

return PuzzleRecordItem

-- chunkname: @modules/logic/versionactivity1_4/puzzle/model/PuzzleRecordMO.lua

module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordMO", package.seeall)

local PuzzleRecordMO = pureTable("PuzzleRecordMO")

function PuzzleRecordMO:init(_index, _desc)
	self.index = _index
	self.desc = _desc
end

function PuzzleRecordMO:GetIndex()
	return self.index
end

function PuzzleRecordMO:GetRecord()
	return self.desc
end

return PuzzleRecordMO

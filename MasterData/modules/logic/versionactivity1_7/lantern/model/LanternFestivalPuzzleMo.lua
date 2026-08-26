-- chunkname: @modules/logic/versionactivity1_7/lantern/model/LanternFestivalPuzzleMo.lua

module("modules.logic.versionactivity1_7.lantern.model.LanternFestivalPuzzleMo", package.seeall)

local LanternFestivalPuzzleMo = pureTable("LanternFestivalPuzzleMo")

function LanternFestivalPuzzleMo:ctor()
	self.puzzleId = 0
	self.state = 0
	self.answerRecords = {}
end

function LanternFestivalPuzzleMo:init(info)
	self.puzzleId = info.puzzleId
	self.state = info.state
	self.answerRecords = {}

	for _, v in ipairs(info.answerRecords) do
		table.insert(self.answerRecords, v)
	end
end

function LanternFestivalPuzzleMo:reset(info)
	self.puzzleId = info.puzzleId
	self.state = info.state
	self.answerRecords = {}

	for _, v in ipairs(info.answerRecords) do
		table.insert(self.answerRecords, v)
	end
end

return LanternFestivalPuzzleMo

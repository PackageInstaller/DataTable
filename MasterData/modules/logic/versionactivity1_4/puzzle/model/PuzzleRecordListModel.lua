-- chunkname: @modules/logic/versionactivity1_4/puzzle/model/PuzzleRecordListModel.lua

module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordListModel", package.seeall)

local PuzzleRecordListModel = class("PuzzleRecordListModel", ListScrollModel)

function PuzzleRecordListModel:init()
	local dataList = {}

	self:setList(dataList)
end

function PuzzleRecordListModel:setRecordList(recordList)
	self:clear()

	for index, desc in ipairs(recordList) do
		local num = index

		if num < 10 then
			num = "0" .. num
		end

		local mo = PuzzleRecordMO.New()

		mo:init(num, desc)
		self:addAtLast(mo)
	end

	PuzzleRecordMixListModel.instance:setRecordList(self:getList())
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RecordCntChange, self:getCount())
end

function PuzzleRecordListModel:clearRecord()
	self:clear()
	PuzzleRecordMixListModel.instance:setRecordList(self:getList())
	Role37PuzzleController.instance:dispatchEvent(Role37PuzzleEvent.RecordCntChange, self:getCount())
end

PuzzleRecordListModel.instance = PuzzleRecordListModel.New()

return PuzzleRecordListModel

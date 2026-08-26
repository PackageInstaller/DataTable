-- chunkname: @modules/logic/versionactivity1_4/puzzle/model/PuzzleRecordMixListModel.lua

module("modules.logic.versionactivity1_4.puzzle.model.PuzzleRecordMixListModel", package.seeall)

local PuzzleRecordMixListModel = class("PuzzleRecordMixListModel", MixScrollModel)

function PuzzleRecordMixListModel:ctor()
	PuzzleRecordMixListModel.super.ctor(self)

	self._infos = nil
end

function PuzzleRecordMixListModel:setRecordList(recordList)
	self._infos = recordList

	self:setList(recordList)
end

function PuzzleRecordMixListModel:getInfoList(scrollGO)
	local mixCellInfos = {}

	if not self._infos or #self._infos <= 0 then
		return mixCellInfos
	end

	local textComp = gohelper.findChildText(scrollGO, "Viewport/Content/RecordItem")
	local mixType = 0

	for i, info in ipairs(self._infos) do
		local text = GameUtil.filterRichText(info:GetRecord())

		table.insert(mixCellInfos, SLFramework.UGUI.MixCellInfo.New(mixType, GameUtil.getTextHeightByLine(textComp, text .. "   ", 37.1) + 20, nil))
	end

	return mixCellInfos
end

function PuzzleRecordMixListModel:clearData()
	self._infos = nil
end

PuzzleRecordMixListModel.instance = PuzzleRecordMixListModel.New()

return PuzzleRecordMixListModel

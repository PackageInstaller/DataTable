-- chunkname: @modules/logic/teach/model/TeachNoteRewardListModel.lua

module("modules.logic.teach.model.TeachNoteRewardListModel", package.seeall)

local TeachNoteRewardListModel = class("TeachNoteRewardListModel", ListScrollModel)

function TeachNoteRewardListModel:setRewardList(infos)
	self._moList = {}

	if infos then
		for _, v in pairs(infos) do
			table.insert(self._moList, v)
		end
	end

	table.sort(self._moList, function(a, b)
		return a.id < b.id
	end)
	self:setList(self._moList)
end

TeachNoteRewardListModel.instance = TeachNoteRewardListModel.New()

return TeachNoteRewardListModel

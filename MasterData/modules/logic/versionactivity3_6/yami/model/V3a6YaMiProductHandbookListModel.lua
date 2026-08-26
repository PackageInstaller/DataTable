-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiProductHandbookListModel.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiProductHandbookListModel", package.seeall)

local V3a6YaMiProductHandbookListModel = class("V3a6YaMiProductHandbookListModel", ListScrollModel)

function V3a6YaMiProductHandbookListModel:setHandbookList()
	local dict = V3a6YaMiModel.instance:getProductDict()
	local list = {}

	if dict then
		for _, mo in pairs(dict) do
			table.insert(list, mo)
		end
	end

	table.sort(list, self.sortList)
	self:setList(list)
	self:selectCell(1, true)
end

function V3a6YaMiProductHandbookListModel.sortList(a, b)
	return a.id < b.id
end

function V3a6YaMiProductHandbookListModel:selectCell(index, isSelect)
	V3a6YaMiProductHandbookListModel.super.selectCell(self, index, isSelect)

	self._selectIndex = index
end

function V3a6YaMiProductHandbookListModel:getSelectMo()
	return self:getByIndex(self._selectIndex or 1)
end

V3a6YaMiProductHandbookListModel.instance = V3a6YaMiProductHandbookListModel.New()

return V3a6YaMiProductHandbookListModel

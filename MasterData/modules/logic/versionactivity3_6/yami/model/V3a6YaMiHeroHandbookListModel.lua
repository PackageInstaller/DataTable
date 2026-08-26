-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiHeroHandbookListModel.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiHeroHandbookListModel", package.seeall)

local V3a6YaMiHeroHandbookListModel = class("V3a6YaMiHeroHandbookListModel", ListScrollModel)

function V3a6YaMiHeroHandbookListModel:setHandbookList(selectIndex)
	local dict = V3a6YaMiModel.instance:getHeroDict()
	local list = {}

	if dict then
		for _, mo in pairs(dict) do
			table.insert(list, mo)
		end
	end

	table.sort(list, self.sortList)
	self:setList(list)

	if selectIndex then
		self:selectCell(selectIndex, true)
	end

	self._selectIndex = selectIndex
end

function V3a6YaMiHeroHandbookListModel.sortList(a, b)
	return a.id < b.id
end

function V3a6YaMiHeroHandbookListModel:selectCell(index, isSelect)
	V3a6YaMiHeroHandbookListModel.super.selectCell(self, index, isSelect)
	self:setSelectIndex(index)
end

function V3a6YaMiHeroHandbookListModel:getSelectMo()
	if self._selectIndex and self._selectIndex > 0 then
		return self:getByIndex(self._selectIndex)
	end
end

function V3a6YaMiHeroHandbookListModel:setSelectIndex(index)
	self._selectIndex = index
end

function V3a6YaMiHeroHandbookListModel:getSelectIndex()
	return self._selectIndex
end

V3a6YaMiHeroHandbookListModel.instance = V3a6YaMiHeroHandbookListModel.New()

return V3a6YaMiHeroHandbookListModel

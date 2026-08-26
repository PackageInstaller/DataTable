-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiHeroSkillListModel.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiHeroSkillListModel", package.seeall)

local V3a6YaMiHeroSkillListModel = class("V3a6YaMiHeroSkillListModel", ListScrollModel)

function V3a6YaMiHeroSkillListModel:setHandbookList(selectIndex)
	local heroList = V3a6YaMiModel.instance:getSelectHeros()
	local list = {}

	if heroList then
		for _, id in pairs(heroList) do
			local mo = V3a6YaMiModel.instance:getHeroMoById(id)

			table.insert(list, mo)
		end
	end

	self:setList(list)
	self:selectCell(selectIndex, true)
end

function V3a6YaMiHeroSkillListModel:selectCell(index, isSelect)
	V3a6YaMiHeroSkillListModel.super.selectCell(self, index, isSelect)
	self:setSelectIndex(index)
end

function V3a6YaMiHeroSkillListModel:getSelectMo()
	if self._selectIndex and self._selectIndex > 0 then
		return self:getByIndex(self._selectIndex)
	end
end

function V3a6YaMiHeroSkillListModel:setSelectIndex(index)
	self._selectIndex = index
end

function V3a6YaMiHeroSkillListModel:getSelectIndex()
	return self._selectIndex
end

V3a6YaMiHeroSkillListModel.instance = V3a6YaMiHeroSkillListModel.New()

return V3a6YaMiHeroSkillListModel

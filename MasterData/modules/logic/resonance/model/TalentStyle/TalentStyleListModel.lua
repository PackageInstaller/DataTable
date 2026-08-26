-- chunkname: @modules/logic/resonance/model/TalentStyle/TalentStyleListModel.lua

module("modules.logic.resonance.model.TalentStyle.TalentStyleListModel", package.seeall)

local TalentStyleListModel = class("TalentStyleListModel", ListScrollModel)

function TalentStyleListModel._sort(a, b)
	if a._isUnlock == b._isUnlock then
		if a._styleId == 0 then
			return false
		end

		if b._styleId == 0 then
			return true
		end

		return a._styleId < b._styleId
	end

	return a._isUnlock
end

function TalentStyleListModel:initData(heroId)
	local moList = TalentStyleModel.instance:getStyleMoList(heroId)

	table.sort(moList, self._sort)
	self:setList(moList)
end

function TalentStyleListModel:refreshData(heroId)
	local moList = TalentStyleModel.instance:refreshMoList(heroId, self:getList())

	self:setList(moList)
end

TalentStyleListModel.instance = TalentStyleListModel.New()

return TalentStyleListModel

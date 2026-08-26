-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_HandBookListModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_HandBookListModel", package.seeall)

local V3a2_BossRush_HandBookListModel = class("V3a2_BossRush_HandBookListModel", ListScrollModel)

function V3a2_BossRush_HandBookListModel:setMoList()
	local moList = {}

	for _, mo in pairs(V3a2_BossRushModel.instance:getHandBookGroupMos()) do
		table.sort(mo.bossGroup, self.sortBoss)
		table.insert(moList, mo)
	end

	table.sort(moList, self.sortGroup)

	local mo = moList[1].bossGroup[1]

	self:onSelect(mo)
	self:setList(moList)
end

function V3a2_BossRush_HandBookListModel.sortGroup(a, b)
	local a_sort = a.config.sort
	local b_sort = b.config.sort

	if a_sort ~= b_sort then
		return a_sort < b_sort
	end

	return a.config.mintype < b.config.mintype
end

function V3a2_BossRush_HandBookListModel.sortBoss(a, b)
	local a_sort = a.config.sort
	local b_sort = b.config.sort

	if a_sort ~= b_sort then
		return a_sort < b_sort
	end

	return a:getBossType() < b:getBossType()
end

function V3a2_BossRush_HandBookListModel:onSelect(mo)
	self._selectMo = mo

	BossRushController.instance:dispatchEvent(BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, mo)
end

function V3a2_BossRush_HandBookListModel:getSelectMo()
	return self._selectMo
end

V3a2_BossRush_HandBookListModel.instance = V3a2_BossRush_HandBookListModel.New()

return V3a2_BossRush_HandBookListModel

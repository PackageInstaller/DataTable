-- chunkname: @modules/logic/tower/model/TowerAssistBossTalentListModel.lua

module("modules.logic.tower.model.TowerAssistBossTalentListModel", package.seeall)

local TowerAssistBossTalentListModel = class("TowerAssistBossTalentListModel", ListScrollModel)

function TowerAssistBossTalentListModel:initBoss(bossId)
	self.bossId = bossId
	self.selectTalentId = nil
end

function TowerAssistBossTalentListModel:refreshList()
	if #self._scrollViews == 0 then
		return
	end

	local bossMo = TowerAssistBossModel.instance:getById(self.bossId)

	if not bossMo then
		return
	end

	local talentTree = bossMo:getTalentTree()
	local list = talentTree:getList()

	self:setList(list)
end

function TowerAssistBossTalentListModel:getSelectTalent()
	return self.selectTalentId
end

function TowerAssistBossTalentListModel:isSelectTalent(talentId)
	return self.selectTalentId == talentId
end

function TowerAssistBossTalentListModel:setSelectTalent(talentId)
	if self:isSelectTalent(talentId) then
		return
	end

	self.selectTalentId = talentId

	self:refreshList()
	TowerController.instance:dispatchEvent(TowerEvent.SelectTalentItem)
end

function TowerAssistBossTalentListModel:isTalentCanReset(talentId, showToast)
	talentId = talentId or self.selectTalentId

	if not talentId then
		return false
	end

	local bossMo = TowerAssistBossModel.instance:getById(self.bossId)

	if not bossMo:isActiveTalent(talentId) then
		return false
	end

	local talentTree = bossMo:getTalentTree()
	local node = talentTree:getNode(talentId)

	if not node then
		return false
	end

	if not node:isLeafNode() then
		return false
	end

	return true
end

function TowerAssistBossTalentListModel:setAutoTalentState(isAutoTalent)
	self.isAutoTalent = isAutoTalent
end

function TowerAssistBossTalentListModel:getAutoTalentState()
	return self.isAutoTalent
end

TowerAssistBossTalentListModel.instance = TowerAssistBossTalentListModel.New()

return TowerAssistBossTalentListModel

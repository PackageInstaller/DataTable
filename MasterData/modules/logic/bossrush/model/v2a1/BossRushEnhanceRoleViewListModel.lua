-- chunkname: @modules/logic/bossrush/model/v2a1/BossRushEnhanceRoleViewListModel.lua

module("modules.logic.bossrush.model.v2a1.BossRushEnhanceRoleViewListModel", package.seeall)

local BossRushEnhanceRoleViewListModel = class("BossRushEnhanceRoleViewListModel", ListScrollModel)

function BossRushEnhanceRoleViewListModel:setListData()
	local configs = BossRushConfig.instance:getActRoleEnhance()

	if configs then
		local moList = {}
		local firstHeroId = 0

		for _, co in pairs(configs) do
			local mo = {
				characterId = co.characterId,
				sort = co.sort
			}

			if co.sort == 1 then
				firstHeroId = co.characterId
			end

			table.insert(moList, mo)
		end

		table.sort(moList, self.sort)
		self:setList(moList)

		if firstHeroId ~= 0 then
			self:setSelect(firstHeroId)
		end
	end
end

function BossRushEnhanceRoleViewListModel.sort(a, b)
	return a.sort < b.sort
end

function BossRushEnhanceRoleViewListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectHeroId = nil
end

function BossRushEnhanceRoleViewListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.characterId == self._selectHeroId then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function BossRushEnhanceRoleViewListModel:setSelect(characterUid)
	self._selectHeroId = characterUid

	self:_refreshSelect()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnSelectEnhanceRole, characterUid)
end

function BossRushEnhanceRoleViewListModel:getSelectHeroId()
	return self._selectHeroId
end

BossRushEnhanceRoleViewListModel.instance = BossRushEnhanceRoleViewListModel.New()

return BossRushEnhanceRoleViewListModel

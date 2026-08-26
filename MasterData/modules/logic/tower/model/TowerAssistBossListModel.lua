-- chunkname: @modules/logic/tower/model/TowerAssistBossListModel.lua

module("modules.logic.tower.model.TowerAssistBossListModel", package.seeall)

local TowerAssistBossListModel = class("TowerAssistBossListModel", ListScrollModel)

function TowerAssistBossListModel:initList()
	self.isFirstRefresh = true
end

function TowerAssistBossListModel:refreshList(param)
	self.isFromHeroGroup = param and param.isFromHeroGroup
	self.bossId = param and param.bossId
	self.towerType = param and param.towerType
	self.towerId = param and param.towerId

	if param.otherParam then
		if self.isFromHeroGroup then
			if not param.otherParam then
				::label_2_0::

				do
					local mo = HeroGroupModel.instance:getCurGroupMO()

					self.bossId = mo:getAssistBossId()

					if TowerModel.instance:isBossBan(self.bossId) or TowerModel.instance:isLimitTowerBossBan(self.towerType, self.towerId, self.bossId) then
						self.bossId = 0
					end
				end

				if self.isFirstRefresh then
					local list = TowerConfig.instance:getAssistBossList()
					local dataList = {}

					if list then
						for i, v in ipairs(list) do
							if self:checkBossCanShow(v.bossId) then
								table.insert(dataList, self:buildBossData(v))
							end
						end
					end

					if #dataList > 1 then
						if self.isFromHeroGroup then
							table.sort(dataList, SortUtil.tableKeyLower({
								"isBanOrder",
								"isSelectOrder",
								"isLock",
								"bossId"
							}))
						else
							table.sort(dataList, SortUtil.tableKeyLower({
								"isLock",
								"bossId"
							}))
						end
					end

					self:setList(dataList)
				else
					local list = self:getList()

					for i, v in ipairs(list) do
						self:buildBossData(v.config, v)
					end

					local dataList = {}

					for i, v in ipairs(list) do
						if self:checkBossCanShow(v.bossId) then
							table.insert(dataList, v)
						end
					end

					self:setList(dataList)
				end
			end
		end

		self.isFirstRefresh = false
	end
end

function TowerAssistBossListModel:checkBossCanShow(bossId)
	if not TowerModel.instance:isBossOpen(bossId) then
		return false
	end

	if self.towerType and self.towerType == TowerEnum.TowerType.Limited then
		local limitedTimeCo = TowerConfig.instance:getTowerLimitedTimeCo(self.towerId)

		if limitedTimeCo then
			local bossIdList = string.splitToNumber(limitedTimeCo.bossPool, "#")

			for i, v in ipairs(bossIdList) do
				if v == bossId then
					return true
				end
			end
		end

		return false
	end

	return true
end

function TowerAssistBossListModel:buildBossData(config, data)
	data = data or {}
	data.id = config.bossId
	data.config = config
	data.bossId = config.bossId
	data.bossInfo = TowerAssistBossModel.instance:getById(config.bossId)
	data.isLock = (data.bossInfo == nil or data.bossInfo:getTempState()) and 1 or 0
	data.isFromHeroGroup = self.isFromHeroGroup

	if self.isFromHeroGroup then
		data.isSelect = self.bossId == config.bossId

		if self.isFirstRefresh then
			data.isSelectOrder = data.isSelect and 0 or 1
		end

		data.isBanOrder = TowerModel.instance:isBossBan(config.bossId) and 1 or 0
	end

	local openInfo = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Boss, config.towerId, TowerEnum.TowerStatus.Open)

	data.isTowerOpen = openInfo ~= nil

	return data
end

TowerAssistBossListModel.instance = TowerAssistBossListModel.New()

return TowerAssistBossListModel

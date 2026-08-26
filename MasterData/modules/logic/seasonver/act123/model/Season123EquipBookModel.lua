-- chunkname: @modules/logic/seasonver/act123/model/Season123EquipBookModel.lua

module("modules.logic.seasonver.act123.model.Season123EquipBookModel", package.seeall)

local Season123EquipBookModel = class("Season123EquipBookModel", ListScrollModel)

function Season123EquipBookModel:onInit()
	self:clear()
end

function Season123EquipBookModel:clear()
	Season123EquipBookModel.super.clear(self)

	self.equipItemList = {}
	self.curSelectItemId = nil
	self.curActId = nil
	self.tagModel = nil
	self._itemStartAnimTime = nil
	self.allItemMo = nil
	self.recordNew = nil
	self.allEquipItemMap = {}
	self.ColumnCount = 6
	self.AnimRowCount = 4
	self.OpenAnimTime = 0.06
	self.OpenAnimStartTime = 0.05
	self.selectStage = nil
	self.equipStageDict = nil
end

function Season123EquipBookModel:initDatas(activityId)
	self.curActId = activityId
	self.curSelectItemId = nil
	self.selectStage = nil

	self:initSubModel()
	self:initPlayerPrefs()
	self:initList()
end

function Season123EquipBookModel:initList()
	self:initConfig()
	self:initBackpack()

	if self:getCount() > 0 then
		self:setCurSelectItemId(self:getByIndex(1).id)
	end
end

function Season123EquipBookModel:initConfig()
	local stage = self:getSelectStage()

	if self.equipStageDict then
		local equipList = self.equipStageDict[stage]

		if not self.equipStageDict then
			self.equipStageDict = self.equipStageDict or {}

			local dict = {}
			local episodeList = Season123Config.instance:getSeasonEpisodeStageCos(self.curActId, stage)

			for _, episode in pairs(episodeList) do
				local isUnlock = Season123ProgressUtils.isEpisodeUnlock(self.curActId, stage, episode.layer)

				if isUnlock then
					local usableEquipList = string.splitToNumber(episode.usableEquip, "#")

					for _, equipId in ipairs(usableEquipList) do
						dict[equipId] = true
					end
				end
			end

			equipList = {}

			for equipId, _ in pairs(dict) do
				table.insert(self.equipStageDict, equipId)
			end

			self.equipStageDict[stage] = self.equipStageDict
		end

		local list = {}

		for _, itemId in pairs(self.equipStageDict) do
			local cfg = Season123Config.instance:getSeasonEquipCo(itemId)

			if not Season123EquipMetaUtils.isBanActivity(cfg, self.curActId) and self:isCardCanShowByTag(cfg.tag) then
				local equipBookMO = Season123EquipBookMO.New()

				equipBookMO:init(itemId)
				table.insert(list, equipBookMO)
			end
		end

		self:setList(list)
	end
end

function Season123EquipBookModel:initBackpack()
	self.allItemMo = Season123Model.instance:getAllItemMo(self.curActId) or {}

	for itemUid, itemMo in pairs(self.allItemMo) do
		local config = Season123Config.instance:getSeasonEquipCo(itemMo.itemId)

		if config then
			local equipBookMO = self:getById(itemMo.itemId)

			if equipBookMO then
				equipBookMO.count = equipBookMO.count + 1

				if not self.recordNew:contain(itemMo.itemId) then
					equipBookMO:setIsNew(true)
				end
			end
		end
	end

	self:sort(Season123EquipBookModel.sortItemMOList)
end

function Season123EquipBookModel:setCurSelectItemId(itemId)
	local selectItemMo = self:getById(itemId)

	if selectItemMo then
		self.curSelectItemId = itemId

		self.recordNew:add(itemId)
		selectItemMo:setIsNew(false)
	else
		self.curSelectItemId = nil
	end
end

function Season123EquipBookModel:initSubModel()
	self.tagModel = Season123EquipTagModel.New()

	self.tagModel:init(self.curActId)
end

function Season123EquipBookModel:initPlayerPrefs()
	self.recordNew = Season123EquipLocalRecord.New()

	self.recordNew:init(self.curActId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function Season123EquipBookModel:isCardCanShowByTag(itemTags)
	if self.tagModel then
		return self.tagModel:isCardNeedShow(itemTags)
	end

	return true
end

function Season123EquipBookModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	local curTime = Time.time

	if self._itemStartAnimTime == nil then
		self._itemStartAnimTime = curTime + self.OpenAnimStartTime
	end

	local index = self:getIndex(mo)

	if not index or index > self.AnimRowCount * self.ColumnCount then
		return -1
	end

	local delayTime = math.floor((index - 1) / self.ColumnCount) * self.OpenAnimTime + self.OpenAnimStartTime
	local passTime = curTime - self._itemStartAnimTime

	if passTime - delayTime > 0.1 then
		return -1
	else
		return delayTime
	end
end

function Season123EquipBookModel.sortItemMOList(a, b)
	local hasGainA = a.count > 0
	local hasGainB = b.count > 0

	if hasGainA ~= hasGainB then
		return hasGainA
	end

	local cfgA = Season123Config.instance:getSeasonEquipCo(a.id)
	local cfgB = Season123Config.instance:getSeasonEquipCo(b.id)

	if cfgA ~= nil and cfgB ~= nil then
		local isMainA = cfgA.isMain == Activity123Enum.isMainRole
		local isMainB = cfgB.isMain == Activity123Enum.isMainRole

		if isMainA ~= isMainB then
			return isMainA
		end

		if cfgA.rare ~= cfgB.rare then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.equipId > cfgB.equipId
		end
	else
		return a.id < b.id
	end
end

function Season123EquipBookModel:checkResetCurSelected()
	if self.curSelectItemId and not self:getById(self.curSelectItemId) then
		self.curSelectItemId = nil
	end
end

function Season123EquipBookModel:flushRecord()
	if self.recordNew then
		self.recordNew:recordAllItem()
	end
end

function Season123EquipBookModel:getEquipBookItemCount(itemId)
	local itemList = self:getList()

	for i = 1, #itemList do
		if itemList[i].id == itemId then
			return itemList[i].count
		end
	end

	return 0
end

function Season123EquipBookModel:refreshBackpack()
	self:initConfig()
	self:initBackpack()
end

function Season123EquipBookModel:removeDecomposeEquipItem(equipUids)
	self:initConfig()
	self:initBackpack()

	local selectItemMo = self:getById(self.curSelectItemId)

	if selectItemMo and selectItemMo.count == 0 then
		self:setCurSelectItemId(self:getByIndex(1).id)
	end
end

function Season123EquipBookModel:selectFirstCard()
	if self:getCount() > 0 then
		self:setCurSelectItemId(self:getByIndex(1).id)
	end
end

function Season123EquipBookModel:getAllEquipItem()
	self.allEquipItemMap = {}

	local cfgDict = Season123Config.instance:getSeasonEquipCos()

	for itemId, cfg in pairs(cfgDict) do
		if not Season123EquipMetaUtils.isBanActivity(cfg, self.curActId) then
			local equipBookMO = Season123EquipBookMO.New()

			equipBookMO:init(itemId)

			self.allEquipItemMap[itemId] = equipBookMO
		end
	end

	self.allItemMo = Season123Model.instance:getAllItemMo(self.curActId) or {}

	for itemUid, itemMo in pairs(self.allItemMo) do
		local config = Season123Config.instance:getSeasonEquipCo(itemMo.itemId)

		if config then
			local equipBookMO = self.allEquipItemMap[itemMo.itemId]

			if equipBookMO then
				equipBookMO.count = equipBookMO.count + 1
			end
		end
	end
end

function Season123EquipBookModel:setSelectStage(stage)
	local rs = Season123ProgressUtils.isStageUnlock(self.curActId, stage)

	if not rs then
		return
	end

	if stage == self.selectStage then
		return
	end

	self.selectStage = stage

	self:initList()

	return true
end

function Season123EquipBookModel:getSelectStage()
	local stage = self.selectStage

	if stage == nil then
		local stageList = Season123Config.instance:getStageCos(self.curActId)

		for i, v in ipairs(stageList) do
			local rs = Season123ProgressUtils.isStageUnlock(v.activityId, v.stage)

			if rs then
				stage = v.stage
				self.selectStage = v.stage

				break
			end
		end
	end

	return stage
end

Season123EquipBookModel.instance = Season123EquipBookModel.New()

return Season123EquipBookModel

-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaModel.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaModel", package.seeall)

local AiZiLaModel = class("AiZiLaModel", BaseModel)

function AiZiLaModel:onInit()
	self._epsiodeItemModelDict = {}

	self:_clearData()
end

function AiZiLaModel:reInit()
	self:_clearData()
end

function AiZiLaModel:clear()
	AiZiLaModel.super.clear(self)
	self:_clearData()
end

function AiZiLaModel:_clearData()
	self._curEpisodeId = 0
	self._curActivityId = VersionActivity1_5Enum.ActivityId.AiZiLa
	self._unlockEventIds = {}
	self._optionEventIds = {}
	self._selectEventIds = {}
	self._collectItemIds = {}

	self:_clearModel()
end

function AiZiLaModel:_clearModel()
	self._itemModel = self:_clearOrCreateModel(self._itemModel)
	self._equipModel = self:_clearOrCreateModel(self._equipModel)
	self._episodeModel = self:_clearOrCreateModel(self._episodeModel)
	self._epsiodeItemModelDict = self._epsiodeItemModelDict or {}

	for epsiodeId, tempModel in pairs(self._epsiodeItemModelDict) do
		tempModel:clear()
	end
end

function AiZiLaModel:_clearOrCreateModel(model)
	return AiZiLaHelper.clearOrCreateModel(model)
end

function AiZiLaModel:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function AiZiLaModel:getCurEpisodeId()
	return self._curEpisodeId
end

function AiZiLaModel:getCurActivityID()
	return self._curActivityId
end

function AiZiLaModel:isEpisodeClear(episodeId)
	return false
end

function AiZiLaModel:isEpisodeLock(episodeId)
	return self:getEpisodeMO(episodeId) == nil
end

function AiZiLaModel:getEquipMO(typeId)
	return self._equipModel:getById(typeId)
end

function AiZiLaModel:getEquipMOList()
	return self._equipModel:getList()
end

function AiZiLaModel:getEpisodeMO(episodeId)
	return self._episodeModel:getById(episodeId)
end

function AiZiLaModel:getRecordMOList()
	if not self._recordMOList then
		self._recordMOList = {}

		local cfgList = AiZiLaConfig.instance:getRecordEventList(VersionActivity1_5Enum.ActivityId.AiZiLa) or {}

		for i, cfg in ipairs(cfgList) do
			local recordMO = AiZiLaRecordMO.New()

			recordMO:init(cfg)
			table.insert(self._recordMOList, recordMO)
		end
	end

	return self._recordMOList
end

function AiZiLaModel:getHandbookMOList()
	if not self._handbookMOList then
		self._handbookMOList = {}

		local itemCoList = AiZiLaConfig.instance:getItemList() or {}

		for index, itemCo in ipairs(itemCoList) do
			local handbookMO = AiZiLaHandbookMO.New()

			handbookMO:init(itemCo.id)
			table.insert(self._handbookMOList, handbookMO)
		end
	end

	return self._handbookMOList
end

function AiZiLaModel:_updateIdDict(dict, ids)
	if ids and #ids > 0 then
		for i, id in ipairs(ids) do
			if dict[id] == nil then
				dict[id] = true
			end
		end
	end
end

function AiZiLaModel:_isHasIdDict(dict, id)
	if dict[id] then
		return true
	end

	return false
end

function AiZiLaModel:_updateMOModel(clsMO, model, moId, info)
	return AiZiLaHelper.updateMOModel(clsMO, model, moId, info)
end

function AiZiLaModel:_updateEpsiodeModel(episodeInfo)
	self:_updateMOModel(AiZiLaEpsiodeMO, self._episodeModel, episodeInfo.episodeId, episodeInfo)
end

function AiZiLaModel:_updateItemModel(itemInfo)
	return self:_updateMOModel(AiZiLaItemMO, self._itemModel, itemInfo.uid, itemInfo)
end

function AiZiLaModel:_updateEquipModel(equipId)
	local config = AiZiLaConfig.instance:getEquipCo(VersionActivity1_5Enum.ActivityId.AiZiLa, equipId)

	if not config then
		logError(string.format("[144_爱兹拉角色活动 export_装备] 找不到装备 id:%s", equipId))

		return self._equipModel
	end

	local mode = self:_updateMOModel(AiZiLaEquipMO, self._equipModel, config.typeId, equipId)

	self:_checkEquipUpLevelRed()

	return mode
end

function AiZiLaModel:getItemQuantity(itemId)
	local list = self._itemModel:getList()
	local quantity = 0

	for i, itemMO in ipairs(list) do
		if itemMO.itemId == itemId then
			quantity = quantity + itemMO.quantity
		end
	end

	return quantity
end

function AiZiLaModel:isSelectOptionId(optionId)
	return self:_isHasIdDict(self._optionEventIds, optionId)
end

function AiZiLaModel:isSelectEventId(eventId)
	return self:_isHasIdDict(self._selectEventIds, eventId)
end

function AiZiLaModel:isUnlockEventId(eventId)
	return self:_isHasIdDict(self._unlockEventIds, eventId)
end

function AiZiLaModel:isCollectItemId(itemId)
	return self:_isHasIdDict(self._collectItemIds, itemId)
end

function AiZiLaModel:getInfosReply(msg)
	local info = msg.Act144InfoNO

	self:_clearData()

	if not info.act144Episodes then
		for i, episodeInfo in ipairs(info.act144Episodes) do
			self:_updateEpsiodeModel(episodeInfo)
		end

		if not info.act144Items then
			for i, itemInfo in ipairs(info.act144Items) do
				self:_updateItemModel(itemInfo)
			end

			if not info.equipIds then
				for i, equipId in ipairs(info.equipIds) do
					self:_updateEquipModel(equipId)
				end

				self:_updateIdDict(self._optionEventIds, info.optionIds)
				self:_updateIdDict(self._unlockEventIds, info.unlockEventIds)
				self:_updateIdDict(self._selectEventIds, info.selectEventIds)
				self:_updateIdDict(self._collectItemIds, info.collectItemIds)
				self:checkItemRed()
				self:checkRecordRed()
			end
		end
	end
end

function AiZiLaModel:enterEpisodeReply(msg)
	return
end

function AiZiLaModel:selectOptionReply(msg)
	self:_updateIdDict(self._optionEventIds, msg.optionIds)
	self:_updateIdDict(self._unlockEventIds, msg.unlockEventIds)
	self:_updateIdDict(self._selectEventIds, msg.selectEventIds)
	self:checkRecordRed()
end

function AiZiLaModel:settleEpisodeReply(msg)
	return
end

function AiZiLaModel:settlePush(msg)
	self:_updateIdDict(self._collectItemIds, msg.collectItemIds)
	self:checkItemRed()
end

function AiZiLaModel:nextDayReply(msg)
	return
end

function AiZiLaModel:upgradeEquipReply(msg)
	self:_updateEquipModel(msg.newEquipId)
end

function AiZiLaModel:episodePush(msg)
	self:_updateEpsiodeModel(msg.act144Episode)
end

function AiZiLaModel:itemChangePush(msg)
	if not msg.deleteAct144Items then
		for i, itemInfo in ipairs(msg.deleteAct144Items) do
			self._itemModel:remove(self._itemModel:getById(itemInfo.uid))
		end

		if not msg.updateAct144Items then
			for i, itemInfo in ipairs(msg.updateAct144Items) do
				self:_updateItemModel(itemInfo)
			end

			self:_checkEquipUpLevelRed()
		end
	end
end

function AiZiLaModel:isHasEquipUpLevel()
	local equipMOList = self._equipModel:getList()

	for i, equipMO in ipairs(equipMOList) do
		if equipMO:isCanUpLevel() then
			return true
		end
	end

	return false
end

function AiZiLaModel:_checkEquipUpLevelRed()
	local redInfoList = {}

	table.insert(redInfoList, {
		id = RedDotEnum.DotNode.V1a5AiZiLaEquip,
		value = self:isHasEquipUpLevel() and 1 or 0
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redInfoList, true)
end

function AiZiLaModel:checkItemRed()
	local redInfoList = {}

	self:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaHandbookNew, self:getHandbookMOList(), RedDotEnum.DotNode.V1a5AiZiLaHandbook, redInfoList)
	RedDotRpc.instance:clientAddRedDotGroupList(redInfoList, true)
end

function AiZiLaModel:finishItemRed()
	local moList = self:getHandbookMOList()

	for i, mo in ipairs(moList) do
		if mo:isHasRed() then
			mo:finishRed()
		end
	end

	self:checkItemRed()
end

function AiZiLaModel:checkRecordRed()
	local redInfoList = {}
	local recordMOList = self:getRecordMOList()

	for i, recordMO in ipairs(recordMOList) do
		self:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaRecordEventNew, recordMO:getEventMOList(), nil, redInfoList)
	end

	self:_addRedMOList(RedDotEnum.DotNode.V1a5AiZiLaRecordNew, recordMOList, RedDotEnum.DotNode.V1a5AiZiLaRecord, redInfoList)
	RedDotRpc.instance:clientAddRedDotGroupList(redInfoList, true)
end

function AiZiLaModel:_addRedMOList(id, xRedMOList, parentId, addResInfoList)
	local redInfoList = addResInfoList or {}
	local hasRed = false

	for i, reMO in ipairs(xRedMOList) do
		local isHasRed = reMO:isHasRed()
		local uid = reMO:getRedUid()

		if isHasRed then
			hasRed = true
		end

		table.insert(redInfoList, {
			id = id,
			uid = uid,
			value = isHasRed and 1 or 0
		})
	end

	if parentId then
		table.insert(redInfoList, {
			id = parentId,
			value = hasRed and 1 or 0
		})
	end

	return redInfoList
end

AiZiLaModel.instance = AiZiLaModel.New()

return AiZiLaModel

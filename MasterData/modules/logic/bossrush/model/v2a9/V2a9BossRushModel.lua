-- chunkname: @modules/logic/bossrush/model/v2a9/V2a9BossRushModel.lua

module("modules.logic.bossrush.model.v2a9.V2a9BossRushModel", package.seeall)

local V2a9BossRushModel = class("V2a9BossRushModel", BaseModel)

function V2a9BossRushModel:isV2a9BossRush()
	return BossRushConfig.instance:getActivityId() == VersionActivity2_9Enum.ActivityId.BossRush
end

function V2a9BossRushModel:onRefresh128InfosReply(msg)
	self._equipMos = {}
	self._spHighestPoint = self._spHighestPoint or {}

	for j = 1, #msg.bossDetail do
		local bossDetail = msg.bossDetail[j]
		local stage = bossDetail.bossId

		self._equipMos[stage] = self._equipMos[stage] or {}
		self._spHighestPoint[stage] = self._spHighestPoint[stage] or {}

		if not bossDetail.spItemTypeIds then
			local spItemIds = {}
			local maxCount = self:getMaxEquipCount()

			for i = 1, BossRushEnum.V2a9FightEquipSkillMaxCount do
				local itemType = spItemIds[i]
				local mo = V2a9BossRushAssassinEquipMO.New()
				local isLock = maxCount < i

				mo:init(i, itemType, isLock)
				table.insert(self._equipMos[stage], mo)
			end

			self._spHighestPoint[stage] = bossDetail.spHighestPoint
		end
	end
end

function V2a9BossRushModel:getHighestPoint(stage)
	return self._spHighestPoint[stage] or 0
end

function V2a9BossRushModel:isV2a9BossRushSecondStageSpecialLayer(episodeType, episodeId)
	if episodeType == DungeonEnum.EpisodeType.BossRush then
		local bossrushCo = BossRushConfig.instance:getEpisodeCoByEpisodeId(episodeId)

		if bossrushCo and self:isV2a9SecondStageSpecialLayer(bossrushCo.stage, bossrushCo.layer) then
			return true
		end
	end
end

function V2a9BossRushModel:isV2a9SecondStageSpecialLayer(stage, layer)
	return stage == BossRushEnum.V2a9StageEnum.Second and layer == BossRushEnum.LayerEnum.V2a9
end

function V2a9BossRushModel:getMaxEquipCount()
	local constCo = lua_activity128_const.configDict[BossRushEnum.V2a9FightCanEquipSkillCountConst]
	local canEquipMaxCount = constCo and constCo.value1

	return canEquipMaxCount or 4
end

function V2a9BossRushModel:getAllEquipMos(stage)
	return self._equipMos and self._equipMos[stage]
end

function V2a9BossRushModel:selectSpItemId(id)
	self._selectItemId = id
end

function V2a9BossRushModel:getSelectedItemId()
	return self._selectItemId
end

function V2a9BossRushModel:getItemIdByItemType(itemType)
	self._itemTypeDict = self._itemTypeDict or {}

	local id = self._itemTypeDict[itemType]

	if id then
		return id
	end

	return (AssassinConfig.instance:getAssassinItemId(itemType, 2))
end

function V2a9BossRushModel:isEquip(stage, id)
	local index = self:getEquipIndex(stage, id)

	return index ~= nil
end

function V2a9BossRushModel:getEquipIndex(stage, id)
	local equipMos = self:getAllEquipMos(stage)

	if not equipMos then
		return
	end

	local itemType = AssassinConfig.instance:getAssassinItemType(id)

	for _, mo in ipairs(equipMos) do
		if mo:getItemType() == itemType then
			return mo:getIndex()
		end
	end
end

function V2a9BossRushModel:isFullEquip(stage)
	local equipMos = self:getAllEquipMos(stage)

	if not equipMos then
		return
	end

	for i = 1, self:getMaxEquipCount() do
		local mo = equipMos[i]

		if mo and not mo:isEquip() then
			return false
		end
	end

	return true
end

function V2a9BossRushModel:changeEquippedSelectItem(stage, callback, callbackobj)
	local equipMos = self:getAllEquipMos(stage)

	if not equipMos then
		return
	end

	local id = self:getSelectedItemId()
	local itemType = AssassinConfig.instance:getAssassinItemType(id)
	local itemIds = {}
	local equipIndex = self:getEquipIndex(stage, id)

	if equipIndex then
		local mo = equipMos[equipIndex]

		if mo then
			mo:setEquipItemType()
		end
	else
		local index = self:_getNullIndex(equipMos)

		if index then
			local mo = equipMos[index]

			if mo then
				mo:setEquipItemType(itemType)
			end
		else
			logError("没位置了，应该改变按钮状态")
		end
	end

	for _, mo in ipairs(equipMos) do
		local itemType = mo:getItemType()

		if mo:isEquip() then
			table.insert(itemIds, itemType)
		end
	end

	local actId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.instance:sendAct128SpFirstHalfSelectItemRequest(actId, stage, itemIds, callback, callbackobj)
end

function V2a9BossRushModel:_getNullIndex(equipMos)
	if not equipMos then
		return
	end

	for i, mo in ipairs(equipMos) do
		if not mo:isEquip() then
			return i
		end
	end
end

function V2a9BossRushModel:onReceiveAct128SpFirstHalfSelectItemReply(msg)
	if not msg.itemTypeIds then
		local spItemIds = {}
		local stage = msg.bossId

		if self._equipMos and self._equipMos[stage] then
			for i, mo in ipairs(self._equipMos[stage]) do
				local itemType = spItemIds[i]

				mo:setEquipItemType(itemType)
			end
		end
	end
end

function V2a9BossRushModel:getUnlockEpisodeDisplay(stage, episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterId = episodeCo and episodeCo.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actCo = ActivityConfig.instance:getActivityCo(chapterCo and chapterCo.actId)
	local episodeDisplay

	if stage == 1 then
		episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(episodeId)
	else
		local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

		table.sort(episodeCoList, function(a, b)
			return a.id < b.id
		end)

		local index = self:_getEpisodeIndex(chapterId, episodeId)

		if index then
			local chapterIndex = chapterCo.chapterIndex

			episodeDisplay = string.format("%s-%s%s", chapterIndex, index, episodeCo.name)
		end
	end

	return actCo and actCo.name, episodeDisplay
end

function V2a9BossRushModel:_getEpisodeIndex(chapterId, episodeId)
	local episodeCoList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)

	table.sort(episodeCoList, function(a, b)
		if SLFramework.FrameworkSettings.IsEditor then
			local aMap = {}

			if SLFramework.FrameworkSettings.IsEditor then
				local bMap = {}
				local aIndex = DungeonConfig.instance:_getEpisodeIndex(a, aMap)
				local bIndex = DungeonConfig.instance:_getEpisodeIndex(b, bMap)

				if aIndex ~= bIndex then
					return aIndex < bIndex
				end

				return a.id < b.id
			end
		end
	end)

	for i, episodeCoList in ipairs(episodeCoList) do
		if episodeCoList.id == episodeId then
			return i
		end
	end
end

V2a9BossRushModel.instance = V2a9BossRushModel.New()

return V2a9BossRushModel

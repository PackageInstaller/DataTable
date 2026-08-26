-- chunkname: @modules/logic/fight/model/FightResultModel.lua

module("modules.logic.fight.model.FightResultModel", package.seeall)

local FightResultModel = class("FightResultModel", ListScrollModel)

function FightResultModel:onEndDungeonPush(msg)
	self.chapterId = msg.chapterId
	self.episodeId = msg.episodeId
	self.playerExp = msg.playerExp
	self.star = msg.star
	self.firstPass = msg.firstPass
	self._materialDataList = {}

	self:_initFirstBonus(msg)
	self:_initNormalBonus(msg)
	FightResultModel._addMaterialDatasToList(msg.advencedBonus, self._materialDataList, FightEnum.FightBonusTag.AdvencedBonus)
	self:_initAdditionBonus(msg)
	self:_initTimeFirstBonus(msg)
	self:_initCommonDropBonus(msg)
	self:_addExp(msg.firstBonus)
	self:_addExp(msg.normalBonus)
	self:_addExp(msg.advencedBonus)
	self:_addExp(msg.additionBonus)
	self:_addExp(msg.timeFirstBonus)
	table.sort(self._materialDataList, FightResultModel._sortMaterial)
	self:_setLastEpisodePass()

	self.updateDungeonRecord = msg.updateDungeonRecord
	self.canUpdateDungeonRecord = msg.canUpdateDungeonRecord
	self.oldRecordRound = msg.oldRecordRound
	self.newRecordRound = msg.newRecordRound
	self.assistUserId = msg.assistUserId
	self.assistNickname = msg.assistNickname
	self.totalRound = msg.totalRound
	self.extraStr = msg.extraStr

	if BossRushController.instance:isInBossRushFight(true) then
		BossRushModel.instance:onEndDungeonExtraStr(msg.extraStr)
	end
end

function FightResultModel:_initCommonDropBonus(msg)
	self.act155BonusList = {}
	self.act153BonusList = {}
	self.act217BonusList = {}
	self.normal2SimpleList = {}

	for _, dropBonus in ipairs(msg.dropBonus) do
		local dropType = dropBonus.type

		if dropType == FightEnum.DropType.Act155 or dropType == FightEnum.DropType.Act158 then
			for _, bonus in ipairs(dropBonus.bonus) do
				if bonus.materilType ~= MaterialEnum.MaterialType.Faith and bonus.materilType ~= MaterialEnum.MaterialType.Exp then
					local materialDataMO = MaterialDataMO.New()

					materialDataMO.bonusTag = FightEnum.FightBonusTag.ActBonus

					materialDataMO:init(bonus)
					table.insert(self.act155BonusList, materialDataMO)
				end
			end
		elseif dropType == FightEnum.DropType.Act153 then
			for _, bonus in ipairs(dropBonus.bonus) do
				if bonus.materilType ~= MaterialEnum.MaterialType.Faith and bonus.materilType ~= MaterialEnum.MaterialType.Exp then
					local materialDataMO = MaterialDataMO.New()

					materialDataMO.bonusTag = FightEnum.FightBonusTag.AdditionBonus

					materialDataMO:init(bonus)
					table.insert(self.act153BonusList, materialDataMO)
				end
			end

			table.sort(self.act153BonusList, FightResultModel._sortMaterial)
		elseif dropType == FightEnum.DropType.Act217 then
			for _, bonus in ipairs(dropBonus.bonus) do
				if bonus.materilType ~= MaterialEnum.MaterialType.Faith and bonus.materilType ~= MaterialEnum.MaterialType.Exp then
					local materialDataMO = MaterialDataMO.New()

					materialDataMO.bonusTag = FightEnum.FightBonusTag.AdditionBonus

					materialDataMO:init(bonus)
					table.insert(self.act217BonusList, materialDataMO)
				end
			end

			table.sort(self.act217BonusList, FightResultModel._sortMaterial)
		elseif dropType == FightEnum.DropType.Normal2Simple then
			for _, bonus in ipairs(dropBonus.bonus) do
				if bonus.materilType ~= MaterialEnum.MaterialType.Faith and bonus.materilType ~= MaterialEnum.MaterialType.Exp then
					local materialDataMO = MaterialDataMO.New()

					materialDataMO.bonusTag = FightEnum.FightBonusTag.SimpleBouns

					materialDataMO:init(bonus)
					table.insert(self.normal2SimpleList, materialDataMO)
				end
			end
		end
	end
end

function FightResultModel:_initFirstBonus(msg)
	self._firstList = {}

	FightResultModel._addMaterialDatasToList(msg.firstBonus, self._firstList, FightEnum.FightBonusTag.FirstBonus)
	table.sort(self._firstList, FightResultModel._sortMaterial)
end

function FightResultModel:_initAdditionBonus(msg)
	self._additionList = {}

	FightResultModel._addMaterialDatasToList(msg.additionBonus, self._additionList, FightEnum.FightBonusTag.AdditionBonus)
	table.sort(self._additionList, FightResultModel._sortMaterial)
end

function FightResultModel:_initTimeFirstBonus(msg)
	self._timeFirstList = {}

	FightResultModel._addMaterialDatasToList(msg.timeFirstBonus, self._timeFirstList, FightEnum.FightBonusTag.TimeFirstBonus)
	table.sort(self._timeFirstList, FightResultModel._sortMaterial)
end

function FightResultModel:_initNormalBonus(msg)
	self._extraList = nil

	if not FightModel.instance:isEnterUseFreeLimit() then
		FightResultModel._addMaterialDatasToList(msg.normalBonus, self._materialDataList, FightEnum.FightBonusTag.NormalBonus)

		return
	end

	local normalList = {}

	FightResultModel._addMaterialDatasToList(msg.normalBonus, normalList, FightEnum.FightBonusTag.NormalBonus)

	local extraList = {}

	table.sort(normalList, FightResultModel._sortMaterial)

	for k, v in pairs(normalList) do
		if #extraList < 3 and (v.materilType == MaterialEnum.MaterialType.Currency or v.materilType == MaterialEnum.MaterialType.Equip) then
			table.insert(extraList, v)
		else
			table.insert(self._materialDataList, v)
		end
	end

	self._extraList = extraList
end

function FightResultModel:clear()
	FightResultModel.super.clear(self)

	self.chapterId = nil
	self.episodeId = nil
	self.playerExp = nil
	self.star = nil
	self._firstList = nil
	self._extraList = nil
	self._materialDataList = nil
	self._additionList = nil
	self._timeFirstList = nil
	self.updateDungeonRecord = nil
	self.curSendEpisodePass = nil
	self.extraStr = nil
end

function FightResultModel:getChapterId()
	return self.chapterId or DungeonModel.instance.curSendChapterId
end

function FightResultModel:getEpisodeId()
	return self.episodeId or DungeonModel.instance.curSendEpisodeId
end

function FightResultModel:getPlayerExp()
	return self.playerExp or 0
end

function FightResultModel:getMaterialDataList()
	return self._materialDataList
end

function FightResultModel:getExtraMaterialDataList()
	return self._extraList
end

function FightResultModel:getFirstMaterialDataList()
	return self._firstList
end

function FightResultModel:getAdditionMaterialDataList()
	return self._additionList
end

function FightResultModel:getTimeFirstMaterialDataList()
	return self._timeFirstList
end

function FightResultModel:getAct155MaterialDataList()
	return self.act155BonusList
end

function FightResultModel:getAct153MaterialDataList()
	return self.act153BonusList
end

function FightResultModel:getAct217MaterialDataList()
	return self.act217BonusList
end

function FightResultModel:getExtraStr()
	return self.extraStr
end

function FightResultModel:_addExp(materialDataList)
	for _, bonus in ipairs(materialDataList) do
		if bonus.materilType == MaterialEnum.MaterialType.Exp then
			self.playerExp = self.playerExp + bonus.quantity
		end
	end
end

function FightResultModel:_setLastEpisodePass()
	local sendEpisodeId = DungeonModel.instance.curSendEpisodeId

	if sendEpisodeId then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(sendEpisodeId)

		if self.episodeId == sendEpisodeId or episodeCo and self.episodeId == episodeCo.chainEpisode then
			DungeonModel.instance.curSendEpisodePass = not DungeonModel.instance.curSendEpisodePrePass and self.star > 0

			return
		end
	end

	self.curSendEpisodePass = false
end

function FightResultModel._addMaterialDatasToList(materialDataList, toList, bonusTag)
	for _, bonus in ipairs(materialDataList) do
		if bonus.materilType ~= MaterialEnum.MaterialType.Faith and bonus.materilType ~= MaterialEnum.MaterialType.Exp then
			local materialDataMO = MaterialDataMO.New()

			materialDataMO.bonusTag = bonusTag

			materialDataMO:init(bonus)
			table.insert(toList, materialDataMO)
		end
	end
end

function FightResultModel._sortMaterial(xMaterialDataMO, yMaterialDataMO)
	local xConfig = ItemModel.instance:getItemConfig(xMaterialDataMO.materilType, xMaterialDataMO.materilId)
	local yConfig = ItemModel.instance:getItemConfig(yMaterialDataMO.materilType, yMaterialDataMO.materilId)
	local result = FightResultModel._sortMaterialByBonusTag(xMaterialDataMO, yMaterialDataMO)

	if result == nil then
		result = FightResultModel._sortMaterialByRare(xConfig, yConfig)
	end

	if result == nil then
		result = FightResultModel._sortMaterialByType(xMaterialDataMO, yMaterialDataMO)
	end

	if result == nil then
		result = xMaterialDataMO.materilId < yMaterialDataMO.materilId
	end

	return result
end

function FightResultModel._sortMaterialByBonusTag(xMaterialDataMO, yMaterialDataMO)
	if not FightEnum.FightBonusTagPriority[xMaterialDataMO.bonusTag] then
		local xBonusScore = 0

		if not FightEnum.FightBonusTagPriority[yMaterialDataMO.bonusTag] then
			local yBonusScore = 0

			if xBonusScore == yBonusScore then
				return nil
			end

			return yBonusScore < xBonusScore
		end
	end
end

function FightResultModel._sortMaterialByRare(xConfig, yConfig)
	if xConfig then
		if not xConfig.rare then
			local xRare = 0

			if yConfig then
				if not yConfig.rare then
					local yRare = 0

					if xRare == yRare then
						return nil
					end

					return yRare < xRare
				end
			end
		end
	end
end

function FightResultModel._sortMaterialByType(xMaterialDataMO, yMaterialDataMO)
	FightResultModel.MaterialTypePriority = FightResultModel.MaterialTypePriority or {
		[MaterialEnum.MaterialType.Item] = 1,
		[MaterialEnum.MaterialType.Currency] = 5,
		[MaterialEnum.MaterialType.Hero] = 4,
		[MaterialEnum.MaterialType.Equip] = 3,
		[MaterialEnum.MaterialType.PowerPotion] = 2
	}

	if not FightResultModel.MaterialTypePriority[xMaterialDataMO.materilType] then
		local xTypeScore = 0

		if not FightResultModel.MaterialTypePriority[yMaterialDataMO.materilType] then
			local yTypeScore = 0

			if xTypeScore == yTypeScore then
				return nil
			end

			return yTypeScore < xTypeScore
		end
	end
end

function FightResultModel:getNormal2SimpleMaterialDataList()
	return self.normal2SimpleList
end

FightResultModel.instance = FightResultModel.New()

return FightResultModel

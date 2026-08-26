-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyModel", package.seeall)

local OdysseyModel = class("OdysseyModel", BaseModel)

function OdysseyModel:onInit()
	self:reInit()
end

function OdysseyModel:reInit()
	self:initPropInfoData()
	self:initFightInfoData()
	self:clearResultInfo()
end

function OdysseyModel:onReceiveOdysseyGetInfoReply(info, isPush)
	self:setPropInfo(info.propInfo, isPush)
	OdysseyDungeonModel.instance:updateMapInfo(info.mapInfo)
	OdysseyItemModel.instance:updateBagInfo(info.bagInfo)
	OdysseyTalentModel.instance:updateTalentInfo(info.talentInfo)
	OdysseyHeroGroupModel.instance:updateFormInfo(info.formInfo.currForm)
	self:setFightInfo(info.fightInfo)
end

function OdysseyModel:initPropInfoData()
	self.heroOldExp = 0
	self.heroCurExp = 0
	self.heroCurLevel = 0
	self.heroOldLevel = 0
end

function OdysseyModel:setPropInfo(info, isPush)
	self.heroCurLevel = info.level
	self.heroCurExp = info.exp
	self.parasm = info.parasm

	if not isPush and (not self.heroOldLevel or self.heroOldLevel == 0) then
		self:updateHeroOldLevel(self.heroCurLevel, self.heroCurExp)
	end

	OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshHeroInfo)
end

function OdysseyModel:updateHeroLevel(info)
	self.heroCurLevel = info.newLevel
	self.heroCurExp = info.newExp

	if info.reason ~= OdysseyEnum.Reason.ConquestFightReward and info.reason ~= OdysseyEnum.Reason.MythicFightReward then
		self:updateHeroOldLevel(info.oldLevel, info.oldExp)
	end
end

function OdysseyModel:updateHeroOldLevel(level, exp)
	self.heroOldLevel = level
	self.heroOldExp = exp
end

function OdysseyModel:getHeroCurLevelAndExp()
	return self.heroCurLevel, self.heroCurExp
end

function OdysseyModel:getHeroOldLevelAndExp()
	return self.heroOldLevel, self.heroOldExp
end

function OdysseyModel:getHeroAddExp()
	local addExp = 0

	if self.heroOldLevel ~= self.heroCurLevel then
		for level = self.heroOldLevel, self.heroCurLevel do
			local levelConfig = OdysseyConfig.instance:getLevelConfig(level)

			if level == self.heroOldLevel and level < self.heroCurLevel then
				addExp = levelConfig.needExp - self.heroOldExp
			elseif level > self.heroOldLevel and level < self.heroCurLevel then
				addExp = addExp + levelConfig.needExp
			elseif level == self.heroCurLevel then
				addExp = addExp + self.heroCurExp
			end
		end
	elseif self.heroOldExp ~= self.heroCurExp then
		addExp = self.heroCurExp - self.heroOldExp
	end

	return addExp
end

function OdysseyModel:initFightInfoData()
	self.mercenarySuitMap = {}
	self.mercenaryNextRefreshTime = 0
	self.religionMemberMap = {}
end

function OdysseyModel:setFightInfo(info)
	if not info.mercenaryInfo then
		return
	end

	self:setMercenaryInfo(info.mercenaryInfo)
	self:setAllReligionInfo(info.religionInfo)
end

function OdysseyModel:setMercenaryInfo(mercenaryInfo)
	self:updateMercenaryNextRefreshTime(mercenaryInfo.nextRefTime)

	for _, suitInfo in ipairs(mercenaryInfo.suits) do
		self.mercenarySuitMap[suitInfo.type] = suitInfo.suitId
	end
end

function OdysseyModel:updateMercenaryNextRefreshTime(nextRefreshTime)
	self.mercenaryNextRefreshTime = tonumber(nextRefreshTime) or 0
end

function OdysseyModel:getRemainMercenaryRefreshTime()
	return Mathf.Max(0, self.mercenaryNextRefreshTime / 1000 - ServerTime.now())
end

function OdysseyModel:getMercenaryNextRefreshTime()
	return self.mercenaryNextRefreshTime
end

function OdysseyModel:getMercenaryTypeSuit(mercenaryType)
	local suitConstId = OdysseyEnum.MercenaryTypeToSuit[mercenaryType]
	local suitConstConfig = OdysseyConfig.instance:getConstConfig(suitConstId)
	local suitIdList = string.splitToNumber(suitConstConfig.value, "#")
	local defaultSuit = suitIdList[1]

	return self.mercenarySuitMap[mercenaryType] or defaultSuit
end

function OdysseyModel:updateMercenaryTypeSuit(mercenaryType, suitId)
	self.mercenarySuitMap[mercenaryType] = suitId
end

function OdysseyModel:setAllReligionInfo(religionInfo)
	if religionInfo then
		for _, memberInfo in ipairs(religionInfo.members) do
			self:setReligionInfo(memberInfo)
		end
	end
end

function OdysseyModel:setReligionInfo(memberInfo)
	local memberMo = {}

	memberMo.religionId = memberInfo.religionId
	memberMo.status = memberInfo.status
	self.religionMemberMap[memberInfo.religionId] = memberMo
end

function OdysseyModel:getReligionInfoData(religionId)
	return self.religionMemberMap[religionId]
end

function OdysseyModel:setFightResultInfo(info)
	self._resultMo = OdysseyResultMo.New()

	self._resultMo:init(info)
end

function OdysseyModel:getFightResultInfo()
	return self._resultMo
end

function OdysseyModel:clearResultInfo()
	self._resultMo = nil
end

OdysseyModel.instance = OdysseyModel.New()

return OdysseyModel

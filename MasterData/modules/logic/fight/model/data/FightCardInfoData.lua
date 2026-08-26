-- chunkname: @modules/logic/fight/model/data/FightCardInfoData.lua

module("modules.logic.fight.model.data.FightCardInfoData", package.seeall)

local FightCardInfoData = FightDataClass("FightCardInfoData")

function FightCardInfoData:onConstructor(proto)
	self:initClientData()

	self.uid = proto.uid
	self.skillId = proto.skillId
	self.cardEffect = proto.cardEffect or 0
	self.tempCard = proto.tempCard or false
	self.enchants = {}

	if proto.enchants then
		for i, v in ipairs(proto.enchants) do
			local tab = FightCardEnchantData.New(v)

			table.insert(self.enchants, tab)
		end
	end

	self.cardType = proto.cardType or FightEnum.CardType.NONE
	self.heroId = proto.heroId or 0
	self.status = proto.status or FightEnum.CardInfoStatus.STATUS_NONE
	self.targetUid = proto.targetUid or "0"
	self.energy = proto.energy or 0
	self.areaRedOrBlue = proto.areaRedOrBlue
	self.heatId = proto.heatId or 0

	if proto.musicNote then
		self.musicNote = FightRouge2MusicNote.New(proto.musicNote)
	end

	self.extraInfos = {}
	self.extraInfoDict = {}

	if proto.extraInfos then
		for _, extraInfo in ipairs(proto.extraInfos) do
			local mo = FightCardExtraInfoData.New(extraInfo)

			table.insert(self.extraInfos, mo)

			self.extraInfoDict[mo.key] = mo
		end
	end

	self.cardDataes = {}
	self.cardDataDict = {}

	if proto.cardDataes then
		for _, cardData in ipairs(proto.cardDataes) do
			local mo = FightCardInfo_CardData.New(cardData)

			table.insert(self.cardDataes, mo)

			self.cardDataDict[mo.key] = mo
		end
	end
end

function FightCardInfoData:initClientData()
	local clientData = FightClientData.New()

	clientData.custom_lock = nil
	clientData.custom_enemyCardIndex = nil
	clientData.custom_playedCard = nil
	clientData.custom_handCardIndex = nil
	clientData.custom_color = FightEnum.CardColor.None
	clientData.custom_fromSkillId = 0
	clientData.custom_addFromRefrigerator = nil
	clientData.custom_addToRefrigerator = nil
	self.clientData = clientData
end

function FightCardInfoData:isBigSkill()
	return FightCardDataHelper.isBigSkill(self.skillId)
end

function FightCardInfoData:clone()
	return FightDataUtil.copyData(self)
end

function FightCardInfoData:getCardData(key)
	return key and self.cardDataDict[key]
end

function FightCardInfoData:checkHasExtraInfo(key)
	return key and self.extraInfoDict[key] ~= nil
end

function FightCardInfoData:checkIsUnnamedCard()
	return self:getCardData(FightCardInfo_CardData.CardDataKey.Unnamed) ~= nil
end

local DeviceMoTemplate = {
	uid = "0",
	skillId = 0,
	cardType = FightEnum.CardType.DEVICE
}

function FightCardInfoData.getTempDeviceCard()
	FightCardInfoData.tempDeviceCardMo = FightCardInfoData.tempDeviceCardMo or FightCardInfoData.New(DeviceMoTemplate)

	return FightCardInfoData.tempDeviceCardMo
end

return FightCardInfoData

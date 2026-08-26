-- chunkname: @modules/logic/fight/model/mo/FightCardInfoMO.lua

module("modules.logic.fight.model.mo.FightCardInfoMO", package.seeall)

local FightCardInfoMO = pureTable("FightCardInfoMO")

function FightCardInfoMO:ctor()
	self.custom_lock = nil
	self.custom_enemyCardIndex = nil
	self.custom_playedCard = nil
	self.custom_handCardIndex = nil
	self.custom_color = FightEnum.CardColor.None
	self.custom_fromSkillId = 0
end

function FightCardInfoMO:init(info)
	self.uid = info.uid
	self.skillId = info.skillId
	self.cardEffect = info.cardEffect or 0
	self.tempCard = info.tempCard or false
	self.enchants = {}

	if info.enchants then
		for i, v in ipairs(info.enchants) do
			local tab = {}

			tab.enchantId = v.enchantId
			tab.duration = v.duration
			tab.exInfo = {}

			for index, value in ipairs(v.exInfo) do
				table.insert(tab.exInfo, value)
			end

			table.insert(self.enchants, tab)
		end
	end

	self.cardType = info.cardType or FightEnum.CardType.NONE
	self.heroId = info.heroId or 0
	self.status = info.status or FightEnum.CardInfoStatus.STATUS_NONE
	self.targetUid = info.targetUid or "0"
	self.energy = info.energy or 0
	self.areaRedOrBlue = info.areaRedOrBlue
	self.heatId = info.heatId or 0
end

function FightCardInfoMO:isBigSkill()
	return FightCardDataHelper.isBigSkill(self.skillId)
end

function FightCardInfoMO:clone()
	local ret = FightCardInfoMO.New()

	ret:init(self)

	return ret
end

return FightCardInfoMO

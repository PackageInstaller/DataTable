-- chunkname: @modules/logic/fight/model/mo/FightCardMO.lua

module("modules.logic.fight.model.mo.FightCardMO", package.seeall)

local FightCardMO = pureTable("FightCardMO")

function FightCardMO:ctor()
	self.cardGroup = {}
	self.actPoint = 0
	self.moveNum = 0
	self.dealCardGroup = {}
	self.beforeCards = {}
	self.extraMoveAct = 0
	self.playCanAddExpoint = nil
	self.combineCanAddExpoint = nil
	self.moveCanAddExpoint = nil
end

function FightCardMO:init(info)
	self.cardGroup = self:_buildCards(info.cardGroup)
	self.actPoint = info.actPoint
	self.moveNum = info.moveNum
	self.dealCardGroup = self:_buildCards(info.dealCardGroup)
	self.beforeCards = self:_buildCards(info.beforeCards)
	self.extraMoveAct = info.extraMoveAct
end

function FightCardMO:setExtraMoveAct(num)
	self.extraMoveAct = num
end

function FightCardMO:setCards(cards)
	self.cardGroup = cards
end

function FightCardMO:reset()
	self.cardGroup = {}
	self.actPoint = 0
	self.moveNum = 0
end

function FightCardMO:_buildCards(cardGroup)
	local res = {}

	for _, cardInfo in ipairs(cardGroup) do
		local fightCardInfoMO = FightCardInfoMO.New()

		fightCardInfoMO:init(cardInfo)
		table.insert(res, fightCardInfoMO)
	end

	return res
end

function FightCardMO:isUnlimitMoveCard()
	return self.extraMoveAct == -1
end

return FightCardMO

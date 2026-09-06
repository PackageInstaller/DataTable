-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/data/GdcCardBagMgr.lua

module("logic.extensions.goddesscontest.data.GdcCardBagMgr", package.seeall)

local GdcCardBagMgr = class("GdcCardBagMgr")

function GdcCardBagMgr:ctor(activityId)
	self._activityId = activityId
	self._cardPool = {}
	self._emptyCardMo = GdcCardMo.New()
end

function GdcCardBagMgr:onReset()
	self:onResetCard()
end

function GdcCardBagMgr:onResetCard()
	table.clear(self._cardPool)

	local stepCfg = GoddessContestConfig.instance:getCardStepCfg(self._activityId) or {}

	for _, stepData in ipairs(stepCfg) do
		local stepId = stepData.stepId
		local cardCfg = GoddessContestConfig.instance:getCardCfg(self._activityId, stepId) or {}

		self._cardPool[stepId] = {}

		for _, cardData in ipairs(cardCfg) do
			local cardId = cardData.cardId
			local mo = GdcCardMo.New()

			mo.cardId = cardId

			if cardData.isRandomCard then
				mo:setCardType(GdcCardEnum.CardType_Random)
				mo:setIsShowValue(false)
			else
				mo:setCardType(GdcCardEnum.CardType_Normal)
				mo:setIsShowValue(true)
			end

			mo:setValue(cardData.cardShowNum)

			self._cardPool[stepId][cardId] = mo
		end
	end
end

function GdcCardBagMgr:updateCardByCardListMsg(stepId, repeated_PM_GoddessContestCard)
	for i, v in ipairs(repeated_PM_GoddessContestCard) do
		local cardId = v.cardId
		local mo = self:getCardMo(stepId, cardId)

		if mo == nil then
			printError(string.format("不存在对应卡牌( activityId = %s | stepId = %s | cardId = %s )", self._activityId, stepId, cardId))
		else
			local cardType = mo:getCardType()

			if cardType == GdcCardEnum.CardType_Random then
				mo:setIsShowValue(checkbool(v.isShow))
				mo:setValue(checknumber(v.randomShowNum))
			end

			mo:setPosId(v.posId)
			mo:setIsWith(true)
		end
	end
end

function GdcCardBagMgr:getCardMo(stepId, cardId)
	if self._cardPool[stepId] then
		return self._cardPool[stepId][cardId]
	end
end

function GdcCardBagMgr:getEmptyCardMo()
	return self._emptyCardMo
end

return GdcCardBagMgr

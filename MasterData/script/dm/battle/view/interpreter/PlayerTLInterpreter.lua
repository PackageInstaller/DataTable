-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/interpreter/PlayerTLInterpreter.lua

PlayerTLInterpreter = class("PlayerTLInterpreter", TLInterpreter, _M)

PlayerTLInterpreter:has("_isMainPlayer", {
	is = "rwb"
})
PlayerTLInterpreter:has("_side", {
	is = "rw"
})

function PlayerTLInterpreter:initialize(viewContext)
	super.initialize(self)

	self._context = viewContext
	self._battleUIMediator = viewContext:getValue("BattleUIMediator")
end

function PlayerTLInterpreter:setCurMainPlayerId(id)
	self._mainPlayerId = id

	self._context:setValue("CurMainPlayerId", id)
end

function PlayerTLInterpreter:checkMainPlayerId(id)
	self._mainPlayerId = self._context:getValue("CurMainPlayerId")

	if self._mainPlayerId and self._mainPlayerId == id then
		return true
	end

	local mainPlayerId = self._context:getValue("MainPlayerId")

	if type(mainPlayerId) == "table" then
		if mainPlayerId[id] then
			self:setCurMainPlayerId(id)

			return true
		end

		for _, playerId in ipairs(mainPlayerId) do
			if playerId == id then
				self:setCurMainPlayerId(id)

				return true
			end
		end
	elseif id == mainPlayerId then
		self:setCurMainPlayerId(id)

		return true
	end

	return false
end

function PlayerTLInterpreter:act_RelocatCardWindow(action, args)
	if self._isMainPlayer then
		local cards = args.cards
		local remain = args.cardPoolSize
		local nextCard = args.nextCard

		self._battleUIMediator:removeCards()
		self._battleUIMediator:updateCardArray(cards, remain, nextCard)
	end
end

function PlayerTLInterpreter:act_NewPlayer(action, args)
	local id = args.id
	local side = args.side
	local isMainPlayer = false
	local headWidget

	if not self:checkMainPlayerId(id) then
		headWidget = self._battleUIMediator:getRightHeadWidget()
	else
		isMainPlayer = true

		self._context:setValue("CurMainPlayer", id)

		if side == kBattleSideA then
			self._mainPlayerSide = true

			self._context:setValue("IsTeamAView", true)
		elseif side == kBattleSideB then
			self._mainPlayerSide = false

			self._context:setValue("IsTeamAView", false)
		end

		local cards = args.cards
		local extraCards = args.extraCards
		local remain = args.cardPoolSize
		local nextCard = args.nextCard
		local energy = args.energy

		self._battleUIMediator:removeCards()
		self._battleUIMediator:updateCardArray(cards, remain, nextCard)
		self._battleUIMediator:updateExtraCardArray(extraCards, remain)
		self._battleUIMediator:syncEnergy(energy, 0, 0)

		headWidget = self._battleUIMediator:getLeftHeadWidget()
	end

	local count = args.cardPoolSize

	for i = math.min(4, #args.cards), 1, -1 do
		local cardInfo = args.cards[i]

		if type(cardInfo) == "table" then
			count = count + 1
		end
	end

	if headWidget.setCardNum then
		headWidget:setCardNum(count)
	end

	self._side = side
	self._isMainPlayer = isMainPlayer
end

function PlayerTLInterpreter:act_NewWave(action, args)
	local headWidget

	if self._isMainPlayer then
		headWidget = self._battleUIMediator:getLeftHeadWidget()
	else
		local waveWidget = self._context:getValue("BattleWaveWidget")

		if waveWidget ~= nil then
			waveWidget:setWave(args.index, args.total)
		end

		if self._battleUIMediator.showNewWaveLabel then
			self._battleUIMediator:showNewWaveLabel(args.index)
		end

		headWidget = self._battleUIMediator:getRightHeadWidget()
	end

	if headWidget.updateHeros then
		if args.master == nil then
			headWidget:updateHeros(args.heros)
		else
			headWidget:updateHeros()
		end
	end

	if headWidget.setHpTierCount then
		if args.master then
			local hpTierCount = ConfigReader:getDataByNameIdAndKey("RoleModel", args.master, "HpTierCount")

			headWidget:setHpTierCount(hpTierCount or 1)
		else
			headWidget:setHpTierCount(1)
		end
	end
end

function PlayerTLInterpreter:act_SyncE(action, args)
	if self._isMainPlayer and args then
		local energy = args[1]
		local remain = args[2]
		local speed = args[3]

		self._battleUIMediator:syncEnergy(energy, remain, speed)
	end
end

function PlayerTLInterpreter:act_SyncERecovery(action, args)
	if self._isMainPlayer and args then
		local energy = args[1]
		local remain = args[2]
		local speed = args[3]

		self._battleUIMediator:syncEnergy(energy, remain, speed)

		if self._battleUIMediator.showRecoveryEnergyAnim then
			self._battleUIMediator:showRecoveryEnergyAnim()
		end
	end
end

function PlayerTLInterpreter:act_ShowGrayEnergyEffect(action, args)
	if self._isMainPlayer then
		local isShow = args or false

		if self._battleUIMediator.showGrayEnergyEffect then
			self._battleUIMediator:showGrayEnergyEffect(isShow)
		end
	end
end

function PlayerTLInterpreter:act_ShowFrazeEnergyEffect(action, args)
	if self._isMainPlayer then
		local isShow = args or false

		if self._battleUIMediator.showFrazeEnergyEffect then
			self._battleUIMediator:showFrazeEnergyEffect(isShow)
		end
	end
end

function PlayerTLInterpreter:act_RemoveSCard(action, args)
	self._battleUIMediator:removeCards()
end

function PlayerTLInterpreter:act_FillSCard(action, args)
	local cards = args.cards
	local remain = args.cardPoolSize
	local nextCard = args.nextCard
	local count = args.cardPoolSize

	for i = math.min(4, #args.cards), 1, -1 do
		local cardInfo = args.cards[i]

		if type(cardInfo) == "table" then
			count = count + 1
		end
	end

	if self._isMainPlayer then
		self._battleUIMediator:removeCards()
		self._battleUIMediator:updateCardArray(cards, remain, nextCard)
		self._battleUIMediator:getLeftHeadWidget():setCardNum(count)
		self._battleUIMediator:getSkillRefreshBtn():show()
	else
		self._battleUIMediator:getRightHeadWidget():setCardNum(count)
	end
end

function PlayerTLInterpreter:act_Card(action, args)
	if self._isMainPlayer then
		local idx = args.idx
		local card = args.card
		local nextCard = args.next

		self._battleUIMediator:replaceCard(idx, card, nextCard)
		self._battleUIMediator:getLeftHeadWidget():reduceCard(args.type)
	else
		self._battleUIMediator:getRightHeadWidget():reduceCard(args.type)
	end
end

function PlayerTLInterpreter:act_SwapCard(action, args)
	local reduce = args.reduce

	if self._isMainPlayer then
		local idx = args.idx
		local card = args.card

		self._battleUIMediator:swapCard(idx, card)

		if not reduce then
			self._battleUIMediator:getLeftHeadWidget():addCard(args.type)
		end
	elseif not reduce then
		self._battleUIMediator:getRightHeadWidget():addCard(args.type)
	end
end

function PlayerTLInterpreter:act_UseHeroCard(action, args)
	if self._battleUIMediator.usedCard then
		self._battleUIMediator:usedCard(args.cardId)
	end
end

function PlayerTLInterpreter:act_RecruitCard(action, args)
	if self._isMainPlayer then
		local idx = args.idx
		local card = args.card
		local nextCard = args.next

		if idx then
			self._battleUIMediator:replaceCard(idx, card, nextCard)
		else
			self._battleUIMediator:replacePreview(nextCard)
		end

		self._battleUIMediator:getLeftHeadWidget():reduceCard(args.type)
	else
		self._battleUIMediator:getRightHeadWidget():reduceCard(args.type)
	end
end

function PlayerTLInterpreter:act_BackToCard(action, args)
	if self._isMainPlayer then
		local card = args.card

		self._battleUIMediator:replacePreview(card)
		self._battleUIMediator:getLeftHeadWidget():addCard(args.type)
	else
		self._battleUIMediator:getRightHeadWidget():addCard(args.type)
	end
end

function PlayerTLInterpreter:act_BackToExtraCard(action, args)
	if self._isMainPlayer then
		local card = args.card

		self._battleUIMediator:replaceExtraPreview(card, args.idx)
		self._battleUIMediator:getLeftHeadWidget():addCard(args.type)
	else
		self._battleUIMediator:getRightHeadWidget():addCard(args.type)
	end
end

function PlayerTLInterpreter:act_Kick(action, args)
	return
end

function PlayerTLInterpreter:act_AddEnchant(action, args)
	if self._isMainPlayer then
		local idx = args.idx

		if idx and args.eft then
			for _, detail in ipairs(args.eft) do
				if detail.evt == "cardCost" then
					self._battleUIMediator:adjustCardCost(idx, detail)
				end
			end
		end
	end
end

function PlayerTLInterpreter:act_StackEnchant(action, args)
	if self._isMainPlayer then
		local idx = args.idx

		if idx and args.eft then
			for _, detail in ipairs(args.eft) do
				if detail.evt == "cardCost" then
					self._battleUIMediator:adjustCardCost(idx, detail)
				end
			end
		end
	end
end

function PlayerTLInterpreter:act_UpdateHeroCard(action, args)
	if self._isMainPlayer then
		local cardInfo = args.cardInfo
		local idx = args.idx

		if cardInfo and idx then
			self._battleUIMediator:updateCardInfo(idx, cardInfo)
		end
	end
end

function PlayerTLInterpreter:act_RmEnchant(action, args)
	if self._isMainPlayer then
		local idx = args.idx

		if idx and args.eft then
			for _, detail in ipairs(args.eft) do
				if detail.evt == "cardCost" then
					self._battleUIMediator:adjustCardCost(idx, detail)
				end
			end
		end
	end
end

function PlayerTLInterpreter:act_UpdateCardWeight(action, args)
	if self._isMainPlayer then
		self._battleUIMediator:updateCardWeight(args.cardInfos[1], args.cardInfos[2], args.cardInfos[3])
	end
end

function PlayerTLInterpreter:act_CurrentBattleSt(action, args)
	if self._isMainPlayer then
		self._battleUIMediator:updateCurrentBattleSt(args.status)
	end
end

function PlayerTLInterpreter:act_MaxCardWeight(action, args)
	if self._isMainPlayer then
		self._battleUIMediator:maxCardWeight(args.cardInfos)
	end
end

function PlayerTLInterpreter:act_TriggerBuff(action, args)
	if self._isMainPlayer then
		local idx = args.idx
		local anim = args.anim

		if idx and self._battleUIMediator.adjustCardBuff then
			self._battleUIMediator:adjustCardBuff(idx, anim)
		end
	end
end

function PlayerTLInterpreter:act_LockCard(action, args)
	if self._isMainPlayer then
		local idx = args.idx

		self._battleUIMediator:showLockAnim(idx, args)
	end
end

function PlayerTLInterpreter:act_UnlockCard(action, args)
	if self._isMainPlayer then
		local idx = args.idx

		self._battleUIMediator:hideLockAnim(idx, args)
	end
end

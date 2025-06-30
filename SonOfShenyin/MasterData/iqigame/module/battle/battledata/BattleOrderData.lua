-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleOrderData.lua

local BattleOrder = {
	ActionType = 0,
	BattleUnitID = 0,
	RoundNumber = 0
}

function BattleOrder.New(battleUnitID, roundNumber)
	logError("BattleOrderData.lua 中存在未定义 New 方法的指令类型")
end

function BattleOrder:_Init(battleUnitID, roundNumber)
	self.BattleUnitID = battleUnitID
	self.RoundNumber = roundNumber
end

function BattleOrder:ToDic()
	logError("BattleOrderData.lua 中存在未定义 ToDic 方法的指令类型")
end

function BattleOrder:_ToDic()
	return {
		UnitID = self.BattleUnitID,
		RoundNumber = self.RoundNumber
	}
end

local BattleResetOrder = Clone(BattleOrder)

function BattleResetOrder.New(battleUnitID, roundNumber)
	local obj = Clone(BattleResetOrder)

	obj:__Init(battleUnitID, roundNumber)

	return obj
end

function BattleResetOrder:__Init(battleUnitID, roundNumber)
	self:_Init(battleUnitID, roundNumber)
end

function BattleResetOrder:ToDic()
	return self:_ToDic()
end

local BattleMoveOrder = Clone(BattleOrder)

function BattleMoveOrder.New(battleUnitID, roundNumber)
	local obj = Clone(BattleMoveOrder)

	obj:__Init(battleUnitID, roundNumber)

	return obj
end

function BattleMoveOrder:__Init(battleUnitID, roundNumber)
	self:_Init(battleUnitID, roundNumber)

	self.BattlePos = nil
end

function BattleMoveOrder:ToDic()
	local dic = self:_ToDic()

	dic.BattlePos = self.BattlePos

	return dic
end

local BattleCastSkillOrder = Clone(BattleOrder)

function BattleCastSkillOrder.New(battleUnitID, roundNumber)
	local obj = Clone(BattleCastSkillOrder)

	obj:__Init(battleUnitID, roundNumber)

	return obj
end

function BattleCastSkillOrder:__Init(battleUnitID, roundNumber)
	self:_Init(battleUnitID, roundNumber)

	self.SkillCid = 0
	self.battleTileUnitID = 0
end

function BattleCastSkillOrder:ToDic()
	local dic = self:_ToDic()

	dic.SkillCid = self.SkillCid
	dic.Targets = {
		self.battleTileUnitID
	}

	return dic
end

function BattleCastSkillOrder:SetTarget(battleTileUnitID)
	self.battleTileUnitID = battleTileUnitID
end

local PreviewSkillOrder = Clone(BattleOrder)

PreviewSkillOrder.SkillCid = 0

function PreviewSkillOrder.New(battleUnitID, roundNumber)
	local obj = Clone(PreviewSkillOrder)

	obj:__Init(battleUnitID, roundNumber)

	return obj
end

function PreviewSkillOrder:__Init(battleUnitID, roundNumber)
	self:_Init(battleUnitID, roundNumber)
end

function PreviewSkillOrder:SetSkillCid(skillCid)
	self.SkillCid = skillCid
end

function PreviewSkillOrder:ToDic()
	local dic = self:_ToDic()

	dic.SkillCid = self.SkillCid

	return dic
end

local BattleStatusSwitchOrder = Clone(BattleOrder)

function BattleStatusSwitchOrder.New(battleUnitID, roundNumber)
	local obj = Clone(BattleStatusSwitchOrder)

	obj:__Init(battleUnitID, roundNumber)

	return obj
end

function BattleStatusSwitchOrder:__Init(battleUnitID, roundNumber)
	self:_Init(battleUnitID, roundNumber)

	self.status = 0
end

function BattleStatusSwitchOrder:ToDic()
	local dic = self:_ToDic()

	dic.Status = self.status

	return dic
end

function BattleStatusSwitchOrder:SetStatus(status)
	self.status = status
end

local BattleOrderData = {
	__order_constructor_dic = {}
}

BattleOrderData.__order_constructor_dic[BattleConstant.BattleOrderType.Rest] = BattleResetOrder
BattleOrderData.__order_constructor_dic[BattleConstant.BattleOrderType.Move] = BattleMoveOrder
BattleOrderData.__order_constructor_dic[BattleConstant.BattleOrderType.CastSkill] = BattleCastSkillOrder
BattleOrderData.__order_constructor_dic[BattleConstant.BattleOrderType.StatusSwitch] = BattleStatusSwitchOrder
BattleOrderData.__order_constructor_dic[BattleConstant.BattleOrderType.PreviewSkill] = PreviewSkillOrder

function BattleOrderData.CreateOrder(actionType, battleUnitID, roundNumber)
	local order_constructor = BattleOrderData.__order_constructor_dic[actionType]

	if order_constructor == nil then
		logError("找不到对应类型的指令， {0}", actionType)

		return nil
	end

	local order = order_constructor.New(battleUnitID, roundNumber)

	order.ActionType = actionType

	return order
end

function BattleOrderData.CreateAutoFightOrder(battleUnitID, roundNumber)
	local order = {}

	order.UnitID = battleUnitID
	order.SkillCid = 0
	order.RoundNumber = roundNumber

	local battleTileUnitID

	if BattleSkillModule.AutoFightDefaultTargetBattlePos ~= BattleConstant.AutoFightDefaultSelectBattlePos then
		BattleModule.ForeachBattleTiles(function(unitID, tileData)
			if tileData.troopType ~= BattleModule.defineBattleTroopType then
				return
			end

			if tileData.battlePos ~= BattleSkillModule.AutoFightDefaultTargetBattlePos then
				return
			end

			battleTileUnitID = unitID

			return true
		end)
	end

	order.Targets = {
		battleTileUnitID
	}

	return order
end

return BattleOrderData

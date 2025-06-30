-- chunkname: @IQIGame\\Module\\Battle\\BattleTurnAction.lua

local Queue = require("IQIGame.Module.Util.BattleQueue")
local m = {
	moverID = 0
}

function m.New(turnCommand)
	local obj = Clone(m)

	obj:__Init(turnCommand)

	return obj
end

function m:__Init(turnCommand)
	self.turnCommand = turnCommand
	self.moverID = turnCommand.MoverID
end

function m:Start(callback)
	BattleModule.Log("单位【{0}】出手开始", self.moverID)

	self.turnCompleteCall = callback
	BattleModule.__tempRecordTurnMoverID = self.moverID

	EventDispatcher.Dispatch(EventID.BattleUnitTurnBeginEvent, self.moverID)
	self:__DoBeforeAction(self.turnCommand.BeforeActionPOD)
end

function m:Dispose(isForce)
	BattleModule.Log("单位【{0}】出手结束", self.moverID)

	self.turnCommand = nil
end

function m:__DoBeforeAction(actionPOD)
	BattleModule.Log("BattleClient === 执行战斗单位【{0}】 BeforeActionPOD", self.moverID)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.TurnStart, actionPOD.UpdateUnits, nil, function()
		self:__DoInAction(self.turnCommand.InActionPOD)
	end)
end

function m:__DoInAction(actionPOD)
	BattleModule.Log("BattleClient === 执行战斗单位【{0}】 InActionPOD", self.moverID)

	if self.moverID == BattleModule.attackTeamBattleUnitID or self.moverID == BattleModule.defendTeamBattleUnitID then
		self:__CastTeamBattleUnitCastSkill(actionPOD.CastSkills, function()
			self:__OnInActionComplete()
		end)

		return
	end

	local castSkills = actionPOD.CastSkills

	if castSkills == nil then
		self:__OnInActionComplete()

		return
	end

	BattleSkillModule.CasterSkills(castSkills, function()
		self:__OnInActionComplete()
	end)
end

function m:__CastTeamBattleUnitCastSkill(castSkillPODs, callback)
	for i = 1, #castSkillPODs do
		local castSkillPOD = castSkillPODs[i]

		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillStart, castSkillPOD.BeforeUpdateUnits, nil, function()
			return
		end)

		if castSkillPOD.SkillHits ~= nil then
			for _, skillHit in ipairs(castSkillPOD.SkillHits) do
				BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillHit, skillHit.UpdateUnits, nil, function()
					return
				end)
			end
		end

		BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.SkillEnd, castSkillPOD.AfterUpdateUnits, nil, function()
			return
		end)
	end

	callback()
end

function m:__OnInActionComplete()
	BattleModule.Log("BattleClient === 执行战斗单位【{0}】 AfterActionPOD", self.moverID)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.TurnEnd, self.turnCommand.AfterActionPOD.UpdateUnits, nil, function()
		BattleModule.CheckDialog(function()
			BattleModule.WaitAllBattleUnitReady(function()
				BattleModule.ShowAllSummons(function()
					self:__OnTurnComplete()
				end)
			end)
		end)
	end)
end

function m:__OnTurnComplete()
	BattleLogicAdapter.Instance:AddBattleOrderFromLua(BattleLogicAdapter.ORDER_FIGHT_UNIT_ACTION_OVER, {
		UnitID = self.moverID
	})
	EventDispatcher.Dispatch(EventID.BattleUnitTurnEndEvent, self.moverID)
	BattleModule.Log("-----通知{0}表演结束----", self.moverID)

	if self.turnCompleteCall ~= nil then
		self.turnCompleteCall()
	end
end

return m

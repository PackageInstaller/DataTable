-- chunkname: @modules/logic/autochess/main/flow/AutoChessEffectHandleFunc.lua

module("modules.logic.autochess.main.flow.AutoChessEffectHandleFunc", package.seeall)

local AutoChessEffectHandleFunc = class("AutoChessEffectHandleFunc")

function AutoChessEffectHandleFunc:ctor()
	self._defineList = {
		[AutoChessEnum.EffectType.LeaderHp] = AutoChessEffectHandleFunc._handleLeaderHp,
		[AutoChessEnum.EffectType.LeaderHpFloat] = AutoChessEffectHandleFunc._handleLeaderHpFloat,
		[AutoChessEnum.EffectType.ChessHp] = AutoChessEffectHandleFunc._handleChessHp,
		[AutoChessEnum.EffectType.ChessHpFloat] = AutoChessEffectHandleFunc._handleChessHpFloat,
		[AutoChessEnum.EffectType.ChessMove] = AutoChessEffectHandleFunc._handleChessMove,
		[AutoChessEnum.EffectType.ChessDie] = AutoChessEffectHandleFunc._handleChessDie,
		[AutoChessEnum.EffectType.AddBuff] = AutoChessEffectHandleFunc._handleAddBuff,
		[AutoChessEnum.EffectType.UpdateBuff] = AutoChessEffectHandleFunc._handleUpdateBuff,
		[AutoChessEnum.EffectType.DelBuff] = AutoChessEffectHandleFunc._handleDelBuff,
		[AutoChessEnum.EffectType.CoinChange] = AutoChessEffectHandleFunc._handleCoinChange,
		[AutoChessEnum.EffectType.ExpChange] = AutoChessEffectHandleFunc._handleExpChange,
		[AutoChessEnum.EffectType.StarChange] = AutoChessEffectHandleFunc._handleStarChange,
		[AutoChessEnum.EffectType.Summon] = AutoChessEffectHandleFunc._handleSummon,
		[AutoChessEnum.EffectType.BattleChange] = AutoChessEffectHandleFunc._handleBattleChange,
		[AutoChessEnum.EffectType.MallUpdate] = AutoChessEffectHandleFunc._handleMallUpdate,
		[AutoChessEnum.EffectType.PlayAttack] = AutoChessEffectHandleFunc._handlePlayAttack,
		[AutoChessEnum.EffectType.UpdateChessPos] = AutoChessEffectHandleFunc._handleUpdateChessPos,
		[AutoChessEnum.EffectType.FightUpdate] = AutoChessEffectHandleFunc._handleFightUpdate,
		[AutoChessEnum.EffectType.LeaderSkillUpdate] = AutoChessEffectHandleFunc._handleLeaderSkillUpdate,
		[AutoChessEnum.EffectType.LeaderChange] = AutoChessEffectHandleFunc._handleLeaderChange,
		[AutoChessEnum.EffectType.UdimoSkill] = AutoChessEffectHandleFunc._handleUdimoSkill,
		[AutoChessEnum.EffectType.BossDrop] = AutoChessEffectHandleFunc._handleBossDrop,
		[AutoChessEnum.EffectType.ChessCd] = AutoChessEffectHandleFunc._handleChessCd,
		[AutoChessEnum.EffectType.ChessCombine] = AutoChessEffectHandleFunc._handleChessCombine,
		[AutoChessEnum.EffectType.RepleaceSkill] = AutoChessEffectHandleFunc._handleRepleaceSkill
	}
end

function AutoChessEffectHandleFunc:_handleLeaderHp()
	local leader = self.mgr:getLeaderEntity(self.effect.targetId)

	if leader then
		leader:updateHp(self.effect.effectNum)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleLeaderHpFloat()
	if self.effect.fromId == self.effect.targetId then
		self:delayFloatLeader()
	else
		local attackLeader = self.mgr:getLeaderEntity(self.effect.fromId)

		if attackLeader then
			self.mgr:flyStarByTeam(attackLeader.data.teamType)
			TaskDispatcher.runDelay(self.delayAttack, self, 1.1)
		else
			self:delayFloatLeader()
		end
	end
end

function AutoChessEffectHandleFunc:_handleChessHp()
	local chess = self.mgr:getEntity(self.effect.targetId)

	if chess then
		chess:updateHp(self.effect.effectNum)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleChessHpFloat()
	local chess = self.mgr:getEntity(self.effect.targetId)

	if chess then
		chess:floatHp(self.effect.effectNum, self.effect.fromId)
	end

	TaskDispatcher.runDelay(self.finishWork, self, 0.5)
end

function AutoChessEffectHandleFunc:_handleChessMove()
	local fightData = (self.context == AutoChessEnum.ContextType.EndBuy or self.context == AutoChessEnum.ContextType.Fight) and self.chessMo.lastSvrFight or self.chessMo.svrFight
	local chessPosA, warZone = self.chessMo:getChessPosition1(self.effect.targetId, fightData)
	local chessPosB = self.chessMo:getChessPosition(warZone, tonumber(self.effect.effectNum) + 1, fightData)

	if chessPosA and chessPosB then
		chessPosB.chess = chessPosA.chess
		chessPosA.chess = chessPosB.chess
	else
		logError(string.format("位置: %s %s 的ChessPosition数据为空,请检查", self.effect.fromId, self.effect.effectNum))
	end

	local chess = self.mgr:getEntity(self.effect.targetId)

	if chess then
		chess:move(self.effect.effectNum)
	end

	TaskDispatcher.runDelay(self.finishWork, self, AutoChessEnum.ChessAniTime.jump)
end

function AutoChessEffectHandleFunc:_handleChessDie()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_death)

	local fightData, dieSkill

	if self.context == AutoChessEnum.ContextType.EndBuy or self.context == AutoChessEnum.ContextType.Fight then
		fightData = self.chessMo.lastSvrFight
		dieSkill = true
	else
		fightData = self.chessMo.svrFight
		dieSkill = false
	end

	local delayTime = AutoChessEnum.ChessAniTime.die
	local chessEntity = self.mgr:getEntity(self.effect.targetId)

	if chessEntity then
		if self.skillEffectId then
			chessEntity:playEffect(self.skillEffectId)
		end

		if chessEntity.go.activeInHierarchy then
			local effectId = chessEntity:die(dieSkill)

			if effectId then
				local effectCo = lua_auto_chess_effect.configDict[effectId]

				delayTime = math.max(delayTime, effectCo.duration)
			end
		else
			delayTime = 0
		end
	end

	local chessPos = self.chessMo:getChessPosition(tonumber(self.effect.fromId), tonumber(self.effect.effectNum) + 1, fightData)

	chessPos.chess = AutoChessHelper.buildEmptyChess()

	if delayTime == 0 then
		self:finishWork()
	else
		TaskDispatcher.runDelay(self.finishWork, self, delayTime)
	end
end

function AutoChessEffectHandleFunc:_handleAddBuff()
	local entity = self.mgr:tryGetEntity(self.effect.targetId)

	if entity then
		entity:addBuff(self.effect.buff)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleUpdateBuff()
	local entity = self.mgr:tryGetEntity(self.effect.targetId)

	if entity then
		entity:updateBuff(self.effect.buff)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleDelBuff()
	local entity = self.mgr:tryGetEntity(self.effect.targetId)

	if entity then
		entity:delBuff(self.effect.effectNum)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleCoinChange()
	local delayTime = 0

	if self.skillEffectId then
		local entity = self.mgr:tryGetEntity(self.skillFromUid)

		if entity then
			local param = {
				value1 = self.effect.targetId
			}

			delayTime = entity:playEffect(self.skillEffectId, param)
		end
	end

	self.chessMo:updateSvrMallCoin(self.effect.effectNum)
	TaskDispatcher.runDelay(self.finishWork, self, delayTime)
end

function AutoChessEffectHandleFunc:_handleExpChange()
	local chess = self.mgr:getEntity(self.effect.targetId)

	if chess then
		chess:updateExp(self.effect.effectNum)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleStarChange()
	local chess = AutoChessHelper.copyChess(self.effect.chessList[1])
	local chessPos = (self.context == AutoChessEnum.ContextType.EndBuy or self.context == AutoChessEnum.ContextType.Fight) and self.chessMo:getChessPosition1(chess.uid, self.chessMo.lastSvrFight) or self.chessMo:getChessPosition1(chess.uid)

	if chessPos then
		chessPos.chess = chess
	end

	local chessEntity = self.mgr:getEntity(chess.uid)

	if chessEntity then
		local delayTime = chessEntity:updateStar(chess)

		TaskDispatcher.runDelay(self.finishWork, self, delayTime)
	else
		self:finishWork()
	end
end

function AutoChessEffectHandleFunc:_handleBattleChange()
	local chess = self.mgr:getEntity(self.effect.targetId)

	if chess then
		chess:updateBattle(self.effect.effectNum)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleSummon()
	local chess = AutoChessHelper.copyChess(self.effect.chessList[1])

	if self.context == AutoChessEnum.ContextType.EndBuy or self.context == AutoChessEnum.ContextType.Fight then
		local chessPos = self.chessMo:getChessPosition(tonumber(self.effect.targetId), tonumber(self.effect.effectNum) + 1, self.chessMo.lastSvrFight)

		chessPos.chess = chess
	else
		local chessPos = self.chessMo:getChessPosition(tonumber(self.effect.targetId), tonumber(self.effect.effectNum) + 1)

		chessPos.chess = chess
	end

	self.mgr:addEntity(self.effect.targetId, chess, self.effect.effectNum)
	TaskDispatcher.runDelay(self.finishWork, self, AutoChessEnum.ChessAniTime.born)
end

function AutoChessEffectHandleFunc:_handlePlayAttack()
	self.damageWork = AutoChessDamageWork.New(self.effect, self.skillEffectId)

	self.damageWork:registerDoneListener(self.finishWork, self)
	self.damageWork:onStart()
end

function AutoChessEffectHandleFunc:_handleUpdateChessPos()
	local chess = self.mgr:getEntity(self.effect.targetId)

	if chess then
		local toWarZone = tonumber(self.effect.fromId)
		local toPos = tonumber(self.effect.effectNum)
		local targetChessPos = self.chessMo:getChessPosition(toWarZone, toPos + 1)

		if self.effect.targetId ~= targetChessPos.chess.uid then
			local chessPos = self.chessMo:getChessPosition(chess.warZone, chess.index + 1)

			chessPos.chess = targetChessPos.chess
			targetChessPos.chess = chessPos.chess
		end

		chess:updateIndex(toWarZone, toPos)
	end

	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleMallUpdate()
	self.chessMo:updateSvrMallRegion(self.effect.region, true)
	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleFightUpdate()
	self.chessMo:updateSvrFight(self.effect.fight)
	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleLeaderSkillUpdate()
	self.chessMo.svrFight:unlockMasterSkill(self.effect.targetId)
	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleLeaderChange()
	local leader = self.mgr:getLeaderEntity(self.chessMo.svrFight.mySideMaster.uid)

	if leader then
		leader:setData(self.effect.master)
	end

	self.chessMo.svrFight:updateMaster(self.effect.master)
	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleUdimoSkill()
	self.chessMo:updateSvrMallRegion(self.effect.region, true)
	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleBossDrop()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BossDrop, self.effect.effectString)
	self:finishWork()
end

function AutoChessEffectHandleFunc:_handleChessCd()
	local chessPos = (self.context == AutoChessEnum.ContextType.EndBuy or self.context == AutoChessEnum.ContextType.Fight) and self.chessMo:getChessPosition1(self.effect.targetId, self.chessMo.lastSvrFight) or self.chessMo:getChessPosition1(self.effect.targetId)

	if chessPos then
		chessPos.chess.cd = tonumber(self.effect.effectNum)
	end

	local delayTime = 0

	if self.skillEffectId then
		local entity = self.mgr:getEntity(self.effect.targetId)

		if entity then
			delayTime = entity:playEffect(self.skillEffectId)
		end
	end

	if delayTime == 0 then
		self:finishWork()
	else
		TaskDispatcher.runDelay(self.finishWork, self, delayTime)
	end
end

function AutoChessEffectHandleFunc:_handleChessCombine()
	self.combineWork = AutoChessCombineWork.New(self.effect)

	self.combineWork:registerDoneListener(self.finishWork, self)
	self.combineWork:onStart()
end

function AutoChessEffectHandleFunc:_handleRepleaceSkill()
	local chessPos = self.chessMo:getChessPosition1(self.effect.fromId)

	chessPos.chess.replaceSkillChessIds = string.splitToNumber(self.effect.effectString, "#")

	self:finishWork()
end

function AutoChessEffectHandleFunc:getHandleFunc(type)
	return self._defineList[type]
end

AutoChessEffectHandleFunc.instance = AutoChessEffectHandleFunc.New()

return AutoChessEffectHandleFunc

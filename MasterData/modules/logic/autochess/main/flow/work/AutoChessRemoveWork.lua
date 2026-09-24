-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessRemoveWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessRemoveWork", package.seeall)

local AutoChessRemoveWork = class("AutoChessRemoveWork", AutoChessBaseWork)

function AutoChessRemoveWork:onStart()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_death)

	local sceneMo = AutoChessModel.instance:getSceneMo()
	local delayTime = AutoChessEnum.ChessAniTime.die
	local chessEntity = self.entityMgr:getEntity(self.effect.targetId)

	if chessEntity then
		if self.skillEffectId then
			chessEntity:playEffect(self.skillEffectId)
		end

		if chessEntity.go.activeInHierarchy then
			local effectId = chessEntity:die((sceneMo and self.context == sceneMo.lastFight or nil) and true)

			if effectId then
				local effectCo = AutoChessConfig.instance:getEffectCfg(effectId)

				if effectCo and effectCo.duration then
					delayTime = math.max(delayTime, effectCo.duration)
				end
			end
		else
			delayTime = 0
		end
	end

	local chessPos = self.context:getChessPosition(self.effect.fromId, self.effect.effectNum + 1)

	if chessPos then
		chessPos.chess = AutoChessHelper.buildEmptyChess()
	end

	self:delayCall(self.finishWork, delayTime)
end

function AutoChessRemoveWork:finishWork()
	AutoChessEntityMgr.instance:removeEntity(self.effect.targetId)
	AutoChessRemoveWork.super.finishWork(self)
end

return AutoChessRemoveWork

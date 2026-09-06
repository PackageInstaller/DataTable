-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/battle/BattleRoundHandler.lua

module("logicscene.scene.component.battle.BattleRoundHandler", package.seeall)

local BattleRoundHandler = class("BattleRoundHandler", SceneComponentBase)

function BattleRoundHandler:onEnterSceneFinished(sceneId, bornX, bornZ)
	self.battleModel = BattleModel.instance
	self.curRound = nil
	self.passAllRounds = nil
	self.retreatAllRounds = nil
end

function BattleRoundHandler:onExitScene()
	return
end

function BattleRoundHandler:passBattle()
	if self.curRound then
		self.passAllRounds = true

		return
	end

	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		for k1, v1 in pairs(v) do
			v1:stopSkill()
		end
	end

	local round = self.battleModel:popRound()
	local isToResult = true

	while round do
		local rcdRound = round

		round = self.battleModel:popRound()

		rcdRound:onPass()

		if round and round.roundType == BattleRoundBase.RoundPlayStory then
			isToResult = false
			self.curRound = round

			break
		end
	end

	if isToResult and self.battleModel:isRoundsEmpty() then
		self.battleModel:endBattle()
	end
end

function BattleRoundHandler:retreatBattle()
	if self.curRound then
		if Framework.OSDef.isEditor then
			self.curRound:onRetreat()

			self.curRound = nil
		else
			self.retreatAllRounds = true

			return
		end
	end

	local battleScene = SceneMgr.instance:getCurScene()
	local units = battleScene.unitFactory:getAllUnit()

	for k, v in pairs(units) do
		for k1, v1 in pairs(v) do
			v1:stopSkill()
		end
	end

	local round = self.battleModel:popRound()

	while round do
		round:onRetreat()

		round = self.battleModel:popRound()
	end

	self.battleModel:endBattle()
end

function BattleRoundHandler:pauseBattle(pause)
	if self.curRound then
		self.curRound:pause(pause)
	end
end

function BattleRoundHandler:onContinueFightRes()
	if self.curRound and self.curRound.roundType == BattleRoundBase.RoundContinue then
		self.curRound.isRespont = true
	end
end

function BattleRoundHandler:update(deltaTime)
	if self.battleModel and self.battleModel.isRunning and not self.battleModel.pauseBattle then
		if self.battleModel:isErrorCheck() then
			TipsFacade.instance:openCommonTips("精灵资源异常，自动跳过战斗")

			if self.curRound then
				self.curRound:onPass()

				self.curRound = nil

				return
			end

			if BattleModel.instance:hasReceivedResult() then
				if self.curRound then
					self.curRound:onPass()

					self.curRound = nil
				end

				BattleController.instance:pass()

				return
			else
				if BattleModel.instance.enableSkip ~= GameEnum.SkipType.UNABLE_SKIP and BattleModel.instance.enableSkip ~= GameEnum.SkipType.UNABLE_SKIP_FORCED then
					if BattleModel.instance.enableSkip == GameEnum.SkipType.NORMAL_SKIP then
						BattleController.instance:onSkipBattle()
					else
						BattleController.instance:onRetreatPass()
					end
				elseif BattleModel.instance.retreatMsgType ~= 0 then
					BattleController.instance:onRetreatPass()
				else
					BattleController.instance:pass()
				end

				return
			end
		end

		if not self.battleModel:isSkillCheck() then
			return
		end

		self.curRound = self.curRound or self.battleModel:popRound()

		if self.curRound then
			if not self.curRound.isRunning then
				self.curRound:start()

				if self.curRound then
					GlobalDispatcher:dispatch(GlobalNotify.OnBattleRoundStart, self.curRound)
				end
			end

			if self.curRound then
				self.curRound:update(deltaTime)
			end

			if self.curRound and self.curRound:isDone() then
				self.curRound:finish()
				self.curRound:clear()

				self.curRound = nil

				if self.passAllRounds then
					self:passBattle()
				end

				if self.retreatAllRounds then
					self:retreatBattle()
				end
			end
		elseif not self.battleModel.skipType and not self.battleModel:hasError() and not self.battleModel:hasReceivedResult() and self.battleModel:isRoundsEmpty() and not self.battleModel.viewFightBtl and (self.battleModel:getActionMode() ~= GameEnum.ActionModel.NoneAction or self.battleModel.retreatMsgType ~= 0) then
			self.battleModel:pushContinueFightRound()
		end
	end
end

return BattleRoundHandler

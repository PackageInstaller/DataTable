-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyFightWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyFightWork", package.seeall)

local StealthEnemyFightWork = class("StealthEnemyFightWork", BaseWork)

function StealthEnemyFightWork:onStart(context)
	local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()
	local battleGridList = enemyOperationData and enemyOperationData.battleGrids
	local hasBattle = battleGridList and #battleGridList > 0

	if hasBattle then
		local beAttackedHeroList = {}

		for _, gridId in ipairs(battleGridList) do
			local gridHeroList = AssassinStealthGameModel.instance:getGridEntityIdList(gridId, false)

			for _, heroUid in ipairs(gridHeroList) do
				local heroMo = AssassinStealthGameModel.instance:getHeroMo(heroUid, true)
				local status = heroMo:getStatus()

				if status == AssassinEnum.HeroStatus.Expose then
					beAttackedHeroList[#beAttackedHeroList + 1] = heroUid
				end
			end
		end

		if #beAttackedHeroList > 0 then
			for _, heroUid in ipairs(beAttackedHeroList) do
				AssassinStealthGameEntityMgr.instance:playHeroEff(heroUid, AssassinEnum.EffectId.EnemyAttack)
			end

			local duration = AssassinConfig.instance:getAssassinEffectDuration(AssassinEnum.EffectId.EnemyAttack)

			TaskDispatcher.cancelTask(self.playAttackEffFinished, self)
			TaskDispatcher.runDelay(self.playAttackEffFinished, self, duration)
		else
			self:playAttackEffFinished()
		end
	else
		self:onDone(true)
	end
end

function StealthEnemyFightWork:playAttackEffFinished()
	local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()
	local battleGridList = enemyOperationData and enemyOperationData.battleGrids
	local battleGrid = battleGridList and battleGridList[1]

	if battleGrid then
		AssassinStealthGameController.instance:enterBattleGrid(battleGrid)
	end

	self:onDone(false)
end

function StealthEnemyFightWork:clearWork()
	TaskDispatcher.cancelTask(self.playAttackEffFinished, self)
end

return StealthEnemyFightWork

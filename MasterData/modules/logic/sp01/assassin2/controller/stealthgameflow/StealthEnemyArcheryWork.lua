-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyArcheryWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyArcheryWork", package.seeall)

local StealthEnemyArcheryWork = class("StealthEnemyArcheryWork", BaseWork)

function StealthEnemyArcheryWork:onStart(context)
	local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()
	local attackDataList = enemyOperationData and enemyOperationData.attacks

	if attackDataList and #attackDataList > 0 then
		for _, attackData in ipairs(attackDataList) do
			AssassinStealthGameController.instance:updateHero(attackData.hero, AssassinEnum.EffectId.EnemyAttack)
		end

		local duration = AssassinConfig.instance:getAssassinEffectDuration(AssassinEnum.EffectId.EnemyAttack)

		TaskDispatcher.cancelTask(self.playAttackEffFinished, self)
		TaskDispatcher.runDelay(self.playAttackEffFinished, self, duration)
	else
		self:playAttackEffFinished()
	end
end

function StealthEnemyArcheryWork:playAttackEffFinished()
	self:onDone(true)
end

function StealthEnemyArcheryWork:clearWork()
	TaskDispatcher.cancelTask(self.playAttackEffFinished, self)
end

return StealthEnemyArcheryWork

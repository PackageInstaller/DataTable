-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyBornWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyBornWork", package.seeall)

local StealthEnemyBornWork = class("StealthEnemyBornWork", BaseWork)
local WAIT_TIME = 0.5

function StealthEnemyBornWork:onStart(context)
	local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()
	local newEnemyDataList = enemyOperationData and enemyOperationData.summons

	if newEnemyDataList and #newEnemyDataList > 0 then
		AssassinStealthGameController.instance:enemyBornByList(newEnemyDataList)
		TaskDispatcher.cancelTask(self._bornEnemyFinished, self)
		TaskDispatcher.runDelay(self._bornEnemyFinished, self, WAIT_TIME)
	else
		self:_bornEnemyFinished()
	end
end

function StealthEnemyBornWork:_bornEnemyFinished()
	self:onDone(true)
end

function StealthEnemyBornWork:clearWork()
	TaskDispatcher.cancelTask(self._bornEnemyFinished, self)
end

return StealthEnemyBornWork

-- chunkname: @modules/logic/sp01/assassin2/controller/stealthgameflow/StealthEnemyMoveWork.lua

module("modules.logic.sp01.assassin2.controller.stealthgameflow.StealthEnemyMoveWork", package.seeall)

local StealthEnemyMoveWork = class("StealthEnemyMoveWork", BaseWork)

function StealthEnemyMoveWork:ctor()
	self.maxStep = 0
end

function StealthEnemyMoveWork:onStart(context)
	self.curStep = 0

	local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()

	if enemyOperationData then
		self.moveDataList = enemyOperationData.moves or {}
	end

	for _, moveData in ipairs(self.moveDataList) do
		self.maxStep = math.max(self.maxStep, #moveData.path)
	end

	self:_nextMove()
end

local STEP_MOVE_TIME = 1

function StealthEnemyMoveWork:_nextMove()
	if self.curStep >= self.maxStep then
		local enemyOperationData = AssassinStealthGameModel.instance:getEnemyOperationData()
		local monsterUnitList = enemyOperationData and enemyOperationData.monster

		AssassinStealthGameController.instance:updateEnemies(monsterUnitList)
		self:onDone(true)
	else
		self.curStep = self.curStep + 1

		for _, moveData in ipairs(self.moveDataList) do
			self.maxStep = math.max(self.maxStep, #moveData.path)

			local posData = moveData.path[self.curStep]

			if posData then
				AssassinStealthGameController.instance:enemyMove(moveData.uid, posData.gridId, posData.pos)
			end
		end

		TaskDispatcher.cancelTask(self._nextMove, self)
		TaskDispatcher.runDelay(self._nextMove, self, STEP_MOVE_TIME)
	end
end

function StealthEnemyMoveWork:clearWork()
	TaskDispatcher.cancelTask(self._nextMove, self)
end

return StealthEnemyMoveWork

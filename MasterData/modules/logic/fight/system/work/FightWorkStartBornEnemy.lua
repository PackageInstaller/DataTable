-- chunkname: @modules/logic/fight/system/work/FightWorkStartBornEnemy.lua

module("modules.logic.fight.system.work.FightWorkStartBornEnemy", package.seeall)

local FightWorkStartBornEnemy = class("FightWorkStartBornEnemy", BaseWork)
local BornTime = 10

function FightWorkStartBornEnemy:onStart()
	if FightWorkAppearTimeline.getAppearTimeline() then
		self:onDone(true)

		return
	end

	self._flowParallel = FlowParallel.New()

	local newEnemyList = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

	for _, entity in ipairs(newEnemyList) do
		if not self.context.oldEntityIdDict or not self.context.oldEntityIdDict[entity.id] then
			local entityMO = entity:getMO()
			local evolution = FightMsgMgr.sendMsg(FightMsgId.IsEvolutionSkin, entityMO.skin)

			if (evolution or nil) and false then
				self._flowParallel:addWork(FightWorkStartBornNormal.New(entity, false))
			else
				FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBornNormal, entity.id)
			end
		end
	end

	TaskDispatcher.runDelay(self._onBornTimeout, self, BornTime)
	self._flowParallel:registerDoneListener(self._onEnemyBornDone, self)
	self._flowParallel:start()
end

function FightWorkStartBornEnemy:_onEnemyBornDone()
	self._flowParallel:unregisterDoneListener(self._onEnemyBornDone, self)
	self:onDone(true)
end

function FightWorkStartBornEnemy:_onBornTimeout()
	logError("播放出生效果时间超过" .. BornTime .. "秒")
	self:onDone(true)
end

function FightWorkStartBornEnemy:clearWork()
	if self._flowParallel then
		self._flowParallel:stop()
		self._flowParallel:unregisterDoneListener(self._onEnemyBornDone, self)
	end

	TaskDispatcher.cancelTask(self._onBornTimeout, self)
end

return FightWorkStartBornEnemy

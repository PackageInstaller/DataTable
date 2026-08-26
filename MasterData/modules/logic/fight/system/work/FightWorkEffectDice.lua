-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDice.lua

module("modules.logic.fight.system.work.FightWorkEffectDice", package.seeall)

local FightWorkEffectDice = class("FightWorkEffectDice", FightEffectBase)
local diceList

function FightWorkEffectDice:onStart()
	if diceList then
		table.insert(diceList, {
			self.fightStepData,
			self.actEffectData
		})
	else
		diceList = {}

		table.insert(diceList, {
			self.fightStepData,
			self.actEffectData
		})
		TaskDispatcher.runDelay(self._delayStart, self, 0.01)
	end
end

function FightWorkEffectDice:_delayStart()
	FightController.instance:registerCallback(FightEvent.OnDiceEnd, self._onDiceEnd, self)
	self:com_registTimer(self._delayDone, 10)

	local fightParam = FightModel.instance:getFightParam()
	local episode_config = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)
	local episodeType = episode_config and episode_config.type

	ViewMgr.instance:openView((Activity104Model.instance:isSeasonEpisodeType(episodeType) or nil) and ViewName.FightSeasonDiceView, diceList)

	diceList = nil
end

function FightWorkEffectDice:_delayDone()
	self:onDone(true)
end

function FightWorkEffectDice:_onDiceEnd()
	self:onDone(true)
end

function FightWorkEffectDice:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnDiceEnd, self._onDiceEnd, self)
	TaskDispatcher.cancelTask(self._delayStart, self)
end

return FightWorkEffectDice

-- chunkname: @modules/logic/fight/system/work/FightWorkRestartAbandon.lua

module("modules.logic.fight.system.work.FightWorkRestartAbandon", package.seeall)

local FightWorkRestartAbandon = class("FightWorkRestartAbandon", BaseWork)

function FightWorkRestartAbandon:ctor(fightParam)
	self._fightParam = fightParam
end

function FightWorkRestartAbandon:onStart()
	self.episode_config = self._fightParam:getCurEpisodeConfig()
	self.chapter_config = DungeonConfig.instance:getChapterCO(self.episode_config.chapterId)

	local playType = self.chapter_config.type

	if not _G["FightRestartAbandonType" .. playType] then
		local class = _G["FightRestartAbandonType" .. (FightRestartSequence.RestartType2Type[playType] or playType)]

		if class then
			self._abandon_class = class.New(self, self._fightParam, self.episode_config, self.chapter_config)

			if self._abandon_class:canRestart() then
				self._abandon_class:abandon()
			else
				FightGameMgr.restartMgr:cancelRestart()
			end
		else
			FightGameMgr.restartMgr:cancelRestart()
		end
	end
end

function FightWorkRestartAbandon:clearWork()
	if self._abandon_class then
		self._abandon_class:releaseEvent()
		self._abandon_class:releaseSelf()

		self._abandon_class = nil
	end
end

return FightWorkRestartAbandon

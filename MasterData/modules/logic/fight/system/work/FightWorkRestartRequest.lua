-- chunkname: @modules/logic/fight/system/work/FightWorkRestartRequest.lua

module("modules.logic.fight.system.work.FightWorkRestartRequest", package.seeall)

local FightWorkRestartRequest = class("FightWorkRestartRequest", BaseWork)

function FightWorkRestartRequest:ctor(fightParam)
	self._fightParam = fightParam
end

function FightWorkRestartRequest:onStart()
	self.episode_config = self._fightParam:getCurEpisodeConfig()
	self.chapter_config = DungeonConfig.instance:getChapterCO(self.episode_config.chapterId)

	local playType = self.chapter_config.type

	if not _G["FightRestartRequestType" .. playType] then
		local class = _G["FightRestartRequestType" .. (FightRestartSequence.RestartType2Type[playType] or playType)]

		if class then
			self._request_class = class.New(self, self._fightParam, self.episode_config, self.chapter_config)

			if self._request_class.requestFight then
				self._request_class:requestFight()
			else
				FightGameMgr.restartMgr:cancelRestart()
			end
		else
			FightGameMgr.restartMgr:cancelRestart()
		end
	end
end

function FightWorkRestartRequest:clearWork()
	if self._request_class then
		self._request_class:releaseSelf()

		self._request_class = nil
	end
end

return FightWorkRestartRequest

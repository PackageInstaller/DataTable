-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightEnd.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEnd", package.seeall)

local WaitGuideActionFightEnd = class("WaitGuideActionFightEnd", BaseGuideAction)

function WaitGuideActionFightEnd:onStart(context)
	WaitGuideActionFightEnd.super.onStart(self, context)

	if string.find(self.actionParam, ",") then
		self._episodeIdList = string.splitToNumber(self.actionParam, ",")
	else
		self._episodeId = tonumber(self.actionParam)
	end

	FightController.instance:registerCallback(FightEvent.PushEndFight, self._endFight, self)
end

function WaitGuideActionFightEnd:_endFight()
	if self._episodeId then
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(self._episodeId)

		if episodeInfo and episodeInfo.star > DungeonEnum.StarType.None then
			self:onDone(true)
		end
	elseif self._episodeIdList then
		for i, episodeId in ipairs(self._episodeIdList) do
			local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

			if episodeInfo and episodeInfo.star > DungeonEnum.StarType.None then
				self:onDone(true)
			end
		end
	else
		self:onDone(true)
	end
end

function WaitGuideActionFightEnd:clearWork()
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, self._endFight, self)
end

return WaitGuideActionFightEnd

-- chunkname: @modules/logic/fight/system/work/FightWorkFbStory.lua

module("modules.logic.fight.system.work.FightWorkFbStory", package.seeall)

local FightWorkFbStory = class("FightWorkFbStory", BaseWork)

FightWorkFbStory.Type_EnterWave = 1
FightWorkFbStory.Type_BeforePlaySkill = 2
FightWorkFbStory.Type_AfterPlaySkill = 3
FightWorkFbStory.Type_ChangeRound = 4

function FightWorkFbStory:ctor(conditionType, exParam)
	self.conditionType = conditionType
	self.exParam = exParam

	local fightParam = FightModel.instance:getFightParam()

	self.episodeId = fightParam and fightParam.episodeId

	if self.episodeId then
		local episodeCO = DungeonConfig.instance:getEpisodeCO(self.episodeId)
		local sp = episodeCO and string.split(episodeCO.story, "#")

		self.configCondType = sp and tonumber(sp[1])
		self.configCondParam = sp and sp[2]
		self.configCondStoryId = sp and tonumber(sp[3])
	end
end

function FightWorkFbStory:onStart()
	if not self.configCondType or self.conditionType ~= self.configCondType then
		self:onDone(true)

		return
	end

	if self.configCondType == 1 then
		local curWaveId = FightModel.instance:getCurWaveId()

		if curWaveId ~= tonumber(self.configCondParam) then
			self:onDone(true)

			return
		end

		self:_checkPlayStory()
	elseif self.configCondType == 2 or self.configCondType == 3 then
		local skillId = tonumber(self.configCondParam)

		if not skillId or not self.exParam or self.exParam ~= skillId then
			self:onDone(true)

			return
		end

		self:_checkPlayStory()
	elseif self.configCondType == 4 then
		local curRound = FightModel.instance:getCurRoundId()

		if curRound ~= tonumber(self.configCondParam) then
			self:onDone(true)

			return
		end

		self.replayBgm = true

		self:_checkPlayStory()
	else
		self:onDone(true)
	end
end

function FightWorkFbStory:_checkPlayStory()
	if StoryModel.instance:isStoryFinished(self.configCondStoryId) then
		self:onDone(true)

		return
	end

	self:_setAllEntitysVisible(false)

	local param = {}

	param.mark = true
	param.episodeId = self.episodeId

	StoryController.instance:playStory(self.configCondStoryId, param, self._afterPlayStory, self)
end

function FightWorkFbStory:_afterPlayStory()
	self:_setAllEntitysVisible(true)

	if self.replayBgm then
		FightController.instance:dispatchEvent(FightEvent.ReplayBgmAfterAVG)
	end

	self:onDone(true)
end

function FightWorkFbStory:_setAllEntitysVisible(active)
	local all = FightHelper.getAllEntitys()

	for _, entity in ipairs(all) do
		entity:setActive(active)
	end
end

function FightWorkFbStory.checkHasFbStory()
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId

	if episodeId then
		::label_6_0::

		local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId)

		return episodeCO and not string.nilorempty(episodeCO.story)
	end
end

return FightWorkFbStory

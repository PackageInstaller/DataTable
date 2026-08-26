-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/LengZhou6StatHelper.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6StatHelper", package.seeall)

local LengZhou6StatHelper = class("LengZhou6StatHelper")

function LengZhou6StatHelper:ctor()
	self._episodeId = nil
	self._endless_library_round = 0
	self._result = nil
	self._beginTime = 0
	self._useRound = 0
	self._playerHp = 0
	self._enemyHp = 0
	self._skill_ids = {}
	self._skill_usages = {}
	self._isEndless = false
end

function LengZhou6StatHelper:enterGame()
	self._episodeId = LengZhou6Model.instance:getCurEpisodeId()

	local info = LengZhou6Model.instance:getEpisodeInfoMo(self._episodeId)

	if info then
		self._isEndless = info:isEndlessEpisode()
	end

	self._beginTime = os.time()
	self._useRound = 0

	tabletool.clear(self._skill_ids)
	tabletool.clear(self._skill_usages)
end

function LengZhou6StatHelper:setGameResult(result)
	self._result = result
end

function LengZhou6StatHelper:updateRound()
	self._useRound = self._useRound + 1
end

function LengZhou6StatHelper:addUseSkillId(id)
	if id == nil then
		return
	end

	local needAdd = true

	for _, v in ipairs(self._skill_ids) do
		if v == id then
			needAdd = false

			break
		end
	end

	if needAdd then
		table.insert(self._skill_ids, id)
	end
end

function LengZhou6StatHelper:addUseSkillInfo(id)
	if id == nil then
		return
	end

	local needAdd = true

	for i = 1, #self._skill_usages do
		local data = self._skill_usages[i]

		if data.skill_id == id then
			data.skill_num = data.skill_num + 1
			needAdd = false

			break
		end
	end

	if needAdd then
		table.insert(self._skill_usages, {
			skill_num = 1,
			skill_id = id
		})
	end
end

function LengZhou6StatHelper:setPlayerAndEnemyHp(playerHp, enemyHp)
	self._playerHp = playerHp
	self._enemyHp = enemyHp
end

function LengZhou6StatHelper:sendGameExit()
	local player = LengZhou6GameModel.instance:getPlayer()
	local enemy = LengZhou6GameModel.instance:getEnemy()

	if player and enemy then
		self:setPlayerAndEnemyHp(player:getHp(), enemy:getHp())
	end

	StatController.instance:track(StatEnum.EventName.ExitHissabethActivity, {
		[StatEnum.EventProperties.LengZhou6_EpisodeId] = tostring(self._episodeId),
		[StatEnum.EventProperties.LengZhou6_EndlessLibraryRound] = (self._isEndless or nil) and tostring(LengZhou6GameModel.instance:getEndLessModelLayer()),
		[StatEnum.EventProperties.LengZhou6_Result] = tostring(self._result),
		[StatEnum.EventProperties.LengZhou6_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.LengZhou6_TotalRound] = self._useRound,
		[StatEnum.EventProperties.LengZhou6_OurRemainingHP] = self._playerHp,
		[StatEnum.EventProperties.LengZhou6_EnemyRemainingHP] = self._enemyHp,
		[StatEnum.EventProperties.LengZhou6_SkillId] = self._skill_ids,
		[StatEnum.EventProperties.LengZhou6_SkillUsage] = self._skill_usages
	})
end

LengZhou6StatHelper.instance = LengZhou6StatHelper.New()

return LengZhou6StatHelper

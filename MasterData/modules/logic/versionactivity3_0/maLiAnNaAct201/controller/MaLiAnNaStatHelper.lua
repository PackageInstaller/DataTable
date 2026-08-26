-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/controller/MaLiAnNaStatHelper.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaLiAnNaStatHelper", package.seeall)

local MaLiAnNaStatHelper = class("MaLiAnNaStatHelper")

function MaLiAnNaStatHelper:ctor()
	self._episodeId = "0"
	self._result = 0
	self._beginTime = 0
	self._soliderHero = {}
	self._skill_usages = {}
end

function MaLiAnNaStatHelper:enterEpisode(episodeId)
	self._episodeId = tostring(episodeId)
	self._beginTime = os.time()

	tabletool.clear(self._soliderHero)
	tabletool.clear(self._skill_usages)
end

function MaLiAnNaStatHelper:addUseSkillInfo(id)
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

function MaLiAnNaStatHelper:sendGameExit(result, failType)
	local allSolider = MaLiAnNaLaSoliderMoUtil.instance:getAllHeroSolider(Activity201MaLiAnNaEnum.CampType.Player)

	if allSolider then
		for i = 1, #allSolider do
			local solider = allSolider[i]

			table.insert(self._soliderHero, {
				soldierid = solider:getConfigId(),
				hp = solider:getHp()
			})
		end
	end

	local gameTime = Activity201MaLiAnNaGameModel.instance:getGameTime()

	StatController.instance:track(StatEnum.EventName.ExitMaLiAnNaActivity, {
		[StatEnum.EventProperties.MaLiAnNa_EpisodeId] = self._episodeId,
		[StatEnum.EventProperties.MaLiAnNa_Result] = tostring(result),
		[StatEnum.EventProperties.MaLiAnNa_UseTime] = os.time() - self._beginTime,
		[StatEnum.EventProperties.MaLiAnNa_TotalRound] = gameTime,
		[StatEnum.EventProperties.MaLiAnNa_FailureCondition] = tostring(failType),
		[StatEnum.EventProperties.MaLiAnNa_OurRemainingHpArray] = self._soliderHero,
		[StatEnum.EventProperties.MaLiAnNa_SkillUsage] = self._skill_usages
	})
end

MaLiAnNaStatHelper.instance = MaLiAnNaStatHelper.New()

return MaLiAnNaStatHelper

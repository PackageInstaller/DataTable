-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/controller/battlemgr/MiracleHeroRoundMgr.lua

module("logic.extensions.miraclehero.controller.battlemgr.MiracleHeroRoundMgr", package.seeall)

local MiracleHeroRoundMgr = class("MiracleHeroRoundMgr")

function MiracleHeroRoundMgr:ctor()
	self.id = 0
	self.roundIndex = 0
	self.curStepCount = 0
	self.curRoundIndex = 1
	self.endRoundIndex = 0
	self._roundList = {}
	self.objectPool = nil
	self.myTeamFinish = false
	self.enemyTeamFinish = false
	self.endRoundReportMos = {}

	local function resetFunc()
		return
	end

	local function disposeFunc()
		return
	end

	self.reportPool = ObjectPool.New(100, nil, disposeFunc, resetFunc)
end

function MiracleHeroRoundMgr:initData(activityId)
	self._activityId = activityId
	self.id = MiracleHeroBattleModel.instance:getBattleIndex()
	self.roundIndex = 0
	self.curStepCount = 0
	self.curRoundIndex = 1
	self.endRoundIndex = 0

	for i, roundMo in pairs(self._roundList) do
		local skillMo = roundMo.skillMo

		if skillMo then
			for j, reportMo in ipairs(skillMo.reportMos) do
				self:returnReportMo(reportMo)
			end
		end
	end

	for i, mos in pairs(self.endRoundReportMos) do
		for j, reportMo in pairs(mos) do
			self:returnReportMo(reportMo)
		end
	end

	self.endRoundReportMos = {}
	self._roundList = {}
	self.objectPool = nil
	self.myTeamFinish = false
	self.enemyTeamFinish = false
end

function MiracleHeroRoundMgr:getBigRound()
	return self.roundIndex
end

function MiracleHeroRoundMgr:startBigRound()
	self.roundIndex = self.roundIndex + 1
	self.enemyTeamFinish = false
	self.myTeamFinish = false
end

function MiracleHeroRoundMgr:startRound()
	self.roundRuning = true
	self.runingTeam = self:getCurTeamType()

	local roundMo = MiracleHeroRoundMgr.instance:getTopRound()
	local enemyTeamId = MiracleHeroTeamType.EnemyTeam

	if roundMo.skillMo.targetA and roundMo.skillMo.targetA ~= 0 then
		local petMo = MiracleHeroUnitMgr.instance:getPet(roundMo.skillMo.targetA)

		if petMo.teamId == MiracleHeroTeamType.EnemyTeam then
			enemyTeamId = MiracleHeroTeamType.MyTeam
		end
	end

	roundMo.skillMo.targetB = MiracleHeroSkillMgr.instance:getSkillTarget(enemyTeamId, roundMo.skillMo.configId)

	roundMo.skillMo:onStart()
	roundMo.skillMo:hpChange()
	roundMo.skillMo:onEnd()

	self.isUsingSupportSkill = roundMo.skillMo.isSupportSkill
end

function MiracleHeroRoundMgr:endRound()
	self:popTopRound()

	if MiracleHeroRoundMgr.instance:getTopRound() then
		return
	end

	if self.isUsingSupportSkill == true then
		self.isUsingSupportSkill = false

		return
	end

	self.curStepCount = self.curStepCount + 1

	local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(self.runingTeam)

	if self.curStepCount >= teamMo:getSurvalPetNum() then
		if self.runingTeam == MiracleHeroTeamType.MyTeam then
			self.myTeamFinish = true
		else
			self.enemyTeamFinish = true
		end

		self.curStepCount = 0
	end
end

function MiracleHeroRoundMgr:endBigRound()
	MiracleHeroSkillMgr.instance:setSupportColdDown()

	self.endRoundReportMos[self.roundIndex] = MiracleHeroBuffMgr.instance:reduceAllBuffTier()
end

function MiracleHeroRoundMgr:getEndRoundReportMos(roundIndex)
	return self.endRoundReportMos[self.roundIndex] or {}
end

function MiracleHeroRoundMgr:createAndAddEmptyRound()
	local roundMo = MiracleHeroRoundMgr.instance:getEndRound()

	if not roundMo or roundMo.isInit == true then
		roundMo = MiracleHeroRoundMo.New()

		table.insert(self._roundList, roundMo)

		roundMo.isInit = false
		self.endRoundIndex = self.endRoundIndex + 1
	end
end

function MiracleHeroRoundMgr:addRound(skillMo, teamId)
	local skillCfg = MiracleHeroConfig.instance:getSkillCfg(skillMo.configId)

	if skillCfg.funtionType == GameEnum.SkillFuncType.BuffOnly then
		local insertSkillMo = skillMo

		insertSkillMo.skillCurBatterCount = 1

		local roundMo = MiracleHeroRoundMgr.instance:getEndRound()

		if not roundMo or roundMo.isInit == true then
			roundMo = MiracleHeroRoundMo.New()

			table.insert(self._roundList, roundMo)

			self.endRoundIndex = self.endRoundIndex + 1
		end

		roundMo.roundIndex = self.roundIndex
		roundMo.isInit = true
		roundMo.skillMo = insertSkillMo
		roundMo.teamId = teamId
	else
		for i = 1, skillCfg.attackCount do
			local insertSkillMo = skillMo

			if i > 1 then
				insertSkillMo = MiracleHeroSkillMgr.instance:getCloneSkillMo(skillMo)
			end

			insertSkillMo.skillCurBatterCount = i

			local roundMo = MiracleHeroRoundMgr.instance:getEndRound()

			if not roundMo or roundMo.isInit == true then
				roundMo = MiracleHeroRoundMo.New()

				table.insert(self._roundList, roundMo)

				self.endRoundIndex = self.endRoundIndex + 1
			end

			roundMo.roundIndex = self.roundIndex
			roundMo.isInit = true
			roundMo.skillMo = insertSkillMo
			roundMo.teamId = teamId
		end
	end
end

function MiracleHeroRoundMgr:popTopRound()
	local roundMo = MiracleHeroRoundMgr.instance:getTopRound()

	if roundMo and roundMo.isInit == true then
		self.curRoundIndex = self.curRoundIndex + 1
	end
end

function MiracleHeroRoundMgr:getTopRound()
	return self._roundList[self.curRoundIndex]
end

function MiracleHeroRoundMgr:getEndRound()
	return self._roundList[self.endRoundIndex]
end

function MiracleHeroRoundMgr:getCurTeamType()
	local isMyTeamFirst = MiracleHeroUnitMgr.instance:getFirstTeamType() == MiracleHeroTeamType.MyTeam

	if isMyTeamFirst then
		if not self.myTeamFinish then
			return MiracleHeroTeamType.MyTeam
		elseif not self.enemyTeamFinish then
			return MiracleHeroTeamType.EnemyTeam
		end
	elseif not self.enemyTeamFinish then
		return MiracleHeroTeamType.EnemyTeam
	elseif not self.myTeamFinish then
		return MiracleHeroTeamType.MyTeam
	end

	return nil
end

function MiracleHeroRoundMgr:createEnemySkill()
	local skillMo = MiracleHeroSkillMgr.instance:getEnemySkill(self.curStepCount + 1)

	if skillMo then
		local skillCfg = MiracleHeroConfig.instance:getSkillCfg(skillMo.configId)

		MiracleHeroSkillMgr.instance:useEnemySkill(skillMo.targetA, skillCfg.type)
		self:addRound(skillMo, MiracleHeroTeamType.EnemyTeam)
	end
end

function MiracleHeroRoundMgr:getBigRoundList(roundIndex)
	local roundList = {}

	for i = self.endRoundIndex, 1, -1 do
		local roundMo = self._roundList[i]

		if roundMo.roundIndex == roundIndex then
			table.insert(roundList, 1, roundMo)
		end
	end

	return roundList
end

function MiracleHeroRoundMgr:getRuningTeam()
	return self.runingTeam
end

function MiracleHeroRoundMgr:getCurStepCount()
	return self.curStepCount
end

function MiracleHeroRoundMgr:getNewReportMo()
	local reportMo = self.reportPool:fetchObject()

	reportMo = reportMo or MiracleHeroReportMo.New()

	return reportMo
end

function MiracleHeroRoundMgr:returnReportMo(mo)
	mo:reset()
	self.reportPool:returnObject(mo)
end

MiracleHeroRoundMgr.instance = MiracleHeroRoundMgr.New()

return MiracleHeroRoundMgr

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/battleMo/MiracleHeroSkillMo.lua

module("logic.extensions.miraclehero.model.battleMo.MiracleHeroSkillMo", package.seeall)

local MiracleHeroSkillMo = class("MiracleHeroSkillMo")

function MiracleHeroSkillMo:ctor()
	self.battleId = 0
	self.configId = 0
	self.isSupportSkill = false
	self.targetA = 0
	self.targetB = {}
	self.skillCurBatterCount = 1
	self.energy = 0
	self.isDone = false
	self.reportMos = {}
end

function MiracleHeroSkillMo:initData()
	self.skillCfg = MiracleHeroConfig.instance:getSkillCfg(self.configId)
end

function MiracleHeroSkillMo:onStart()
	local buffCfgs = MiracleHeroConfig.instance:getAffixBySkillId(self.configId)
	local targetAPetMo = MiracleHeroUnitMgr.instance:getPet(self.targetA)

	if targetAPetMo then
		if not targetAPetMo.teamId then
			local targetATeamType = MiracleHeroTeamType.MyTeam
			local targetBTeamType = MiracleHeroTeamType.EnemyTeam

			if targetATeamType ~= MiracleHeroTeamType.MyTeam then
				targetBTeamType = MiracleHeroTeamType.MyTeam
			end

			if #buffCfgs > 0 then
				for i, buffId in ipairs(buffCfgs) do
					local buffCfg = MiracleHeroConfig.instance:getSkillAffixCfg(buffId)
					local params = string.split(buffCfg.buffType, "-")
					local targetList = {}

					if params[1] == "我方" then
						if params[2] == "目标" then
							table.insert(targetList, self.targetA)
						elseif params[2] == GameEnum.FRONT_PET then
							local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(targetATeamType)

							for j, v in pairs(teamMo.pos) do
								if j < 3 and MiracleHeroUnitMgr.instance:isPetSurvival(v) then
									table.insert(targetList, v)
								end
							end
						elseif params[2] == GameEnum.BACK_PET then
							local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(targetATeamType)

							for j, v in pairs(teamMo.pos) do
								if j >= 3 and MiracleHeroUnitMgr.instance:isPetSurvival(v) then
									table.insert(targetList, v)
								end
							end
						elseif params[2] == "全体" then
							local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(targetATeamType)

							for j, v in pairs(teamMo.pos) do
								if MiracleHeroUnitMgr.instance:isPetSurvival(v) then
									table.insert(targetList, v)
								end
							end
						end
					elseif params[1] == "敌方" then
						if params[2] == "目标" then
							targetList = self.targetB
						elseif params[2] == GameEnum.FRONT_PET then
							local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(targetBTeamType)

							for j, v in pairs(teamMo.pos) do
								if j < 3 and MiracleHeroUnitMgr.instance:isPetSurvival(v) then
									table.insert(targetList, v)
								end
							end
						elseif params[2] == GameEnum.BACK_PET then
							local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(targetBTeamType)

							for j, v in pairs(teamMo.pos) do
								if j >= 3 and MiracleHeroUnitMgr.instance:isPetSurvival(v) then
									table.insert(targetList, v)
								end
							end
						elseif params[2] == "全体" then
							local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(targetBTeamType)

							for j, v in pairs(teamMo.pos) do
								if MiracleHeroUnitMgr.instance:isPetSurvival(v) then
									table.insert(targetList, v)
								end
							end
						end
					end

					for j, v in ipairs(targetList) do
						if not self.reportMos[v] then
							local reportMo = MiracleHeroRoundMgr.instance:getNewReportMo()

							reportMo.petId = v

							table.insert(reportMo.buffIds, buffId)

							local buffMo = MiracleHeroBuffMgr.instance:createBuffMo(buffCfg)

							if buffMo.buffType == MiracleHeroBuffType.PropertyChange and (buffMo.proertyType == GameEnum.AttrType.Hp or buffMo.proertyType == GameEnum.AttrType.HpRate) then
								local petMo = MiracleHeroUnitMgr.instance:getPet(v)
								local beforeCurHp = petMo.curHp
								local beforeMaxHp = petMo:getMaxHp()

								MiracleHeroBuffMgr.instance:addBuff(v, buffMo)

								local buffInfo = {
									buffId = buffId,
									changeHp = petMo.curHp - beforeCurHp,
									afterChangeHp = petMo.curHp,
									changeMaxHp = petMo:getMaxHp() - beforeMaxHp,
									afterChangeMaxHp = petMo:getMaxHp()
								}

								table.insert(reportMo.effectHpBuffIds, buffInfo)

								self.reportMos[v] = reportMo
							else
								MiracleHeroBuffMgr.instance:addBuff(v, buffMo)
							end
						end
					end
				end
			end
		end
	end
end

function MiracleHeroSkillMo:hpChange()
	local petMoA = MiracleHeroUnitMgr.instance:getPet(self.targetA)
	local totalAttack = 0
	local totalCriticalRate = 0

	if petMoA then
		totalAttack = petMoA.attack

		for i, v in ipairs(petMoA.buffList) do
			local buffMo = MiracleHeroBuffMgr.instance:getBuff(v)

			if buffMo.buffType == MiracleHeroBuffType.PropertyChange then
				if buffMo.proertyType == GameEnum.AttrType.AttackRate then
					totalAttack = totalAttack + petMoA.attack * buffMo.changeValue
				elseif buffMo.proertyType == GameEnum.AttrType.Attack then
					totalAttack = totalAttack + buffMo.changeValue
				end
			end
		end

		totalAttack = totalAttack * self:getDamageRate()
		totalCriticalRate = petMoA.criticalRate

		for i, v in ipairs(petMoA.buffList) do
			local buffMo = MiracleHeroBuffMgr.instance:getBuff(v)

			if buffMo.buffType == MiracleHeroBuffType.PropertyChange and buffMo.proertyType == GameEnum.AttrType.CriticalRate then
				totalCriticalRate = buffMo.rateType == true and totalCriticalRate + petMoA.criticalRate * buffMo.changeValue or totalCriticalRate + buffMo.changeValue
			end
		end
	end

	for i, v in ipairs(self.targetB) do
		local totalDamage = totalAttack
		local reportMo = self.reportMos[v]

		if not reportMo then
			reportMo = MiracleHeroRoundMgr.instance:getNewReportMo()
			reportMo.petId = v
			self.reportMos[reportMo.petId] = reportMo
		end

		local petMoB = MiracleHeroUnitMgr.instance:getPet(v)
		local random = math.random(1, 10000)
		local isCritical = random <= totalCriticalRate * 10000

		if isCritical then
			totalDamage = totalDamage * petMoA.criticaDamage
		end

		local powerChange = 1

		if petMoA then
			for i, v in ipairs(petMoA.buffList) do
				local buffMo = MiracleHeroBuffMgr.instance:getBuff(v)

				totalDamage = buffMo:onDamage(totalDamage)
				powerChange = buffMo:onAttackPowerChange(powerChange)
			end
		end

		for i, v in ipairs(petMoB.buffList) do
			local buffMo = MiracleHeroBuffMgr.instance:getBuff(v)

			powerChange = buffMo:onDefendPowerChange(powerChange)
		end

		totalDamage = totalDamage * math.max(0, powerChange)
		totalDamage = math.floor(totalDamage)

		petMoB:reduceHp(totalDamage)

		reportMo.isCritical = isCritical
		reportMo.attackHps = -totalDamage
		reportMo.createDamage = self.skillCfg.funtionType == GameEnum.SkillFuncType.Hurt
	end
end

function MiracleHeroSkillMo:onEnd()
	for i, v in pairs(self.reportMos) do
		local petMo = MiracleHeroUnitMgr.instance:getPet(v.petId)

		v.afterRoundHp = petMo.curHp
	end
end

function MiracleHeroSkillMo:getReportMoList()
	return table.values(self.reportMos)
end

function MiracleHeroSkillMo:getDamageRate()
	local rateCfg = MiracleHeroConfig.instance:getDamageRateCfg(self.energy)

	return rateCfg.damageRate * self.skillCfg.damageRate
end

function MiracleHeroSkillMo:isDone()
	return self.isDone
end

return MiracleHeroSkillMo

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/MoyanController.lua

module("logic.extensions.timelimitedchallenge.controller.MoyanController", package.seeall)

local MoyanController = class("MoyanController", BaseController)

function MoyanController:ctor()
	MoyanController.super.ctor(self)
end

function MoyanController:onInit()
	self:onReset()
end

function MoyanController:onReset()
	self.syspetListMap = {}
	self.sysFormationMo = FormationMO.New()
end

function MoyanController:sendGetInfo(challengeId)
	MoyanModel.instance:sendGetInfo(challengeId)
end

function MoyanController:getGetBattleEnterInfo(challengeId)
	MoyanModel.instance:getGetBattleEnterInfo(challengeId)
end

function MoyanController:getSingleChanllengeInfo(challengeId, type)
	MoyanModel.instance:getSingleChanllengeInfo(challengeId, type)
end

function MoyanController:sendGetProgressPrize(challengeId, prizeId)
	MoyanModel.instance:sendGetProgressPrize(challengeId, prizeId)
end

function MoyanController:sendResetChallenge(challengeId, type)
	MoyanModel.instance:sendResetChallenge(challengeId, type)
end

function MoyanController:sendSweep(challengeId, type)
	MoyanModel.instance:sendSweep(challengeId, type)
end

function MoyanController:sendBuyTimes(challengeId, stage)
	MoyanModel.instance:sendBuyTimes(challengeId, stage)
end

function MoyanController:sendFight(challengeId, type, stage, fmo)
	MoyanModel.instance:sendFight(challengeId, type, stage, fmo)
end

function MoyanController:getPetHpById(params, petId)
	if params then
		local type = params.type
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)
		local mo = MoyanModel.instance:getSingleInfo(challengeId, type)

		if checknumber(cfg.handler) == 101 then
			local selfSysPetHpInfos

			if mo.linearSysPetTypeInfo then
				selfSysPetHpInfos = mo.linearSysPetTypeInfo.selfSysPetHpInfos
			end

			if selfSysPetHpInfos then
				for i, v in ipairs(selfSysPetHpInfos) do
					if v.id == petId then
						return v.hpRatio / 10000
					end
				end
			end

			return 1
		elseif checknumber(cfg.handler) == 201 then
			local selfSysPetHpInfos

			if mo.randomSelfPetTypeInfo then
				selfSysPetHpInfos = mo.randomSelfPetTypeInfo.selfPetHpInfos
			end

			if selfSysPetHpInfos then
				for i, v in ipairs(selfSysPetHpInfos) do
					if v.id == petId then
						return v.hpRatio / 10000
					end
				end
			end

			return 1
		end
	end

	return 1
end

function MoyanController:getEnemyPetHpById(params, stageId, petId)
	if params then
		local type = params.type
		local stageId = params.stageId
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)
		local mo = MoyanModel.instance:getSingleInfo(challengeId, type)

		if checknumber(cfg.handler) == 101 then
			local selfSysPetHpInfos

			if mo.linearSysPetTypeInfo and mo.linearSysPetTypeInfo.stageCreepsHpInfo and mo.linearSysPetTypeInfo.stageCreepsHpInfo.stage == stageId then
				selfSysPetHpInfos = mo.linearSysPetTypeInfo.stageCreepsHpInfo.enemyCreepsHpInfos
			end

			if selfSysPetHpInfos then
				for i, v in ipairs(selfSysPetHpInfos) do
					if v.id == petId then
						return v.hpRatio / 10000
					end
				end
			end

			return 1
		elseif checknumber(cfg.handler) == 201 then
			local selfSysPetHpInfos

			if mo.randomSelfPetTypeInfo and mo.randomSelfPetTypeInfo.stageCreepsHpInfo then
				for i, v in ipairs(mo.randomSelfPetTypeInfo.stageCreepsHpInfo) do
					if v.stage == stageId then
						selfSysPetHpInfos = v.enemyCreepsHpInfos

						break
					end
				end
			end

			if selfSysPetHpInfos then
				for i, v in ipairs(selfSysPetHpInfos) do
					if v.id == petId then
						return v.hpRatio / 10000
					end
				end
			end

			return 1
		end
	end

	return 1
end

function MoyanController:GetCurFormation(params)
	if params then
		local type = params.type
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)

		if checknumber(cfg.systemPetPlan) > 0 then
			return self.sysFormationMo
		end
	end

	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function MoyanController:getPetListInMission(params)
	local cCfg
	local systemPetPlan = 0

	if params then
		local type = params.type
		local challengeId = params.challengeId
		local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
		local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)

		systemPetPlan = checknumber(cfg.systemPetPlan)
	end

	if systemPetPlan > 0 then
		return MoyanController.instance:getPetList(systemPetPlan)
	else
		return (BagPetsController.instance:getFightBagPet())
	end
end

function MoyanController:getPetList(systemPetPlan)
	local cfgList = MoyanConfig.instance:getSysPetListCfg(systemPetPlan)

	if cfgList and self.syspetListMap[systemPetPlan] == nil then
		self.syspetListMap[systemPetPlan] = {}

		for i, v in pairs(cfgList) do
			local fmo = FightingPowerPetMo.New()

			fmo:fromChallengeCreepCo(v)

			local petMo = fmo:toBaseBagPetMo()

			table.insert(self.syspetListMap[systemPetPlan], petMo)
		end
	end

	return self.syspetListMap[systemPetPlan]
end

function MoyanController:onBattleEnd(challengeId, type, stage)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isWin = MoyanModel.instance.isWin

	MoyanModel.instance.isWin = false

	UIJumper.instance:pushOneStack(ViewName.MoyanbattleView, true)

	local baseCfg = MoyanConfig.instance:getBaseConfig(challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, type)
	local stagePlan = cfg.stagePlan
	local fightList = MoyanConfig.instance:getMonsterCfgList(stagePlan)
	local mo = MoyanModel.instance:getSingleInfo(challengeId, type)

	if type == MoyanModel.TYPE_1 then
		do
			local tdPassedStage = 0
			local count = #fightList

			if not isWin or count > ((mo.linearSysPetTypeInfo or nil) and checknumber(mo.linearSysPetTypeInfo.tdPassedStage)) + 1 then
				UIJumper.instance:pushOneStack(ViewName.LiehuohonglianiView, true)
			end
		end
	elseif type == MoyanModel.TYPE_2 then
		do
			local tdPassedStages = {}
			local count = #fightList

			if not isWin or count > #((mo.randomSelfPetTypeInfo or nil) and (mo.randomSelfPetTypeInfo.tdPassedStages or {})) + 1 then
				UIJumper.instance:pushOneStack(ViewName.HonglianzhanfangView, true)
			end
		end
	elseif type == MoyanModel.TYPE_3 then
		if not MoyanModel.instance.bossDamageInfo then
			do
				local bossDamageInfo = {}
				local leftHp = bossDamageInfo.bossCurHp

				if leftHp > 0 then
					UIJumper.instance:pushOneStack(ViewName.HongliannvhuangView, true)
				end
			end

			local title = lang("战斗失败")
			local content = lang("未能击败敌阵全部精灵，战斗失败")
			local btnTxt = lang("知道了")

			if isWin then
				title = lang("战斗胜利")

				if type == MoyanModel.TYPE_1 or type == MoyanModel.TYPE_2 then
					local num = MoyanModel.instance.gainedScore

					content = num > 0 and langPara("击败敌阵全部精灵，破阵成功！\n\n获得了，红莲花x%s", num) or lang("击败敌阵全部精灵，破阵成功！")
				elseif type == MoyanModel.TYPE_3 then
					if not mo.bossDamageTypeInfo then
						local bossDamageTypeInfo = {}

						if not MoyanModel.instance.bossDamageInfo then
							local bossDamageInfo = {}
							local damage = bossDamageInfo.damage
							local leftHp = bossDamageInfo.bossCurHp

							bossDamageTypeInfo.bossCurHp = bossDamageInfo.bossCurHp
							content = langPara("本次对末炎造成伤害：%s\n末炎剩余血量：%s", damage, leftHp)
						end
					end
				end
			end

			TipsFacade.instance:openTipWindowValidX(title, content, function()
				BattleController.instance:endBattle()
			end, btnTxt, UnityEngine.TextAnchor.MiddleCenter)

			return true
		end
	end
end

MoyanController.instance = MoyanController.New()

return MoyanController

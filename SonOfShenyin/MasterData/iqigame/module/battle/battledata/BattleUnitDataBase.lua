-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattleUnitDataBase.lua

local BattlePODData = require("IQIGame.Module.Battle.BattleData.BattlePODData")
local BattleSkillData = require("IQIGame.Module.Battle.BattleData.BattleSkillData")
local BattlePreviewSkillData = require("IQIGame.Module.Battle.BattleData.BattlePreviewSkillData")
local BattleUnitDataBase = Clone(BattlePODData)

BattleUnitDataBase.commonSkillCD = 0
BattleUnitDataBase.skillsData = {}
BattleUnitDataBase.previewSkillData = {}
BattleUnitDataBase.joinBattle = false
BattleUnitDataBase.isTroopData = false

function BattleUnitDataBase:__InitUnitDataByPOD(pod)
	self:__InitPODData(pod)
	self:__InitSkillsData(pod)

	if not self.isTroopData then
		self:__InitPreviewSkillData(pod)
	end
end

function BattleUnitDataBase:__InitSkillsData(podData)
	self.commonSkillCD = type(podData.CommonSkillCD) == "number" and podData.CommonSkillCD or 0
	self.skillsData = {}

	for i = 1, #podData.Skills do
		local skillConfigID = podData.Skills[i]
		local skill = BattleSkillData.New(skillConfigID)

		skill:UpdateCoolDown(podData.SkillCD[skillConfigID])

		if podData.SkillCostEnergy ~= nil then
			skill:UpdateEnergyCost(podData.SkillCostEnergy[skillConfigID])
		end

		skill:UpdateAPCost(podData.SkillCostAP[skillConfigID])
		skill:UpdateLevel(podData.SkillsLevel[skillConfigID])
		skill:UpdatePurifyLv(podData.SkillPurifyLv[skillConfigID])
		skill:UpdateStrengthLv(podData.SkillStrengLv[skillConfigID])
		skill:UpdateUserLimit(podData.SkillReleaseLimit[skillConfigID])
		skill:UpdateSkillTargetTypeID(podData.SkillTarget[skillConfigID])

		self.skillsData[skillConfigID] = skill
	end
end

function BattleUnitDataBase:GetSkillRealCD(skillCid, includeCommonCD)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		return 0
	end

	if includeCommonCD == false then
		return skillData.coolDown
	end

	return math.max(self.commonSkillCD, skillData.coolDown)
end

function BattleUnitDataBase:IsSkillInCD(skillCid)
	if self.commonSkillCD > 0 then
		return true
	end

	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		return false
	end

	return skillData.coolDown > 0
end

function BattleUnitDataBase:GetSkillData(skillCid)
	return self.skillsData[skillCid]
end

function BattleUnitDataBase:GetSkillBySkillType(skillType, checkShow)
	local result

	ForPairs(self.skillsData, function(_, _skillData)
		if _skillData.skillType ~= skillType then
			return
		end

		if not _skillData.valid then
			return
		end

		if checkShow and _skillData.disableManual then
			return
		end

		result = _skillData

		return true
	end)

	return result
end

function BattleUnitDataBase:UpdateCommonSkillCD(cd)
	self.commonSkillCD = cd
end

function BattleUnitDataBase:UpdateSkillCD(skillCid, cd)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能CD 失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateCoolDown(cd)
end

function BattleUnitDataBase:UpdateSkillEnergyCost(skillCid, cost)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能消耗失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateEnergyCost(cost)
	EventDispatcher.Dispatch(EventID.BattleSkillEnergyCostChange, self.battleUnitID, skillCid)
end

function BattleUnitDataBase:UpdateSkillAPCost(skillCid, cost)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能消耗失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateAPCost(cost)
	EventDispatcher.Dispatch(EventID.BattleSkillAPCostChange, self.battleUnitID, skillCid)
end

function BattleUnitDataBase:UpdateSkillLevel(skillCid, level)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能等级失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateLevel(level)
end

function BattleUnitDataBase:UpdateSkillUsedLimit(skillCid, limit)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能使用限制次数失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateUserLimit(limit)
end

function BattleUnitDataBase:UpdateSkillUsedCount(skillCid, count)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能使用次数失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateSKillUsedCount(count)
end

function BattleUnitDataBase:UpdateSkillSealState(skillCid, isSeal)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能锁定状态失败，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateSkillSealState(isSeal)
end

function BattleUnitDataBase:UpdateSkillTargetTypeID(skillCid, targetTypeID)
	local skillData = self.skillsData[skillCid]

	if skillData == nil then
		logError("战斗单位 {0} 更新技能目标，找不到技能ID {1}", self.battleUnitID, skillCid)

		return
	end

	skillData:UpdateSkillTargetTypeID(targetTypeID)
end

function BattleUnitDataBase:RemoveSkill(skillCid)
	self.skillsData[skillCid] = nil
end

function BattleUnitDataBase:AddSkill(battleUpdateUnitPOD)
	local skillCid = battleUpdateUnitPOD.Param[1]
	local skillData = self.skillsData[skillCid]

	if skillData ~= nil then
		logError("战斗单位 {0} 新增技能失败，当前已有相同ID的技能存在{1}", self.battleUnitID, skillCid)
	else
		skillData = BattleSkillData.New(skillCid)
	end

	skillData:UpdateCoolDown(battleUpdateUnitPOD.Param[2])
	skillData:UpdateEnergyCost(battleUpdateUnitPOD.Param[3])
	skillData:UpdateAPCost(battleUpdateUnitPOD.Param[4])
	skillData:UpdateLevel(battleUpdateUnitPOD.Param[5])
	skillData:UpdatePurifyLv(battleUpdateUnitPOD.Param[6])
	skillData:UpdateStrengthLv(battleUpdateUnitPOD.Param[7])
	skillData:UpdateUserLimit(battleUpdateUnitPOD.Param[9])
	skillData:UpdateSkillTargetTypeID(battleUpdateUnitPOD.Param[10])

	self.skillsData[skillCid] = skillData

	local timelineCid = battleUpdateUnitPOD.Param[8]

	self.PODData.SkillSkinId[skillCid] = timelineCid

	BattleTimelineModule.AddSkillTimeline(self.battleUnitID, skillCid, timelineCid)
end

function BattleUnitDataBase:OnAPChange(ap, addAP)
	self.PODData.AP = ap

	if self.battleUnitID ~= BattleModule.attackTeamBattleUnitID then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleUnitAPChange, self.battleUnitID, addAP)
end

function BattleUnitDataBase:OnMaxAPChange(maxAP)
	self.PODData.MaxAP = maxAP

	if self.battleUnitID ~= BattleModule.attackTeamBattleUnitID then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleUnitMaxAPChange, self.battleUnitID)
end

function BattleUnitDataBase:GetAPData()
	return self.PODData.AP, self.PODData.MaxAP
end

function BattleUnitDataBase:__InitPreviewSkillData(pod)
	local skillCid = pod.PreviewSkillCid

	self.previewSkillData = BattlePreviewSkillData.New(skillCid, pod.PreviewSkillTarget)
end

function BattleUnitDataBase:UpdatePreviewSkillData(battleUpdateUnitPOD)
	local skillCid = battleUpdateUnitPOD.Param[1]

	if self.previewSkillData.skillCid ~= skillCid then
		self.previewSkillData = BattlePreviewSkillData.New(skillCid, nil)
	end

	self.previewSkillData:UpdateTargetTilePosTable(battleUpdateUnitPOD.Param)
	EventDispatcher.Dispatch(EventID.BattleUnitPreviewSkillChange, self.battleUnitID, skillCid)
end

function BattleUnitDataBase:GetAttackTargetData(troopType, battlePos)
	local targetTroopType = self:GetPreviewSkillTargetTroop()

	if targetTroopType < 0 then
		return nil
	end

	if targetTroopType ~= troopType then
		return nil
	end

	return self.previewSkillData.targetTilePosTable[battlePos]
end

function BattleUnitDataBase:GetPreviewSkillTargetTroop()
	if self.previewSkillData == nil then
		return -99
	end

	if self.previewSkillData.skillCid == 0 then
		return -99
	end

	local skillData = self.skillsData[self.previewSkillData.skillCid]
	local targetTroopType = BattleModule.defineBattleTroopType

	if skillData:TargetIsFriendly() then
		targetTroopType = self.troopType
	elseif self.troopType == BattleModule.defineBattleTroopType then
		targetTroopType = BattleModule.attackBattleTroopType
	else
		targetTroopType = BattleModule.defineBattleTroopType
	end

	return targetTroopType
end

return BattleUnitDataBase

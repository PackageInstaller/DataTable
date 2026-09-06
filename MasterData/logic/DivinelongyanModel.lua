-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/model/DivinelongyanModel.lua

module("logic.extensions.divinelongyan.view.DivinelongyanModel", package.seeall)

local DivinelongyanModel = class("DivinelongyanModel", BaseModel)

function DivinelongyanModel:ctor()
	return
end

function DivinelongyanModel:onInit()
	self:onReset()
end

function DivinelongyanModel:onReset()
	self._msgInfos = {}
	self._activityId = 0
	self._powerFmtMo = DivineLongyanFmtMo.New()
	self._lineFmtMo = DivineLongyanFmtMo.New()
end

function DivinelongyanModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivinelongyanModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivinelongyanModel:setActivieyId(activityId)
	self._activityId = activityId
end

function DivinelongyanModel:getActivityId()
	return self._activityId
end

function DivinelongyanModel:getActivityId()
	return self._activityId
end

function DivinelongyanModel:getPowerFmtMo()
	return self._powerFmtMo
end

function DivinelongyanModel:getlineFmtMo()
	return self._lineFmtMo
end

function DivinelongyanModel:updatePowerStage(activityId, stageId)
	local info = self:getInfo(activityId)

	if info then
		info.powerStageFinishIds = info.powerStageFinishIds or {}

		table.insert(info.powerStageFinishIds, stageId)
	end
end

function DivinelongyanModel:getCurLineStageId(activityId)
	local info = self:getInfo(activityId)

	if info then
		return info.curLineStageId
	end

	return 0
end

function DivinelongyanModel:updateLineStage(activityId)
	local info = self:getInfo(activityId)

	if info then
		info.curLineStageId = info.curLineStageId + 1
	end
end

function DivinelongyanModel:updateSupportPet(activityId, supportPet)
	local info = self:getInfo(activityId)

	if info then
		info.supportPet = GameUtil.pbToTable(supportPet)
	end
end

function DivinelongyanModel:getSupportPet(activityId)
	local info = self:getInfo(activityId)

	if info then
		return info.supportPet
	end
end

function DivinelongyanModel:getCurSuppopPetMo(activityId)
	local support = self:getSupportPet(activityId)

	if support then
		local actCfg = DivinelongyanConfig.instance:getActCfg(activityId)
		local supportPetId = actCfg.supportPetId
		local fmo = FightingPowerPetMo.New()
		local supportCfg = DivinelongyanConfig.instance:getSupportPetCfg(supportPetId)

		fmo:fromChallengeCreepCo(supportCfg)

		local supCfg = DivinelongyanConfig.instance:getSupportPetLevelCfg(activityId, support.level)
		local petLvl = 1
		local extproperties = ""

		if supCfg then
			petLvl = supCfg.petLevel
			extproperties = supCfg.extproperties
		end

		local arr = FightingPowerFormula.instance:parseAttrValues(extproperties) or {}

		AttrMo.addSameAttrs(arr, fmo.extpropertiesArr)

		fmo.level = petLvl
		fmo.normalSkillLv = support.normalSkillLv
		fmo.ultimateSkillLv = support.ultimateSkillLv
		fmo.passiveSkillLv = support.passiveSkillLv
		fmo.psychicedNormalSkillLv = support.psychicedNormalSkillLv
		fmo.psychicedUltimateSkillLv = support.psychicedUltimateSkillLv
		fmo.petId = supportPetId

		fmo:setSupportedPet(true)

		return (fmo:toBaseBagPetMo())
	end

	return nil
end

DivinelongyanModel.instance = DivinelongyanModel.New()

return DivinelongyanModel

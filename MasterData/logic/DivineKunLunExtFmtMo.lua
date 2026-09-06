-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/model/DivineKunLunExtFmtMo.lua

module("logic.extensions.divinekunlun.model.DivineKunLunExtFmtMo", package.seeall)

local DivineKunLunExtFmtMo = class("DivineKunLunExtFmtMo", BaseCustomFmtMo)

function DivineKunLunExtFmtMo:onInit()
	DivineKunLunExtFmtMo.super.onInit(self)

	self.needUpPetCount = 6
end

function DivineKunLunExtFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local cfg = DivineKunlunConfig.instance:getExtremeCfgById(activityId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = DivineKunlunConfig.instance:getMonsterCfg(self.creepsMasterId)
	self.creeps = DivineKunlunConfig.instance:getCreeps(self.creepsMasterId)
	self._supportPetId = checknumber(cfg.psychicSysPetId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DivineKunLunExtFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
	self.validatorDescStr = ""

	local supportCfg = DivineKunlunConfig.instance:getSysPetById(self._supportPetId)

	if supportCfg then
		self.validatorDescStr = string.format("支援精灵:%s必须上阵", supportCfg.creepsName)
	end
end

function DivineKunLunExtFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineKunLunExtFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineKunLunExtFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineKunlunController.instance:sendStartExtFight(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function DivineKunLunExtFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local formationMo = self:getCurFormation()

	if not formationMo:HasPet(self._supportPetId) then
		local petMo = self:getPetMoById(self._supportPetId)

		FloatWordMgr.instance:show("必须上阵支援精灵：" .. petMo.name)

		return true
	else
		return DivineKunLunExtFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

function DivineKunLunExtFmtMo:_createSuppopPetMo(petId)
	local petMo
	local supportCfg = DivineKunlunConfig.instance:getSysPetById(petId)

	if supportCfg then
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(supportCfg)
		fmo:setSupportedPet(true)

		petMo = fmo:toBaseBagPetMo()
	end

	return petMo
end

function DivineKunLunExtFmtMo:updateData()
	self:tryInitPetList()

	if self._lastSupportId ~= self._supportPetId then
		self:tryRemovePetByIds(self._lastSupportId)

		if self._supportPetId > 0 then
			local supportPetMo = self:_createSuppopPetMo(self._supportPetId)

			self:addPetToList(self:_changePetMo(supportPetMo))

			local fmo = self:getCurFormation()

			fmo:SetPosition(5, self._supportPetId)
		end
	end

	self._lastSupportId = self._supportPetId
end

local emptyTb = {}
local oneTb = {}

function DivineKunLunExtFmtMo:getPsychicsPets()
	local formationMo = self:getCurFormation()

	if formationMo:HasPet(self._supportPetId) then
		oneTb[1] = self:getPetMoById(self._supportPetId)

		return oneTb
	end

	return emptyTb
end

function DivineKunLunExtFmtMo:onFmoSetDown()
	DivineKunLunExtFmtMo.super.onFmoSetDown(self)
	self:getCurFormation():SetPsychicedSkillId(0)

	local petMo = self:getPetMoById(self._supportPetId)

	if petMo then
		local petCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId)

		if petCo then
			self:getCurFormation():SetPsychicedSkillId(petCo.psychicSkillId)
		end
	end
end

function DivineKunLunExtFmtMo:checkBlockClickBtn(buttonName)
	if buttonName == "PsychicSkill" then
		FloatWordMgr.instance:show(lang("仅支援精灵生效通灵技"))

		return true
	end

	return false
end

return DivineKunLunExtFmtMo

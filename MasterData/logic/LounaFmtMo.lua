-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/louna/mo/LounaFmtMo.lua

module("logic.extensions.timelimitedchallenge.view.louna.mo.LounaFmtMo", package.seeall)

local LounaFmtMo = class("LounaFmtMo", ICustomFmtMo)

function LounaFmtMo:ctor()
	LounaFmtMo.super.ctor(self)
end

function LounaFmtMo:onReset()
	LounaFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function LounaFmtMo:initParams(params)
	self.activityId = params.activityId
	self.creepsMasterId = params.creepsMasterId

	local curTier = LounaModel.instance.curTier
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}
	local tierPlanId = checknumber(cfg.tierPlanId)
	local tierCfg = LounaConfig.instance:getTierCfgById(tierPlanId, curTier) or {}
	local creepsMasterPlanId = checknumber(tierCfg.creepsMasterPlanId)

	self.masterCfg = LounaConfig.instance:getMasterCfgById(creepsMasterPlanId, self.creepsMasterId)
	self.creeps = LounaConfig.instance:getCreepsCfg(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = "LounaFmtMo_" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function LounaFmtMo:initFightHandler()
	self:setFightHandler(function()
		LounaController.instance:sendStartFight(self.activityId, self.creepsMasterId, self:getCurSimpleForm())
	end, nil)
end

function LounaFmtMo:updateCellTop(cell, petMo)
	self:clearCellTop(cell)

	local ruleHandler = LounaController.instance:getCurRuleType()

	if ruleHandler == "DiePet" then
		local luaCls = PetHpSlider
		local url = PetHpSlider.prefabUrl
		local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

		if proxy then
			local hpRatio = LounaController.instance:getPetHpRatioAsUnit(petMo)

			proxy.binder:onUpdateHp(hpRatio / 10000)
		end
	elseif ruleHandler == "Formation" then
		-- block empty
	end
end

function LounaFmtMo:checkPetIsForbit(petMo)
	return LounaController.instance:checkIsLimit(petMo)
end

function LounaFmtMo:showForbitPetAlert(petMo)
	local ruleHandler = LounaController.instance:getCurRuleType()

	if ruleHandler == "DiePet" then
		if LounaModel.instance:getPetHp(petMo) <= 0 then
			FloatWordMgr.instance:show(lang("moyanfmtrightview__1"))
		end
	else
		FloatWordMgr.instance:show(lang("当前精灵上阵次数已被限制"))
	end
end

function LounaFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local isMatch = LounaFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip)
	local mo = self:getPetMoById(petId)
	local isNotLimit = not LounaController.instance:checkIsLimit(mo)

	return isMatch and isNotLimit
end

function LounaFmtMo:getMonsterConfigList()
	return self.creeps
end

function LounaFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function LounaFmtMo:initPetList()
	self:clearAllPetList()

	local map = {}
	local fmo = self:getCurFormation()

	if fmo then
		local pos = fmo:GetPositions()

		for k, v in pairs(pos) do
			map[v] = true
		end
	end

	local pets = BagPetsController.instance:getFightBagPet()
	local pool = {}

	ArraySort.sortOn(pets, function(mo)
		return (mo:getFightingPower())
	end, ArraySort.DESCENDING)

	for k, v in pairs(pets) do
		if v then
			local isMaster = BagPetsController.instance:checkPetIsActiveMaster(v)

			if pool[v.raceId] or isMaster or v:isSummonedPet() or map[v.petId] then
				if isMaster or v:isSummonedPet() then
					-- block empty
				else
					pool[v.raceId] = v
				end

				local mo = FightingPowerPetMo.getMaxPetMoByData(v)

				self:addPetToList(mo)
			end
		end
	end
end

function LounaFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		local mo = FightingPowerPetMo.getMaxPetMoByData(petMo)

		self:updatePetMo(mo)
	end
end

LounaFmtMo.instance = LounaFmtMo.New()

return LounaFmtMo

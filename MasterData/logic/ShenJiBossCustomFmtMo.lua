-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/model/ShenJiBossCustomFmtMo.lua

module("logic.extensions.shenjichallenge.model.ShenJiBossCustomFmtMo", package.seeall)

local ShenJiBossCustomFmtMo = class("ShenJiBossCustomFmtMo", ICustomFmtMo)

function ShenJiBossCustomFmtMo:initParams(activityId, bossId, isEmulate)
	self._activityId = activityId
	self._bossId = bossId
	self._isEmulate = isEmulate

	local cfgBoss = ShenJiChallengeConfig.instance:getBoss(activityId, bossId)

	self._monsterCfg = ShenJiChallengeConfig.instance:getMaster(cfgBoss.creepsMasterId)
	self._creepsCfgs = ShenJiChallengeConfig.instance:getCreeps(cfgBoss.creepsMasterId)
end

function ShenJiBossCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc
	self.validatorDescStr = self._isEmulate and "演习中可不消耗次数的预览Boss挑战的结果" or ""

	self:setFormCondition(self._monsterCfg.formCondition)

	local fmtMo = FormationModel.instance:getTeamFormation()
	local oldPosList = fmtMo:GetPositions()
	local newPosList = {}

	for i, petId in ipairs(oldPosList) do
		local isLock = ShenJiChallengeModel.instance:isPetLock(petId)

		newPosList[i] = isLock and 0 or petId
	end

	fmtMo.CloneFromFmoAndFix(fmtMo, fmtMo, newPosList)
end

function ShenJiBossCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function ShenJiBossCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function ShenJiBossCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()

		ShenJiChallengeController.instance:sendPM_ShenJiChallengeBossClgReq(self._activityId, self._bossId, form, self._isEmulate)
	end

	self:setFightHandler(handler, nil)
end

function ShenJiBossCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function ShenJiBossCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function ShenJiBossCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function ShenJiBossCustomFmtMo:checkPetIsForbit(petMo, baseCheck)
	return ShenJiChallengeModel.instance:isPetLock(petMo.petId)
end

function ShenJiBossCustomFmtMo:showForbitPetAlert(petMo)
	if ShenJiChallengeModel.instance:isPetLock(petMo.petId) then
		FloatWordMgr.instance:show(string.format("%s已经使用过,请使用其他精灵破阵", petMo.name))
	end
end

return ShenJiBossCustomFmtMo

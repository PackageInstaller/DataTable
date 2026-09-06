-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/model/DivineCiYuanExtremeFmtMo.lua

module("logic.extensions.divineciyuan.model.DivineCiYuanExtremeFmtMo", package.seeall)

local DivineCiYuanExtremeFmtMo = class("DivineCiYuanExtremeFmtMo", ICustomFmtMo)

function DivineCiYuanExtremeFmtMo:onReset()
	DivineCiYuanExtremeFmtMo.super.onReset(self)
end

function DivineCiYuanExtremeFmtMo:initParams(activityId, tabId, stageId, teamIndex)
	self._activityId = checknumber(activityId)
	self._activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._tabId = tabId
	self._stageId = stageId
	self._teamIndex = teamIndex
	self._teamId = 0
end

function DivineCiYuanExtremeFmtMo:updateData()
	self.isShowOneKey = true

	local tabCfg = DivineCiYuanConfig.instance:getTabCfgById(self._activityId, self._tabId)
	local stageCfg = DivineCiYuanConfig.instance:getExtremeStageCfgById(self._activityId, self._tabId, self._stageId)

	self._teamId = stageCfg.teamIds[self._teamIndex + 1]

	local cfg = DivineCiYuanConfig.instance:getMonsterCfg(self._teamId)

	self.topTitleStr = cfg.name
	self.validatorDescStr = cfg.WinDesc
	self.needUpPetCount = tabCfg.fullMonster and 9 or 5

	self:setFormCondition(cfg.formCondition)
end

function DivineCiYuanExtremeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineCiYuanController.instance:sendPM_DivineCiYuanExtremeChallengeReq(self._activityId, self._tabId, self._stageId, self._teamIndex, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineCiYuanExtremeFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return true
		end
	end

	return DivineCiYuanExtremeFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function DivineCiYuanExtremeFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineCiYuanExtremeFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineCiYuanExtremeFmtMo:getMonsterConfigList()
	return DivineCiYuanConfig.instance:getCreepCfg(self._teamId)
end

function DivineCiYuanExtremeFmtMo:getFmtInfoConfig()
	return DivineCiYuanConfig.instance:getMonsterCfg(self._teamId)
end

function DivineCiYuanExtremeFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self.needUpPetCount > 5 then
		posList, petPool = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petPool, posList, self:getCurFormation())
	end

	return posList, petPool
end

function DivineCiYuanExtremeFmtMo:checkPetIsForbit(petMo)
	local lockPetIds = DivineCiYuanModel.instance:getExtremePetIds(self._tabId, self._stageId)

	return not not table.indexof(lockPetIds, petMo:getPetId())
end

return DivineCiYuanExtremeFmtMo

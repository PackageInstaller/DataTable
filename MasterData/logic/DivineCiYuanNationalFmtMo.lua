-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/model/DivineCiYuanNationalFmtMo.lua

module("logic.extensions.divineciyuan.model.DivineCiYuanNationalFmtMo", package.seeall)

local DivineCiYuanNationalFmtMo = class("DivineCiYuanNationalFmtMo", ICustomFmtMo)

function DivineCiYuanNationalFmtMo:onReset()
	DivineCiYuanNationalFmtMo.super.onReset(self)
end

function DivineCiYuanNationalFmtMo:initParams(activityId, tabId, bossId)
	self._activityId = activityId
	self._tabId = tabId
	self._bossId = bossId
end

function DivineCiYuanNationalFmtMo:updateData()
	self.isShowOneKey = true

	local info = DivineCiYuanConfig.instance:getUniversalStageCfgById(self._activityId, self._tabId, self._bossId)
	local cfg = DivineCiYuanConfig.instance:getMonsterCfg(info.creepsMasterId)

	self.topTitleStr = cfg.name
	self.validatorDescStr = cfg.WinDesc

	self:setFormCondition(cfg.formCondition)
end

function DivineCiYuanNationalFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineCiYuanController.instance:sendPM_DivineCiYuanUniversalChallengeReq(self._activityId, self._tabId, self._bossId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineCiYuanNationalFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineCiYuanNationalFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivineCiYuanNationalFmtMo:getMonsterConfigList()
	local info = DivineCiYuanConfig.instance:getUniversalStageCfgById(self._activityId, self._tabId, self._bossId)

	return DivineCiYuanConfig.instance:getCreepCfg(info.creepsMasterId)
end

function DivineCiYuanNationalFmtMo:getFmtInfoConfig()
	local info = DivineCiYuanConfig.instance:getUniversalStageCfgById(self._activityId, self._tabId, self._bossId)

	return DivineCiYuanConfig.instance:getMonsterCfg(info.creepsMasterId)
end

return DivineCiYuanNationalFmtMo

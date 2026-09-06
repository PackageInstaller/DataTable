-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teshamu/model/TeShaMuChallengeFmtMo.lua

module("logic.extensions.teshamu.model.TeShaMuChallengeFmtMo", package.seeall)

local TeShaMuChallengeFmtMo = class("TeShaMuChallengeFmtMo", ICustomFmtMo)

function TeShaMuChallengeFmtMo:onReset()
	TeShaMuChallengeFmtMo.super.onReset(self)
end

function TeShaMuChallengeFmtMo:initParams(activityId, stageId, blockId)
	self._activityId = activityId
	self._stageId = stageId
	self._blockId = blockId

	TeShaMuChallengeModel.instance:setWinId(nil)

	local stageInfo = TeShaMuChallengeConfig.instance:getStageCfgById(self._activityId, self._stageId)

	self._info = TeShaMuChallengeConfig.instance:getMasterCfgById(stageInfo.mapMonsterPlanId, self._blockId)
end

function TeShaMuChallengeFmtMo:updateData()
	self.isShowOneKey = true
	self.topTitleStr = self._info.name
	self.ruleDescStr = self._info.WinDesc
	self.validatorDescStr = self._info.missionDesc

	self:setFormCondition(self._info.formCondition)
end

function TeShaMuChallengeFmtMo:initFightHandler()
	local function handler()
		TeShaMuChallengeController.instance:fightResult(self._activityId)
		TeShaMuChallengeModel.instance:setWinId(self._info.winId)

		local simpleForm = self:getCurSimpleForm()

		TeShaMuChallengeController.instance:sendPM_TeshamuChallengeReq(self._activityId, self._stageId, self._blockId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function TeShaMuChallengeFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function TeShaMuChallengeFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function TeShaMuChallengeFmtMo:getMonsterConfigList()
	return TeShaMuChallengeConfig.instance:getCreepsCfg(self._info.creepsMasterId)
end

function TeShaMuChallengeFmtMo:getFmtInfoConfig()
	return self._info
end

function TeShaMuChallengeFmtMo:updateCellTop(cell, petMo)
	local luaCls = TeShaMuLockView
	local url = TeShaMuLockView.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local lockPetIds = TeShaMuChallengeController.instance:stageBanPetIds(self._stageId)

		proxy.binder:isLock(table.indexof(lockPetIds, petMo:getPetId()) and true or false)
	end
end

function TeShaMuChallengeFmtMo:clearCellTop(cell)
	TeShaMuChallengeFmtMo.super.clearCellTop(self, cell)
end

function TeShaMuChallengeFmtMo:checkPetIsForbit(petMo)
	local lockPetIds = TeShaMuChallengeController.instance:stageBanPetIds(self._stageId)

	return not not table.indexof(lockPetIds, petMo:getPetId())
end

return TeShaMuChallengeFmtMo

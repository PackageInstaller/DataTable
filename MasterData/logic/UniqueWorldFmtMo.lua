-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/model/UniqueWorldFmtMo.lua

module("logic.extensions.uniqueworld.model.UniqueWorldFmtMo", package.seeall)

local UniqueWorldFmtMo = class("UniqueWorldFmtMo", BaseCustomFmtMo)

function UniqueWorldFmtMo:updateCfg(activityId, levelId, gridId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._levelId = checknumber(levelId)
	self._gridId = checknumber(gridId)
	self._petHpMap = UniqueWorldModel.instance:getPetHpMap(activityId)

	if self._gridId > 0 then
		self._creepsMasterId = UniqueWorldController.instance:getCreepsMasterId(activityId, levelId, gridId)
		self._masterData = UniqueWorldConfig.instance:getMasterCfg(self._creepsMasterId)
		self._creepsCfg = UniqueWorldConfig.instance:getCreepsCfg(self._creepsMasterId)
		self.topTitleStr = self._masterData.name
		self.ruleDescStr = self._masterData.ruleDesc

		self:setFormCondition(self._masterData.formCondition)
	end

	self.isOnlyUpdateExistPet = true

	local desc = UniqueWorldController.instance:getCurUsePropDesc(activityId)

	if desc then
		self.validatorDescStr = desc
	end

	self:clearAllPetList()
end

function UniqueWorldFmtMo:initPetList()
	self:clearAllPetList()

	local info = UniqueWorldModel.instance:getInfo(self._activityId)
	local mapInfo = info and info.mapInfo

	if mapInfo then
		if not mapInfo.petList then
			local petList = {}
			local fMo = FightingPowerPetMo.New()

			for _, petInfo in ipairs(petList) do
				local creepsId = petInfo.creepsId
				local supportCfg = UniqueWorldConfig.instance:getSystemPetCfg(creepsId)

				fMo:fromChallengeCreepCo(supportCfg)

				local petMo = fMo:toBaseBagPetMo()

				petMo.petId = creepsId
				petMo.isSupportedPet = true

				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end
end

function UniqueWorldFmtMo:initFightHandler()
	local hpIsEmpty = UniqueWorldModel.instance:allHpIsEmpty(self._activityId)

	if hpIsEmpty then
		FloatWordMgr.instance:show("暂无可上阵精灵")

		return
	end

	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		UniqueWorldController.instance:sendPM_UniqueWorldFightReq(self._activityId, simpleForm, self._gridId)
	end, nil)
end

function UniqueWorldFmtMo:refreshPetList(changePetMoMap)
	return
end

function UniqueWorldFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function UniqueWorldFmtMo:getFmtInfoConfig()
	return self._masterData
end

function UniqueWorldFmtMo:getActivityId()
	return self._activityId
end

function UniqueWorldFmtMo:updateCellTop(cell, petMo)
	local luaCls = UniqueWorldBlood
	local url = UniqueWorldBlood.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)
	local creepsId = petMo.petId
	local hpWanPercent = self._petHpMap[creepsId]

	if proxy then
		self._proxyPool[cell] = proxy

		proxy.binder:clearUI()
		proxy.binder:updateUI(hpWanPercent)
	end
end

function UniqueWorldFmtMo:clearCellTop(cell)
	UniqueWorldFmtMo.super.clearCellTop(self, cell)

	local proxy = self._proxyPool[cell]

	if proxy then
		proxy.binder:clearUI()
	end
end

function UniqueWorldFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function UniqueWorldFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("该精灵为疲劳状态，无法上阵")
	end
end

function UniqueWorldFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if UniqueWorldFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function UniqueWorldFmtMo:_isPetLock(petMo)
	if petMo then
		local creepsId = petMo.petId
		local hpWanPercent = self._petHpMap[creepsId]

		return checknumber(hpWanPercent) <= 0
	end
end

return UniqueWorldFmtMo

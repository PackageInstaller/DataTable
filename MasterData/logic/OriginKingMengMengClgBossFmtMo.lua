-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/model/OriginKingMengMengClgBossFmtMo.lua

module("logic.extensions.originkingmengmengclg.model.OriginKingMengMengClgBossFmtMo", package.seeall)

local OriginKingMengMengClgBossFmtMo = class("OriginKingMengMengClgBossFmtMo", OriginKingMengMengClgBaseFmtMo)

function OriginKingMengMengClgBossFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingMengMengClgConfig.instance:getActivityData(self._activityId)
	self._creepsMasterId = self._actData.extremeClgCreepsMasterId
	self._supportPetCfg = OriginKingMengMengClgConfig.instance:getSupportPetData(self._activityId, self._actData.extremeClgSupportPetId)
	self._mustOnFormPetId = self._supportPetCfg and checknumber(self._supportPetCfg.creepsId) or 0
	self._masterData = OriginKingMengMengClgConfig.instance:getCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = OriginKingMengMengClgConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or self._masterData.WinDesc or ""
	self.validatorDescStr = self._masterData.ruleDesc or ""

	self:setFormCondition(nil)
	self:_refreshSupportPetMo()
end

function OriginKingMengMengClgBossFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self._supportPetCfg == nil or self._mustOnFormPetId <= 0 then
		FloatWordMgr.instance:show("极限Boss支援精灵配置缺失")

		return true
	end

	return OriginKingMengMengClgBossFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function OriginKingMengMengClgBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgBossFightReq(self._activityId, simpleForm)
	end, nil)
end

function OriginKingMengMengClgBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginKingMengMengClgBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginKingMengMengClgBossFmtMo:initPetList()
	OriginKingMengMengClgBossFmtMo.super.initPetList(self)

	local petMo = self:_createSupportPetMo()

	if petMo then
		self:addPetToList(petMo)
	end
end

function OriginKingMengMengClgBossFmtMo:_refreshSupportPetMo()
	if self._rightPetMap == nil then
		return
	end

	self:_removeSupportPetMo()

	local petMo = self:_createSupportPetMo()

	if petMo then
		self:addPetToList(petMo)
	end
end

function OriginKingMengMengClgBossFmtMo:_removeSupportPetMo()
	if self._rightPetList == nil or self._rightPetMap == nil then
		return
	end

	local supportPetId = self._mustOnFormPetId

	for i = #self._rightPetList, 1, -1 do
		local petMo = self._rightPetList[i]
		local petId = petMo and checknumber(petMo.petId) or 0
		local needRemove = petMo and checkbool(petMo.isSupportedPet) and (supportPetId <= 0 or petId == supportPetId)

		if needRemove then
			self._rightPetMap[petId] = nil

			table.remove(self._rightPetList, i)
		end
	end
end

function OriginKingMengMengClgBossFmtMo:_createSupportPetMo()
	local supportPetCfg = self:_getSupportPetCfg()

	if supportPetCfg == nil then
		return nil
	end

	local powerPetMo = FightingPowerPetMo.New()

	powerPetMo:fromChallengeCreepCo(supportPetCfg)

	local petMo = powerPetMo:toBaseBagPetMo()

	petMo:setSupportedPet(true)

	return self:_changePetMo(petMo)
end

function OriginKingMengMengClgBossFmtMo:_needCheckMustOnFormPet()
	return self._mustOnFormPetId > 0
end

function OriginKingMengMengClgBossFmtMo:_isMustOnFormPetMoMatch(petMo)
	if not petMo then
		return false
	end

	return self._mustOnFormPetId > 0 and checkbool(petMo.isSupportedPet) and checknumber(petMo.petId) == self._mustOnFormPetId
end

function OriginKingMengMengClgBossFmtMo:_getMustOnFormPetTip()
	if self._supportPetCfg then
		if not self._supportPetCfg.creepsName then
			local creepsName = ""

			if not string.nilorempty(creepsName) then
				return string.format("请上阵并存活援助精灵%s", creepsName)
			end

			return "请上阵并存活援助精灵"
		end
	end
end

function OriginKingMengMengClgBossFmtMo:_getSupportPetCfg()
	if self._supportPetCfg == nil then
		return nil
	end

	local propertyStrs = {}
	local stageDatas = OriginKingMengMengClgConfig.instance:getStageDatas(self._activityId) or {}

	for _, stageData in ipairs(stageDatas) do
		local value = self._subMo:getStageValue(stageData.stageId)
		local propertyData = OriginKingMengMengClgConfig.instance:getPropertyDataByValue(self._activityId, stageData.stageId, value)

		if propertyData and not string.nilorempty(propertyData.propertyStr) then
			table.insert(propertyStrs, propertyData.propertyStr)
		end
	end

	local propertyStr = #propertyStrs > 0 and self:_mergePropertyStrs(propertyStrs) or self._supportPetCfg.extproperties

	return setmetatable({
		extproperties = propertyStr
	}, {
		__index = self._supportPetCfg
	})
end

function OriginKingMengMengClgBossFmtMo:_mergePropertyStrs(propertyStrs)
	local propertyNames = {}
	local propertyValueMap = {}

	for _, propertyStr in ipairs(propertyStrs) do
		local propertyItems = string.split(propertyStr, "#")

		for _, propertyItem in ipairs(propertyItems) do
			local propertyInfos = string.split(propertyItem, "+")
			local propertyName = propertyInfos[1]
			local propertyValue = propertyInfos[2]

			if not string.nilorempty(propertyName) and not string.nilorempty(propertyValue) then
				if propertyValueMap[propertyName] == nil then
					table.insert(propertyNames, propertyName)

					propertyValueMap[propertyName] = 0
				end

				propertyValueMap[propertyName] = propertyValueMap[propertyName] + checknumber(propertyValue)
			end
		end
	end

	local result = {}

	for _, propertyName in ipairs(propertyNames) do
		local propertyValue = propertyValueMap[propertyName]

		table.insert(result, string.format("%s+%s", propertyName, propertyValue))
	end

	return table.concat(result, "#")
end

return OriginKingMengMengClgBossFmtMo

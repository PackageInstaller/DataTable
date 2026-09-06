-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/model/DivineAoJiuExtremeFmtMo.lua

module("logic.extensions.divineaojiu.model.DivineAoJiuExtremeFmtMo", package.seeall)

local DivineAoJiuExtremeFmtMo = class("DivineAoJiuExtremeFmtMo", BaseCustomFmtMo)

function DivineAoJiuExtremeFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local stageCfg = DivineAoJiuConfig.instance:getExtremeStageCfg(self.activityId, self.stageId)
	local creepsMasterId = checknumber(stageCfg.creepsMasterId)

	self._cfgEnemy = DivineAoJiuConfig.instance:getTeamCfg(creepsMasterId)
	self._masterList = DivineAoJiuConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self.selectBuffId = stageCfg.buffIds[1]
	self._supportPetIdList = {}

	local supportPetPosCfg = DivineAoJiuConfig.instance:getSupportPetPosCfg(stageCfg.systemPetPosPlan)

	for i, v in pairs(supportPetPosCfg) do
		table.insert(self._supportPetIdList, v.creepsId)
	end

	self.needUpPetCount = 5 + #self._supportPetIdList
end

function DivineAoJiuExtremeFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineAoJiuClgAgent.instance:sendPM_DivineAoJiuClgExtremeClgReq(self.activityId, self.stageId, self.selectBuffId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineAoJiuExtremeFmtMo:updateData()
	self:tryInitPetList()

	if self:_isNeedUpdateSupportPet() then
		self:tryRemovePetByIds(self._lastSupportIdList)

		if self._supportPetIdList then
			for i, creepsId in ipairs(self._supportPetIdList) do
				local cfgSupport = DivineAoJiuConfig.instance:getSupportPetCfg(creepsId)

				if cfgSupport then
					local fmo = FightingPowerPetMo.New()

					fmo:fromChallengeCreepCo(cfgSupport)
					fmo:setSupportedPet(true)

					local supportPetMo = fmo:toBaseBagPetMo()

					self:addPetToList(supportPetMo)
				end
			end
		end
	end

	self._lastSupportIdList = self._supportPetIdList

	self:getCurFormation():ResetPosition()

	self._fixPos = {}
	self._forbitPetId = {}

	local stageCfg = DivineAoJiuConfig.instance:getExtremeStageCfg(self.activityId, self.stageId)
	local supportPetPosCfg = DivineAoJiuConfig.instance:getSupportPetPosCfg(stageCfg.systemPetPosPlan)

	for i, v in pairs(supportPetPosCfg) do
		table.insert(self._fixPos, v.posId)
		self:getCurFormation():SetPosition(v.posId, v.creepsId)

		self._forbitPetId[v.creepsId] = true
	end

	local hasResult, posInfo = DivineAoJiuModel.instance:getExtremeFmt(self.activityId, self.stageId)

	if hasResult == true then
		for k, v in pairs(posInfo) do
			if checknumber(v) > 0 and self:getPetMoById(v) ~= nil then
				self:getCurFormation():SetPosition(k, v)
			end
		end
	end
end

function DivineAoJiuExtremeFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineAoJiuExtremeFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineAoJiuExtremeFmtMo:getExtendViewName()
	return ViewName.DivineAoJiuFmtView
end

function DivineAoJiuExtremeFmtMo:getFixedPosList()
	return self._fixPos
end

function DivineAoJiuExtremeFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if self._forbitPetId[petId] == true then
		return false
	end

	if self._formCondition then
		return FormationValidatorController.instance:isPosValidatorMatchOnSelect(pos, petId, self._formCondition, self:getCurFormation(), isShowTip)
	else
		return true
	end
end

function DivineAoJiuExtremeFmtMo:_isNeedUpdateSupportPet()
	local curSupportCount = #self._supportPetIdList

	if self._lastSupportIdList then
		if not #self._lastSupportIdList then
			local lastSupportCount = 0

			if curSupportCount ~= lastSupportCount then
				return true
			end

			if curSupportCount == 0 then
				return false
			end

			local sameCount = 0

			for i, id1 in ipairs(self._supportPetIdList) do
				for j, id2 in ipairs(self._lastSupportIdList) do
					if id1 == id2 then
						sameCount = sameCount + 1

						break
					end
				end
			end

			return sameCount ~= curSupportCount
		end
	end
end

function DivineAoJiuExtremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self._forbitPetId[petMo.petId] == true then
		return true
	end

	return false
end

function DivineAoJiuExtremeFmtMo:showForbitPetAlert(petMo)
	if self._forbitPetId[petMo.petId] == true then
		FloatWordMgr.instance:show(lang("不可更改小奥奇的位置哦"))
	end
end

function DivineAoJiuExtremeFmtMo:onExitView()
	local posInfo = {}
	local formationMo = self:getCurFormation()
	local formationPos = formationMo:GetPositions()

	for pos, petId in pairs(formationPos) do
		if not self._forbitPetId[petId] and petId ~= 0 then
			posInfo[pos] = petId
		end
	end

	DivineAoJiuModel.instance:saveExtremeFmt(self.activityId, self.stageId, posInfo)
	DivineAoJiuExtremeFmtMo.super.onExitView(self)
end

return DivineAoJiuExtremeFmtMo

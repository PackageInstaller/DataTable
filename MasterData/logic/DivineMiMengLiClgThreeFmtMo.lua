-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/model/DivineMiMengLiClgThreeFmtMo.lua

module("logic.extensions.divinemimengliclg.model.DivineMiMengLiClgThreeFmtMo", package.seeall)

local DivineMiMengLiClgThreeFmtMo = class("DivineMiMengLiClgThreeFmtMo", BaseCustomFmtMo)

function DivineMiMengLiClgThreeFmtMo:onReset()
	DivineMiMengLiClgThreeFmtMo.super.onReset(self)
end

function DivineMiMengLiClgThreeFmtMo:updateCfg(activityId, stageId, teamId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamId = teamId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._divineMmlClgMo = DivineMiMengLiClgController.instance:getDivineMmlClgMo(self._activityId)
	self._youlingCount = self._divineMmlClgMo:getCurYoulingCount(stageId)

	local stageData = DivineMiMengLiClgConfig.instance:getStageData(activityId, stageId)
	local teamData = DivineMiMengLiClgConfig.instance:getTeamData(activityId, stageId, teamId)

	self._creepsMasterId = teamData.creepsMasterId
	self._supportCreepsId = stageData.mustFormPetId
	self._enemyExtPetId = stageData.enemyExtPetId
	self._masterData = DivineMiMengLiClgConfig.instance:getMasterData(self._creepsMasterId)
	self._supportCreepsData = DivineMiMengLiClgConfig.instance:getPetData(self._supportCreepsId)
	self._creepsCfg = {}

	local position = {}
	local normalCreepsCfg = DivineMiMengLiClgConfig.instance:getCreepsCfg(self._creepsMasterId)

	for _, data in ipairs(normalCreepsCfg) do
		table.insert(self._creepsCfg, data)

		position[data.posId] = true
	end

	local youlingCount = self._youlingCount
	local exCreepsData = DivineMiMengLiClgConfig.instance:getPetData(self._enemyExtPetId)

	for posId = 1, 9 do
		if youlingCount > 0 then
			if not position[posId] then
				youlingCount = youlingCount - 1

				local data = TableUtil.deepcopy(exCreepsData)

				data.posId = posId

				table.insert(self._creepsCfg, data)

				position[posId] = true
			end
		else
			break
		end
	end
end

function DivineMiMengLiClgThreeFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
	self:tryInitPetList()

	local removePetIdList = {}

	if self._lastSupportCreepsId ~= self._supportCreepsId then
		table.insert(removePetIdList, self._supportCreepsId)
	end

	self:tryRemovePetByIds(removePetIdList)

	if self._lastSupportCreepsId ~= self._supportCreepsId then
		local fmo = FightingPowerPetMo.New()

		fmo:fromChallengeCreepCo(self._supportCreepsData)

		local petMo = fmo:toBaseBagPetMo()

		petMo:setSupportedPet(true)

		petMo = self:_changePetMo(petMo)
		self._supportPetMo = petMo

		self:addPetToList(petMo)

		self._lastSupportCreepsId = self._supportCreepsId
	end
end

function DivineMiMengLiClgThreeFmtMo:initFightHandler()
	local function handler()
		if not self:isSupportPetMoHasFmt() then
			local petMo = self:getSupportPetMo()
			local name = petMo:getName()

			FloatWordMgr.instance:show(string.format("必须上阵%s", name))
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack)

			return
		end

		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, DivineMiMengLiClgController.instance:getActivityType(), self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgFightReq(self._activityId, self._stageId, self._teamId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineMiMengLiClgThreeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineMiMengLiClgThreeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineMiMengLiClgThreeFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.DivineMiMengLiClgStageThreeSupportPetCheck)
end

function DivineMiMengLiClgThreeFmtMo:getExtendViewName()
	return ViewName.DivineMiMengLiClgStageThreeExView
end

function DivineMiMengLiClgThreeFmtMo:getSupportPetMo()
	return self._supportPetMo
end

function DivineMiMengLiClgThreeFmtMo:isSupportPetMoHasFmt()
	return self:getCurFormation():HasPet(self._supportCreepsId)
end

return DivineMiMengLiClgThreeFmtMo

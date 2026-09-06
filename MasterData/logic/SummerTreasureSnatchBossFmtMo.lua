-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summertreasuresnatch/model/SummerTreasureSnatchBossFmtMo.lua

module("logic.extensions.summertreasuresnatch.model.SummerTreasureSnatchBossFmtMo", package.seeall)

local SummerTreasureSnatchBossFmtMo = class("SummerTreasureSnatchBossFmtMo", BaseCustomFmtMo)

function SummerTreasureSnatchBossFmtMo:updateCfg(activityId, bossId, isTrial)
	self._activityId = checknumber(activityId)
	self._bossId = checknumber(bossId)
	self._info = SummerTreasureSnatchModel.instance:getInfo(self._activityId) or {}

	local gainBuffId = SummerTreasureSnatchModel.instance:getBuffIdList(activityId)
	local week = SummerTreasureSnatchController.instance:getCurWeek(self._activityId)

	self._key = string.format("SummerTreasureSnatchBossFmtMoKey_%s_%s", activityId, week)
	self._buffId = 0

	if #gainBuffId > 0 then
		self._buffId = 1

		local saveBuffId = checknumber(GameUtil.getUserData(self._key))

		self._buffId = GameUtil.getUserData(self._key) and table.indexof(gainBuffId, saveBuffId) and saveBuffId or gainBuffId[1]
	end

	self._isTrial = isTrial
	self.isShowBtnSave = true
	self._bossCfg = SummerTreasureSnatchConfig.instance:getBossCfg(self._activityId, week, self._bossId)

	if self._bossCfg then
		self._creepsMasterId = self._bossCfg.creepsMasterId or 0
	end

	self._masterData = SummerTreasureSnatchConfig.instance:getMasterCfg(self._creepsMasterId) or {}
	self._creepsCfg = SummerTreasureSnatchConfig.instance:getCreepsCfg(self._creepsMasterId) or {}
	self._bossInfo = SummerTreasureSnatchModel.instance:getBossInfo(activityId, bossId) or {}
	self._bindRaceIdMap = SummerTreasureSnatchController.instance:getBossBindRaceIdMap(activityId, bossId)
	self._petCardMap = SummerTreasureSnatchController.instance:getPetExperienceRaceIdMap(activityId)
	self._petExperienceMap = SummerTreasureSnatchModel.instance:getPetExperienceMap(activityId)
	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or ""
	self.validatorDescStr = lang("上阵精灵不可在其他BOSS挑战中上阵")

	self:setFormCondition(self._masterData.formCondition)

	self.isOnlyUpdateExistPet = true

	self:initPetList()
end

function SummerTreasureSnatchBossFmtMo:setBuffId(buffId)
	self._buffId = checknumber(buffId)
end

function SummerTreasureSnatchBossFmtMo:initFightHandler()
	local function handler()
		local bindRaceId = checktable(self._bossInfo.bindRaceId)

		if self._isTrial then
			self:_beginBattle()
		elseif #bindRaceId <= 0 then
			local tipsContent = lang("是否确认使用该队伍挑战该boss，确认后本周将无法更改队伍")

			local function okFunc()
				self:_beginBattle()
			end

			local function cancelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
			end

			TipsFacade.instance:openPopupWindow(lang("提示"), tipsContent, okFunc, cancelFunc, "确定", "取消")
		else
			self:_beginBattle()
		end
	end

	self:setFightHandler(handler, nil)
end

function SummerTreasureSnatchBossFmtMo:_beginBattle()
	UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

	local simpleForm = self:getCurSimpleForm()

	SummerTreasureSnatchController.instance:sendPM_SummerTreasureSnatchBossClgReq(self._activityId, self._bossId, simpleForm, self._buffId, self._isTrial)
end

function SummerTreasureSnatchBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function SummerTreasureSnatchBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function SummerTreasureSnatchBossFmtMo:initPetList()
	self:clearAllPetList()

	local bindRaceIds = self._bossInfo.bindRaceId

	if self._isTrial or #bindRaceIds <= 0 then
		local petMoList = BagPetsController.instance:getFightBagPet()

		for _, petMo in pairs(petMoList) do
			self:addPetToList(self:_changePetMo(petMo))
		end

		for cardId, v in pairs(self._petExperienceMap) do
			local fMo = FightingPowerPetMo.New()
			local supportPetCfg = SummerTreasureSnatchConfig.instance:getSupportPetCfg(self._activityId, cardId)

			fMo:fromChallengeCreepCo(supportPetCfg)

			local supportPetMo = fMo:toBaseBagPetMo()

			supportPetMo.isSupportedPet = true

			self:addPetToList(supportPetMo)
		end
	else
		for _, raceId in ipairs(bindRaceIds) do
			local maxZdlPetId = BagModel.instance:getMaxZdlPetIdByRaceId(raceId)
			local petMo = BagPetsController.instance:getPet(maxZdlPetId)
			local hasCardPet = self._petCardMap[raceId]

			if hasCardPet then
				local fMo = FightingPowerPetMo.New()
				local supportPetCfg = SummerTreasureSnatchConfig.instance:getSupportPetCfgByRaceId(self._activityId, raceId)

				fMo:fromChallengeCreepCo(supportPetCfg)

				local supportPetMo = fMo:toBaseBagPetMo()
				local supportPetZdl = supportPetMo:getFightingPower()
				local petMoZdl = petMo and petMo:getFightingPower() or 0

				if petMoZdl < supportPetZdl then
					supportPetMo.isSupportedPet = true

					self:addPetToList(supportPetMo)
				else
					self:addPetToList(petMo)
				end
			else
				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end
end

function SummerTreasureSnatchBossFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function SummerTreasureSnatchBossFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function SummerTreasureSnatchBossFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._bindRaceIdMap[raceId]
end

function SummerTreasureSnatchBossFmtMo:getActivityId()
	return self._activityId
end

function SummerTreasureSnatchBossFmtMo:getBuffId()
	return self._buffId
end

function SummerTreasureSnatchBossFmtMo:setBuffId(buffId)
	self._buffId = buffId

	GameUtil.saveUserData(self._key, self._buffId)
end

function SummerTreasureSnatchBossFmtMo:getExtendViewName()
	return ViewName.SummerTreasureSnatchBossExtView
end

return SummerTreasureSnatchBossFmtMo

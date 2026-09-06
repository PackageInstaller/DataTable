-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/model/HolyStripeCopyModel.lua

module("logic.extensions.holystripecopy.model.HolyStripeCopyModel", package.seeall)

local HolyStripeCopyModel = class("HolyStripeCopyModel", BaseModel)

function HolyStripeCopyModel:onInit()
	self:onReset()
end

function HolyStripeCopyModel:onReset()
	self._useGameTime = 0
	self._maxLevels = nil
	self._teamFormationInfo = nil
	self._teamCustomFmtMo = nil
	self._soloFormationInfoList = nil
	self._soloCustomFmtMo = nil
	self.CiList = nil
	self._curLivingPetIds = nil
	self._curTeamPetIds = nil
end

function HolyStripeCopyModel:onGetInfo(msg)
	self._useGameTime = checkint(msg.todayGameTime)
	self._maxLevels = {}

	for k, v in ipairs(msg.tabList) do
		self._maxLevels[checkint(v.tabId)] = checkint(v.maxStageId)
	end
end

function HolyStripeCopyModel:onGetLastForm(msg)
	if msg.isGroupForm then
		self._teamFormationInfo = msg.formList[1]
	else
		self._soloFormationInfoList = msg.formList or {}
	end
end

function HolyStripeCopyModel:getTeamFormationInfo()
	return self._teamFormationInfo
end

function HolyStripeCopyModel:getSoloFormationInfoList()
	return self._soloFormationInfoList
end

function HolyStripeCopyModel:onGetSoloFightReseult(msg)
	self._curLivingPetIds = msg.activePetIds
	self._maxLevels = self._maxLevels or {}
	self._maxLevels[checkint(msg.tabId)] = checkint(msg.stageId)

	if msg.isWin then
		self._useGameTime = checkint(msg.todayGameTime)
	end

	self.CiList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function HolyStripeCopyModel:onGetTeamFightReseult(msg)
	self._curLivingPetIds = msg.activePetIds
	self._curTeamPetIds = msg.petIds

	if msg.isWin then
		self._useGameTime = checkint(msg.todayGameTime)
	end

	self.CiList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function HolyStripeCopyModel:onSweepSuc(msg)
	self._useGameTime = checkint(msg.todayGameTime)
end

function HolyStripeCopyModel:getFuncOpenId()
	return 611
end

function HolyStripeCopyModel:getMaxLevel(tabId)
	return checkint(self._maxLevels and self._maxLevels[tabId])
end

function HolyStripeCopyModel:isLevelPassed(tabId, curLevel)
	local maxPassLevel = self:getMaxLevel(tabId)

	return curLevel <= maxPassLevel
end

function HolyStripeCopyModel:getLeftSoloTime()
	return math.max(self._useGameTime, 0)
end

function HolyStripeCopyModel:getLimitSoloTime()
	return checkint(HolyStripeCopyConfig.instance:getCommonValue("GAME_TIME_STORAGE"))
end

function HolyStripeCopyModel:getLeftTeamTime()
	return math.max(self._useGameTime, 0)
end

function HolyStripeCopyModel:getLimitTeamTime()
	return checkint(HolyStripeCopyConfig.instance:getCommonValue("GAME_TIME_STORAGE"))
end

function HolyStripeCopyModel:getLeftTeamTime()
	return math.max(self._useGameTime, 0)
end

function HolyStripeCopyModel:isDoubleTime()
	local timeStr = HolyStripeCopyConfig.instance:getCommonValue("MULTIPLY_TIME")
	local timeParms = string.split(timeStr, "#")

	if not string.nilorempty(timeParms[1]) and not string.nilorempty(timeParms[2]) then
		return GameUtil.checkIsInTimePeriod(timeParms[1], timeParms[2])
	end

	return false
end

function HolyStripeCopyModel:getTeamCustomFmtMo()
	self._teamCustomFmtMo = self._teamCustomFmtMo or HolyStripeCopyTeamFmtMo.New()

	return self._teamCustomFmtMo
end

function HolyStripeCopyModel:getSoloCustomFmtMo()
	self._soloCustomFmtMo = self._soloCustomFmtMo or HolyStripeCopySoloFmtMo.New()

	return self._soloCustomFmtMo
end

function HolyStripeCopyModel:ShowCI()
	return
end

function HolyStripeCopyModel:setRewardListCI()
	BattleSettlementModel.instance:setChangeSetId(self.CiList)

	self.CiList = nil
end

function HolyStripeCopyModel:getCurBattleSettlePetUnits()
	local units = {}

	if BattleModel.instance.HolyStripeCopyFight then
		if BattleModel.instance.HolyStripeCopyFight == 2 then
			for _, petId in ipairs(self._curTeamPetIds) do
				if petId > 0 then
					local pet = BagPetsController.instance:getPet(petId)

					if pet then
						local unit = {}

						unit.raceId = pet.raceId
						unit.skinId = pet.curFaceId
						unit.isHaveExpUp = false
						unit.isExpedition = false
						unit.level = checknumber(pet.curLv)
						unit.isDead = not table.keyof(self._curLivingPetIds, petId)

						table.insert(units, unit)
					end
				end
			end
		else
			local fmtMoList = self:getSoloCustomFmtMo():getCurFormationList()

			for id, fmtMo in ipairs(fmtMoList) do
				for _, petId in ipairs(fmtMo:GetPositions()) do
					if petId > 0 then
						local pet = BagPetsController.instance:getPet(petId)

						if pet then
							local unit = {}

							unit.raceId = pet.raceId
							unit.skinId = pet.curFaceId
							unit.isHaveExpUp = false
							unit.isExpedition = false
							unit.level = checknumber(pet.curLv)
							unit.isDead = not table.keyof(self._curLivingPetIds, petId)

							table.insert(units, unit)
						end
					end
				end
			end
		end
	end

	return units
end

HolyStripeCopyModel.instance = HolyStripeCopyModel.New()

return HolyStripeCopyModel

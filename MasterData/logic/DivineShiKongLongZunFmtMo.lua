-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/model/DivineShiKongLongZunFmtMo.lua

module("logic.extensions.divineshikonglongzunmainview.model.DivineShiKongLongZunFmtMo", package.seeall)

local DivineShiKongLongZunFmtMo = class("DivineShiKongLongZunFmtMo", ICustomFmtMo)

function DivineShiKongLongZunFmtMo:onReset()
	DivineShiKongLongZunFmtMo.super.onReset(self)
end

function DivineShiKongLongZunFmtMo:updateCfg(activityId, stageId, teamIndex, creepsMasterId)
	self._activityId = activityId
	self._stageId = stageId
	self._teamIndex = teamIndex
	self._creepsMasterId = creepsMasterId
	self._masterData = DivineShiKongLongZunConfig.instance:getDivineTsDragonLoardClgMonsterData(creepsMasterId)
	self._creepsCfg = DivineShiKongLongZunConfig.instance:getDivineTsDragonLoardClgCreepsData(creepsMasterId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
end

function DivineShiKongLongZunFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineShiKongLongZunFmtMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineShiKongLongZunController.instance:sendPM_DivineTSDragonLordClgChallengeReq(self._activityId, self._stageId, self._teamIndex, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineShiKongLongZunFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineShiKongLongZunFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineShiKongLongZunFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for _, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function DivineShiKongLongZunFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return DivineShiKongLongZunFmtMo

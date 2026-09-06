-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/model/KingspacedragonCustomFmtMo.lua

module("logic.extensions.kingspacedragon.model.KingspacedragonCustomFmtMo", package.seeall)

local KingspacedragonCustomFmtMo = class("KingspacedragonCustomFmtMo", ICustomFmtMo)

function KingspacedragonCustomFmtMo:initParams(activityId, clgType, creepsMasterId)
	self._activityId = activityId
	self._clgType = clgType
	self.creepsMasterId = creepsMasterId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self.masterCfg = KingspacedragonConfig.instance:getMasterCfg(self.creepsMasterId)
	self.creeps = KingspacedragonConfig.instance:getCreepsCfgs(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc

	self:setFormCondition(self.masterCfg.formCondition)
	self:clearAllPetList()
end

function KingspacedragonCustomFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self._isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, activityType, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurFormation():createFormPb()

		BattleFacade.instance:startKingSpaceDragonClg()
		KingspacedragonController.instance:sendPM_KingSpaceDragonClgFightReq(self._activityId, self._clgType, form)
	end)
end

function KingspacedragonCustomFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, mo in ipairs(pets) do
		self:addPetToList(mo)
	end
end

function KingspacedragonCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function KingspacedragonCustomFmtMo:getMonsterConfigList()
	return self.creeps
end

function KingspacedragonCustomFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

return KingspacedragonCustomFmtMo

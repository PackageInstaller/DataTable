-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/model/EternalholydragonRiverCustomMo.lua

module("logic.extensions.eternalholydragon.model.EternalholydragonRiverCustomMo", package.seeall)

local EternalholydragonRiverCustomMo = class("EternalholydragonRiverCustomMo", ICustomFmtMo)

function EternalholydragonRiverCustomMo:initParams(row, col, creepsMasterId, isLand)
	self.isShowTab = false
	self.isShowBtnSave = true
	self._isLand = isLand
	self._row = row
	self._col = col
	self._creepsMasterId = creepsMasterId
	self._activityId = EternalholydragonModel.instance:getActivityId()
	self._masterList = EternalholydragonConfig.instance:getCreepMonstersCfgs(creepsMasterId)
	self._creepsCfg = EternalholydragonConfig.instance:getCreepCfg(creepsMasterId)
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
	self.validatorDescStr = self._creepsCfg.missionDesc
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:clearAllPetList()
end

function EternalholydragonRiverCustomMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local petInfos_kv = EternalholydragonModel.instance:getPetInfos()

	for i, petMo in ipairs(pets) do
		if not petInfos_kv[petMo.petId] or petInfos_kv[petMo.petId].value > 0 then
			self:addPetToList(petMo)
		end
	end
end

function EternalholydragonRiverCustomMo:refreshPetList(changePetMoMap)
	local petInfos_kv = EternalholydragonModel.instance:getPetInfos()

	for petId, petMo in pairs(changePetMoMap) do
		if not petInfos_kv[petMo.petId] or petInfos_kv[petMo.petId].value > 0 then
			self:updatePetMo(petMo)
		end
	end
end

function EternalholydragonRiverCustomMo:initFightHandler()
	local function handler()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.EHolyDragon, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		local form = self:getCurFormation():createFormPb()

		UIJumper.instance:pushOneStack(ViewName.EternalholydragonmainView)
		UIJumper.instance:pushOneStack(ViewName.EternalholydragongameView)
		EternalholydragonController.instance:recordItem(self._activityId, self._creepsMasterId)

		if self._isLand then
			EternalHolyDragonChallengeAgent.instance:sendPM_EHolyDragonClgFightLandMonsterReq(self._activityId, form, {
				x = self._row,
				y = self._col
			})
		else
			EternalHolyDragonChallengeAgent.instance:sendPM_EHolyDragonClgFightRiverMonsterReq(self._activityId, form, {
				x = self._row,
				y = self._col
			})
		end
	end

	self:setFightHandler(handler, nil)
end

function EternalholydragonRiverCustomMo:getMonsterConfigList()
	return self._masterList
end

function EternalholydragonRiverCustomMo:getFmtInfoConfig()
	return self._creepsCfg
end

function EternalholydragonRiverCustomMo:updateCellTop(cell, petMo)
	local luaCls = EternalholydragonRightTopCell
	local url = EternalholydragonRightTopCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:setData(petMo)
	end
end

return EternalholydragonRiverCustomMo

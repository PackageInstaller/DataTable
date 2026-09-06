-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/model/DivineMiZongClgFmtMo.lua

module("logic.extensions.divinemizongclg.model.DivineMiZongClgFmtMo", package.seeall)

local DivineMiZongClgFmtMo = class("DivineMiZongClgFmtMo", BaseCustomFmtMo)

function DivineMiZongClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = DivineMiZongClgConfig.instance:getStageData(self._activityId, stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._clgMo = DivineMiZongClgController.instance:getClgMo(self._activityId)
	self._masterData = DivineMiZongClgConfig.instance:getMasterData(creepsMasterId)
	self._creepsCfg = DivineMiZongClgConfig.instance:getCreepsCfg(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self._centerPetId = self._centerPetId or 0

	if self._centerPetId > 0 then
		local petMo = self:getPetMoById(self._centerPetId)

		if petMo == nil then
			self._centerPetId = 0
		end
	end
end

function DivineMiZongClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineMiZongClgController.instance:sendPM_DivineMiZongClgFightReq(self._activityId, self._stageId, simpleForm, self._centerPetId)
	end, nil)
end

function DivineMiZongClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineMiZongClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineMiZongClgFmtMo:getExtendViewName()
	return ViewName.DivineMiZongClgFmtExtisonView
end

function DivineMiZongClgFmtMo:onFmoSetDown()
	local centerPosId = self:getCenterPosId()

	if self._oldCenterPosId == centerPosId then
		return
	end

	self._oldCenterPosId = centerPosId

	local centerPetId = self:getCenterPetId()
	local fmo = self:getCurFormation()

	if fmo:HasPet(centerPetId) then
		self:setCenterPetId(self._centerPetId)
	else
		self:setCenterPetId(0)
	end
end

function DivineMiZongClgFmtMo:updateCellTop(cell, petMo)
	local luaCls = DivineMiZongClgBuffTag
	local url = DivineMiZongClgBuffTag.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local centerPetId = self:getCenterPetId()

		proxy.binder:setTagGoVisible(centerPetId == petMo:getPetId())
	end
end

function DivineMiZongClgFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local result = false

	if self._centerPetId <= 0 then
		FloatWordMgr.instance:show("必须选择承伤精灵")
		GlobalDispatcher:dispatch(GlobalNotify.DivineMiZongClg_ForbitStartClg)

		result = true
	else
		result = DivineMiZongClgFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end

	return result
end

function DivineMiZongClgFmtMo:getActivityId()
	return self._activityId
end

function DivineMiZongClgFmtMo:getCenterPetId()
	return self._centerPetId
end

function DivineMiZongClgFmtMo:setCenterPetId(petId)
	self._centerPetId = checknumber(petId)

	self:updateFmtSpecialEffect()
	GlobalDispatcher:dispatch(GlobalNotify.DivineMiZongClg_UpdateFmtCenterPet, self._centerPetId)
end

function DivineMiZongClgFmtMo:getCenterPosId()
	local petId = self:getCenterPetId()
	local fmo = self:getCurFormation()

	return fmo:GetPetPosition(petId) or 0
end

function DivineMiZongClgFmtMo:updateFmtSpecialEffect()
	self:clearAllFixedEffects()

	local centerPosId = self:getCenterPosId()
	local nbrPosIds = DivineMiZongClgEnum.GetNbrPosIds(centerPosId, GameEnum.BattleTeam.Left)

	if centerPosId > 0 then
		self:setFixedEffect(centerPosId, "fx_ui_jinglinggezi/fx_ui_buzhen_05.prefab")
	end

	for _, posId in ipairs(nbrPosIds) do
		self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
	end

	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
end

return DivineMiZongClgFmtMo

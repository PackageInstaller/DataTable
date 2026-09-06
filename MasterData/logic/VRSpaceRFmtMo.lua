-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/model/VRSpaceRFmtMo.lua

module("logic.extensions.vrspace.model.VRSpaceRFmtMo", package.seeall)

local VRSpaceRFmtMo = class("VRSpaceRFmtMo", BaseCustomFmtMo)

function VRSpaceRFmtMo:initParams(activityId, mode, stageId)
	self.activityId = activityId
	self.mode = mode
	self.stageId = stageId

	if mode == 0 then
		self.useMaxFightPower = true
	end

	local planCfg = VRSpaceConfig.instance:getPlanCfgById(activityId, mode, 1) or {}
	local stagePlanId = checknumber(planCfg.stagePlanId)
	local cfg = VRSpaceConfig.instance:getStageCfgById(stagePlanId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = VRSpaceConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = VRSpaceConfig.instance:getCreepsCfgById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "VRSpaceRFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
	self._info = VRSpaceModel.instance:getInfo(self.activityId) or {}

	if not self._info.modeInfos then
		local modeInfos = {}

		self._modeInfoMap = {}

		for i, v in ipairs(modeInfos) do
			self._modeInfoMap[v.mode] = v
		end

		if not self._modeInfoMap[self.mode] then
			self._deadPetIdMap = {}

			for i, v in ipairs(self._modeInfoMap[self.mode].deadPetIds or {}) do
				self._deadPetIdMap[v] = true
			end

			self._supportPetIdList = {}
			self._supportPetMap = {}

			for i, v in ipairs(self._modeInfoMap[self.mode].virtualStageInfos or {}) do
				for j, pp in ipairs(v.virtualPetIds or {}) do
					local petMo = MaterialMgr.getModel(MatType.Pet, pp.right)

					if petMo then
						local fmo = petMo:GetClone()

						fmo.petId = pp.left
						fmo.curFaceId = petMo.raceId

						fmo:setSupportedPet(true)

						self._supportPetMap[fmo.petId] = fmo

						table.insert(self._supportPetIdList, fmo.petId)
					end
				end
			end
		end
	end
end

function VRSpaceRFmtMo:checkPetIsForbit(petMo, baseCheck)
	if petMo then
		return checkbool(self._deadPetIdMap[petMo.petId])
	end

	return false
end

function VRSpaceRFmtMo:getMonsterConfigList()
	return self.creeps
end

function VRSpaceRFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function VRSpaceRFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		VRSpaceController.instance:sendStartRFight(self.activityId, self.mode, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function VRSpaceRFmtMo:updateData()
	self:tryInitPetList()
	self:tryRemovePetByIds(self._lastSupportIdList)

	for k, supportPetMo in pairs(self._supportPetMap) do
		self:addPetToList(self:_changePetMo(supportPetMo))
	end

	self._lastSupportIdList = self._supportPetIdList
end

return VRSpaceRFmtMo

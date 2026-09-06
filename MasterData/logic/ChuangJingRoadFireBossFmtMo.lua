-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/model/ChuangJingRoadFireBossFmtMo.lua

module("logic.extensions.chuangjingroad.model.ChuangJingRoadFireBossFmtMo", package.seeall)

local ChuangJingRoadFireBossFmtMo = class("ChuangJingRoadFireBossFmtMo", BaseCustomFmtMo)

function ChuangJingRoadFireBossFmtMo:initParams(activityId, zoneId, idx, creepsMasterId)
	self.activityId = activityId
	self.zoneId = zoneId
	self.idx = idx
	self._lockedRaceMap = {}

	local info = ChuangJingRoadModel.instance:getInfo(self.activityId) or {}

	if not info.zones then
		local zones = {}

		self._zoneInfo = nil

		for i, v in ipairs(zones) do
			if v.zoneId == self.zoneId then
				self._zoneInfo = v

				break
			end
		end

		self._zoneInfo = self._zoneInfo or {}
		self._fireBoss = self._zoneInfo.fireBoss or {}

		if not self._fireBoss.teamABanRaceIds then
			local banRaceIds = {}

			for k, v in pairs(banRaceIds) do
				self._lockedRaceMap[v] = true
			end

			if not self._fireBoss.teamBanRaceIds then
				for k, v in pairs(self._fireBoss.teamBanRaceIds) do
					self._lockedRaceMap[v] = true
				end

				self.creepsMasterId = creepsMasterId
				self.masterCfg = ChuangJingRoadConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
				self.creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

				self:setFormCondition(self.masterCfg.formCondition)

				self.isShowTab = false
				self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
				self.strShowRuleFlagKey = "ChuangJingRoadFireBossFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
				self.topTitleStr = self.masterCfg.name
				self.ruleDescStr = self.masterCfg.ruleDesc
				self.isPopRuleDesc = true

				self:clearAllPetList()
			end
		end
	end
end

function ChuangJingRoadFireBossFmtMo:initPetList()
	local petsMap = ChuangJingRoadModel.instance:getPetMoMap(self.activityId) or {}
	local info = ChuangJingRoadModel.instance:getPetInfo(self.activityId) or {}

	if not info.unlockCreepIds then
		local unlockCreepIds = {}
		local level = checknumber(info.level)
		local awakenLv = checknumber(info.awakenLv)
		local equipmentLv = checknumber(info.equipmentLv)
		local starGodPlusLv = checknumber(info.starGodPlusLv)
		local holyStripeLv = checknumber(info.holyStripeLv)

		for i, petId in ipairs(unlockCreepIds) do
			local petMo = petsMap[petId]

			if petMo then
				petMo = ChuangJingRoadModel.instance:updatePetMo(self.activityId, petMo, level, awakenLv, equipmentLv, starGodPlusLv, holyStripeLv)

				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end
end

function ChuangJingRoadFireBossFmtMo:getMonsterConfigList()
	return self.creeps
end

function ChuangJingRoadFireBossFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ChuangJingRoadFireBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		ChuangJingRoadController.instance:sendFireBossFight(self.activityId, self.zoneId, self.idx - 1, self:getCurSimpleForm())
	end, nil)
end

function ChuangJingRoadFireBossFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function ChuangJingRoadFireBossFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

function ChuangJingRoadFireBossFmtMo:refreshPetList(changePetMoMap)
	return
end

return ChuangJingRoadFireBossFmtMo

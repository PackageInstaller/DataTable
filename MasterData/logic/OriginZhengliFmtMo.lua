-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/model/OriginZhengliFmtMo.lua

module("logic.extensions.originzhengli.model.OriginZhengliFmtMo", package.seeall)

local OriginZhengliFmtMo = class("OriginZhengliFmtMo", BaseCustomFmtMo)

function OriginZhengliFmtMo:initParams(activityId, stageCfg, buffId)
	self.activityId = activityId
	self.stageId = stageCfg.stageId
	self.stageCfg = stageCfg
	self.curSelectBuffId = buffId
	self._actCfg = OriginZhengliConfig.instance:getActivityCfg(self.activityId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = OriginZhengliConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = OriginZhengliConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = self.stageCfg.fmtTips or ""
	self._lockedPetMap = {}

	local stageInfo = OriginZhengliModel.instance:getStageInfoById(self.activityId, self.stageId)

	if stageInfo then
		if not stageInfo.banRaceId then
			for i, raceId in ipairs(stageInfo.banRaceId) do
				self._lockedPetMap[checknumber(raceId)] = true
			end
		end
	end

	self:tryInitPetList()
end

function OriginZhengliFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginZhengliController.instance:challenge(self.activityId, simpleForm, self.stageId, self:getCurValidBuffId())
	end

	self:setFightHandler(handler, nil)
end

function OriginZhengliFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function OriginZhengliFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginZhengliFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginZhengliFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedPetMap[petMo.raceId])
end

function OriginZhengliFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已被锁定")
end

function OriginZhengliFmtMo:getCurValidBuffId()
	if self._actCfg and self.stageId == self._actCfg.startingStageId then
		return 0
	end

	local stageInfo = OriginZhengliModel.instance:getStageInfoById(self.activityId, self.stageId)

	if stageInfo then
		if not stageInfo.activateBuff then
			if stageInfo.activateBuff ~= 0 then
				return 0
			end

			return self.curSelectBuffId or 0
		end
	end

	return 0
end

function OriginZhengliFmtMo:updateCurSelectBuffId(buffId)
	self.curSelectBuffId = buffId
end

function OriginZhengliFmtMo:getExtendViewName()
	return ViewName.OriginZhengliFmtExView
end

function OriginZhengliFmtMo:getActivityId()
	return self.activityId
end

function OriginZhengliFmtMo:getStageId()
	return self.stageId
end

function OriginZhengliFmtMo:getCurSelectBuffId()
	return self.curSelectBuffId
end

return OriginZhengliFmtMo

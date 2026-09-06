-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/model/OriginLongzhuFmtMo.lua

module("logic.extensions.originlongzhu.model.OriginLongzhuFmtMo", package.seeall)

local OriginLongzhuFmtMo = class("OriginLongzhuFmtMo", BaseCustomFmtMo)

function OriginLongzhuFmtMo:initParams(activityId, stageId, extView, resultView)
	self.activityId = activityId
	self.stageId = stageId
	self._extView = extView
	self._resultView = resultView
	self._currSelectMap = {}

	local info = OriginLongzhuModel.instance:getInfo(self.activityId) or {}

	if not info.stageInfos then
		local stageInfos = {}

		self._lockedRaceMap = {}

		for i, v in ipairs(stageInfos) do
			if not v.lockRaceIds then
				for j, raceId in ipairs(v.lockRaceIds) do
					self._lockedRaceMap[raceId] = true
				end
			end
		end

		local groupCfg = OriginLongzhuConfig.instance:getStageCfgById(activityId, stageId) or {}

		self.creepsMasterId = groupCfg.creepsMasterId
		self.masterCfg = OriginLongzhuConfig.instance:getMonsterCfgById(self.creepsMasterId)
		self.creeps = OriginLongzhuConfig.instance:getCreepsById(self.creepsMasterId)

		self:setFormCondition(self.masterCfg.formCondition)

		self.isShowTab = false
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
		self.strShowRuleFlagKey = "OriginLongzhuFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
		self.topTitleStr = self.masterCfg.name
		self.ruleDescStr = self.masterCfg.ruleDesc
		self.isPopRuleDesc = true
	end
end

function OriginLongzhuFmtMo:getMonsterConfigList()
	return self.creeps
end

function OriginLongzhuFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function OriginLongzhuFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local buffIds = {}
		local fmo = self:getCurFormation()

		for type, boo in pairs(self._currSelectMap) do
			if boo then
				table.insert(buffIds, type)
			end
		end

		OriginLongzhuController.instance:sendStartFight(self.activityId, self.stageId, buffIds, self:getCurSimpleForm(), self._resultView)
	end, nil)
end

function OriginLongzhuFmtMo:getExtendViewName()
	return self._extView
end

function OriginLongzhuFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function OriginLongzhuFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

function OriginLongzhuFmtMo:setBuffSelect(scoreType)
	self._currSelectMap[scoreType] = not self._currSelectMap[scoreType]
end

function OriginLongzhuFmtMo:getBuffSelect(scoreType)
	return checkbool(self._currSelectMap[scoreType])
end

function OriginLongzhuFmtMo:getBuffCount()
	local count = 0

	for i, boo in pairs(self._currSelectMap) do
		if boo then
			count = count + 1
		end
	end

	return count
end

return OriginLongzhuFmtMo

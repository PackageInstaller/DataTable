-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/model/OriginChenClgFmtMoExt.lua

module("logic.extensions.originchenclg.model.OriginChenClgFmtMoExt", package.seeall)

local OriginChenClgFmtMoExt = class("OriginChenClgFmtMoExt", BaseCustomFmtMo)

function OriginChenClgFmtMoExt:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageCfg = OriginChenClgConfig.instance:getExtremeStageCfg(activityId, stageId)

	self._creepsMasterId = stageCfg.creepsMasterId
	self._creepsCfg = OriginChenClgConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._masterData = OriginChenClgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)

	local info = OriginChenClgModel.instance:getInfo(self._activityId)

	self._lockRaceMap = {}

	if info and info.extremeStageInfos then
		for i, v in ipairs(info.extremeStageInfos) do
			if v.lockRaceIds and #v.lockRaceIds > 0 then
				for i, lockRaceId in ipairs(v.lockRaceIds) do
					self._lockRaceMap[lockRaceId] = true
				end
			end
		end
	end
end

function OriginChenClgFmtMoExt:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginChenClgFmtMoExt:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginChenClgAgent.instance:sendPM_OriginChenClgChallengeExtremeReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginChenClgFmtMoExt:getMonsterConfigList()
	return self._creepsCfg
end

function OriginChenClgFmtMoExt:getFmtInfoConfig()
	return self._masterData
end

function OriginChenClgFmtMoExt:checkPetIsForbit(petMo, baseCheck)
	if self._lockRaceMap[petMo.raceId] then
		return true
	end

	return false
end

function OriginChenClgFmtMoExt:getExtendViewName()
	return ViewName.OriginchenclgextremeextView
end

return OriginChenClgFmtMoExt

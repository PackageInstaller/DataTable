-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/model/DivineJiClgModel.lua

module("logic.extensions.divinejiclg.model.DivineJiClgModel", package.seeall)

local DivineJiClgModel = class("DivineJiClgModel", BaseModel)

function DivineJiClgModel:onInit()
	self:onReset()
end

function DivineJiClgModel:onReset()
	self._activityInfo = {}
	self._extremeFightResult = {}
end

function DivineJiClgModel:onDivineJiClgGetInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._activityInfo[pb.activityId] = pb
end

function DivineJiClgModel:onDivineJiNotifyExtremeFightResultRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._extremeFightResult[msg.activityId] = pb

	if pb.passExtremeClg then
		MaterialController.instance:saveChangeSetToTemp(pb.changeSetId)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

		if isAoqiGodProcessType then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineJiClg, msg.activityId)
		end
	end
end

function DivineJiClgModel:onDivineJiClgResetExtremeClgStageRes(msg)
	local pb = GameUtil.pbToTable(msg)

	DivineJiClgAgent.instance:sendPM_DivineJiClgGetInfoReq(pb.activityId)
end

function DivineJiClgModel:onDivineJiGainNormalClgPrizeRes(msg)
	local pb = GameUtil.pbToTable(msg)

	DivineJiClgAgent.instance:sendPM_DivineJiClgGetInfoReq(pb.activityId)
end

function DivineJiClgModel:getActivityInfo(activityId)
	return self._activityInfo[activityId]
end

function DivineJiClgModel:getExtremeFightResult(activityId)
	if self._extremeFightResult then
		if self._extremeFightResult then
			if not self._extremeFightResult.lockedRace then
				if not self._extremeFightResult.targetPetRace then
					local targetPetRace = {}

					self._extremeFightResult.raceInfo = {}

					for i, v in ipairs(self._extremeFightResult.lockedRace) do
						local race = {}

						race.raceId = v
						race.isTargetRace = checknumber(table.indexof(targetPetRace, race.raceId)) > 0 and 1 or 0

						table.insert(self._extremeFightResult.raceInfo, race)
					end

					table.sort(self._extremeFightResult.raceInfo, function(a, b)
						return a.isTargetRace > b.isTargetRace
					end)

					return self._extremeFightResult
				end
			end
		end

		return nil
	end
end

function DivineJiClgModel:getExtremeClgStageInfo(activityId)
	if self._activityInfo then
		return (self._activityInfo or nil) and (self._activityInfo.extremeClgStageInfo or {})
	end
end

function DivineJiClgModel:getExtremeClSingleStageInfo(activityId, stageId)
	local stageInfo = self:getExtremeClgStageInfo(activityId)
	local info = {}

	for i, v in ipairs(stageInfo) do
		if v.stageId == stageId then
			info = v

			break
		end
	end

	return info
end

function DivineJiClgModel:getExtremeClgCurStageId(activityId)
	local info = self:getExtremeClgStageInfo(activityId)

	for i, v in ipairs(info) do
		if i ~= v.stageId then
			return i
		end
	end

	return #info + 1
end

function DivineJiClgModel:getExtremeClgStageTargetsInfo(activityId)
	local info = self:getExtremeClgStageInfo(activityId)
	local passNum, score = #info, 0

	for i, v in ipairs(info) do
		if checknumber(v.score) then
			score = score + v.score
		end
	end

	return passNum, score
end

function DivineJiClgModel:getExtremeClgLockedRace(activityId)
	local info = self:getExtremeClgStageInfo(activityId)
	local lockedRace = {}

	for i, v in ipairs(info) do
		if v.lockedRace then
			for j, race in ipairs(v.lockedRace) do
				table.insert(lockedRace, race)
			end
		end
	end

	return lockedRace
end

DivineJiClgModel.instance = DivineJiClgModel.New()

return DivineJiClgModel

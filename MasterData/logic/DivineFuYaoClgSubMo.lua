-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/data/DivineFuYaoClgSubMo.lua

module("logic.extensions.divinefuyaoclg.data.DivineFuYaoClgSubMo", package.seeall)

local DivineFuYaoClgSubMo = class("DivineFuYaoClgSubMo")

function DivineFuYaoClgSubMo:ctor(activityId)
	self._activityId = activityId
	self._normalStageId = 0
	self._extremeStageInfos = {}
	self._hadGainExtremePrize = false
	self._extremeFinishMsg = nil
	self._locakRaceIdsInExt = {}
end

function DivineFuYaoClgSubMo:dispose()
	return
end

function DivineFuYaoClgSubMo:handlePM_DivineFuYaoClgInfoRes(msg)
	self._normalStageId = msg.normalStageId

	table.clear(self._extremeStageInfos)

	for _, info in ipairs(msg.extremeStages) do
		local stageId = info.stageId

		self._extremeStageInfos[stageId] = info
		self._locakRaceIdsInExt[stageId] = {}

		for _, v in ipairs(info.lockRaceIds) do
			if v > 0 then
				table.insert(self._locakRaceIdsInExt[stageId], v)
			end
		end
	end

	self._hadGainExtremePrize = checkbool(msg.hadGainExtremePrize)
end

function DivineFuYaoClgSubMo:handlePM_DivineFuYaoClgNormalChallengeRes(msg)
	return
end

function DivineFuYaoClgSubMo:handlePM_NotifyFuYaoClgNormalChallengeFinishRes(msg)
	if msg.isWin then
		self._normalStageId = Mathf.Max(self._normalStageId, msg.stageId)
	end
end

function DivineFuYaoClgSubMo:handlePM_DivineFuYaoClgExtremeChallengeRes(msg)
	return
end

function DivineFuYaoClgSubMo:handlePM_DivineFuYaoClgExtremeConfirmRes(msg)
	if msg.save then
		local var_7_0 = {
			stageId = msg.stageId
		}

		var_7_0.lockRaceIds = msg.lockRaceIds or {}
		self._extremeStageInfos[msg.stageId] = var_7_0
		self._locakRaceIdsInExt[msg.stageId] = {}

		for _, v in ipairs(msg.lockRaceIds) do
			if v > 0 then
				table.insert(self._locakRaceIdsInExt[msg.stageId], v)
			end
		end

		local maxStageId = self:getMaxExtremeStageId()
		local allCompleted = true

		for stageId = 1, maxStageId do
			if not self:isPassStageInExt(stageId) then
				allCompleted = false

				break
			end
		end

		if allCompleted then
			self._hadGainExtremePrize = true
		end
	end

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		self._changeSetId = msg.changeSetId
	end
end

function DivineFuYaoClgSubMo:handlePM_DivineFuYaoClgExtremeResetRes(msg)
	table.clear(self._extremeStageInfos)
	table.clear(self._locakRaceIdsInExt)
end

function DivineFuYaoClgSubMo:handlePM_NotifyFuYaoClgExtremeChallengeFinishRes(msg)
	self._extremeFinishMsg = msg
end

function DivineFuYaoClgSubMo:isPassNormalClg()
	local maxStageId = self:getMaxNormalStageId()

	return self:isPassStageInNor(maxStageId)
end

function DivineFuYaoClgSubMo:isUnlockStageInNor(stageId)
	return self:isPassStageInNor(stageId - 1)
end

function DivineFuYaoClgSubMo:isPassStageInNor(stageId)
	return stageId <= self._normalStageId
end

function DivineFuYaoClgSubMo:getNormalStageId()
	return self._normalStageId
end

function DivineFuYaoClgSubMo:getMaxNormalStageId()
	local datas = DivineFuYaoClgConfig.instance:getNormalStageDatas(self._activityId)

	return (datas or nil) and (#datas or 0)
end

function DivineFuYaoClgSubMo:isPassExtremeClg()
	local maxStageId = self:getMaxExtremeStageId()

	return self:isPassStageInExt(maxStageId)
end

function DivineFuYaoClgSubMo:getLockRaceIdList()
	local list = {}

	for stageId, raceIdList in pairs(self._locakRaceIdsInExt) do
		table.insertto(list, raceIdList)
	end

	return list
end

function DivineFuYaoClgSubMo:isPassStageInExt(stageId)
	if stageId > 0 then
		local info = self:getExtremeStageInfo(stageId)

		return info ~= nil
	else
		return true
	end
end

function DivineFuYaoClgSubMo:getMaxExtremeStageId()
	local datas = DivineFuYaoClgConfig.instance:getExtremeStageDatas(self._activityId)

	return (datas or nil) and (#datas or 0)
end

function DivineFuYaoClgSubMo:getLockRaceIds(stageId)
	return self._locakRaceIdsInExt[stageId] or {}
end

function DivineFuYaoClgSubMo:getExtremeStageInfo(stageId)
	return self._extremeStageInfos[stageId]
end

function DivineFuYaoClgSubMo:isHasGainExtremePrize()
	return self._hadGainExtremePrize
end

function DivineFuYaoClgSubMo:getExtremeFinishMsg()
	return self._extremeFinishMsg
end

function DivineFuYaoClgSubMo:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

return DivineFuYaoClgSubMo

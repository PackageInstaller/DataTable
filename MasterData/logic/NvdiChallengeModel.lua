-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/model/NvdiChallengeModel.lua

module("logic.extensions.nvdi.model.NvdiChallengeModel", package.seeall)

local NvdiChallengeModel = class("NvdiChallengeModel", BaseModel)

function NvdiChallengeModel:onInit()
	self:onReset()
end

function NvdiChallengeModel:onReset()
	self._msg_pool = {}
	self.passExtremeClg = false
end

function NvdiChallengeModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msg_pool[activityId] = GameUtil.pbToTable(msg)
end

function NvdiChallengeModel:onGetProgressPrize(msg)
	local activityId = msg.activityId
	local info = self._msg_pool[activityId]

	if info then
		local dataBitId = msg.dataBitId

		info.normalClgProgressPrizeGainedBitId = info.normalClgProgressPrizeGainedBitId or {}

		table.insert(info.normalClgProgressPrizeGainedBitId, dataBitId)
	end
end

function NvdiChallengeModel:ondGetExtPrize(msg)
	local activityId = msg.activityId
	local info = self._msg_pool[activityId]

	if info then
		info.hasGainExtremeClgPrize = true
	end
end

function NvdiChallengeModel:onResetExtStage(msg)
	local activityId = msg.activityId
	local info = self._msg_pool[activityId]

	if info then
		local stageId = msg.stageId

		info.extremeClgStageInfo = info.extremeClgStageInfo or {}

		for i, v in ipairs(info.extremeClgStageInfo) do
			if v.stageId == stageId then
				table.remove(info.extremeClgStageInfo, i)

				break
			end
		end
	end
end

function NvdiChallengeModel:onNoramlFightMsg(msg)
	local activityId = msg.activityId
	local win = msg.win

	if win then
		local info = self._msg_pool[activityId]

		if info then
			local dataBitId = msg.dataBitId
			local bestScore = msg.bestScore

			info.normalClgProgress = msg.normalClgProgress
			info.normalClgStageInfo = info.normalClgStageInfo or {}

			local isFound = false

			for i, v in ipairs(info.normalClgStageInfo) do
				if v.dataBitId == dataBitId then
					v.bestScore = bestScore
					isFound = true

					break
				end
			end

			if not isFound then
				local obj = {}

				obj.dataBitId = dataBitId
				obj.bestScore = bestScore

				table.insert(info.normalClgStageInfo, obj)
			end
		end
	end
end

function NvdiChallengeModel:onExtFightMsg(msg)
	local activityId = msg.activityId
	local win = msg.win

	if win then
		local info = self._msg_pool[activityId]

		if info then
			self.passExtremeClg = msg.passExtremeClg

			local stageInfo = msg.stageInfo

			if stageInfo then
				stageInfo = GameUtil.pbToTable(stageInfo)

				local isFound = false

				info.extremeClgStageInfo = info.extremeClgStageInfo or {}

				for i, v in ipairs(info.extremeClgStageInfo) do
					if v.stageId == stageInfo.stageId then
						info.extremeClgStageInfo[i] = stageInfo
						isFound = true

						break
					end
				end

				if not isFound then
					table.insert(info.extremeClgStageInfo, stageInfo)
				end
			end
		end
	end
end

function NvdiChallengeModel:getInfo(activityId)
	return self._msg_pool[activityId]
end

function NvdiChallengeModel:isHasGainExtremeClgPrize(activityId)
	local info = self._msg_pool[activityId]

	if info then
		return checkbool(info.hasGainExtremeClgPrize)
	end

	return false
end

function NvdiChallengeModel:isPassAllOfExtStage(activityId)
	local info = self._msg_pool[activityId]

	if info then
		if not info.extremeClgStageInfo then
			local gainIds = {}

			for i, v in ipairs(info.extremeClgStageInfo) do
				gainIds[v.stageId] = v
			end

			local cfgs = NvdiChallengeConfig.instance:getStageCfgList(activityId) or {}

			for i, v in ipairs(cfgs) do
				local stageInfo = gainIds[v.stageId]

				if not stageInfo or not stageInfo.passed then
					return false
				end
			end

			return true
		end
	end

	return false
end

function NvdiChallengeModel:hasGainAllNormalClgPrize(activityId)
	local info = self._msg_pool[activityId]

	if info then
		local gainIds = {}

		for i, dataBitId in ipairs(info.normalClgProgressPrizeGainedBitId or {}) do
			gainIds[dataBitId] = true
		end

		local cfgs = NvdiChallengeConfig.instance:getProgressCfgById(activityId) or {}

		for i, v in ipairs(cfgs) do
			if not gainIds[v.dataBitId] then
				return false
			end
		end

		return true
	end

	return false
end

NvdiChallengeModel.instance = NvdiChallengeModel.New()

return NvdiChallengeModel

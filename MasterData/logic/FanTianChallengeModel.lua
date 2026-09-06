-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/model/FanTianChallengeModel.lua

module("logic.extensions.fantian.model.FanTianChallengeModel", package.seeall)

local FanTianChallengeModel = class("FanTianChallengeModel", BaseModel)

function FanTianChallengeModel:onInit()
	self:onReset()
end

function FanTianChallengeModel:onReset()
	self._infoMap = {}
end

function FanTianChallengeModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function FanTianChallengeModel:handlePM_FanTianClgGetInfoRes(msg)
	local activityId = msg.activityId

	self._infoMap[activityId] = GameUtil.pbToTable(msg)
end

function FanTianChallengeModel:handlePM_FanTianClgGainProgressPrizeRes(msg)
	local activityId = msg.activityId
	local dataBitId = msg.dataBitId
	local tb = self._infoMap[activityId]

	if tb then
		tb.prizeGainedBitId = tb.prizeGainedBitId or {}

		table.insert(tb.prizeGainedBitId, dataBitId)

		self._infoMap[activityId] = tb
	end
end

function FanTianChallengeModel:checkStageHasGain(activityId, curTierId, stageId, creepsId)
	local tb = self._infoMap[activityId]

	if tb then
		if curTierId < tb.curTierId then
			return true
		end

		if curTierId > tb.curTierId then
			return false
		end

		local stageInfo = tb.stageInfo

		if stageInfo then
			for i, v in ipairs(stageInfo) do
				if v.stageId == stageId then
					if not v.hasGainSoulCreepsId then
						local hasGainSoulCreepsId = {}

						return table.indexof(hasGainSoulCreepsId, creepsId) ~= false
					end
				end
			end
		end
	end

	return false
end

function FanTianChallengeModel:updateHasGainSoulCreepsId(msg)
	local activityId = msg.activityId
	local stageId = msg.stageIdWhenFight
	local list = msg.hasGainSoulCreepsId

	if not self._infoMap[activityId] then
		if not self._infoMap[activityId].stageInfo then
			local stageInfo = {}
			local isFound = false

			for i, v in ipairs(stageInfo) do
				if v.stageId == stageId then
					isFound = true
					v.hasGainSoulCreepsId = list
				end
			end

			if not isFound then
				local obj = {}

				obj.stageId = stageId
				obj.hasGainSoulCreepsId = list

				table.insert(stageInfo, obj)
			end

			self._infoMap[activityId].stageInfo = stageInfo
			self._infoMap[activityId] = self._infoMap[activityId]
		end
	end
end

FanTianChallengeModel.instance = FanTianChallengeModel.New()

return FanTianChallengeModel

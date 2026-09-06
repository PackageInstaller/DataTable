-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starhall/model/StarHallModel.lua

module("logic.extensions.starhall.model.StarHallModel", package.seeall)

local StarHallModel = class("StarHallModel", BaseModel)

function StarHallModel:onInit()
	self:onReset()
end

function StarHallModel:onReset()
	self._baseInfoMap = {}
	self._rankInfoMap = {}
	self._stageInfoMap = {}
end

function StarHallModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info

	if not info.stages then
		if #info.stages > 0 then
			if not self._stageInfoMap[info.activityId] then
				table.clear(self._stageInfoMap[info.activityId])

				for i, stageInfo in ipairs(info.stages) do
					self._stageInfoMap[info.activityId][stageInfo.stageId] = stageInfo
				end

				self._stageInfoMap[info.activityId] = self._stageInfoMap[info.activityId]
			end
		end
	end
end

function StarHallModel:onResetStage(msg)
	local info = GameUtil.pbToTable(msg)
	local stageInfoMap = self._stageInfoMap[info.activityId]

	if stageInfoMap then
		stageInfoMap[info.stageId] = nil
	end
end

function StarHallModel:onGetRankInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._rankInfoMap[info.activityId] = info
end

function StarHallModel:onNotifyClgFinish(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local stageId = info.stageId
	local difficultId = info.difficultId
	local number = info.number
	local stageCfg = StarHallConfig.instance:getStageCfgByStageId(activityId, stageId)
	local diffCfg = StarHallConfig.instance:getStageDifficultyCfgsByDiffId(activityId, stageId, difficultId)

	if diffCfg then
		if not diffCfg.score then
			local diffScore = 0

			if number ~= -1 then
				if not stageCfg.numberScore then
					local addScore = 0
					local newScore = diffScore + addScore
					local oldScore = self:getScoreByStage(activityId, stageId)

					if oldScore < newScore then
						if not self._stageInfoMap[activityId] then
							local stageInfoMap = {}
							local stageInfo = stageInfoMap[stageId]

							if stageInfo then
								stageInfo.difficultId = difficultId
								stageInfo.settlementId = info.settlementId
								stageInfo.number = number
							else
								stageInfo = {
									stageId = stageId,
									difficultId = difficultId,
									settlementId = info.settlementId,
									number = number
								}
								stageInfoMap[stageId] = stageInfo
							end

							self._stageInfoMap[activityId] = stageInfoMap
						end
					end
				end
			end
		end
	end
end

function StarHallModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		printError("星运神殿数据未初始化")
	end

	return self._baseInfoMap[activityId]
end

function StarHallModel:getRankInfo(activityId)
	if not self._rankInfoMap[activityId] then
		printError("星运神殿排行榜数据未初始化")
	end

	return self._rankInfoMap[activityId]
end

function StarHallModel:getCurTotalSocre(activityId)
	local stageInfoMap = self._stageInfoMap[activityId]

	if stageInfoMap then
		local totalScore = 0

		for _, stageInfo in pairs(stageInfoMap) do
			totalScore = totalScore + self:getScoreByStage(activityId, stageInfo.stageId)
		end

		return totalScore
	end

	return 0
end

function StarHallModel:getScoreByStage(activityId, stageId)
	if not self._stageInfoMap[activityId] then
		local stageInfoMap = {}
		local stageInfo = stageInfoMap[stageId]

		if stageInfo then
			local stageCfg = StarHallConfig.instance:getStageCfgByStageId(activityId, stageId)
			local diffCfg = StarHallConfig.instance:getStageDifficultyCfgsByDiffId(activityId, stageId, stageInfo.difficultId)

			if diffCfg then
				if not diffCfg.score then
					local diffScore = 0

					if stageInfo.number ~= -1 then
						if not stageCfg.numberScore then
							local addScore = 0

							return diffScore + addScore
						end
					end
				end
			end
		end

		return 0
	end
end

function StarHallModel:getCurStageInfoMap(activityId)
	return self._stageInfoMap[activityId] or {}
end

StarHallModel.instance = StarHallModel.New()

return StarHallModel

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/model/DivineYuHuiModel.lua

module("logic.extensions.divineyuhui.model.DivineYuHuiModel", package.seeall)

local DivineYuHuiModel = class("DivineYuHuiModel", BaseModel)

function DivineYuHuiModel:onInit()
	self:onReset()
end

function DivineYuHuiModel:onReset()
	self._customFmtMoPool = {}
	self._infos = {}
	self._raceId2StageIdsDic = {}
end

function DivineYuHuiModel:getInfo(activityId)
	return self._infos[activityId]
end

function DivineYuHuiModel:getRaceIdDic(activityId)
	if self._raceId2StageIdsDic[activityId] == nil then
		self._raceId2StageIdsDic[activityId] = {}
	end

	return self._raceId2StageIdsDic[activityId]
end

function DivineYuHuiModel:handlePM_DivineYuHuiClgInfoRes(msg)
	self._infos[msg.activityId] = self._infos[msg.activityId] or {}

	local info = self._infos[msg.activityId]

	if msg.stages then
		info.stages = {}

		local curRaceIdDic = self:getRaceIdDic(msg.activityId)

		for i, stageInfo in pairs(msg.stages) do
			if stageInfo and stageInfo.stageId then
				info.stages[stageInfo.stageId] = stageInfo

				local raceIds = stageInfo.raceIds

				if raceIds then
					for k, raceId in pairs(raceIds) do
						local stageIdList = curRaceIdDic[raceId]

						if stageIdList == nil then
							stageIdList = {}
							curRaceIdDic[raceId] = stageIdList
						end

						if not table.indexof(stageIdList, stageInfo.stageId) then
							table.insert(stageIdList, stageInfo.stageId)
							table.sort(stageIdList, function(a, b)
								return a < b
							end)
						end
					end
				end
			end
		end
	end

	info.hadGainFinishPrize = msg.hadGainFinishPrize
end

function DivineYuHuiModel:handlePM_DivineYuHuiClgResetRes(msg)
	local info = self:getInfo(msg.activityId)

	if msg.stageId == -1 then
		info.stages = nil
		self._raceId2StageIdsDic[msg.activityId] = {}
	else
		local curStageInfo = info.stages[msg.stageId]

		if curStageInfo.raceIds then
			local curRaceIdDic = self:getRaceIdDic(msg.activityId)

			for k, raceId in pairs(curStageInfo.raceIds) do
				local stageIdList = curRaceIdDic[raceId]

				if stageIdList then
					local index = table.indexof(stageIdList, msg.stageId)

					if index then
						table.remove(stageIdList, index)
					end
				end
			end
		end

		info.stages[msg.stageId] = nil
	end
end

function DivineYuHuiModel:handlePM_NotifyDivineYuHuiClgFinishRes(msg)
	if msg.isWin then
		local stageId = msg.stageId
		local info = self._infos[msg.activityId]
		local curRaceIdDic = self:getRaceIdDic(msg.activityId)

		info.stages = info.stages or {}

		if msg.raceIds then
			for k, raceId in pairs(msg.raceIds) do
				local stageIdList = curRaceIdDic[raceId]

				if stageIdList == nil then
					stageIdList = {}
					curRaceIdDic[raceId] = stageIdList
				end

				if not table.indexof(stageIdList, stageId) then
					table.insert(stageIdList, stageId)
					table.sort(stageIdList, function(a, b)
						return a < b
					end)
				end
			end
		end
	end
end

function DivineYuHuiModel:getStageIdListByRaceId(activityId, raceId)
	local curRaceIdDic = self:getRaceIdDic(activityId)

	return curRaceIdDic[raceId]
end

function DivineYuHuiModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = DivineYuHuiFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function DivineYuHuiModel:stageHasPassed(activityId, stageId)
	local info = self:getInfo(activityId)
	local stageInfo = info.stages[stageId]

	return stageInfo ~= nil
end

DivineYuHuiModel.instance = DivineYuHuiModel.New()

return DivineYuHuiModel

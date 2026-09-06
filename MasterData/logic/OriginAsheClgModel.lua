-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originasheclg/model/OriginAsheClgModel.lua

module("logic.extensions.originasheclg.model.OriginAsheClgModel", package.seeall)

local OriginAsheClgModel = class("OriginAsheClgModel", BaseModel)

function OriginAsheClgModel:ctor()
	return
end

function OriginAsheClgModel:onInit()
	self:onReset()
end

function OriginAsheClgModel:onReset()
	self._infos = {}
	self._stageInfo = {}
	self._lockPet = {}
	self._fmtMo = nil
end

function OriginAsheClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginAsheClgFmtMo.New()

	return self._fmtMo
end

function OriginAsheClgModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	local stageInfo = {}

	if data.stageInfos then
		for i, v in ipairs(data.stageInfos) do
			stageInfo[v.stageId] = {}

			local info = stageInfo[v.stageId]

			info.info = v
			info.lockPet = {}
			info.petInfo = {}

			if v.lockRaceLists then
				for index, formationList in ipairs(v.lockRaceLists) do
					info.petInfo[index] = {}

					for pos, raceId in ipairs(formationList.list) do
						if raceId > 0 then
							info.lockPet[raceId] = true
						end

						info.petInfo[index][pos] = raceId
					end
				end
			end
		end
	end

	self._stageInfo[data.activityId] = stageInfo
end

function OriginAsheClgModel:getStageInfo(activityId, stageId)
	if self._stageInfo[activityId] then
		return self._stageInfo[activityId][stageId]
	end

	return nil
end

function OriginAsheClgModel:isPetLock(activityId, stageId, raceId)
	if self._stageInfo[activityId] and self._stageInfo[activityId][stageId] then
		return self._stageInfo[activityId][stageId].lockPet[raceId]
	end

	return false
end

function OriginAsheClgModel:getPetInfo(activityId, stageId, index)
	if self._stageInfo[activityId] and self._stageInfo[activityId][stageId] then
		return self._stageInfo[activityId][stageId].petInfo[index]
	end

	return nil
end

function OriginAsheClgModel:getMaxPassStage(activityId)
	if self._stageInfo[activityId] then
		local maxStageId = 0

		for i, v in pairs(self._stageInfo[activityId]) do
			if v.info.everPass == true and maxStageId < v.info.stageId then
				maxStageId = v.info.stageId
			end
		end

		return maxStageId
	end

	return 0
end

function OriginAsheClgModel:saveResetInfo(msg)
	local stageInfo = self:getStageInfo(msg.activityId, msg.stageId)

	if stageInfo then
		stageInfo.lockPet = {}
		stageInfo.petInfo = {}
		stageInfo.info.passBattleSeq = 0
		stageInfo.info.hpWanPercent = {}
	end
end

function OriginAsheClgModel:saveChallengeResult(msg, lockRaceMap)
	local data = GameUtil.pbToTable(msg)

	self:_saveTempHpList(msg)

	if data.pass == true then
		local stageInfo = self:getStageInfo(msg.activityId, msg.stageId)

		if not stageInfo then
			stageInfo = {
				info = {}
			}
			stageInfo.info.stageId = data.stageId
			stageInfo.info.passBattleSeq = data.battleSeq
			stageInfo.info.hpWanPercent = data.hpWanPercent
			stageInfo.lockPet = {}
			stageInfo.petInfo = {}
			stageInfo.petInfo[data.battleSeq] = {}

			for pos, raceId in pairs(lockRaceMap) do
				stageInfo.lockPet[raceId] = true
				stageInfo.petInfo[data.battleSeq][pos] = raceId
			end

			self._stageInfo[data.activityId] = self._stageInfo[data.activityId] or {}
			self._stageInfo[data.activityId][data.stageId] = stageInfo
		else
			stageInfo.info.passBattleSeq = data.battleSeq
			stageInfo.info.hpWanPercent = data.hpWanPercent
			stageInfo.petInfo[data.battleSeq] = {}

			for pos, raceId in pairs(lockRaceMap) do
				stageInfo.lockPet[raceId] = true
				stageInfo.petInfo[data.battleSeq][pos] = raceId
			end

			if data.battleSeq == 2 then
				stageInfo.info.everPass = true
			end
		end
	end
end

function OriginAsheClgModel:_saveTempHpList(msg)
	self._tmepHpList = msg.hpWanPercent
end

function OriginAsheClgModel:getTempHpList()
	return self._tmepHpList
end

OriginAsheClgModel.instance = OriginAsheClgModel.New()

return OriginAsheClgModel

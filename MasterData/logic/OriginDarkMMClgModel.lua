-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/model/OriginDarkMMClgModel.lua

module("logic.extensions.origindarkmmclg.model.OriginDarkMMClgModel", package.seeall)

local OriginDarkMMClgModel = class("OriginDarkMMClgModel", BaseModel)

function OriginDarkMMClgModel:onInit()
	self:onReset()
end

function OriginDarkMMClgModel:onReset()
	self._fmtMo = nil
	self._infos = {}
	self._stageInfos = {}
	self._prizeGainMap = {}
	self._actionValueDataMap = {}
	self._zeroActionValueConfirmKey = "OriginDarkMMClgActionValueView_ZeroActionValueConfirm"
end

function OriginDarkMMClgModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._infos[data.activityId] = data

	if data.stageInfos then
		local stageInfos = {}

		for i, v in ipairs(data.stageInfos) do
			stageInfos[v.stageId] = v
		end

		self._stageInfos[data.activityId] = stageInfos
	end

	self._prizeGainMap[data.activityId] = data.hasGainPrize
end

function OriginDarkMMClgModel:getStageInfos(activityId)
	return self._stageInfos[activityId] or {}
end

function OriginDarkMMClgModel:getStageInfo(activityId, stageId)
	return self._stageInfos[activityId] and self._stageInfos[activityId][stageId]
end

function OriginDarkMMClgModel:resetStageInfo(activityId, stageId)
	if self._stageInfos[activityId] then
		self._stageInfos[activityId][stageId] = nil
	end

	local info = self._infos[activityId]

	if info and info.stageInfos then
		for i, v in ipairs(info.stageInfos) do
			if v.stageId == stageId then
				table.remove(info.stageInfos, i)

				break
			end
		end
	end
end

function OriginDarkMMClgModel:isGainPrize(activityId)
	return self._prizeGainMap[activityId] == true
end

function OriginDarkMMClgModel:_getActionValueKey(activityId, stageId)
	return string.format("%s_%s", checknumber(activityId), checknumber(stageId))
end

function OriginDarkMMClgModel:saveActionValueData(activityId, stageId, actionValueData)
	if not actionValueData then
		return
	end

	self._actionValueDataMap[self:_getActionValueKey(activityId, stageId)] = clone(actionValueData)
end

function OriginDarkMMClgModel:getActionValueData(activityId, stageId)
	local data = self._actionValueDataMap[self:_getActionValueKey(activityId, stageId)]

	return data and clone(data) or nil
end

function OriginDarkMMClgModel:saveChallengeResult(msg)
	local data = GameUtil.pbToTable(msg)

	if data.win then
		self._stageInfos[data.activityId] = self._stageInfos[data.activityId] or {}
		self._infos[data.activityId] = self._infos[data.activityId] or {}
		self._infos[data.activityId].stageInfos = self._infos[data.activityId].stageInfos or {}

		local stageInfo = {
			stageId = data.stageId,
			lockRaceIds = data.lockRaceIds,
			changeSetId = data.changeSetId
		}

		self._stageInfos[data.activityId][data.stageId] = stageInfo

		for i, v in ipairs(self._infos[data.activityId].stageInfos) do
			if v.stageId == data.stageId then
				self._infos[data.activityId].stageInfos[i] = stageInfo

				return
			end
		end

		table.insert(self._infos[data.activityId].stageInfos, stageInfo)
	end
end

function OriginDarkMMClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginDarkMMClgFmtMo.New()

	return self._fmtMo
end

function OriginDarkMMClgModel:getZeroActionValueConfirmKey()
	return self._zeroActionValueConfirmKey
end

OriginDarkMMClgModel.instance = OriginDarkMMClgModel.New()

return OriginDarkMMClgModel

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldprogressprize/data/WorldProgressPrizeMo.lua

module("logic.extensions.worldprogressprize.data.WorldProgressPrizeMo", package.seeall)

local WorldProgressPrizeMo = class("WorldProgressPrizeMo")

function WorldProgressPrizeMo:ctor(activityId)
	self._activityId = activityId
	self._progressDic = {}
end

function WorldProgressPrizeMo:dispose()
	return
end

function WorldProgressPrizeMo:handlePM_WorldProgressPrizeGetInfoRes(_msg)
	local msg = GameUtil.pbToTable(_msg)

	table.clear(self._progressDic)

	for _, v in ipairs(msg.progressList) do
		v.gainPrizeIds = v.gainPrizeIds or {}
		self._progressDic[v.progressId] = v
	end
end

function WorldProgressPrizeMo:handlePM_WorldProgressPrizeGainPrizeRes(msg)
	local info = self._progressDic[msg.progressId]

	if info then
		info.gainPrizeIds = info.gainPrizeIds or {}

		table.insert(info.gainPrizeIds, msg.prizeId)
	end
end

function WorldProgressPrizeMo:handlePM_WorldProgressOneClickGainPrizeRes(msg)
	local info = self._progressDic[msg.progressId]

	if info then
		info.gainPrizeIds = info.gainPrizeIds or {}

		local curGainPrizeIds = checktable(msg.gainPrizeIds)

		for i, v in ipairs(curGainPrizeIds) do
			table.insert(info.gainPrizeIds, v)
		end
	end
end

function WorldProgressPrizeMo:getProgressInfo(progressId)
	return self._progressDic[progressId]
end

function WorldProgressPrizeMo:getProgress(progressId)
	local info = self:getProgressInfo(progressId)

	return checknumber(info and info.progress)
end

function WorldProgressPrizeMo:isCanGetPrize(progressId, prizeId)
	return not self:isHasGainPrize(progressId, prizeId) and self:isEnoughGetPrize(progressId, prizeId)
end

function WorldProgressPrizeMo:isHasGainPrize(progressId, prizeId)
	local info = self:getProgressInfo(progressId)

	if info then
		return table.indexof(info.gainPrizeIds, prizeId) ~= false
	end

	return false
end

function WorldProgressPrizeMo:isEnoughGetPrize(progressId, prizeId)
	local cur = self:getProgress(progressId)
	local data = WorldProgressPrizeConfig.instance:getPrizeData(self._activityId, progressId, prizeId)
	local need = data and checknumber(data.needProgress) or 0

	return need <= cur
end

return WorldProgressPrizeMo

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/model/ScriptKillModel.lua

module("logic.extensions.scriptkill.model.ScriptKillModel", package.seeall)

local ScriptKillModel = class("ScriptKillModel", BaseModel)

function ScriptKillModel:onInit()
	self:onReset()
end

function ScriptKillModel:onReset()
	self._msgMap = {}
	self._rankInfoMap = {}
end

function ScriptKillModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function ScriptKillModel:onGetRankInfo(msg)
	local activityId = msg.activityId

	self._rankInfoMap[activityId] = GameUtil.pbToTable(msg)
end

function ScriptKillModel:onGetPrize(msg)
	local activityId = msg.activityId
	local info = self._msgMap[activityId]

	if info then
		info.gainedPrize = true
	end
end

function ScriptKillModel:getInfo(activityId)
	return self._msgMap[activityId]
end

function ScriptKillModel:getRankInfo(activityId)
	return self._rankInfoMap[activityId]
end

function ScriptKillModel:onGetGlue(msg)
	local activityId = msg.activityId
	local clueId = msg.clueId
	local info = self._msgMap[activityId]

	if info then
		info.clueIds = info.clueIds or {}

		table.insert(info.clueIds, clueId)
	end
end

function ScriptKillModel:onSuspect(activityId, chapterId, selectKiller)
	local info = self._msgMap[activityId]

	if info then
		if not info.chapters then
			local isFound = false

			for i, v in ipairs(info.chapters) do
				if v.chapterId == chapterId then
					v.selectKiller = selectKiller
					isFound = true

					break
				end
			end

			if not isFound then
				local obj = {}

				obj.chapterId = chapterId
				obj.selectKiller = selectKiller

				table.insert(info.chapters, obj)
			end

			info.chapters = info.chapters
		end
	end
end

function ScriptKillModel:onUseActionPoint(msg)
	local activityId = msg.activityId
	local todayActionPoint = msg.todayActionPoint
	local info = self._msgMap[activityId]

	if info then
		info.todayActionPoint = todayActionPoint
	end
end

function ScriptKillModel:onGetFormula(msg)
	local activityId = msg.activityId
	local newClueId = msg.newClueId
	local stagingTriggerId = msg.stagingTriggerId
	local info = self._msgMap[activityId]

	if info then
		info.clueIds = info.clueIds or {}

		if checknumber(stagingTriggerId) > 0 then
			info.stagingTriggerId = stagingTriggerId
		end

		if table.indexof(info.clueIds, newClueId) == false then
			table.insert(info.clueIds, newClueId)

			return true
		end
	end

	return false
end

function ScriptKillModel:onGetTalkGlue(msg)
	local activityId = msg.activityId
	local newClueId = msg.newClueId
	local info = self._msgMap[activityId]

	if info then
		info.clueIds = info.clueIds or {}

		if table.indexof(info.clueIds, newClueId) == false then
			table.insert(info.clueIds, newClueId)

			return true
		end
	end

	return false
end

function ScriptKillModel:getClueIds(activityId)
	local info = self._msgMap[activityId]

	if info then
		return info.clueIds
	end
end

function ScriptKillModel:getStagingTriggerId(activityId)
	local info = self._msgMap[activityId]

	if info then
		return checknumber(info.stagingTriggerId)
	end

	return 0
end

function ScriptKillModel:clearStagingTriggerId(activityId)
	local info = self._msgMap[activityId]

	if info then
		info.stagingTriggerId = 0
	end
end

function ScriptKillModel:checkFinishLast(activityId, chapterId)
	local lastId = chapterId - 1

	if lastId > 0 then
		return self:checkFinishCurr(activityId, lastId)
	end

	return true
end

function ScriptKillModel:checkFinishCurr(activityId, chapterId)
	if chapterId > 0 then
		local info = self._msgMap[activityId]

		if info then
			if not info.chapters then
				for i, v in ipairs(info.chapters) do
					if v.chapterId == chapterId then
						return checknumber(v.selectKiller) > 0
					end
				end
			end
		end

		return false
	end

	return true
end

ScriptKillModel.instance = ScriptKillModel.New()

return ScriptKillModel

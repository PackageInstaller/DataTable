-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/data/DivineMmlClgMo.lua

module("logic.extensions.divinemimengliclg.data.DivineMmlClgMo", package.seeall)

local DivineMmlClgMo = class("DivineMmlClgMo")

function DivineMmlClgMo:ctor(activityId)
	self._activityId = activityId
	self._teamInfos = {}
	self._passTeamIdLists = {}
	self._changeSetIds = {}
	self._fightMsg = nil
end

function DivineMmlClgMo:dispose()
	table.clear(self._teamInfos)
	table.clear(self._passTeamIdLists)
	table.clear(self._changeSetIds)

	self._fightMsg = nil
end

function DivineMmlClgMo:handlePM_DivineMiMengLiClgGetInfoRes(msg)
	table.clear(self._stageInfos)
	table.clear(self._teamInfos)
	table.clear(self._passTeamIdLists)

	for _, v in ipairs(msg.stageId) do
		self._passTeamIdLists[v.stageId] = {}

		for _, vv in ipairs(v.teamList) do
			local key = self:_getTeamInfoKey(v.stageId, vv.teamId)

			self._teamInfos[key] = vv

			if vv.isPass then
				table.insert(self._passTeamIdLists[v.stageId], vv.teamId)
			end
		end
	end
end

function DivineMmlClgMo:handlePM_DivineMiMengLiClgFightRes(msg)
	return
end

function DivineMmlClgMo:handlePM_DivineMiMengLiClgConfirmRes(msg)
	local stageId, teamId = msg.stageId, msg.team.teamId
	local key = self:_getTeamInfoKey(stageId, teamId)

	self._teamInfos[key] = msg.team
	self._passTeamIdLists[stageId] = self._passTeamIdLists[stageId] or {}

	if msg.team.isPass then
		table.insert(self._passTeamIdLists[stageId], teamId)
	end
end

function DivineMmlClgMo:handlePM_DivineMiMengLiClgResetRes(msg)
	return
end

function DivineMmlClgMo:handlePM_DivineMiMengLiNotifyFightRes(msg)
	self._fightMsg = msg
end

function DivineMmlClgMo:isPassChallenge()
	local stageCfg = DivineMiMengLiClgConfig.instance:getStageCfg(self._activityId) or {}
	local maxStageId = #stageCfg

	return self:isPassStage(maxStageId)
end

function DivineMmlClgMo:isUnlockStage(stageId)
	local data = DivineMiMengLiClgConfig.instance:getStageData(self._activityId, stageId)

	return GameUtil.getTimePeriod(data and data.openTime, nil) == GameUtil.inTimePeriod
end

function DivineMmlClgMo:isPassStage(stageId)
	local result = false
	local cfg = DivineMiMengLiClgConfig.instance:getTeamCfg(self._activityId, stageId)

	if cfg then
		result = true

		for _, data in ipairs(cfg) do
			if not self:isPassTeam(stageId, data.teamId) then
				result = false

				break
			end
		end
	end

	return result
end

function DivineMmlClgMo:isPassTeam(stageId, teamId)
	local info = self:getTeamInfo(stageId, teamId)

	return (info or nil) and (info.isPass or false)
end

function DivineMmlClgMo:getSignBuffCount(stageId, teamId)
	local info = self:getTeamInfo(stageId, teamId)

	return (info or nil) and (info.signBuffCount or 0)
end

function DivineMmlClgMo:getSignBuffCountInStage(stageId)
	local count = 0
	local cfg = DivineMiMengLiClgConfig.instance:getTeamCfg(self._activityId, stageId)

	if cfg then
		for _, data in ipairs(cfg) do
			count = count + self:getSignBuffCount(stageId, data.teamId)
		end
	end

	return count
end

function DivineMmlClgMo:getTeamInfo(stageId, teamId)
	local key = self:_getTeamInfoKey(stageId, teamId)

	return self._teamInfos[key]
end

function DivineMmlClgMo:_getTeamInfoKey(stageId, teamId)
	return MmUtil.getUniqueKey(stageId, teamId)
end

function DivineMmlClgMo:getCurYoulingCount(stageId)
	local lastPassTeamId = self:getLastPassTeamId(stageId)

	if lastPassTeamId > 0 then
		local signBuffCount = self:getSignBuffCount(stageId, lastPassTeamId)

		return (Mathf.Max(DivineMmlClgEnum.BaseYoulingCount - signBuffCount, 0))
	else
		return 0
	end
end

function DivineMmlClgMo:getLastPassTeamId(stageId)
	local teamId = 0
	local teamIdList = self._passTeamIdLists[stageId]

	teamId = teamIdList and teamIdList[#teamIdList] or teamId

	return teamId
end

function DivineMmlClgMo:getFightMsg()
	return self._fightMsg
end

function DivineMmlClgMo:saveChangeSetId(changeSetId)
	table.insert(self._changeSetIds, changeSetId)
end

function DivineMmlClgMo:popChangeSetId()
	return table.remove(self._changeSetIds)
end

return DivineMmlClgMo

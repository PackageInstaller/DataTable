-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/model/JieShenEventModel.lua

module("logic.extensions.jieshenevent.models.JieShenEventModel", package.seeall)

local JieShenEventModel = class("JieShenEventModel", BaseModel)

JieShenEventModel.ReadFlag = "JieShenEventModel.ReadFlag"

function JieShenEventModel:ctor()
	return
end

function JieShenEventModel:onInit()
	self:onReset()
end

function JieShenEventModel:onReset()
	self._info = {}
end

function JieShenEventModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.JieShenEvent)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.JieShenEvent)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.JieShenEvent, v.activityId) then
			local cfg = JieShenEventConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function JieShenEventModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local timelineGainMap = {}
	local timelineSaveList = {}

	if info.timelineList then
		for i, v in ipairs(info.timelineList) do
			if v.isGainPrize then
				timelineGainMap[v.id] = true
			else
				table.insert(timelineSaveList, v.id)
			end
		end
	end

	info.timelineGainMap = timelineGainMap
	info.timelineSaveList = timelineSaveList

	local clueTabGainMap = {}

	if info.clueInfo and info.clueInfo.gainPrizeTabIds then
		for i, v in ipairs(info.clueInfo.gainPrizeTabIds) do
			clueTabGainMap[v] = true
		end
	end

	info.clueTabGainMap = clueTabGainMap

	local clueGainMap = {}

	if info.clueInfo and info.clueInfo.clueIds then
		for i, v in ipairs(info.clueInfo.clueIds) do
			clueGainMap[v] = true
		end
	end

	info.clueGainMap = clueGainMap

	if info.informerInfo then
		local finishInformerMap = {}

		for i, v in ipairs(info.informerInfo.finishInformerIds or {}) do
			finishInformerMap[v] = true
		end

		local showInformerList = {}

		for i, v in ipairs(info.informerInfo.informerIds or {}) do
			if not finishInformerMap[v] then
				table.insert(showInformerList, v)
			end
		end

		info.informerInfo.showInformerList = showInformerList
	end

	self._info[info.activityId] = info

	if info.changeSetId then
		self._tempChangeSetId = info.changeSetId
	end
end

function JieShenEventModel:saveTimelinInfo(msg)
	local info = self._info[msg.activityId]

	if info then
		info.timelineGainMap[msg.timelineId] = true

		table.removebyvalue(info.timelineSaveList, msg.timelineId)
	end
end

function JieShenEventModel:saveClueTabInfo(msg)
	local info = self._info[msg.activityId]

	if info then
		info.clueTabGainMap[msg.tabId] = true
	end
end

function JieShenEventModel:saveClueInfo(msg)
	local info = self._info[msg.activityId]

	if info then
		info.clueGainMap[msg.targetClueId] = true

		table.insert(info.clueInfo.clueIds, msg.targetClueId)
	end
end

function JieShenEventModel:getTodayViewTimes(activityId)
	local info = self._info[activityId]

	if info then
		return info.todayViewTimes
	end

	return 0
end

function JieShenEventModel:getInformerIds(activityId)
	local info = self._info[activityId]

	if info and info.informerInfo then
		return info.informerInfo.informerIds or {}
	end

	return {}
end

function JieShenEventModel:getShowInfomerIds(activityId)
	local info = self._info[activityId]

	if info and info.informerInfo then
		return info.informerInfo.showInformerList or {}
	end

	return {}
end

function JieShenEventModel:isTimelineGain(activityId, timelineId)
	local info = self._info[activityId]

	if info and info.timelineGainMap then
		return info.timelineGainMap[timelineId] or false
	end

	return false
end

function JieShenEventModel:getTimelineSaveList(activityId)
	local info = self._info[activityId]

	if info then
		return info.timelineSaveList or {}
	end

	return {}
end

function JieShenEventModel:getGainClueList(activityId)
	local info = self._info[activityId]

	if info and info.clueInfo then
		return info.clueInfo.clueIds or {}
	end

	return {}
end

function JieShenEventModel:isGainClueTab(activityId, tabId)
	local info = self._info[activityId]

	if info and info.clueTabGainMap then
		return info.clueTabGainMap[tabId] or false
	end

	return false
end

function JieShenEventModel:isGainClue(activityId, clueId)
	local info = self._info[activityId]

	if info and info.clueGainMap then
		return info.clueGainMap[clueId] or false
	end

	return false
end

function JieShenEventModel:getChangeSetId()
	return self._tempChangeSetId
end

function JieShenEventModel:resetTempChangeSetId()
	self._tempChangeSetId = nil
end

function JieShenEventModel:saveIsShowEnterStory(activityId)
	GameUtil.saveUserData(JieShenEventModel.ReadFlag .. "#enter#" .. activityId, true)
end

function JieShenEventModel:getIsShowEnterStory(activityId)
	return GameUtil.getUserData(JieShenEventModel.ReadFlag .. "#enter#" .. activityId)
end

JieShenEventModel.instance = JieShenEventModel.New()

return JieShenEventModel

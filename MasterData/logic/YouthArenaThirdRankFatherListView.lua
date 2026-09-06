-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdRankFatherListView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdRankFatherListView", package.seeall)

local YouthArenaThirdRankFatherListView = class("YouthArenaThirdRankFatherListView", CommonTabRankFatherListView)

function YouthArenaThirdRankFatherListView:onEnter()
	self:_initActivityId()
	YouthArenaThirdRankFatherListView.super.onEnter(self)
end

function YouthArenaThirdRankFatherListView:_onGetDefaultLeaf(tabData)
	local leafList = tabData and tabData.leafList

	if not leafList or #leafList <= 0 then
		return 0
	end

	for _, leafData in ipairs(leafList) do
		local data = leafData and leafData.data

		if data and data.viewName and self:_isUnlock(leafData) then
			return leafData.leaf
		end
	end

	return 0
end

function YouthArenaThirdRankFatherListView:_isUnlock(tabData)
	local data = tabData and tabData.data
	local rankStage = checknumber(data and data.headTabId)

	if rankStage <= 0 then
		return true
	end

	return YouthArenaThirdController.instance:isRankStageOpen(self._activityId, rankStage)
end

function YouthArenaThirdRankFatherListView:_onPreClickTab(tabData)
	if not self:_isUnlock(tabData) then
		FloatWordMgr.instance:show(self:_getTabLockTips(tabData and tabData.data))

		return true
	end

	return false
end

function YouthArenaThirdRankFatherListView:_initActivityId()
	self._activityId = 0

	local params = self:getOpenParam() or {}
	local commonParams = params[1]
	local tabKeyList = commonParams and commonParams:getTabKeyList() or {}

	for _, key in ipairs(tabKeyList) do
		local data = commonParams:getTabData(key)
		local viewParams = data and data.viewParams
		local activityId = checknumber(viewParams and viewParams[1])

		if activityId > 0 then
			self._activityId = activityId

			return
		end
	end

	self._activityId = YouthArenaThirdController.instance:getActivityId()
end

function YouthArenaThirdRankFatherListView:_getTabLockTips(data)
	local startStamp = YouthArenaThirdController.instance:getRankStageStartStamp(self._activityId, data and data.headTabId)

	if startStamp > 0 then
		return langPara("赛事将于%s开启", self:_formatDenyTime(startStamp))
	end

	return "赛事未开启"
end

function YouthArenaThirdRankFatherListView:_formatDenyTime(stamp)
	local date = GameUtil.time2date(checknumber(stamp))

	return langPara("%s月%s日%s:%02d", date.month, date.day, date.hour, date.min)
end

return YouthArenaThirdRankFatherListView

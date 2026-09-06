-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/QingGuWorldBossTaskView.lua

module("logic.extensions.eventtasksummary.view.QingGuWorldBossTaskView", package.seeall)

local QingGuWorldBossTaskView = class("QingGuWorldBossTaskView", EventTaskFather)

function QingGuWorldBossTaskView:buildUI()
	QingGuWorldBossTaskView.super.buildUI(self)

	self._totalReward = self:getGo("totalReward")
	self._btnGoto = self:getBtn("btn")
	self._rewardScrollList = ScrollerList.create(self._totalReward, self._itemScrollercell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function QingGuWorldBossTaskView:bindEvents()
	QingGuWorldBossTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function QingGuWorldBossTaskView:unbindEvents()
	QingGuWorldBossTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function QingGuWorldBossTaskView:onEnter()
	self._activityId = checknumber(142005)
	self._activityType = checknumber(EventTaskSummaryConfig.instance:getActivityType(self._activityId))

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function QingGuWorldBossTaskView:_updateRewardCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function QingGuWorldBossTaskView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function QingGuWorldBossTaskView:_onClickGoto()
	GotoMgr.gotoByString("func#93")
end

function QingGuWorldBossTaskView:_onUpdatePlaneUI()
	local queue = EventTaskSummaryConfig.instance:getVisibleTaskQueue(self._activityId, EventTaskSummaryModel.instance:getPlayerTypeTag(self._activityId))
	local pageIdList = table.keys(queue)
	local prizes = ""

	table.sort(pageIdList, function(a, b)
		return a < b
	end)

	for i, pageId in ipairs(pageIdList) do
		local taskList = queue[pageId]

		for j, k in ipairs(taskList) do
			prizes = MaterialMgr.combineStrs(prizes, k.prize)
		end
	end

	local prizeList = string.split(prizes, "#")

	self._rewardScrollList:reloadData(prizeList)
end

return QingGuWorldBossTaskView

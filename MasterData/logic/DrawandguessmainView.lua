-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessmainView.lua

module("logic.extensions.drawandguess.view.DrawandguessmainView", package.seeall)

local DrawandguessmainView = class("DrawandguessmainView", ViewComponent)

function DrawandguessmainView:ctor()
	DrawandguessmainView.super.ctor(self)

	self._effectRewardList = {}
end

function DrawandguessmainView:unbindEvents()
	DrawandguessmainView.super.unbindEvents(self)
	self._btnMatch:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnCreate:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnJoin:RemoveClickListener()
end

function DrawandguessmainView:bindEvents()
	DrawandguessmainView.super.bindEvents(self)
	self._btnMatch:AddClickListener(self._onClickbtnMatch, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnCreate:AddClickListener(self._onClickbtnCreate, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnJoin:AddClickListener(self._onClickbtnJoin, self)
end

function DrawandguessmainView:buildUI()
	DrawandguessmainView.super.buildUI(self)

	self._btnMatch = self:getBtn("btnMatch")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnCreate = self:getBtn("btnCreate")
	self._btnRank = self:getBtn("btnRank")
	self._btnJoin = self:getBtn("btnJoin")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._tableview = self:getGo("progressReward/tableview")
	self._txtDamage = self:getTxt("progressReward/total/txt")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtTime = self:getTxt("time/txtTime")
	self._txtRule = self:getTxt("rule/txtRule")
	self._txtType = self:getTxt("btnMatch/type/txtType")
	self._clippRect = self:getGo("progressReward/tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
end

function DrawandguessmainView:onExit()
	DrawandguessmainView.super.onExit(self)
	self._rewardScrollList:dispose()
end

function DrawandguessmainView:onEnter()
	DrawandguessmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DrawAndGuessInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.DrawAndGuessGainPrizeRes, self._onDrawAndGuessGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)

	self._activityType = 536
	self._activityId = self:_getActivityId()
	self._groupId = DrawandguessController.TeamGroupId

	self:_updateUI()

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	DrawAndGuessAgent.instance:sendPM_DrawAndGuessInfoReq(self._activityId)
end

function DrawandguessmainView:_onClickbtnMatch()
	local openTimeStr = DrawandguessConfig.instance:getCommonValue("OPEN_TIME")

	if not DrawandguessController.instance:isInTimeRange(openTimeStr) then
		FloatWordMgr.instance:show("不在匹配时间段内")

		return
	end

	local actCfg = DrawandguessConfig.instance:getActCfg(self._activityId)
	local dailyTimes = actCfg.dailyTimes
	local info = DrawandguessModel.instance:getInfo(self._activityId)

	if dailyTimes <= info.dailyTimes then
		FloatWordMgr.instance:show("今日匹配次数用尽，请明日再来")

		return
	end

	UIStateManager.instance:push(ViewName.DrawandguessmatchView, self._activityId)
end

function DrawandguessmainView:_onClickbtnClose()
	self:close()
end

function DrawandguessmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("drawandguessmain")
end

function DrawandguessmainView:_onClickbtnCreate()
	FormTeamController.instance:createTeam(self._groupId, 0, false)
end

function DrawandguessmainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.DrawandguessrankView, self._activityId)
end

function DrawandguessmainView:_onClickbtnJoin()
	UIStateManager.instance:push(ViewName.DrawandguessteamView, self._activityId, self._groupId)
end

function DrawandguessmainView:_updateUI()
	local info = DrawandguessModel.instance:getInfo(self._activityId)

	if not info then
		return
	end

	self._txtDamage.text = info.score
	self._score = info.score

	local prizeList = DrawandguessConfig.instance:getPrizeCfgs(self._activityId)
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.score)

		if idx == -1 and self._score >= v.score then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._score, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)
	self:_parserOpenTime()
end

function DrawandguessmainView:_parserOpenTime()
	local actCfg = DrawandguessConfig.instance:getActCfg(self._activityId)
	local dailyTimes = actCfg.dailyTimes
	local info = DrawandguessModel.instance:getInfo(self._activityId)
	local openTimeStr = DrawandguessConfig.instance:getCommonValue("OPEN_TIME")
	local arr1 = string.split(openTimeStr, ",")
	local timeTable = {}

	for slot in string.gmatch(openTimeStr, "([^,]+)") do
		local startTime, endTime = slot:match("([^#]+)#([^#]+)")

		if startTime and endTime then
			local start = startTime:sub(1, 5)
			local end_ = endTime:sub(1, 5)

			table.insert(timeTable, string.format("%s-%s", start, end_))
		end
	end

	local tableStr = table.concat(timeTable, ",")

	self._txtRule.text = string.format("每日%s可进行匹配\n排行榜仅统计随机匹配的分数\n<color=#FFB1D0FF>今日随机匹配剩余次数:</color><color=#42FA6CFF>%s</color>/%s", tableStr, dailyTimes - info.dailyTimes, dailyTimes)
end

function DrawandguessmainView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")
	local btnGain = Framework.ButtonAdapter.Get(canGet)

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.score

	local isGainPrize = DrawandguessModel.instance:isGainPrize(self._activityId, data.prizeId)
	local isCanGet = not isGainPrize and self._score >= data.score

	self:_stopRewardEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playRewardEffect(effect)
	end

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	btnGain:AddClickListener(function()
		DrawAndGuessAgent.instance:sendPM_DrawAndGuessGainPrizeReq(self._activityId, data.prizeId)
	end)
end

function DrawandguessmainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	self:_stopRewardEffect(effect)
	MaterialMgr.resetAll(item)
end

function DrawandguessmainView:_playRewardEffect(parent)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	self._effectRewardList[parent] = self:_playEffect(effectPath, parent, true)
end

function DrawandguessmainView:_playEffect(path, parent, isClip)
	local effect = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, true, nil, nil, function(target, eff)
		if isClip then
			eff:setClipping(self._clippRect)
		end
	end, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

function DrawandguessmainView:_stopRewardEffect(effect)
	if self._effectRewardList[effect] then
		UIEffectManager.instance:stopEffect(self._effectRewardList[effect])

		self._effectRewardList[effect] = nil
	end
end

function DrawandguessmainView:_onDrawAndGuessGainPrizeRes()
	self._rewardScrollList:refresh()
end

function DrawandguessmainView:_onJoinTeam()
	UIStateManager.instance:push(ViewName.DrawandguesscurteamView, self._activityId)
end

function DrawandguessmainView:_getActivityId()
	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	return activityId
end

return DrawandguessmainView

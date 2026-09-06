-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagemainView.lua

module("logic.extensions.originage.view.OriginagemainView", package.seeall)

local OriginagemainView = class("OriginagemainView", ViewComponent)

function OriginagemainView:ctor()
	OriginagemainView.super.ctor(self)
end

function OriginagemainView:unbindEvents()
	OriginagemainView.super.unbindEvents(self)
end

function OriginagemainView:bindEvents()
	OriginagemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._shareBtn, self._onClickShare, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGain, self)
end

function OriginagemainView:buildUI()
	OriginagemainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._shareBtn = self:getGo("shareBtn")
	self._btnAdd = self:getGo("btnAdd")
	self._redPointBtnAdd = self:getGo("btnAdd/redPoint")
	self._btnGain = self:getGo("btnGain")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._itemGo = self:getGo("rewardGo/item")
	self._receivedGo = self:getGo("rewardGo/received")
	self._itemShare = self:getGo("rewardShare/item")
	self._receivedShare = self:getGo("rewardShare/received")
	self._txtCount = self:getTxt("progressReward/total/txtCount")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._tableview = self:getGo("progressReward/tableview")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function OriginagemainView:onExit()
	OriginagemainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointBtnAdd)
	self._rewardScrollList:dispose()
end

function OriginagemainView:onEnter()
	OriginagemainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginAgeController.instance:getDefaultActivityId()
	end

	self.addGEvent(self, GlobalNotify.OriginAgeInfoUpdate, self._onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WorldProgressPrizeGetInfoRes, self._onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_WorldProgressPrizeGainPrizeRes, self._onRefreshUI, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointBtnAdd, RedPointModel.ID_ORIGINAGE_INVITE_PRIZE)
	WorldProgressPrizeAgent.instance:sendPM_WorldProgressPrizeGetInfoReq(self._activityId)
	OriginAgeController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function OriginagemainView:_onRefreshUI()
	self._info = OriginAgeModel.instance:getInfo(self._activityId) or {}
	self._actCfg = OriginAgeConfig.instance:getActivityCfgById(self._activityId) or {}

	local progressId = self._actCfg.progressId

	self._progressId = progressId

	local worldProgressPrizeMo = WorldProgressPrizeController.instance:getWorldProgressPrizeMo(self._activityId)
	local winfo = worldProgressPrizeMo:getProgressInfo(progressId) or {}

	self._stageProgress = checknumber(winfo.progress)
	self._gainProgressPrizeId = winfo.gainPrizeIds or {}

	local prizeList = WorldProgressPrizeConfig.instance:getPrizeCfg(self._activityId, progressId) or {}
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.needProgress)

		local isCanGet = self._stageProgress >= v.needProgress
		local isGainPrize = table.indexof(self._gainProgressPrizeId, v.prizeId) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._stageProgress, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = self._stageProgress

	local pcfg1 = OriginAgeConfig.instance:getPrizeyCfgById(self._activityId, "CHECK_IN") or {}
	local pcfg2 = OriginAgeConfig.instance:getPrizeyCfgById(self._activityId, "SHARE") or {}

	MaterialMgr.setCellByCfg(pcfg1.prize, self._itemGo)
	MaterialMgr.setCellByCfg(pcfg2.prize, self._itemShare)

	if not self._info.gainPrizeTypeList then
		local gainPrizeTypeList = {}

		if table.indexof(gainPrizeTypeList, "CHECK_IN") == false then
			GameUtil.SetActive(self._receivedGo, false)
		else
			GameUtil.SetActive(self._receivedGo, true)
		end

		if table.indexof(gainPrizeTypeList, "SHARE") == false then
			GameUtil.SetActive(self._receivedShare, false)
		else
			GameUtil.SetActive(self._receivedShare, true)
		end
	end
end

function OriginagemainView:_onClickTips()
	TipsFacade.instance:openRulesView("originagemainview_rule")
end

function OriginagemainView:_onClickAdd()
	UIStateManager.instance:push(ViewName.OriginagebindView, self._activityId)
end

function OriginagemainView:_onClickShare()
	UIStateManager.instance:push(ViewName.OriginageshareView, "", GameUtil.handler(self._sendGetShare, self))
end

function OriginagemainView:_sendGetShare()
	if not self._info.gainPrizeTypeList then
		if table.indexof(self._info.gainPrizeTypeList, "SHARE") == false then
			OriginAgeController.instance:sendGetPrize(self._activityId, "SHARE")
		end
	end
end

function OriginagemainView:_onClickGain()
	if not self._info.gainPrizeTypeList then
		if table.indexof(self._info.gainPrizeTypeList, "CHECK_IN") == false then
			OriginAgeController.instance:sendGetPrize(self._activityId, "CHECK_IN")
		else
			TipsFacade.instance:openCommonTips("奖励已领取")
		end
	end
end

function OriginagemainView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.needProgress

	local isCanGet = self._stageProgress >= data.needProgress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function OriginagemainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function OriginagemainView:_playEffect(effGo)
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	self:playViewEffectUniGo(effPath, effGo, self:getGo("progressReward/tableview/Viewport").transform, true)
end

function OriginagemainView:_clearEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

function OriginagemainView:_onClickGetPrize(data)
	local isCanGet = self._stageProgress >= data.needProgress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		WorldProgressPrizeController.instance:sendPM_WorldProgressPrizeGainPrizeReq(self._activityId, self._progressId, data.prizeId)
	end
end

return OriginagemainView

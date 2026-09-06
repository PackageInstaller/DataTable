-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightGetRewardView.lua

module("logic.extensions.originfight.view.OriginFightGetRewardView", package.seeall)

local OriginFightGetRewardView = class("OriginFightGetRewardView", ViewComponent)

function OriginFightGetRewardView:ctor()
	OriginFightGetRewardView.super.ctor(self)
end

function OriginFightGetRewardView:unbindEvents()
	OriginFightGetRewardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGoto)
	GameUtil.rmClickHandler(self._btnGain)
end

function OriginFightGetRewardView:bindEvents()
	OriginFightGetRewardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickBtnGoto, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickBtnGain, self)
end

function OriginFightGetRewardView:buildUI()
	OriginFightGetRewardView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnGoto = self:getGo("reward/btnGoto")
	self._btnGain = self:getGo("reward/btnGain")
	self._tableview = self:getGo("reward/tableview")
	self._tablecell = self:getGo("reward/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginFightGetRewardView:onExit()
	OriginFightGetRewardView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginFightGetRewardView:onEnter()
	OriginFightGetRewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginFightGainPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 525001
	end

	self._actCfg = OriginFightConfig.instance:getActCfg(self._activityId)

	local rewardArr = string.split(self._actCfg.prize, "#")

	self._rewardList = {}

	for i, v in ipairs(rewardArr) do
		table.insert(self._rewardList, v)
	end

	self:_onSetUI()
	OriginFightController.instance:sendPM_OriginFightInfoReq(self._activityId)
end

function OriginFightGetRewardView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._scrollList:reloadData(self._rewardList)
	self._scrollList:setCenterMode(true)
end

function OriginFightGetRewardView:_onUpdate()
	self._info = OriginFightModel.instance:getInfo(self._activityId)

	self._scrollList:reloadData(self._rewardList)
	self._scrollList:setCenterMode(true)
	GameUtil.SetActive(self._btnGain, not self._info.hasGainPrize)
end

function OriginFightGetRewardView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local eff = goutil.findChild(cell, "eff")
	local hasGet = goutil.findChild(cell, "hasGet")

	if self._info then
		if not self._info.hasGainPrize then
			local hasGainPrize = false

			MaterialMgr.setCellByCfg(data, item)

			if not hasGainPrize then
				self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", eff, self._tableview, true, nil)
			else
				self:stopViewEffectUniGo(eff)
			end

			GameUtil.SetActive(hasGet, hasGainPrize)
		end
	end
end

function OriginFightGetRewardView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local eff = goutil.findChild(cell, "eff")

	MaterialMgr.resetAll(item)
	self:stopViewEffectUniGo(eff)
end

function OriginFightGetRewardView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function OriginFightGetRewardView:_onClickBtnGoto()
	local btnStr = self._actCfg.rewardGoto

	GotoMgr.gotoByString(btnStr)
end

function OriginFightGetRewardView:_onClickBtnGain()
	if self._info.hasGainPrize then
		FloatWordMgr.instance:show("已领取过奖励，无法重复领取")

		return
	end

	OriginFightController.instance:sendPM_OriginFightGainPrizeReq(self._activityId)
end

return OriginFightGetRewardView

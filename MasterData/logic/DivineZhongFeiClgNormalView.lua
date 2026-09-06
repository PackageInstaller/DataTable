-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgNormalView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgNormalView", package.seeall)

local DivineZhongFeiClgNormalView = class("DivineZhongFeiClgNormalView", ViewComponent)

function DivineZhongFeiClgNormalView:ctor()
	DivineZhongFeiClgNormalView.super.ctor(self)
end

function DivineZhongFeiClgNormalView:unbindEvents()
	DivineZhongFeiClgNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
end

function DivineZhongFeiClgNormalView:bindEvents()
	DivineZhongFeiClgNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function DivineZhongFeiClgNormalView:buildUI()
	DivineZhongFeiClgNormalView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._btnStart = self:getGo("btnStart")
	self._rewardtableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardtableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._petCon = self:getGo("con")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self.damageTxt = self:getGo("dailyDamage/damageTxt"):GetComponent(ComponentType.UIImgNumeralText)
end

function DivineZhongFeiClgNormalView:onExit()
	DivineZhongFeiClgNormalView.super.onExit(self)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end
end

function DivineZhongFeiClgNormalView:onEnter()
	DivineZhongFeiClgNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineZhongFeiClgGetInfo, self._setProgressReward, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = DivineZhongFeiClgConfig.instance:getActivityCfg(self._activityId)

	if self._roleObj then
		RoleObjectPool.instance:removeRole(self._roleObj)

		self._roleObj = nil
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.showRaceId, self._petCon)

	self:_setProgressReward()
end

function DivineZhongFeiClgNormalView:_setProgressReward()
	local prizeList = DivineZhongFeiClgConfig.instance:getNormalPrizeCfgs(self._activityId)

	self._totalScore = DivineZhongFeiClgModel.instance:getNormalStageScore(self._activityId)

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, checknumber(v.damage))

		local isCanGet = self._totalScore >= checknumber(v.damage)
		local isGainPrize = DivineZhongFeiClgModel.instance:isGainNormalPrize(self._activityId, v.prizeId)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._totalScore, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = langPara("%d", checknumber(self._totalScore))

	self.damageTxt:SetNum(DivineZhongFeiClgModel.instance:getNormalTodayDamage(self._activityId))
end

function DivineZhongFeiClgNormalView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "received")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local canGet = goutil.findChild(go, "canGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	local score = checknumber(data.damage)

	txtScore.text = langPara("%s", MmUtil.formatNumber(score, MmUtil.Units_CN, 0))

	local isCanGet = score <= self._totalScore
	local isGainPrize = DivineZhongFeiClgModel.instance:isGainNormalPrize(self._activityId, data.prizeId)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:stopViewEffectUniGo(effect)

	if isCanGet and not isGainPrize then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
		local clipGo = self:getGo("progressReward/tableview/Viewport")

		self:playViewEffectUniGo(effPath, effect, clipGo, true)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function DivineZhongFeiClgNormalView:_clearRewardCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	self:stopViewEffectUniGo(effect)
end

function DivineZhongFeiClgNormalView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineZhongFeiClgNormalBuffView, self._activityId)
end

function DivineZhongFeiClgNormalView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_zhong_fei_clg_rule")
end

function DivineZhongFeiClgNormalView:_onClickStart()
	DivineZhongFeiClgController.instance:openNormalMissionView(self._activityId)
end

function DivineZhongFeiClgNormalView:_onClickGetPrize(data)
	local isCanGet = self._totalScore >= checknumber(data.damage)
	local isGainPrize = DivineZhongFeiClgModel.instance:isGainNormalPrize(self._activityId, data.prizeId)

	if isCanGet and not isGainPrize then
		DivineZhongFeiClgAgent:sendPM_DivineZhongFeiClgNormalGainPrizeReq(self._activityId, data.prizeId)
	end
end

return DivineZhongFeiClgNormalView

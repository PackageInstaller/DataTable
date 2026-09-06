-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialPrizeView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialPrizeView", package.seeall)

local GoddessTrialPrizeView = class("GoddessTrialPrizeView", ViewComponent)

function GoddessTrialPrizeView:ctor()
	GoddessTrialPrizeView.super.ctor(self)
end

function GoddessTrialPrizeView:unbindEvents()
	GoddessTrialPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnOneKey)
end

function GoddessTrialPrizeView:bindEvents()
	GoddessTrialPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
end

function GoddessTrialPrizeView:buildUI()
	GoddessTrialPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnOneKey = self:getGo("btnOneKey")
	self._rewardtableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardtableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._txtTotalScore = self:getTxt("progressReward/total/txt")
	self._txtNormalScore = self:getTxt("normalScore/txtScore")
	self._txtSuperScore = self:getTxt("superScore/txtScore")
	self._txtBossScore = self:getTxt("bossScore/txtScore")
end

function GoddessTrialPrizeView:onExit()
	GoddessTrialPrizeView.super.onExit(self)
end

function GoddessTrialPrizeView:onEnter()
	GoddessTrialPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessTrialGetInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()

	self:_refreshView()
end

function GoddessTrialPrizeView:_refreshView()
	local prizeList = GoddessTrialConfig.instance:getPrizeCfgs(self._activityId)

	self._totalScore = GoddessTrialController.instance:getTotalScore(self._activityId)

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, checknumber(v.needScore))

		local isCanGet = self._totalScore >= checknumber(v.needScore)
		local isGainPrize = GoddessTrialModel.instance:isGainPrize(self._activityId, v.prizeId)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._totalScore, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtTotalScore.text = self._totalScore
	self._txtNormalScore.text = GoddessTrialController.instance:getNormalScore(self._activityId)
	self._txtSuperScore.text = GoddessTrialController.instance:getSuperScore(self._activityId)
	self._txtBossScore.text = GoddessTrialController.instance:getBossScore(self._activityId)
end

function GoddessTrialPrizeView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "received")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local canGet = goutil.findChild(go, "canGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.needScore

	local isCanGet = self._totalScore >= checknumber(data.needScore)
	local isGainPrize = GoddessTrialModel.instance:isGainPrize(self._activityId, data.prizeId)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function GoddessTrialPrizeView:_onClickGetPrize(data)
	local isCanGet = self._totalScore >= checknumber(data.needScore)
	local isGainPrize = GoddessTrialModel.instance:isGainPrize(self._activityId, data.prizeId)

	if isCanGet and not isGainPrize then
		GoddessTrialClgAgent.instance:sendPM_GoddessTrialGainPrizeReq(self._activityId, {
			data.prizeId
		})
	end
end

function GoddessTrialPrizeView:_clearRewardCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function GoddessTrialPrizeView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function GoddessTrialPrizeView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function GoddessTrialPrizeView:_onClickOneKey()
	local prizeList = GoddessTrialConfig.instance:getPrizeCfgs(self._activityId)
	local prizeCanGetList = {}

	for i, v in ipairs(prizeList) do
		local isCanGet = self._totalScore >= checknumber(v.needScore)
		local isGainPrize = GoddessTrialModel.instance:isGainPrize(self._activityId, v.prizeId)

		if isCanGet and not isGainPrize then
			table.insert(prizeCanGetList, v.prizeId)
		end
	end

	if #prizeCanGetList > 0 then
		GoddessTrialClgAgent.instance:sendPM_GoddessTrialGainPrizeReq(self._activityId, prizeCanGetList)
	else
		FloatWordMgr.instance:show(lang("无可领取奖励"))
	end
end

return GoddessTrialPrizeView

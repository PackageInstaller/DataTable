-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideamainView.lua

module("logic.extensions.pickupidea.view.PickupideamainView", package.seeall)

local PickupideamainView = class("PickupideamainView", ViewComponent)

PickupideamainView.PlayEndStoryKey = "PickupideamainView_endStory"

function PickupideamainView:ctor()
	PickupideamainView.super.ctor(self)
end

function PickupideamainView:unbindEvents()
	PickupideamainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnPlay:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function PickupideamainView:bindEvents()
	PickupideamainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnPlay:AddClickListener(self._onClickbtnPlay, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function PickupideamainView:buildUI()
	PickupideamainView.super.buildUI(self)

	self._txtTotal = self:getTxt("progressReward/total/txt")
	self._txtTime = self:getTxt("time/txt")
	self._contentGo = self:getGo("content")
	self._tableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._cellGo = self:getGo("cell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._rewardCellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	goutil.setActive(self._cellGo, false)

	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnRank = self:getBtn("btnRank")
	self._btnPlay = self:getBtn("btnPlay")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtLeft = self:getTxt("txtLeft")
	self._redPointGo = self:getGo("btnPlay/redPoint")
	self._txtCostTip = self:getTxt("txtCostTip")
end

function PickupideamainView:onExit()
	PickupideamainView.super.onExit(self)
	self._scrollerList:dispose()

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)

		self.pmEff = nil
	end
end

function PickupideamainView:onEnter()
	PickupideamainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaGainProgressPrizeRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.PickUpIdeaGetInfoRes, self._updateUI, self)
	self:_initId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开启")
		self:close()

		return
	end

	self._actCfg = PickupideaConfig.instance:getActivityCfg(self._activityId)

	self:_updateUI()
	self:_setTime()
	self:_setCostTip()
	self:_setPlayRedpoint()
	self:_playMainEffect()
	PickUpIdeaAgent.instance:sendPM_PickUpIdeaGetInfoReq(self._activityId)
end

function PickupideamainView:_setTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function PickupideamainView:_updateUI()
	self:_updateRoles()
	self:_updateRewards()
	self:_playEndStory()
	self:_setLeftTime()
end

function PickupideamainView:_updateRoles()
	local cfgs = PickupideaConfig.instance:getRoleCfgs(self._activityId)

	for i, cfg in ipairs(cfgs) do
		local childName = "cell" .. i
		local mainGo = goutil.findChild(self._contentGo, childName)

		self:_updateRole(mainGo, cfg)
	end
end

function PickupideamainView:_updateRole(mainGo, cfg)
	local btnPlay = Framework.ButtonAdapter.GetFrom(mainGo.gameObject, "btnPlay")
	local goIcon = goutil.findChild(mainGo.gameObject, "icon")
	local txtValue = goutil.findChildTextComponent(mainGo.gameObject, "txtValue")
	local redPointGo = goutil.findChild(mainGo.gameObject, "btnPlay/redpoint")
	local value = MaterialFacade.instance:getMatNumber(10, cfg.activityItemId)

	txtValue.text = string.format("好感度%s", value)

	btnPlay:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PickupideastoryView, cfg.roleId)
	end)
	RedPointController.instance:unregRedPoint(redPointGo)

	local ids = {}
	local storyCfgs = PickupideaConfig.instance:getStoryCfgs(self._activityId, cfg.roleId)

	for i, v in ipairs(storyCfgs) do
		local key = PickupideaController.instance:getStoryViewKey(self._activityId, cfg.roleId, v.index)

		table.insert(ids, key)
	end

	RedPointController.instance:regRedPoint(redPointGo, GameUtil.unpack10(ids))
end

function PickupideamainView:_updateRewards()
	self._prizeGainedBitIdList = PickupideaModel.instance:getGainedPrizeIds()
	self._curProgress = PickupideaModel.instance:getHasPlayTimes()

	local progressCfgList = PickupideaConfig.instance:getProgressPrizeCfgs(self._activityId)
	local scoreArr = {}
	local idx = -1

	for k, v in ipairs(progressCfgList) do
		table.insert(scoreArr, v.progress)

		local isCanGet = self._curProgress >= v.progress
		local isGainPrize = table.indexof(self._prizeGainedBitIdList, v.prizeId) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = k - 1
		end
	end

	self._scrollerList:reloadData(progressCfgList)
	self._scrollerList:updateUnderSlider(self._progressBar, self._curProgress, scoreArr)
	self._scrollerList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtTotal.text = self._curProgress
end

function PickupideamainView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._curProgress >= data.progress
	local isGainPrize = table.indexof(self._prizeGainedBitIdList, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.prizeId), self)
end

function PickupideamainView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)

	local effect = goutil.findChild(cell, "effect")

	self:_clearEffect(effect)
end

function PickupideamainView:_playEffect(effGo)
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

function PickupideamainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function PickupideamainView:_onClickGetPrize(prizeId)
	PickUpIdeaAgent.instance:sendPM_PickUpIdeaGainProgressPrizeReq(self._activityId, prizeId)
end

function PickupideamainView:_onClickbtnTip()
	local key = "pickupideamain"

	TipsFacade.instance:openRulesView(key)
end

function PickupideamainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.PickupidearankView)
end

function PickupideamainView:_onClickbtnPlay()
	local leftTimes = self:_getLeftPlayTime()

	if leftTimes == 0 then
		FloatWordMgr.instance:show("好感度不足")

		return
	end

	PickupideaController.instance:tryStartGame(self._activityId)
end

function PickupideamainView:_onClickbtnClose()
	self:close()
end

function PickupideamainView:_initId()
	local id = self:getFirstParam()

	self._activityId = checknumber(id)
	self._activityType = GameEnum.ActivityType.PickUpIdea

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	PickupideaModel.instance:setActivityId(self._activityId)
end

function PickupideamainView:_playEndStory()
	local isPlay = GameUtil.getUserData(PickupideamainView.PlayEndStoryKey)

	if isPlay then
		return
	end

	local hasPlayTimes = PickupideaModel.instance:getHasPlayTimes()

	if hasPlayTimes >= self._actCfg.playTime then
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._actCfg.endStoryId)
		GameUtil.saveUserData(PickupideamainView.PlayEndStoryKey, true)
	end
end

function PickupideamainView:_getLeftPlayTime()
	local cfgs = PickupideaConfig.instance:getRoleCfgs(self._activityId)
	local totalGoodFeel = 0

	for i, v in ipairs(cfgs) do
		local item = string.format("10:%s", v.activityItemId)

		totalGoodFeel = totalGoodFeel + MaterialMgr.getMatCount(item)
	end

	local canTimes = math.floor(totalGoodFeel / self._actCfg.playCost)
	local leftTimes = canTimes - PickupideaModel.instance:getHasPlayTimes()

	leftTimes = math.max(leftTimes, 0)

	return leftTimes
end

function PickupideamainView:_setLeftTime()
	local leftTimes = self:_getLeftPlayTime()

	self._txtLeft.text = string.format("剩余：%s次", leftTimes)
end

function PickupideamainView:_setCostTip()
	self._txtCostTip.text = string.format("每%s好感度可拾取一次", self._actCfg.playCost)
end

function PickupideamainView:_setPlayRedpoint()
	local leftTimes = self:_getLeftPlayTime()

	goutil.setActive(self._redPointGo, leftTimes > 0)
end

function PickupideamainView:_playMainEffect()
	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

return PickupideamainView

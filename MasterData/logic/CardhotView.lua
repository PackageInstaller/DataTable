-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cardhot/view/CardhotView.lua

module("logic.extensions.cardhot.view.CardhotView", package.seeall)

local CardhotView = class("CardhotView", ViewComponent)

function CardhotView:ctor()
	CardhotView.super.ctor(self)
end

function CardhotView:buildUI()
	CardhotView.super.buildUI(self)

	self._close = self:getBtn("btnClose")
	self._btnGet = self:getBtn("btnGet")
	self._redPoint = self:getGo("btnGet/redPoint")
	self._tipNoPrize = self:getGo("rightDown/tipNoPrize")
	self._txtTime = self:getTxt("rightDown/tipTime")
	self._cellAddPrize = self:getGo("rightDown/cell")
	self._itemFriendList = {}

	for i = 1, 3 do
		local item = self:getGo("leftDown/items/cell" .. i)

		table.insert(self._itemFriendList, item)
	end

	self._itemRewardList = {}

	for i = 1, 3 do
		local item = self:getGo("rightUp/items/cell" .. i)

		table.insert(self._itemRewardList, item)
	end

	self._plotCellList = {}

	for i = 1, 3 do
		local plotCell = {}

		plotCell.data = nil

		local path = "leftUp/items/plotCell" .. i
		local go = self:getGo(path)

		plotCell.go = go
		plotCell.goLock = goutil.findChild(go, "lock")
		plotCell.isLock = false
		plotCell.btn = self:getBtn(path .. "/btnPlot")

		table.insert(self._plotCellList, plotCell)
	end
end

function CardhotView:bindEvents()
	CardhotView.super.bindEvents(self)
	self._close:AddClickListener(self.close, self)
	self._btnGet:AddClickListener(self._clickGet, self)

	for i = 1, #self._plotCellList do
		self._plotCellList[i].btn:AddClickListener(function()
			self:_onClickPlotBtn(i)
		end, self)
	end
end

function CardhotView:unbindEvents()
	CardhotView.super.unbindEvents(self)
	self._close:RemoveClickListener()
	self._btnGet:RemoveClickListener()

	for i = 1, #self._plotCellList do
		self._plotCellList[i].btn:RemoveClickListener()
	end
end

function CardhotView:destroyUI()
	CardhotView.super.destroyUI(self)
end

function CardhotView:onEnter()
	CardhotView.super.onEnter(self)

	local effPath = "fx_ui_xiuer/fx_xiuer_zhanshi.prefab"

	self._showEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, nil, self)

	self._showEff:setParent(self.mainGO.transform)
	self._showEff:setLocalPos(0, 0, 0)
	self._showEff:setScale(1)

	self._actId = self:_getCurActId()

	self:_sendInitInfoReq()
	self:_updateFriendItem()
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)

	self._txtTime.text = GameUtil.formatTimeStamp("%m月%d日登录可得", self:_getTimeToGetAddPrize())
end

function CardhotView:onEnterFinished()
	CardhotView.super.onEnterFinished(self)
end

function CardhotView:onExit()
	CardhotView.super.onExit(self)
	MaterialMgr.resetAll(self._cellAddPrize)

	for i = 1, #self._itemFriendList do
		MaterialMgr.resetAll(self._itemFriendList[i])
	end

	for i = 1, #self._itemRewardList do
		MaterialMgr.resetAll(self._itemRewardList[i])
	end

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	self:_showCI()
end

function CardhotView:onExitFinished()
	CardhotView.super.onExitFinished(self)
end

function CardhotView:_getCurActId()
	self._curActCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CardHot)

	if self._curActCfg then
		return self._curActCfg.activityId
	else
		FloatWordMgr.instance:show("活动未开启")
		self:close()
	end
end

function CardhotView:_sendInitInfoReq()
	PoolPreHeatAgent.instance:sendGetActivityInfoReq(self._actId, function(msg)
		self._signDay = checknumber(msg.signInDays)
		self._isGain = checkbool(msg.isGain)
		self._isHasGainAll = checkbool(msg.hasGianMassPrize)

		if self._isHasGainAll then
			FloatWordMgr.instance:show("奖励已领取")
			self:close()

			return
		elseif self:_getIsTimeToGetAddPrize() and self._signDay == 0 then
			FloatWordMgr.instance:show("活动结束")
			self:close()

			return
		end

		self:_updateInfoData()
	end)
end

function CardhotView:_updateInfoData()
	if self._isGain then
		self._curDay = self._signDay or self._signDay + 1
	end

	self:_updateRewardItem()
	self:_updateGetBtnState()
	self:_updatePlotBtnState()
end

function CardhotView:_updatePlotBtnState()
	local storyCfgs = CardhotConfig.instance:getStoryCfgsById(self._actId)

	for i = 1, #self._plotCellList do
		local cfg = storyCfgs[i]
		local cell = self._plotCellList[i]

		if cfg then
			cell.data = cfg
			cell.isLock = self._signDay < cfg.day
		end

		goutil.setActive(cell.go, cfg)
		goutil.setActive(cell.goLock, cell.isLock)
	end
end

function CardhotView:_onClickPlotBtn(day)
	local cell = self._plotCellList[day]

	if cell then
		if cell.isLock then
			FloatWordMgr.instance:show("剧情未解锁，明日再来")
		else
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, cell.data.storyId, StoryModel.StoryType.SCCopy)
		end
	end
end

function CardhotView:_updateRewardItem()
	local cfgs = CardhotConfig.instance:getPrizeCfgsById(self._actId)

	self._isLastOver = #cfgs <= self._signDay

	if not self:_getIsTimeToGetAddPrize() then
		local rewardList = MaterialMgr.changeItemStrArr(cfgs[self._curDay].instantPrize)

		for i = 1, 3 do
			if i <= #rewardList then
				MaterialMgr.setCellByCfg(rewardList[i], self._itemRewardList[i])
			end

			goutil.setActive(self._itemRewardList[i], rewardList[i] ~= nil)
		end
	else
		for i = 1, #self._itemRewardList do
			MaterialMgr.resetAll(self._itemRewardList[i])
		end
	end

	goutil.setActive(self._tipNoPrize, self._signDay <= 0)
	goutil.setActive(self._cellAddPrize, self._signDay > 0)

	if self._signDay > 0 then
		MaterialMgr.resetAll(self._cellAddPrize)

		local showNum = 0
		local lastMatStr = cfgs[1].massPrize

		for i = 1, self._signDay do
			local addPrize = cfgs[i].massPrize
			local matType, matId, matNum = MaterialMgr.getMatParams(addPrize)

			showNum = matNum + showNum
		end

		local proxy = MaterialMgr.setCellByCfg(lastMatStr, self._cellAddPrize)

		proxy:setAutoTips(not self:_getIsAbleToGetAddPrize())
		proxy:setNum(showNum)
		proxy:setCallBack(function()
			self:_clickGetAdd()
		end)

		if self:_getIsAbleToGetAddPrize() then
			self._playEff = self:_creatEffect(self._cellAddPrize)

			proxy:setGray(false)
		else
			proxy:setGray(true)
			UIEffectManager.instance:stopEffect(self._playEff)

			self._playEff = nil
		end
	end
end

function CardhotView:_updateFriendItem()
	local list = CardhotConfig.instance:getFriendListById(self._actId)

	for i, v in ipairs(list) do
		MaterialMgr.setCell(MatType.Pet, v, self._itemFriendList[i])
	end
end

function CardhotView:_clickGet()
	if self._isGain then
		FloatWordMgr.instance:show("今日集结奖励已领取，记得明天再来")

		return
	end

	PoolPreHeatAgent.instance:sendGainDailyPrizeReq(self._actId, function(msg)
		self._signDay = self._signDay + 1
		self._isGain = true

		local ci = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(ci)

		if ci then
			self.ciList = ci
		end

		self:_updateInfoData()
		self:_onClickPlotBtn(self._signDay)
	end)
end

function CardhotView:_showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function CardhotView:_clickGetAdd()
	if self:_getIsAbleToGetAddPrize() then
		PoolPreHeatAgent.instance:sendGainMassPrizeReq(self._actId, function(msg)
			self._isHasGainAll = true

			self:_updateInfoData()
		end)
	end
end

function CardhotView:_creatEffect(cell)
	local effect
	local path = "common/fx_ui_kuang2_common.prefab"

	local function loadCallBack(target, eff)
		eff:setClipping(cell.transform)
	end

	effect = UIEffectManager.instance:playEffect(self, path, cell, 0, 0, true, false, nil, loadCallBack)

	effect:setParent(cell.transform)
	effect:setScaleXYZ(0.43, 1, 0.8)
	effect:setLocalPos(0, 0)

	return effect
end

function CardhotView:_updateGetBtnState()
	uGuiUtil.setGoGrayState(self._btnGet.gameObject, self._isGain)
	goutil.setActive(self._redPoint.gameObject, not self._isGain)
	goutil.setActive(self._btnGet.gameObject, not self._isLastOver)
	goutil.setActive(self._btnGet.gameObject, not self:_getIsTimeToGetAddPrize())
end

function CardhotView:_getIsAbleToGetAddPrize()
	return self:_getIsTimeToGetAddPrize() and not self._isHasGainAll
end

function CardhotView:_getTimeToGetAddPrize()
	return GameUtil.string2time(self._curActCfg.startTime) + CardhotConfig.instance:getSignInDayById(self._actId) * 86400
end

function CardhotView:_getIsTimeToGetAddPrize()
	return ServerTime.now() > self:_getTimeToGetAddPrize()
end

function CardhotView:_onEndStory()
	self:_showCI()
end

return CardhotView

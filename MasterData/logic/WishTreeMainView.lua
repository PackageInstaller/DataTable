-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/WishTreeMainView.lua

module("logic.extensions.wishtree.view.WishTreeMainView", package.seeall)

local WishTreeMainView = class("WishTreeMainView", ViewComponent)
local WishState = {
	CanGet = 2,
	Added = 1,
	Receieved = 3
}
local EffectPath = {
	ViewEffect = "20221223/woyaoshangche/fx_ui_xuyuanshu_jiemian.prefab",
	WishEffect = "20221223/woyaoshangche/fx_ui_xuyuanshu_xuyuan.prefab",
	CanGetEffect = "20231124/xuyuanshu/fx_ui_xuyuanshui_liangguang.prefab"
}

function WishTreeMainView:ctor()
	WishTreeMainView.super.ctor(self)
end

function WishTreeMainView:unbindEvents()
	WishTreeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnLetter)
	GameUtil.rmClickHandler(self._btnPray)
	GameUtil.rmClickHandler(self._btnTip)
end

function WishTreeMainView:bindEvents()
	WishTreeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnLetter, self._onClickLetter, self)
	GameUtil.addClickHandler(self._btnPray, self._onClickPray, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function WishTreeMainView:buildUI()
	WishTreeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnLetter = self:getBtn("btnLetter")
	self._btnPray = self:getBtn("btnPray")
	self._btnTip = self:getBtn("btnTip")
	self._txtPrayValue = self:getTxt("txtValue")
	self._txtTime = self:getTxt("time/txtTime")
	self._bg = self:getGo("bg")
	self._wishCellList = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("wishCell_" .. i)
		cell.lock = goutil.findChild(cell.go, "lock")
		cell.add = goutil.findChild(cell.go, "add")
		cell.wish = goutil.findChild(cell.go, "wish/item")
		cell.canget = goutil.findChild(cell.go, "canGet")
		cell.receieve = goutil.findChild(cell.go, "receieve")
		cell.double = goutil.findChild(cell.go, "double")
		cell.wishTxt = goutil.findChild(cell.go, "wish/txtState")

		table.insert(self._wishCellList, cell)
	end

	self._redPointGame = self:getGo("btnRun2023/redpoint")
	self._redPointTask = self:getGo("btnPray/redpoint")

	goutil.setActive(self._btnLetter.gameObject, false)

	self._closebgGo = self:getGo("closebg")
	self._txtTitleGo = self:getGo("txtTitle")
	self._btnCloseGo = self:getGo("btnClose")
end

function WishTreeMainView:onExit()
	WishTreeMainView.super.onExit(self)

	self._isFirstEnter = false

	self._removeCellEff(self._bg)
	GlobalDispatcher:removeListener(GlobalNotify.WishTreeGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.WishTreeGainPrizeRes, self._gainPrize, self)
	RedPointController.instance:unregRedPoint(self._redPointGame)
	RedPointController.instance:unregRedPoint(self._redPointTask)
end

function WishTreeMainView:onEnter()
	WishTreeMainView.super.onEnter(self)
	self:_initView()

	self._cfgs = WishTreeConfig.instance:getWishTreeCfgsByActId(self._activityId)
	self._isFirstEnter = true

	local runGameActivityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.INTO_THE_CAR)

	GlobalDispatcher:addListener(GlobalNotify.WishTreeGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.WishTreeGainPrizeRes, self._gainPrize, self)

	local gameActCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.INTO_THE_CAR)

	if gameActCfg then
		Run2023Controller.instance:sendGameInfoReq(runGameActivityId)
	end

	WishTreeController.instance:sendWishTreeInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointGame, RedPointModel.ID_RUN_GAME_CAN_PLAY)
	RedPointController.instance:regRedPoint(self._redPointTask, RedPointModel.ID_WISHTREE_TASK)
end

function WishTreeMainView:_refreshView()
	if self._isFirstEnter then
		self:_tryPopUpLetterView()

		self._isFirstEnter = false
	end

	self:_refreshPrayValue()
	self:_refreshWishCell()
end

function WishTreeMainView:_initView()
	self._activityId = self:_getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.WISH_TREE, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtTime then
		self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end
end

function WishTreeMainView:_tryPopUpLetterView()
	return
end

function WishTreeMainView:_refreshPrayValue()
	local type, id, num = MaterialMgr.getMatParams(self._cfgs.wishCost)
	local haveNum = MaterialFacade.instance:getMatNumber(type, id)

	self._txtPrayValue.text = string.format("祈愿值：%s/%s", haveNum, num)

	local isAddValue = WishTreeModel.instance:getIsAddValue()

	if isAddValue then
		self:_playWishedEffect()
		WishTreeModel.instance:setIsAddValue(false)
	end
end

function WishTreeMainView:_refreshWishCell()
	local items = WishTreeModel.instance:getItems()

	for i, v in ipairs(self._wishCellList) do
		self:_resetAll(v)

		local unlockTime = WishTreeConfig.instance:getWishTreeWishCfgsById(self._cfgs.wishPlanId, i).unlockTime
		local unlockCost = self._cfgs.wishCost
		local day = GameUtil.getDaysByTimestamp(ServerTime.now(), GameUtil.string2time(unlockTime)) - 1

		if day > 0 then
			GameUtil.SetActive(v.lock, true)

			local showTime = goutil.findChildTextComponent(v.lock, "txtLock")

			showTime.text = string.format("%s天后开启", day)
		elseif items[i].selectedPrizeId == -1 then
			GameUtil.SetActive(v.add, true)
			GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickAdd, self, i))
		else
			local prize = WishTreeConfig.instance:getWishTreeRewardCfgsById(self._cfgs.rewardPlanId, items[i].selectedPrizeId).prize
			local isEnough = WishTreeController.instance:isEnough(unlockCost)
			local isRecharge = WishTreeModel.instance:isRecharge()
			local wishState = self:_getWishState(items[i], isEnough, isRecharge)

			GameUtil.SetActive(v.double, isRecharge)
			MaterialMgr.setCellByCfg(prize, v.wish)

			if wishState == WishState.Receieved then
				GameUtil.SetActive(v.receieve, true)
			else
				GameUtil.SetActive(v.wishTxt, true)

				if wishState == WishState.CanGet then
					self:_playCellEff(v.canget, EffectPath.CanGetEffect, 0, 0, true, nil)
				end

				GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickGainPrize, self, i, wishState))
			end
		end
	end
end

function WishTreeMainView:_resetAll(go)
	GameUtil.SetActive(go.lock, false)
	GameUtil.SetActive(go.add, false)
	GameUtil.SetActive(go.receieve, false)
	GameUtil.SetActive(go.double, false)
	GameUtil.SetActive(go.wishTxt, false)
	GameUtil.rmClickHandler(go.go)
	MaterialMgr.resetAll(go.wish)
	self:_removeCellEff(go.canget)
end

function WishTreeMainView:_getWishState(item, isEnough, isRecharge)
	return (item.gainedPrizeState == 2 or item.gainedPrizeState == 1 and not isRecharge) and WishState.Receieved or (item.gainedPrizeState == 0 and isEnough or item.gainedPrizeState == 1 and isRecharge) and WishState.CanGet or WishState.Added
end

function WishTreeMainView:_gainPrize(changeSetId, prizeStrList)
	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function WishTreeMainView:_playWishedEffect()
	self:_playCellEff(self._btnPray, EffectPath.WishEffect, 0, 0, false, nil)
end

function WishTreeMainView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function WishTreeMainView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function WishTreeMainView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.WishTreeClose)
end

function WishTreeMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "xuyuanshu_rule")
end

function WishTreeMainView:_onClickLetter()
	UIStateManager.instance:push(ViewName.WishTreeLetterView, self._activityId)
end

function WishTreeMainView:_onClickPray()
	UIStateManager.instance:push(ViewName.WishTreeTaskView, self._activityId)
end

function WishTreeMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "wishtree_rule")
end

function WishTreeMainView:_onClickAdd(idx)
	local unlockTime = WishTreeConfig.instance:getWishTreeWishCfgsById(self._cfgs.wishPlanId, idx).unlockTime

	if not string.nilorempty(unlockTime) then
		local time = GameUtil.string2time(unlockTime)

		if time > ServerTime.now() then
			local date = GameUtil.string2date(unlockTime)
			local str = string.format("心愿将在%s年%s月%s日 %s:00后开放~", date.year, date.month, date.day, date.hour)

			FloatWordMgr.instance:show(str)

			return
		end
	end

	UIStateManager.instance:push(ViewName.WishTreeListView, self._activityId, idx)
end

function WishTreeMainView:_onClickGainPrize(idx, wishState)
	if wishState == WishState.Added then
		local type, id, num = MaterialMgr.getMatParams(self._cfgs.wishCost)

		FloatWordMgr.instance:show(string.format("祈福值达到%s可达成心愿", num))
	else
		local gainTime = WishTreeConfig.instance:getWishTreeWishCfgsById(self._cfgs.wishPlanId, idx).gainTime

		if not string.nilorempty(gainTime) then
			local time = GameUtil.string2time(gainTime)

			if time > ServerTime.now() then
				local date = GameUtil.string2date(gainTime)
				local str = string.format("奖励将在%s年%s月%s日 %s:00后开放领取~", date.year, date.month, date.day, date.hour)

				FloatWordMgr.instance:show(str)

				return
			end
		end

		WishTreeController.instance:sendWishTreeGainPrizeReq(self._activityId, idx)
	end
end

function WishTreeMainView:_getActivityId()
	local activityId = 0
	local actCfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.WISH_TREE)

	for i, v in ipairs(actCfgs) do
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(v.activityId)

		if isInTime and v.activityId ~= 232003 then
			activityId = v.activityId

			break
		end
	end

	return activityId
end

return WishTreeMainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/view/WeektotalchargeView.lua

module("logic.extensions.activitydaylirecharge.view.WeektotalchargeView", package.seeall)

local WeektotalchargeView = class("WeektotalchargeView", TableViewComponent)

function WeektotalchargeView:ctor()
	WeektotalchargeView.super.ctor(self)
end

function WeektotalchargeView:buildUI()
	WeektotalchargeView.super.buildUI(self)

	self._txtRecharge = goutil.findChildTextComponent(self.mainGO, "activeRoot/txtRecharge")
	self._txtAdvance = goutil.findChildTextComponent(self.mainGO, "advanceRoot/txtAdvance")
	self._txtNextAct = goutil.findChildTextComponent(self.mainGO, "activeRoot/txtNextAct")
	self._txtActTime = goutil.findChildTextComponent(self.mainGO, "activeRoot/txtActTime")
	self._activeRootGo = self:getGo("activeRoot")
	self._advanceRootGo = self:getGo("advanceRoot")
	self._itemGroupList = {}
	self._effectGo = self:getGo("effect")
end

function WeektotalchargeView:bindEvents()
	WeektotalchargeView.super.bindEvents(self)
end

function WeektotalchargeView:unbindEvents()
	WeektotalchargeView.super.unbindEvents(self)
end

function WeektotalchargeView:destroyUI()
	WeektotalchargeView.super.destroyUI(self)

	self._itemGroupList = {}
end

function WeektotalchargeView:onEnter()
	WeektotalchargeView.super.onEnter(self)

	self._activityType = GameEnum.ActivityType.ActivityDailyRecharge
	self._isActOpen, self._activityId, self._planCfgsIndex = ActivitydaylirechargeModel.instance:isActOpen()

	self:_updateView()
	GlobalDispatcher:addListener(ActivitydaylirechargeController.PM_DailyRechargeInfoRes, self._PM_DailyRechargeInfoRes, self)

	if self._isActOpen then
		DailyRechargeAgent.instance:sendPM_DailyRechargeInfoReq()
	end

	self:_setEffect()
end

function WeektotalchargeView:onEnterFinished()
	WeektotalchargeView.super.onEnterFinished(self)
end

function WeektotalchargeView:onExit()
	WeektotalchargeView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandler)

	local function disposeFunc(item)
		MaterialMgr.resetAll(item.mainGO)
	end

	for k, v in pairs(self._itemGroupList) do
		v:dispose(disposeFunc)
	end

	GlobalDispatcher:removeListener(ActivitydaylirechargeController.PM_DailyRechargeInfoRes, self._PM_DailyRechargeInfoRes, self)
end

function WeektotalchargeView:onExitFinished()
	WeektotalchargeView.super.onExitFinished(self)
end

function WeektotalchargeView:_getPath()
	return {
		cellPath = "activeRoot/tablecell",
		viewPath = "activeRoot/tableview"
	}
end

function WeektotalchargeView:_cellSize(view, index)
	return 100, 100
end

function WeektotalchargeView:_updateCell(view, cell, data)
	local btnGet = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnGet")
	local goItem = goutil.findChild(cell.gameObject, "itemcon/item")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local txtBtn = goutil.findChildTextComponent(cell.gameObject, "btnGet/Text")
	local txtNeedRechager = goutil.findChildTextComponent(cell.gameObject, "txtNeedRechager")
	local ylqGo = goutil.findChild(cell.gameObject, "ylqGo")

	txtNeedRechager.text = string.format("累充%s元", data.money)

	local itemGroup = self._itemGroupList[goItemcon]

	if not itemGroup then
		itemGroup = ItemGroup.New(goItemcon, goItem, nil, nil, true)
		self._itemGroupList[goItemcon] = itemGroup
	end

	local mos = string.split(data.prize, "#")

	itemGroup:updateWithMoArray(mos, function(item, cfgStr)
		MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
	end)

	local hasGetPrize = ActivitydaylirechargeModel.instance:isGetPrize(data.prizeId)
	local isCanGet = self._rechargeNum >= data.money and not hasGetPrize

	txtBtn.text = hasGetPrize and "已领取" or not isCanGet and "前往充值" or "立即领取"

	goutil.setActive(ylqGo, hasGetPrize)
	GameUtil.SetGray(btnGet.gameObject, hasGetPrize)
	btnGet:AddClickListener(function()
		if hasGetPrize then
			FloatWordMgr.instance:show("奖励已领取")

			return
		end

		if not isCanGet then
			UIStateManager.instance:popByName(ViewName.PayShopMainView)
			PayShopController.instance:openView(GameEnum.PayShopEasyJump.MibaoShop)

			return
		end

		DailyRechargeAgent.instance:sendPM_GainDailyRechargePrizeReq(data.prizeId)
	end)
end

function WeektotalchargeView:_clearTableview(cell)
	return
end

function WeektotalchargeView:_updateView()
	goutil.setActive(self._activeRootGo, self._isActOpen)
	goutil.setActive(self._advanceRootGo, not self._isActOpen)

	if self._isActOpen then
		self:_updateActiveView()
	else
		self:_updateAdvanceView()
	end
end

function WeektotalchargeView:_updateActiveView()
	self:_setActTime()
	self:_setNextAdvanceTime()
	self:_setTodayRecharge()
	self:_setCurrViewData()
end

function WeektotalchargeView:_setCurrViewData()
	local actCfg = ActivitydaylirechargeConfig.instance:getActCfg(self._activityId)
	local rcfg = ActivitydaylirechargeConfig.instance:getRechargePlan(self._activityId)
	local prizeCfgs = ActivitydaylirechargeConfig.instance:getPrizePlan(rcfg[self._planCfgsIndex].prizePlanId)
	local tempList = ActivitydaylirechargeModel.instance:getHasGetPrizeIds()
	local hasGetIds = {}

	for i, id in ipairs(tempList) do
		hasGetIds[id] = true
	end

	self._curViewDatas = {}

	local hasgets = {}
	local cangets = {}
	local normals = {}

	for i, v in ipairs(prizeCfgs) do
		if hasGetIds[v.prizeId] then
			table.insert(hasgets, v)
		elseif self._rechargeNum >= v.money then
			table.insert(cangets, v)
		else
			table.insert(normals, v)
		end
	end

	local function sort_func(a, b)
		return a.prizeId < b.prizeId
	end

	table.sort(hasgets, sort_func)
	table.sort(cangets, sort_func)
	table.sort(normals, sort_func)
	table.insertto(self._curViewDatas, cangets)
	table.insertto(self._curViewDatas, normals)
	table.insertto(self._curViewDatas, hasgets)
	self:reloadData()
end

function WeektotalchargeView:_setActTime()
	local cfg = ActivitydaylirechargeConfig.instance:getRechargePlanByIndex(self._activityId, self._planCfgsIndex)
	local stime = GameUtil.string2time(cfg.time)
	local etime = stime + 86400
	local sdate = GameUtil.time2date(stime)
	local edate = GameUtil.time2date(etime)

	self._txtActTime.text = string.format("活动时间：%s - %s", self:_formatActTimeStr(sdate), self:_formatActTimeStr(edate))
end

function WeektotalchargeView:_formatActTimeStr(date)
	if date.hour < 10 then
		if not ("0" .. date.hour) then
			local hour = date.hour

			if date.min < 10 then
				if not ("0" .. date.min) then
					local min = date.min

					if date.sec < 10 then
						if not ("0" .. date.sec) then
							local sec = date.sec

							return string.format("%s.%s.%s %s:%s:%s", date.year, date.month, date.day, hour, min, sec)
						end
					end
				end
			end
		end
	end
end

function WeektotalchargeView:_setNextAdvanceTime()
	local nextIndex = self._planCfgsIndex + 1
	local nextPlanCfg = ActivitydaylirechargeConfig.instance:getRechargePlanByIndex(self._activityId, nextIndex)

	if nextPlanCfg then
		local time = GameUtil.string2time(nextPlanCfg.time)
		local date = GameUtil.time2date(time)

		if date.hour < 10 then
			if not ("0" .. date.hour) then
				local hour = date.hour

				if date.min < 10 then
					if not ("0" .. date.min) then
						local min = date.min

						if date.sec < 10 then
							if not ("0" .. date.sec) then
								local sec = date.sec

								self._txtNextAct.text = string.format("下次活动预告：%s.%s %s:%s:%s", date.month, date.day, hour, min, sec)
							end
						end
					end
				end
			end
		end
	else
		self._txtNextAct.text = ""
	end
end

function WeektotalchargeView:_setTodayRecharge()
	self._rechargeNum = ActivitydaylirechargeModel.instance:getRechargeNum()
	self._txtRecharge.text = string.format("今日已累充：%s", self._rechargeNum)
end

function WeektotalchargeView:_updateAdvanceView()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(self._activityType)
	local list = {}

	for k, v in pairs(cfgs) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.activityId < b.activityId
	end)

	local nowTime = ServerTime.nowServerLook()
	local nextStime = false

	for i, v in ipairs(list) do
		local stime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, v.activityId)

		if nowTime < stime then
			nextStime = stime

			break
		end
	end

	if nextStime then
		local date = GameUtil.time2date(nextStime)

		if date.min < 10 then
			if not ("0" .. date.min) then
				local min = date.min

				self._txtAdvance.text = string.format("下次活动预告:%s月%s日%s:%s<size=30>敬请期待！</size>", date.month, date.day, date.hour, min)
			end
		end
	else
		self._txtAdvance.text = "<size=30>敬请期待！</size>"
	end
end

function WeektotalchargeView:_PM_DailyRechargeInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function WeektotalchargeView:_setEffect()
	local effName = "fx_ui_leichong/fx_ui_leichong_02.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return WeektotalchargeView

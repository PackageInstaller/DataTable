-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DarkDragonKnifeMainView.lua

module("logic.extensions.darkdragonknife.view.DarkDragonKnifeMainView", package.seeall)

local DarkDragonKnifeMainView = class("DarkDragonKnifeMainView", TableViewComponent)

function DarkDragonKnifeMainView:ctor()
	DarkDragonKnifeMainView.super.ctor(self)
end

function DarkDragonKnifeMainView:buildUI()
	DarkDragonKnifeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChall = self:getBtn("btnChall")
	self._btnExchange = self:getBtn("btnExchange")
	self._scoreBarSli = self:getSlider("scoreScroll/viewport/content/scoreBarSli")
	self._scrollRect = self:getGo("scoreScroll"):GetComponent(ComponentType.ScrollRect)
	self._bar = DDKDiscreteProgressBar.New(self._scoreBarSli)
	self._contentRectTrans = self:getGo("scoreScroll/viewport/content"):GetComponent(goutil.Type_RectTransform)
	self._txtTime = self:getTxt("time/txtTime")
	self._txtRemain = self:getTxt("remain/txtRemain")
	self._txtScore = self:getTxt("score/txtScore")
	self._btnAddTime = self:getBtn("remain/btnAdd")
	self._btnRule = self:getBtn("btnTip")
	self._cellEffect = {}
	self._bubble = self:getGo("scoreScroll/viewport/content/bubble")
	self._txtDesc = goutil.findChildTextComponent(self._bubble, "txtDesc")
	self._txtGameTime = self:getTxt("gameTime/txtGameTime")
end

function DarkDragonKnifeMainView:bindEvents()
	DarkDragonKnifeMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnChall:AddClickListener(self._clickChall, self)
	self._btnExchange:AddClickListener(function()
		UIStateManager.instance:push(ViewName.DdkExchangeView)
	end, self)
	self._btnAddTime:AddClickListener(self._buyTime, self)
	self._btnRule:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "darkdragonkniferule")
	end, self)
end

function DarkDragonKnifeMainView:unbindEvents()
	DarkDragonKnifeMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChall:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnAddTime:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function DarkDragonKnifeMainView:destroyUI()
	DarkDragonKnifeMainView.super.destroyUI(self)
end

function DarkDragonKnifeMainView:onEnter()
	DarkDragonKnifeMainView.super.onEnter(self)

	self.activityId = checknumber(DDragonKConfig.instance:getCommonCfg("RESIDENT_ACTIVITY_ID"))

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self.activityId)

	if not isInTime then
		FloatWordMgr.instance:show("当前活动未开启")
		self:close()

		return
	end

	DDragonKModel.instance:setActId(self.activityId)

	self._actCfg = DDragonKConfig.instance:getActCfg(self.activityId)

	DDragonKModel.instance:setPropPlanId(self._actCfg.propPlanId)

	self._isInitBubble = false

	DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeGetInfoReq(self.activityId)
	DDragonKModel.instance:setHasLoadData(true)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeGetInfo, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeBuyTime, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeGainPrize, self._refresh, self)
	GlobalDispatcher:addListener(GlobalNotify.DarkDragonKnifeRefreshExchange, self._refresh, self)

	self.startTime, self.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DarkDragonKnife, self.activityId)

	self:_timer()
	settimer(1, self._timer, self, true)
end

function DarkDragonKnifeMainView:onEnterFinished()
	DarkDragonKnifeMainView.super.onEnterFinished(self)
end

function DarkDragonKnifeMainView:onExit()
	DarkDragonKnifeMainView.super.onExit(self)

	for k, v in pairs(self._cellEffect) do
		if v then
			UIEffectManager.instance:stopEffect(v)

			self._cellEffect[k] = nil
		end
	end

	removetimer(self._timer, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeGetInfo, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeBuyTime, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeGainPrize, self._refresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.DarkDragonKnifeRefreshExchange, self._refresh, self)
end

function DarkDragonKnifeMainView:onExitFinished()
	DarkDragonKnifeMainView.super.onExitFinished(self)
end

function DarkDragonKnifeMainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "scoreScroll"
	}
end

function DarkDragonKnifeMainView:_cellSize(view, index)
	return self._scoreCellSpace, 100
end

function DarkDragonKnifeMainView:_clickChall()
	local useTime = DDragonKModel.instance:getUseTimes()
	local buyTime = DDragonKModel.instance:getBuyTimes()
	local normalTime = checknumber(DDragonKConfig.instance:getCommonCfg("DAILY_TIMES"))
	local curTimes = normalTime - useTime + buyTime

	if curTimes > 0 then
		UIStateManager.instance:push(ViewName.DarkDragonKnifeGameView)
	else
		FloatWordMgr.instance:show("游戏次数不足")
	end
end

function DarkDragonKnifeMainView:_refresh()
	local useTime = DDragonKModel.instance:getUseTimes()
	local buyTime = DDragonKModel.instance:getBuyTimes()
	local normalTime = checknumber(DDragonKConfig.instance:getCommonCfg("DAILY_TIMES"))
	local curTimes = normalTime - useTime + buyTime

	self._txtRemain.text = langPara("次数：%s/%s", curTimes, normalTime)

	local curScore = DDragonKModel.instance:getTotalScore()

	self._txtScore.text = langPara("当前积分：%s", curScore)
	self._isInitBubble = false

	local prizeCfg = DDragonKConfig.instance:getPrizeCfg(self._actCfg.prizePlan)
	local prizeList = {}
	local list = {}

	for k, v in pairs(prizeCfg) do
		table.insert(prizeList, v)
		table.insert(list, v.gameTime)
	end

	table.sort(prizeList, function(a, b)
		return a.gameTime < b.gameTime
	end)

	local curGameTime = DDragonKModel.instance:getGameTime()
	local newList = {}

	for i, v in ipairs(prizeList) do
		local element = {}

		element.cfg = v

		if not self._isInitBubble and curGameTime < v.gameTime then
			self._isInitBubble = true
			element.isShowBubble = true
		else
			element.isShowBubble = false
		end

		element.isArrivedTime = curGameTime >= v.gameTime

		table.insert(newList, element)
	end

	if not self._isInitBubble then
		self._isInitBubble = true
		newList[#newList].isShowBubble = true
	end

	table.sort(list, function(a, b)
		return a < b
	end)
	self._bar:setValue(list, curGameTime)

	self._curViewDatas = newList

	self:reloadData()
	self:_updateGameTime(curGameTime)
end

function DarkDragonKnifeMainView:_updateGameTime(curGameTime)
	self._txtGameTime.text = string.format("已累计：%ds", curGameTime)
end

function DarkDragonKnifeMainView:_updateCell(view, cell, data)
	local txtTime = goutil.findChildTextComponent(cell, "btn/txtTime")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local rectTrans = cell.gameObject:GetComponent(goutil.Type_RectTransform)

	btn:AddClickListener(function()
		if not goutil.isNil(rectTrans) then
			local x, y = Framework.TransformUtil.GetAnchoredPos(rectTrans, 0, 0)

			self:_updateBubblePos(x, data.cfg, data.isArrivedTime)
		end
	end)

	txtTime.text = string.format("%ds", data.cfg.gameTime)
end

function DarkDragonKnifeMainView:_clearTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btn:RemoveClickListener()
end

function DarkDragonKnifeMainView:_onReloadFinish()
	local startX = self._contentRectTrans.rect.width / 2 * -1

	for i, v in ipairs(self._curViewDatas) do
		if v.isShowBubble then
			local interval = 100

			self:_updateBubblePos(interval * i + startX, v.cfg, v.isArrivedTime)
			self:moveCellToCenter(i)

			break
		end
	end
end

function DarkDragonKnifeMainView:_timer()
	local leftTime = self.endTime - ServerTime.now()

	if leftTime > 0 then
		self._txtTime.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(leftTime))
	else
		FloatWordMgr.instance:show("当前活动结束")
		self:close()
	end
end

function DarkDragonKnifeMainView:_buyTime()
	local buyCfg = DDragonKConfig.instance:getBuyCfg(self._actCfg.propPlanId)
	local buyCfgList = {}

	for k, v in pairs(buyCfg) do
		table.insert(buyCfgList, v)
	end

	table.sort(buyCfgList, function(a, b)
		return a.times < b.times
	end)

	local buyTime = DDragonKModel.instance:getBuyTimes()

	if buyTime < #buyCfgList then
		local price = string.split(buyCfgList[buyTime + 1].cost, ":")[3]
		local str = langPara("是否消耗%s钻石购买一次游戏次数？", price)

		TipsFacade.instance:openPopupWindow("提示", str, function()
			DarkDragonKnifeAgent.instance:sendPM_DarkDragonKnifeBuyTimesReq(self.activityId)
		end, function()
			return
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		FloatWordMgr.instance:show("购买次数已达上限")
	end
end

function DarkDragonKnifeMainView:_updateBubblePos(targetX, cfgDdkPrize, isArrivedTime)
	if not goutil.isNil(self._bubble) then
		local x, y = Framework.TransformUtil.GetAnchoredPos(self._bubble.transform, 0, 0)

		GameUtil.setAnchoredPos(self._bubble, targetX, y)

		if cfgDdkPrize then
			local activityId = SaintKnightRuiModel.instance:getActivityId()
			local id = cfgDdkPrize.id
			local buffCfg = SaintKnightRuiConfig.instance:getBuffCfg(activityId, id)

			if buffCfg and buffCfg.desc and #buffCfg.desc > 0 then
				if buffCfg.desc[1] then
					if not buffCfg.desc[1] then
						local str = ""

						str = str .. ((buffCfg.desc[2] or nil) and ("\n" .. buffCfg.desc[2] or ""))
						str = string.format("<color=#%s>%s</color>", (isArrivedTime or nil) and (ColorConst.Green2 or ColorConst.White), str)
						self._txtDesc.text = str
					end
				end
			end
		end
	end
end

return DarkDragonKnifeMainView

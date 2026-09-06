-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gashapon/view/GashaponView.lua

module("logic.extensions.gashapon.view.GashaponView", package.seeall)

local GashaponView = class("GashaponView", ViewComponent)

function GashaponView:ctor()
	GashaponView.super.ctor(self)
end

function GashaponView:buildUI()
	GashaponView.super.buildUI(self)

	self._close = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnClickOne = self:getBtn("btnOne")
	self._btnClickTen = self:getBtn("btnTen")
	self.btnAnim = self:getGo("btnAnim"):GetComponent(typeof(UnityEngine.UI.Toggle))
	self.goldBarCon = self:getGo("goldBarCon")
	self._roleConGo = self:getGo("con")
	self._bubblePos = self:getGo("con/bubble")
	self._txtDiamond = self:getTxt("txtRewardPool")
	self._txtOneCost = self:getTxt("txtOneCost")
	self._txtTenCost = self:getTxt("txtTenCost")
	self._effectBg = self:getGo("effectBg")
	self._txtTimes = self:getTxt("txtTimes")
	self._txtCountTime = self:getTxt("time/txtTime")
	self._effectPos = self:getGo("effectPos")
	self._itemTab = {}
	self._txtTab = {}
	self._scrollTran = self:getGo("listView/Viewport").transform

	local childCnt = self._scrollTran.childCount

	for i = 1, childCnt do
		local child = self._scrollTran:GetChild(i - 1).gameObject
		local text = child:GetComponent(goutil.Type_UIText)

		table.insert(self._itemTab, child)
		table.insert(self._txtTab, text)
	end
end

function GashaponView:bindEvents()
	GashaponView.super.bindEvents(self)
	self._close:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "gashaponview")
	end)
	self._btnClickOne:AddClickListener(function()
		self:_clickPay(1)
	end)
	self._btnClickTen:AddClickListener(function()
		self:_clickPay(10)
	end)
end

function GashaponView:unbindEvents()
	GashaponView.super.unbindEvents(self)
	self._close:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClickOne:RemoveClickListener()
	self._btnClickTen:RemoveClickListener()
end

function GashaponView:destroyUI()
	GashaponView.super.destroyUI(self)
end

function GashaponView:onEnter()
	GashaponView.super.onEnter(self)

	self._curUsedTimes = 0
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 80015, self._roleConGo, 1.6, nil, true)
	self.CurActivityId = GashaponModel.instance:getOpenActivityId()
	self._cfg = GashaponConfig.instance:getCfgById(self.CurActivityId)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.Gashapon, self.CurActivityId)

	self._endStamp = endTime
	self.oneCost = string.split(self._cfg.oneCost, ":")
	self.tenCost = string.split(self._cfg.tenCost, ":")
	self._txtOneCost.text = self.oneCost[3]
	self._txtTenCost.text = self.tenCost[3]

	self:_reqDiamondNum()

	self.btnAnim.isOn = false

	self._effectBg:SetActive(false)

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btnList)
	settimer(10, self._startPlayBubble, self, true)
	settimer(1, self._showActTime, self, true)
end

function GashaponView:onEnterFinished()
	GashaponView.super.onEnterFinished(self)
end

function GashaponView:onExit()
	GashaponView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	removetimer(self._stopEffect, self)
	removetimer(self._showEffectGet, self)
	removetimer(self._moveRankList, self)
	removetimer(self._startPlayBubble, self)
	removetimer(self._showActTime, self)
	removetimer(self._finishPlayBubble, self)
	self:_finishPlayBubble()

	if self._queue then
		self._queue:clear()
	end

	if self._effect1 then
		UIEffectManager.instance:stopEffect(self._effect1)
	end

	if self._effect2 then
		UIEffectManager.instance:stopEffect(self._effect2)
	end
end

function GashaponView:onExitFinished()
	GashaponView.super.onExitFinished(self)
end

function GashaponView:_reqDiamondNum()
	GashaponAgent.instance:sendPM_GashaponGetDiamondNumReq(self.CurActivityId, function(msg)
		self._curUsedTimes = checknumber(msg.dailyUsedTimes)

		self:_updateDiamondNum(checknumber(msg.diamondNum))
	end)
end

function GashaponView:_reqRank()
	GashaponAgent.instance:sendPM_GashaponGetRankInfosReq(self.CurActivityId, function(msg)
		self:_updateRankList(msg.rankItems)
	end)
end

function GashaponView:_updateDiamondNum(num)
	if self._cfg.isShowTimes then
		local overTimes = self._cfg.dailyTimes - self._curUsedTimes

		self._txtTimes.text = string.format("今日剩余扭蛋次数：%d次", overTimes)
	end
end

function GashaponView:_updateRankList(list)
	if self._queue then
		self._queue:clear()
	end

	self._queue = Queue.New()

	for i = 1, #list do
		local item = list[i]

		self._queue:enqueue(item)
	end

	for i = #self._txtTab, 1, -1 do
		if i <= self._queue:count() then
			self:_updateTextItem(self._txtTab[i])
		else
			self._txtTab[i].text = ""
		end
	end

	self._curIndex = 0
	self._curGap = 0

	self:_moveRankList(true)

	if self._queue:count() > 10 then
		removetimer(self._moveRankList, self)
		settimer(0.05, self._moveRankList, self, true)
	end
end

function GashaponView:_moveRankList(isInit)
	local count, gapY, step = 12, -30, -2
	local addY = isInit and 0 or -gapY

	for i, v in ipairs(self._itemTab) do
		local index = (i - 1 + self._curIndex) % count
		local y = self._curGap + index * gapY + addY

		GameUtil.setLocalPos(v, 0, y)
	end

	if isInit then
		return
	end

	self._curGap = self._curGap + step

	if self._curGap == gapY then
		self._curGap = 0
		self._curIndex = (self._curIndex + 1) % count

		self:_updateTextItem(self._txtTab[(count - self._curIndex) % count + 1])
	end
end

function GashaponView:_updateTextItem(itmeComp)
	local text = "<color=#77FEFFFF>%s</color> 扭出了 <color=#F8986BFF>%d 特级锤</color>"
	local item = self._queue:dequeue()

	self._queue:enqueue(item)

	itmeComp.text = string.format(text, item.name, item.diamondNum)
end

function GashaponView:_clickPay(times)
	local payType = times
	local overTimes = self._cfg.dailyTimes - self._curUsedTimes

	if overTimes < times then
		FloatWordMgr.instance:show(string.format("次数不足，剩余%d次", overTimes))

		return
	end

	if times == 1 then
		if not self.oneCost then
			local cost = self.tenCost
			local haveCount = RoleModel.instance:getCoin()

			if haveCount < checknumber(cost[3]) then
				MaterialMgr.openGetSource(MatType.Coin, MatType.Coin_Gold, GameUtil.handler(self.close, self))
				FloatWordMgr.instance:show("金币不足！")

				return
			end

			local function sendFun()
				GashaponAgent.instance:sendPM_GashaponDrawReq(self.CurActivityId, payType, function(msg)
					self._curUsedTimes = self._curUsedTimes + times

					self:_updateDiamondNum(msg.diamondNum)

					self._drawMsg = msg

					MaterialController.instance:saveChangeSetToTemp(checknumber(msg.changeSetId))

					if not self.btnAnim.isOn then
						self._levelBall = 1
						self._levelBall = msg.drawType == 1 and GashaponConfig.instance:getPrizeById(self._cfg.poolId, msg.prizeInfos[1].prizeId).quality or GashaponModel.instance:getBestQuality(self._cfg.poolId, msg.prizeInfos)

						self:_showEffect()
					else
						GashaponModel.instance:showItemInfos(self._drawMsg)
					end
				end)
			end

			if not GameUtil.getUserDayData(GashaponModel.DAYCOSTHINT) then
				local function funcTog()
					GameUtil.saveUserDayData(GashaponModel.DAYCOSTHINT, true)
				end

				local hint = string.format("确定要花费%d金币，进行%d次扭蛋吗？", cost[3], times)
				local togText = "今日不再提示"

				TipsFacade.instance:openPopupWindowWithTog(lang("tip"), hint, sendFun, function()
					return
				end, funcTog, "确定", "取消", togText, UnityEngine.TextAnchor.MiddleCenter)
			else
				sendFun()
			end
		end
	end
end

function GashaponView:_showEffect()
	local effect1 = "fx_ui_fulizhongxin/fx_ui_fulizhongxin_qiu.prefab"

	if self._effect1 then
		UIEffectManager.instance:stopEffect(self._effect1)
	end

	self._effect1 = UIEffectManager.instance:playEffect(self, effect1, nil, 0, 0, false, false)

	self._effect1:setParent(self._effectPos.transform)
	self._effect1:setScale(1)
	self._effect1:setLocalPos(0, 0)
	self._effectBg:SetActive(true)
	settimer(1.3, self._showEffectGet, self, false)
	settimer(3.1, self._stopEffect, self, false)
	ViewBlockMgr.instance:blockClick(true, self)
end

function GashaponView:_showEffectGet()
	self._effectBg:SetActive(false)

	if self._effect1 then
		UIEffectManager.instance:stopEffect(self._effect1)
	end

	local effect2 = string.format("fx_ui_fulizhongxin/fx_ui_fulizhongxin_niudan_0%d.prefab", self._levelBall)

	if self._effect2 then
		UIEffectManager.instance:stopEffect(self._effect2)
	end

	self._effect2 = UIEffectManager.instance:playEffect(self, effect2, nil, 0, 0, false, false)

	self._effect2:setParent(self._effectPos.transform)
	self._effect2:setScale(1)
	self._effect2:setLocalPos(20, -265)
end

function GashaponView:_stopEffect()
	ViewBlockMgr.instance:blockClick(false, self)

	if self._effect2 then
		UIEffectManager.instance:stopEffect(self._effect2)
	end

	GashaponModel.instance:showItemInfos(self._drawMsg)
end

function GashaponView:_startPlayBubble()
	if not self._isPlayBubble then
		self._isPlayBubble = true

		local index = math.random(1, #self._cfg.talkTab)
		local newstr = self._cfg.talkTab[index]

		BubbleController.instance:OpenView(newstr, self._bubblePos.transform.position, true)
		settimer(5, self._finishPlayBubble, self, false)
	end
end

function GashaponView:_finishPlayBubble()
	BubbleController.instance:CloseView()

	self._isPlayBubble = false
end

function GashaponView:_showActTime()
	local countTime = self._endStamp - ServerTime.now()

	if countTime < 0 then
		self._txtCountTime.text = "已结束"

		return
	end

	self._txtCountTime.text = string.format("剩余时间：%d天%d时%d分%d秒", GameUtil.getTimeDDHHMMSS(countTime))
end

return GashaponView

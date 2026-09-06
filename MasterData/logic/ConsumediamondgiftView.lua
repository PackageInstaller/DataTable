-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumediamondgift/view/ConsumediamondgiftView.lua

module("logic.extensions.consumediamondgift.view.ConsumediamondgiftView", package.seeall)

local ConsumediamondgiftView = class("ConsumediamondgiftView", TableViewComponent)

function ConsumediamondgiftView:ctor()
	ConsumediamondgiftView.super.ctor(self)
end

function ConsumediamondgiftView:buildUI()
	ConsumediamondgiftView.super.buildUI(self)

	self._txtCurrCost = goutil.findChildTextComponent(self.mainGO, "txtCurrCost")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._btnClose = self:getBtn("btnClose")
	self._effectGo = self:getGo("effect")
end

function ConsumediamondgiftView:bindEvents()
	ConsumediamondgiftView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ConsumediamondgiftView:unbindEvents()
	ConsumediamondgiftView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ConsumediamondgiftView:destroyUI()
	ConsumediamondgiftView.super.destroyUI(self)
end

function ConsumediamondgiftView:onEnter()
	ConsumediamondgiftView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		local obj = self:getFirstParam() or {}

		self._activityId = checknumber(obj.parameter)
	end

	GlobalDispatcher:addListener(ConsumediamondgiftController.GetActivityInfoRes, self._GetActivityInfoRes, self)
	GlobalDispatcher:addListener(ConsumediamondgiftController.GainPrizeRes, self._GainPrizeRes, self)
	ConsumediamondgiftModel.instance:setActId(self._activityId)
	ConsumeDiamondGiftAgent.instance:sendPM_GetActivityInfoReq(self._activityId)
	self:_updateView()
	self:_setEffect()
end

function ConsumediamondgiftView:onEnterFinished()
	ConsumediamondgiftView.super.onEnterFinished(self)
end

function ConsumediamondgiftView:onExit()
	ConsumediamondgiftView.super.onExit(self)
	GlobalDispatcher:removeListener(ConsumediamondgiftController.GetActivityInfoRes, self._GetActivityInfoRes, self)
	GlobalDispatcher:removeListener(ConsumediamondgiftController.GainPrizeRes, self._GainPrizeRes, self)
	removetimer(self._updateLeftTime, self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	ConsumediamondgiftModel.instance:setActId(nil)
	ConsumediamondgiftModel.instance:setCurrGainPrizeId(nil)
end

function ConsumediamondgiftView:onExitFinished()
	ConsumediamondgiftView.super.onExitFinished(self)
end

function ConsumediamondgiftView:_onClickbtnClose()
	self:close()
end

function ConsumediamondgiftView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function ConsumediamondgiftView:_cellSize(view, index)
	return 100, 100
end

function ConsumediamondgiftView:_updateCell(view, cell, cfg)
	local rewardcon = goutil.findChild(cell.gameObject, "rewardCon")
	local rewardcell = goutil.findChild(cell.gameObject, "cell")
	local redDot = goutil.findChild(cell.gameObject, "btnOK/dot")
	local btnOK = GameUtil.asBtn(goutil.findChild(cell.gameObject, "btnOK"))
	local receive = goutil.findChild(cell.gameObject, "receive")
	local txtNeedCost = goutil.findChildTextComponent(cell.gameObject, "txtNeedCost")
	local txtBtn = goutil.findChildTextComponent(cell.gameObject, "btnOK/text")

	txtNeedCost.text = string.format("需消耗钻石：%s", cfg.consumeNum)

	local hasGet = self._hasGainPrizeIds[cfg.prizeId]
	local canGet = not hasGet and self._consumeNums >= cfg.consumeNum

	goutil.setActive(btnOK.gameObject, not hasGet)
	goutil.setActive(receive, hasGet)
	goutil.setActive(redDot, canGet)

	if not hasGet then
		btnOK:AddClickListener(function()
			if not canGet then
				local sourceStr = ConsumediamondgiftConfig.instance:getConsumeSource()

				UIStateManager.instance:push(ViewName.ItemSource, sourceStr, true, nil, "消耗途径")
			else
				ConsumediamondgiftModel.instance:setCurrGainPrizeId(cfg.prizeId)
				ConsumeDiamondGiftAgent.instance:sendGainPrizeReq(self._activityId, cfg.prizeId)
			end
		end)

		txtBtn.text = canGet and "领取" or "去消耗"
	end

	local temp = string.split(cfg.prize, "#")
	local arr = {}

	for i, v in ipairs(temp) do
		local temp1 = string.split(v, ":")
		local matType = checknumber(temp1[1])
		local canInsert = true

		if matType == MatType.Cloth then
			local matId = checknumber(temp1[2])
			local cfg = DressConfig.instance:getDressCfgById(matId)

			if cfg and cfg.clothesGender ~= 2 and cfg.clothesGender ~= RoleModel.instance:getGender() then
				canInsert = false
			end
		end

		if canInsert then
			table.insert(arr, v)
		end
	end

	for i = 1, #arr do
		local go = goutil.findChild(rewardcon, "item_" .. i)

		go = go or goutil.cloneAndSetParent(rewardcell, rewardcon.transform, "item_" .. i)

		local con = goutil.findChild(go, "con")

		goutil.setActive(go, true)
		MaterialMgr.setCellByCfg(arr[i], con)
	end

	for i = #arr + 1, rewardcon.transform.childCount do
		local go = goutil.findChild(rewardcon, "item_" .. i)
		local con = goutil.findChild(go, "con")

		goutil.setActive(go, false)
		MaterialMgr.resetAll(con)
	end
end

function ConsumediamondgiftView:_clearTableview(cell)
	local rewardcon = goutil.findChild(cell.gameObject, "rewardCon")

	for i = 1, rewardcon.transform.childCount do
		local go = goutil.findChild(rewardcon, "item_" .. i)
		local con = goutil.findChild(go, "con")

		MaterialMgr.resetAll(con)
	end
end

function ConsumediamondgiftView:_updateView()
	self._consumeNums, self._hasGainPrizeIds = ConsumediamondgiftModel.instance:getActInfo()

	self:_updateReward()
	self:_setActLeftTime()
	self:_setCurrCostDiamond()
	self:_setViewData()
end

function ConsumediamondgiftView:_setViewData()
	local cfgs = ConsumediamondgiftConfig.instance:getActCfg(self._activityId)
	local hasGetList = {}
	local canGetList = {}
	local notGetList = {}

	for i, v in ipairs(cfgs) do
		if self._hasGainPrizeIds[v.prizeId] then
			table.insert(hasGetList, v)
		elseif self._consumeNums >= v.consumeNum then
			table.insert(canGetList, v)
		else
			table.insert(notGetList, v)
		end
	end

	self:_sortFunc(hasGetList)
	self:_sortFunc(canGetList)
	self:_sortFunc(notGetList)
	table.insertto(canGetList, notGetList)
	table.insertto(canGetList, hasGetList)

	self._curViewDatas = canGetList

	self:reloadData()
end

function ConsumediamondgiftView:_sortFunc(list)
	table.sort(list, function(a, b)
		return a.consumeNum < b.consumeNum
	end)
end

function ConsumediamondgiftView:_updateReward()
	return
end

function ConsumediamondgiftView:_setActLeftTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.ConsumeDiamondGift, self._activityId)

	self._leftTime = etime - ServerTime.nowServerLook()

	if self._leftTime > 0 then
		settimer(1, self._updateLeftTime, self, true)
		self:_updateLeftTime()
	else
		self._txtLeftTime.text = "活动已结束"

		TipsFacade.instance:openTipWindow("提示", "活动已结束,即将退出界面", function()
			self:close()
		end)
	end
end

function ConsumediamondgiftView:_updateLeftTime()
	self._leftTime = self._leftTime - 1

	if self._leftTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._leftTime)

		self._txtLeftTime.text = day > 0 and string.format("剩余时间：%s天%s时%s分", day, hour, min) or string.format("剩余时间：%s时%s分%s秒", hour, min, sec)
	else
		self._txtLeftTime.text = "活动已结束"

		removetimer(self._updateLeftTime, self)
		self:_setActLeftTime()
	end
end

function ConsumediamondgiftView:_setCurrCostDiamond()
	self._txtCurrCost.text = string.format("累计已消耗钻石:%s", self._consumeNums)
end

function ConsumediamondgiftView:_GetActivityInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function ConsumediamondgiftView:_GainPrizeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function ConsumediamondgiftView:_setEffect()
	self._effectHandler = UIEffectManager.instance:playEffect(self, "fx_ui_leijixiaohao/fx_ui_leijixiaohao_tanchaung.prefab", nil, nil, nil, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return ConsumediamondgiftView

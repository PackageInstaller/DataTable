-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/singlerecharge/view/SinglerechargemainView.lua

module("logic.extensions.twunique.singlerecharge.view.SinglerechargemainView", package.seeall)

local SinglerechargemainView = class("SinglerechargemainView", TableViewComponent)

function SinglerechargemainView:buildUI()
	SinglerechargemainView.super.buildUI(self)

	self._roleconGo = self:getGo("rolecon")
	self._btnRule = self:getGo("btnRule")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
end

function SinglerechargemainView:bindEvents()
	SinglerechargemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function SinglerechargemainView:unbindEvents()
	SinglerechargemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRule)
end

function SinglerechargemainView:onEnter()
	SinglerechargemainView.super.onEnter(self)

	if SinglerechargeModel.instance:checkFirstOpenRedPoint() then
		SinglerechargeModel:recordFirstOpenRedPoint()
		GlobalDispatcher:dispatch(GlobalNotify.BounsRedPointUpdate)
	end

	self._activityType = GameEnum.ActivityType.SingleRecharge
	self._activityId = 0

	local cfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)

	if cfg then
		self._activityId = cfg.activityId
	else
		local text = lang("不在活动时间内")

		TipsFacade.instance:openTipWindowNoX(lang("提示"), text, function()
			self:close()
		end)

		return
	end

	self.addGEvent(self, GlobalNotify.NotifyPayShopItemBuySucRes, self._NotifyPayShopItemBuySucRes, self)
	GlobalDispatcher:addListener(SinglerechargeController.PM_SingleRechargeGetInfoRes, self._PM_SingleRechargeGetInfoRes, self)
	GlobalDispatcher:addListener(SinglerechargeController.PM_SingleRechargeGainPrizeRes, self._PM_SingleRechargeGainPrizeRes, self)
	SingleRechargeAgent.instance:sendPM_SingleRechargeGetInfoReq(self._activityId)
	self:_setRole()
	self:_setActTime()
end

function SinglerechargemainView:onExit()
	SinglerechargemainView.super.onExit(self)
	GlobalDispatcher:removeListener(SinglerechargeController.PM_SingleRechargeGetInfoRes, self._PM_SingleRechargeGetInfoRes, self)
	GlobalDispatcher:removeListener(SinglerechargeController.PM_SingleRechargeGainPrizeRes, self._PM_SingleRechargeGainPrizeRes, self)
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function SinglerechargemainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function SinglerechargemainView:_updateCell(view, cell, cfg)
	local btnPay = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnPay")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local btnChange = goutil.findChildComponent(cell.gameObject, "btnPay", "UIImageSpriteChange")
	local txtBtnPay = goutil.findChildTextComponent(cell.gameObject, "btnPay/txtBtnPay")
	local txtLimit = goutil.findChildTextComponent(cell.gameObject, "txtLimit")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local dotGo = goutil.findChild(cell.gameObject, "btnPay/dot")
	local ylqGo = goutil.findChild(cell.gameObject, "ylqGo")
	local txtYlq = goutil.findChildTextComponent(cell.gameObject, "ylqGo/receive_1/Text")

	txtYlq.text = lang("已领取")

	local rechargeTimes = 0
	local gainTimes = 0
	local info = self._infos[cfg.itemId]

	if info then
		rechargeTimes = info.rechargeTimes
		gainTimes = info.gainTimes
	end

	local isNeedRecharge = rechargeTimes < cfg.limitTimes and rechargeTimes <= gainTimes
	local isGain = gainTimes >= cfg.limitTimes
	local canGain = rechargeTimes > 0 and gainTimes < rechargeTimes

	self:_setRewardItems(cfg.prize, goItemcon, goItem)

	txtName.text = langPara("%s元", PayConfig.instance:getPayMoney(cfg.payGoodsId) / 100)

	GameUtil.SetActive(btnPay, true)

	if isNeedRecharge then
		btnChange:SetState(1)

		txtBtnPay.text = lang("充值")
	elseif canGain then
		btnChange:SetState(0)

		txtBtnPay.text = lang("领取")
	else
		txtBtnPay.text = lang("已领取")

		GameUtil.SetActive(btnPay, false)
	end

	goutil.setActive(ylqGo, isGain)
	GameUtil.SetActive(txtLimit, cfg.limitTimes > 1)

	txtLimit.text = string.format(lang("次数：%d/%d"), gainTimes, cfg.limitTimes)

	goutil.setActive(dotGo, canGain)
	btnPay:AddClickListener(function()
		if isNeedRecharge then
			PayShopController.instance:buyShopItemWithTips(cfg.mibaoId)
		elseif isGain then
			FloatWordMgr.instance:show(lang("已领取"))
		else
			SinglerechargeController.instance:sendPM_SingleRechargeGainPrizeReq(self._activityId, cfg.itemId)
		end
	end)
end

function SinglerechargemainView:_setRewardItems(prizeStr, goItemcon, goItem)
	local prizes = string.split(prizeStr, "#")
	local transform = goItemcon.transform
	local childCount = transform.childCount
	local prizeCount = #prizes

	for i = 1, prizeCount do
		local childGo = childCount < i and goutil.cloneAndSetParent(goItem, goItemcon.transform) or transform:GetChild(i - 1).gameObject

		goutil.setActive(childGo, true)
		MaterialMgr.setCellByCfg(prizes[i], childGo.transform)
	end

	for i = prizeCount + 1, childCount do
		goutil.setActive(transform:GetChild(i - 1), false)
	end
end

function SinglerechargemainView:_clearTableview(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")
	local transform = goItemcon.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		MaterialMgr.resetAll(transform:GetChild(i - 1))
	end
end

function SinglerechargemainView:_updateUI()
	local prizeCfgs = SinglerechargeConfig.instance:getActCfgs(self._activityId)
	local items = SinglerechargeModel.instance:getItems()

	self._infos = {}

	for i, v in ipairs(items) do
		self._infos[v.itemId] = v
	end

	local hasgets = {}
	local cangets = {}
	local normals = {}
	local infoIds = {}

	for itemId, v in pairs(self._infos) do
		infoIds[itemId] = v
	end

	for i, v in ipairs(prizeCfgs) do
		local info = infoIds[v.itemId]

		if info then
			if info.rechargeTimes < v.limitTimes and info.gainTimes >= info.rechargeTimes then
				table.insert(normals, v)
			elseif info.gainTimes >= info.rechargeTimes then
				table.insert(hasgets, v)
			else
				table.insert(cangets, v)
			end
		else
			table.insert(normals, v)
		end
	end

	local function sort_func(a, b)
		return a.itemId < b.itemId
	end

	table.sort(hasgets, sort_func)
	table.sort(cangets, sort_func)
	table.sort(normals, sort_func)

	self._curViewDatas = {}

	table.insertto(self._curViewDatas, cangets)
	table.insertto(self._curViewDatas, normals)
	table.insertto(self._curViewDatas, hasgets)
	self:reloadData()
end

function SinglerechargemainView:_setRole()
	local skinId = SinglerechargeConfig.instance:getCommonValue("SHOW_RACE_ID", true)
	local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._roleconGo, scale, nil, true, x, y)
end

function SinglerechargemainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "singlerecharge_rule")
end

function SinglerechargemainView:_PM_SingleRechargeGetInfoRes(status)
	if status == 0 then
		self:_updateUI()
	end
end

function SinglerechargemainView:_PM_SingleRechargeGainPrizeRes(status)
	if status == 0 then
		self:_updateUI()
	end
end

function SinglerechargemainView:_NotifyPayShopItemBuySucRes()
	SingleRechargeAgent.instance:sendPM_SingleRechargeGetInfoReq(self._activityId)
end

function SinglerechargemainView:_setActTime()
	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = string.format("%s%s - %s", lang("活动时间："), self:_formatTime(stime), self:_formatTime(etime))
end

function SinglerechargemainView:_formatTime(time)
	local date = GameUtil.time2date(time)

	return string.format("%s%s%s%s%s%s", date.month, lang("月"), date.day, lang("日"), date.hour, lang("：00"))
end

return SinglerechargemainView

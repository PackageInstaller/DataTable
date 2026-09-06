-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/view/FlynuomainView.lua

module("logic.extensions.flyingnuo.view.FlynuomainView", package.seeall)

local FlynuomainView = class("FlynuomainView", ViewComponent)

function FlynuomainView:ctor()
	FlynuomainView.super.ctor(self)
end

function FlynuomainView:buildUI()
	FlynuomainView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/closeBtn")
	self._tipBtn = self:getBtn("bg/tipBtn")
	self._startBtn = self:getBtn("startBtn")
	self._addTimeBtn = self:getBtn("gameTime/addBtn")
	self._shopBtn = self:getBtn("btns/shop")
	self._rewardBtn = self:getBtn("btns/reward")
	self._addGoodsBtn = self:getBtn("bg/huobi/Btn_Add")
	self._rankBtn = self:getBtn("btns/rank")
	self._roleCon = self:getGo("roleCon")
	self._shopRedDot = self:getGo("btns/shop/dot")

	goutil.setActive(self._shopRedDot, false)

	self._timeText = goutil.findChildTextComponent(self.mainGO, "bg/timeText")
	self._historyText = goutil.findChildTextComponent(self.mainGO, "historyText")
	self._leftText = goutil.findChildTextComponent(self.mainGO, "gameTime/leftTime")
	self._goodsText = goutil.findChildTextComponent(self.mainGO, "bg/huobi/TxtC_Num")
	self._useWudiToggle = self:getGo("useToggle/Toggle"):GetComponent(typeof(UnityEngine.UI.Toggle))
	self._toggleAdapter = self:getGo("useToggle/Toggle"):GetComponent(typeof(Framework.ToggleAdapter))
	self._wuIconBtn = self:getBtn("useToggle/wuIconBtn")
end

function FlynuomainView:bindEvents()
	FlynuomainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipBtn:AddClickListener(self._clickTip, self)
	self._startBtn:AddClickListener(self._clickStart, self)
	self._addTimeBtn:AddClickListener(self._clickAddGameTime, self)
	self._shopBtn:AddClickListener(self._clickShop, self)
	self._rewardBtn:AddClickListener(self._clickReward, self)
	self._addGoodsBtn:AddClickListener(self._clickAddGoods, self)
	self._rankBtn:AddClickListener(self._clickRank, self)
	self._toggleAdapter:AddOnValueChanged(self._onToggleChange, self)
	self._wuIconBtn:AddClickListener(self._onClickwuIcon, self)
end

function FlynuomainView:unbindEvents()
	FlynuomainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
	self._startBtn:RemoveClickListener()
	self._addTimeBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._addGoodsBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._toggleAdapter:RemoveOnValueChanged()
	self._wuIconBtn:RemoveClickListener()
end

function FlynuomainView:destroyUI()
	FlynuomainView.super.destroyUI(self)
end

function FlynuomainView:onEnter()
	FlynuomainView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._toggleAdapter.toggle.isOn = FlyNuoModel.instance:getUseWudiToggleTag()

	self:_updateView()
	GlobalDispatcher:addListener(FlyingNuoAgent.GetInfoRes, self._updateView, self)
	GlobalDispatcher:addListener(FlyingNuoAgent.BuyRes, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._checkRedDot, self)

	if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlyNuo, self._activityId) then
		ActivityshopController.instance:getAllShopItemInfo(GameEnum.ActivityType.FlyNuo, self._activityId)
		FlyingNuoAgent.instance:sendPM_GetInfoReq(self._activityId)
	else
		FloatWordMgr.instance:show("不在活动时间内")
	end
end

function FlynuomainView:onEnterFinished()
	FlynuomainView.super.onEnterFinished(self)
end

function FlynuomainView:onExit()
	FlynuomainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	GlobalDispatcher:removeListener(FlyingNuoAgent.BuyRes, self._buyRes, self)
	GlobalDispatcher:removeListener(FlyingNuoAgent.GetInfoRes, self._updateView, self)
	GlobalDispatcher:removeListener(FlyingNuoAgent.BuyRes, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._checkRedDot, self)
end

function FlynuomainView:onExitFinished()
	FlynuomainView.super.onExitFinished(self)
end

function FlynuomainView:_clickTip()
	TipsFacade.instance:openRulesView("flyingnuo")
end

function FlynuomainView:_clickStart()
	if not self._info then
		return
	end

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlyNuo, self._activityId) then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	if FlyNuoModel.instance:getUseWudiToggleTag() then
		local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
		local isEnough = MaterialFacade.instance:isMatsEnough(cfg.gameStartItem)

		if not isEnough then
			local canBuyWudiTimes = FlyNuoModel.instance:getTodayGameStartItemLeftBuyTimes(self._activityId) > 0

			if canBuyWudiTimes then
				self:_clickAddGoods()

				return
			else
				self._toggleAdapter.toggle.isOn = false

				FloatWordMgr.instance:show("当前无敌之翼数量为0")
				FlyNuoModel.instance:setWudiToggleTag(false)
			end
		end
	end

	local time = FlyNuoConfig.instance:getDayGameTime()
	local leftTime = math.max(0, time + self._info.todayGameTimesBuyTimes - self._info.todayGameTimes)

	if leftTime > 0 then
		local useGoods = false

		if self._useWudiToggle.isOn then
			local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)

			useGoods = MaterialFacade.instance:isMatsEnough(cfg.gameStartItem)
		end

		local key = ServerTime.now()

		FlyNuoModel.instance:setUseGameStartItem(useGoods)
		FlyingNuoAgent:sendPM_StartGameReq(self._activityId, useGoods, key)
	else
		FloatWordMgr.instance:show("剩余游戏次数不足")

		if self._info then
			local currBuyTime = self._info.todayGameTimesBuyTimes + 1
			local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
			local buyCfg = FlyNuoConfig.instance:getBuyCfgByTime(cfg.buyTimesPlan, 1, currBuyTime)

			if buyCfg then
				::label_11_0::

				local isEnough = MaterialFacade.instance:isMatsEnough(buyCfg.consume)

				if isEnough then
					self:_clickAddGameTime(true, true)
				else
					FloatWordMgr.instance:show("今日购买次数已达到上限")
				end
			end
		end
	end
end

function FlynuomainView:_buyRes(status)
	GlobalDispatcher:removeListener(FlyingNuoAgent.BuyRes, self._buyRes, self)

	if status == 0 then
		self:_updateView()
		self:_clickStart()
	end
end

function FlynuomainView:_clickAddGameTime(notShowTip, needBindBuyRes)
	if not self._info then
		return
	end

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlyNuo, self._activityId) then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	local leftTime = self:_getLeftGameTime(self._info)

	if leftTime > 0 then
		FloatWordMgr.instance:show("还有游戏次数，无需购买")

		return
	end

	local currBuyTime = self._info.todayGameTimesBuyTimes + 1
	local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
	local buyCfg = FlyNuoConfig.instance:getBuyCfgByTime(cfg.buyTimesPlan, 1, currBuyTime)

	if buyCfg then
		local buyCfgs = FlyNuoConfig.instance:getBuyCfgByType(cfg.buyTimesPlan, 1)
		local limitBuyTime = #buyCfgs
		local t = GameUtil.parseMatStr2Table(buyCfg.consume)
		local isEnough = MaterialFacade.instance:isMatsEnough(buyCfg.consume)
		local name = MaterialMgr.getMaterialsName(t[1], t[2])

		if isEnough then
			local content = "确定花费<color=red>" .. t[3] .. name .. "</color>购买<color=red>1</color>次游戏次数吗？\n每日购买游戏次数上限为：<color=red>" .. limitBuyTime .. "</color>次，当前第<color=red>" .. currBuyTime .. "</color>次"

			local function okFunc()
				if needBindBuyRes then
					GlobalDispatcher:addListener(FlyingNuoAgent.BuyRes, self._buyRes, self)
				end

				FlyingNuoAgent.instance:sendPM_BuyReq(self._activityId, 1)
			end

			local function otherFunc(state)
				if state == TipsFacade.STATE_CANCEL or state == TipsFacade.STATE_FAIL then
					GlobalDispatcher:removeListener(FlyingNuoAgent.BuyRes, self._clickStart, self)
				end
			end

			TipsFacade.instance:openPopupCostMatViewNew(t[1], t[2], t[3], content, okFunc, nil, nil, nil, otherFunc)
		else
			FloatWordMgr.instance:show(name .. "不足")
		end
	elseif not notShowTip then
		FloatWordMgr.instance:show("今日购买次数已达上限")
	end
end

function FlynuomainView:_clickShop()
	FuncOpenController.instance:openFunc(191, GameEnum.ActivityType.FlyNuo)
end

function FlynuomainView:_clickReward()
	UIStateManager.instance:push(ViewName.FlynuorewardView, self._activityId)
end

function FlynuomainView:_clickAddGoods()
	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlyNuo, self._activityId) then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	UIStateManager.instance:push(ViewName.FlynuobuygoodsView, self._activityId)
end

function FlynuomainView:_clickRank()
	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.FlyNuo, self._activityId) then
		FloatWordMgr.instance:show("不在活动时间内")

		return
	end

	UIStateManager.instance:push(ViewName.FlynuorankView)
end

function FlynuomainView:_updateView()
	self:_setActTime()
	self:_setGameStartItem()

	local info = FlyNuoModel.instance:getActivityInfo()

	self._info = info

	if not info then
		return
	end

	local key = "FlynuomainView" .. RoleModel.instance:getUserId()
	local cacheActivityId = Framework.LocalStorage.Instance:GetInt(key)

	if not cacheActivityId or cacheActivityId ~= self._activityId then
		Framework.LocalStorage.Instance:SetInt(key, self._activityId)
		Framework.LocalStorage.Instance:Save()
		UIStateManager.instance:push(ViewName.FlynuoruleView)
	end

	self:_setGameTime(info)
	self:_setHistory(info)
	self:_setRole()
	self:_checkRedDot()
end

function FlynuomainView:_setActTime()
	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FlyNuo, self._activityId)
	local sDate = GameUtil.string2date(cfg.startTime)
	local eDate = GameUtil.string2date(cfg.endTime)
	local startTime = sDate.month .. "." .. sDate.day
	local endTime = eDate.month .. "." .. eDate.day

	self._timeText.text = "活动时间：" .. startTime .. "-" .. endTime
end

function FlynuomainView:_setGameTime(info)
	local time = FlyNuoConfig.instance:getDayGameTime()

	self._leftText.text = "游戏次数： " .. self:_getLeftGameTime(info) .. "/" .. time
end

function FlynuomainView:_getLeftGameTime(info)
	local time = FlyNuoConfig.instance:getDayGameTime()

	return math.max(0, time + info.todayGameTimesBuyTimes - info.todayGameTimes)
end

function FlynuomainView:_setHistory(info)
	self._historyText.text = "最高纪录\n<color=#ffffff><size=24>" .. info.everMaxScore .. "</size></color>"
end

function FlynuomainView:_setGameStartItem()
	local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
	local t = GameUtil.parseMatStr2Table(cfg.gameStartItem)

	self._goodsText.text = MaterialFacade.instance:getMatNumber(t[1], t[2])
end

function FlynuomainView:_checkRedDot()
	local dot = FlyNuoModel.instance:checkAllItemCanExchange(self._activityId)

	goutil.setActive(self._shopRedDot, dot)
end

function FlynuomainView:_setRole()
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 50142, self._roleCon, 0.55)
end

function FlynuomainView:_onToggleChange(obj, isOn)
	FlyNuoModel.instance:setWudiToggleTag(isOn)
end

function FlynuomainView:_onClickwuIcon()
	local cfg = FlyNuoConfig.instance:getActivityCfgById(self._activityId)
	local list = string.split(cfg.gameStartItem, ":")

	CommonTipsMgr.instance:openMaterialTips(self._wuIconBtn.gameObject, checknumber(list[1]), checknumber(list[2]))
end

return FlynuomainView

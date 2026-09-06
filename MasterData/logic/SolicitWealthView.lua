-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/view/SolicitWealthView.lua

module("logic.extensions.solicitwealth.view.SolicitWealthView", package.seeall)

local SolicitWealthView = class("SolicitWealthView", ViewComponent)

function SolicitWealthView:ctor()
	SolicitWealthView.super.ctor(self)
end

function SolicitWealthView:buildUI()
	SolicitWealthView.super.buildUI(self)

	self._oneBtn = self:getBtn("oneBtn")
	self._tenBtn = self:getBtn("tenBtn")
	self._oneText = self:getTxt("oneBtn/Text")
	self._tenText = self:getTxt("tenBtn/Text")
	self._oneGetNum = self:getTxt("oneBtn/getNum")
	self._tenGetNum = self:getTxt("tenBtn/getNum")
	self._oneCostNum = self:getTxt("oneBtn/costNum")
	self._oneCostIcon = self:getGo("oneBtn/costNum/icon")
	self._tenCostNum = self:getTxt("tenBtn/costNum")
	self._tenCostIcon = self:getGo("tenBtn/costNum/icon")
	self._oneFreeTimes = self:getTxt("oneBtn/freeTimes")
	self._tenFreeTimes = self:getTxt("tenBtn/freeTimes")
	self._oneRed = self:getGo("oneBtn/red")
	self._todayNum = self:getTxt("today/num")
	self._times = self:getTxt("times")
	self._goldBar = self:getGo("goldBar")
	self._vipLv = goutil.findChildComponent(self.mainGO, "vip/vipLv/imgTxtNum", "UIImgNumeralText")
	self._vipText = self:getTxt("vip/Text")
	self._tipBtn = self:getBtn("tipBtn")
	self.itemGDC = self:getGo("goldenDiamond/item")
	self.showTip = self:getTxt("goldenDiamond/showTip")
	self.colorChange = self:getGo("goldenDiamond/showTip"):GetComponent("UITextColorChange")
	self.defaultAddTime = GoldenDiamondCardConfig.instance:getPrivilegeDefaultValue(GoldenDiamondCardModel.instance.PrivilegeType.MoneyCat)
end

function SolicitWealthView:bindEvents()
	SolicitWealthView.super.bindEvents(self)
	self._oneBtn:AddClickListener(self._onClickOne, self)
	self._tenBtn:AddClickListener(self._onClickTen, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
end

function SolicitWealthView:unbindEvents()
	SolicitWealthView.super.unbindEvents(self)
	self._oneBtn:RemoveClickListener()
	self._tenBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
end

function SolicitWealthView:destroyUI()
	SolicitWealthView.super.destroyUI(self)
end

function SolicitWealthView:onEnter()
	SolicitWealthView.super.onEnter(self)
	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor)

	local lv, moneyCatLevel = RoleModel.instance:getMyLevel(), SolicitWealthConfig.instance:getLevel()
	local moneyCatConfig = SolicitWealthConfig.instance:getConfig()

	self._limitTimes = tonumber(moneyCatConfig.MAX_TIMES.value)
	self._solicitTimes = self._limitTimes
	self._times.text = "今日剩余次数:" .. self._limitTimes
	self._todayNum.text = 0

	local sp = string.split(moneyCatConfig.SINGLE_COST.value, ":")

	self._oneCostNum.text = sp[3]

	local proxy, scale = MaterialMgr.setCell(tonumber(sp[1]), tonumber(sp[2]), self._oneCostIcon), 0.3

	if proxy then
		proxy.binder:setNum(0)
		proxy.binder:setAutoTips(false)
		proxy.binder:setBgActive(false)
		proxy.binder:setEffStatus(false)
		GameUtil.setLocalScale(proxy.view, scale, scale, 1)
	end

	sp = string.split(moneyCatConfig.TEN_COST.value, ":")
	self._tenCostNum.text = sp[3]
	proxy = MaterialMgr.setCell(tonumber(sp[1]), tonumber(sp[2]), self._tenCostIcon)

	if proxy then
		proxy.binder:setNum(0)
		proxy.binder:setAutoTips(false)
		proxy.binder:setBgActive(false)
		proxy.binder:setEffStatus(false)
		GameUtil.setLocalScale(proxy.view, scale, scale, 1)
	end

	local getNum = moneyCatLevel[math.min(lv, #moneyCatLevel)].prizeNum

	self._oneGetNum.text = getNum
	self._tenGetNum.text = getNum * 10
	self._oneBtnTimes = 1
	self._tenBtnTimes = 10
	self._dailyOnceFreeTimes = 0
	self._dailyTenFreeTimes = 0

	self._vipLv:SetNum(RoleModel.instance:getVipLvl())

	self._vipText.text = string.format(SolicitWealthConfig.instance:getConfigByKey("VIP_TIP"), VipModel.instance:getMoneyCat())
	self._openAreaDay = GameUtil.getOpenAreaDaysForFive()
	self._lock = false

	MoneyCatAgent.instance:sendMoneyCatInfoReq(function(msg)
		self:_updateViewInfo(msg)
	end)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	GlobalDispatcher:addListener(SolicitWealthConfig.UNLOCK, self._unLock, self)

	local effect_path = "fx_ui_zhaocaimao/fx_ui_zhaocaimao_tx_xinxin.prefab"

	self._xinxinEff = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, nil, function(finishHandler, eff)
		eff.effGo.transform:SetParent(self:getGo("bg").transform)
		eff:setScale(1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		eff.hideEffWhileNotOnTop = false
	end)
	self._curShowSpine = StorySpinePlayer.New()
	self._curShowSpine.disableForceAnim = true
	effect_path = "fx_ui_zhaocaimao/fx_ui_zhaocaimao_spine.prefab"
	self._spineEff = UIEffectManager.instance:playEffect(self, "fx_ui_zhaocaimao/fx_ui_zhaocaimao_spine.prefab", nil, 0, 0, true, nil, nil, function(finishHandler, eff)
		eff.effGo.transform:SetParent(self:getGo("bg").transform)
		eff:setScale(1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		self._curShowAnim = goutil.findChildComponent(eff.effGo, "fx_ui_zong/Spine GameObject (zhaocaimao_skeletondata)", "SkeletonAnimation")

		self._curShowSpine:setSpine(self._curShowAnim)

		eff.hideEffWhileNotOnTop = false
		goutil.findChildComponent(eff.effGo, "fx_ui_zong/Spine GameObject (zhaocaimao_skeletondata)", "MeshRenderer").enabled = true
	end)
	self.isUserOfGDC = GoldenDiamondCardModel.instance.isUser

	uGuiUtil.setRawImageGrayState(self.itemGDC, not self.isUserOfGDC)
	self.colorChange:SetState(self.isUserOfGDC and 0 or 1)

	self.showTip.text = self.isUserOfGDC and langPara("金钻特权已获得免费次数%s次", self.defaultAddTime) or langPara("激活金钻特权每日获得免费次数%s次", self.defaultAddTime)
end

function SolicitWealthView:onEnterFinished()
	SolicitWealthView.super.onEnterFinished(self)
end

function SolicitWealthView:onExit()
	SolicitWealthView.super.onExit(self)
	GlobalDispatcher:dispatch(SolicitWealthConfig.SWITCHVIEW)
	GlobalDispatcher:removeListener(SolicitWealthConfig.UNLOCK, self._unLock, self)
	UIEffectManager.instance:stopEffect(self._xinxinEff)
	UIEffectManager.instance:stopEffect(self._spineEff)
	UIEffectManager.instance:stopEffect(self._makeMoneyOneEff)
	UIEffectManager.instance:stopEffect(self._makeMoneyTenEff)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
	MaterialMgr.resetAll(self._oneCostIcon)
	MaterialMgr.resetAll(self._tenCostIcon)
	removetimer(self._showPrize, self)
	MoneyCatAgent.instance:getDispatcher():removeAllListener(MoneyCatAgent.MoneyCatInfoRes)
	MoneyCatAgent.instance:getDispatcher():removeAllListener(MoneyCatAgent.MakeMoneyRes)
end

function SolicitWealthView:onExitFinished()
	SolicitWealthView.super.onExitFinished(self)
end

function SolicitWealthView:_updateViewInfo(msg)
	self._dailyOnceFreeTimes = msg.dailyFreeTimes
	self._solicitTimes = self._limitTimes + VipModel.instance:getMoneyCat() - msg.times

	if self.isUserOfGDC then
		self._solicitTimes = self._solicitTimes + self.defaultAddTime
	end

	self._times.text = "今日剩余次数:" .. self._solicitTimes
	self._todayNum.text = msg.gainNum

	self:_updateBtnGray()

	if self._dailyOnceFreeTimes > 0 then
		self._oneText.text = "免费招财"

		goutil.setActive(self._oneCostNum.gameObject, false)
		goutil.setActive(self._oneFreeTimes.gameObject, true)
		goutil.setActive(self._oneRed, true)

		if self.isUserOfGDC then
			local var_13_0 = VipModel.instance:getMoneyCat() + self.defaultAddTime

			if not var_13_0 then
				var_13_0 = VipModel.instance:getMoneyCat()

				local totalTime = var_13_0

				self._oneFreeTimes.text = self:_freeTextFormat(self._dailyOnceFreeTimes, totalTime)
			end
		end
	else
		self._oneText.text = "招财一次"

		goutil.setActive(self._oneCostNum.gameObject, true)
		goutil.setActive(self._oneFreeTimes.gameObject, false)
		goutil.setActive(self._oneRed, false)
	end

	self._dailyTenFreeTimes = math.floor(msg.dailyFreeTimes / 10)

	if self._dailyTenFreeTimes > 0 then
		self._tenText.text = "免费招财"

		goutil.setActive(self._tenCostNum.gameObject, false)
		goutil.setActive(self._tenFreeTimes.gameObject, true)
	else
		self._tenText.text = "招财十次"

		goutil.setActive(self._tenCostNum.gameObject, true)
		goutil.setActive(self._tenFreeTimes.gameObject, false)
	end
end

function SolicitWealthView:_freeTextFormat(num, sum)
	return string.format("免费次数:%d/%d", num, sum)
end

function SolicitWealthView:_onClickOne()
	if self._solicitTimes <= 0 then
		FloatWordMgr.instance:show(SolicitWealthConfig.instance:getConfigByKey("NONE_TIMES_TIP"))

		return
	end

	if self._lock then
		FloatWordMgr.instance:show(SolicitWealthConfig.instance:getConfigByKey("ANIMATION_TIP"))

		return
	end

	if self._dailyOnceFreeTimes > 0 then
		MoneyCatAgent.instance:sendMakeMoneyReq(self._oneBtnTimes, function(msg)
			self._dailyOnceFreeTimes = self._dailyOnceFreeTimes - self._oneBtnTimes

			if self._dailyOnceFreeTimes <= 0 then
				self._oneText.text = "招财一次"

				goutil.setActive(self._oneCostNum.gameObject, true)
				goutil.setActive(self._oneFreeTimes.gameObject, false)
				goutil.setActive(self._oneRed, false)
			elseif self.isUserOfGDC then
				local var_16_0 = VipModel.instance:getMoneyCat() + self.defaultAddTime

				if not var_16_0 then
					var_16_0 = VipModel.instance:getMoneyCat()

					local totalTime = var_16_0

					self._oneFreeTimes.text = self:_freeTextFormat(self._dailyOnceFreeTimes, totalTime)
				end
			end

			self:_makeMoneyOneRes(msg)
		end)
	else
		TipsFacade.instance:openPopupCostDiamondView(tonumber(self._oneCostNum.text), string.format("是否花费%s钻石招财？", self._oneCostNum.text), function()
			MoneyCatAgent.instance:sendMakeMoneyReq(self._oneBtnTimes, self._makeMoneyOneRes, self)
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function SolicitWealthView:_makeMoneyOneRes(msg)
	local effect_path = "fx_ui_zhaocaimao/fx_ui_zhaocaimao_tx_1.prefab"

	self._makeMoneyOneEff = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, false, nil, function()
		return
	end, function(finishHandler, eff)
		self._curShowSpine:setSpine(self._curShowAnim, {
			"idle2",
			"idle"
		})
		eff.effGo.transform:SetParent(self:getGo("bg").transform)
		eff:setScale(1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		eff.hideEffWhileNotOnTop = false
	end)

	local items = MaterialFacade.instance:getItemsByChangeSetId(msg.changeSetId)

	self._multiple = msg.multiple
	self._items = items

	settimer(1, self._showPrize, self, false)

	if items and #items > 0 then
		self._todayNum.text = tonumber(self._todayNum.text) + items[1]:GetCount()
	end

	self._solicitTimes = self._solicitTimes - self._oneBtnTimes
	self._times.text = "今日剩余次数:" .. self._solicitTimes

	self:_updateBtnGray()
end

function SolicitWealthView:_onClickTen()
	if self._solicitTimes <= 0 then
		FloatWordMgr.instance:show(SolicitWealthConfig.instance:getConfigByKey("NONE_TIMES_TIP"))

		return
	end

	if self._solicitTimes < 10 then
		return
	end

	if self._lock then
		FloatWordMgr.instance:show(SolicitWealthConfig.instance:getConfigByKey("ANIMATION_TIP"))

		return
	end

	if self._dailyTenFreeTimes > 0 then
		MoneyCatAgent.instance:sendMakeMoneyReq(self._tenBtnTimes, function(msg)
			self._lock = true
			self._dailyTenFreeTimes = self._dailyTenFreeTimes - 1

			if self._dailyTenFreeTimes <= 0 then
				self._tenText.text = "招财十次"

				goutil.setActive(self._tenCostNum.gameObject, true)
			end

			self:_makeMoneyTenRes(msg)
		end)
	else
		TipsFacade.instance:openPopupCostDiamondView(tonumber(self._tenCostNum.text), string.format("是否花费%s钻石招财？", self._tenCostNum.text), function()
			MoneyCatAgent.instance:sendMakeMoneyReq(self._tenBtnTimes, self._makeMoneyTenRes, self)
		end, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function SolicitWealthView:_makeMoneyTenRes(msg)
	local effect_path = "fx_ui_zhaocaimao/fx_ui_zhaocaimao_tx_10.prefab"

	self._makeMoneyTenEff = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, false, nil, function()
		return
	end, function(finishHandler, eff)
		self._curShowSpine:setSpine(self._curShowAnim, {
			"idle2",
			"idle"
		})
		eff.effGo.transform:SetParent(self:getGo("bg").transform)
		eff:setScale(1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

		eff.hideEffWhileNotOnTop = false
	end)
	self._lock = true

	local items = MaterialFacade.instance:getItemsByChangeSetId(msg.changeSetId)

	self._multiple = msg.multiple
	self._items = items

	settimer(1, self._showPrize, self, false)

	self._todayNum.text = tonumber(self._todayNum.text) + items[1]:GetCount()
	self._tenText.text = "招财十次"
	self._solicitTimes = self._solicitTimes - self._tenBtnTimes
	self._times.text = "今日剩余次数:" .. self._solicitTimes

	self:_updateBtnGray()
end

function SolicitWealthView:_showPrize()
	UIStateManager.instance:open(ViewName.SolicitwealthgetView, self._multiple, self._items)
end

function SolicitWealthView:_updateBtnGray()
	uGuiUtil.setGoGrayState(self._oneBtn.gameObject, self._solicitTimes < 1)
	uGuiUtil.setGoGrayState(self._tenBtn.gameObject, self._solicitTimes < 10)
end

function SolicitWealthView:_reloadData()
	MoneyCatAgent.instance:sendMoneyCatInfoReq(function(msg)
		self:_updateViewInfo(msg)
	end)
end

function SolicitWealthView:_unLock()
	self._lock = false
end

function SolicitWealthView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "MoneyCat")
end

return SolicitWealthView

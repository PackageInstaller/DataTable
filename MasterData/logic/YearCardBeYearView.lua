-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCardBeYearView.lua

module("logic.extensions.yearcard.view.YearCardBeYearView", package.seeall)

local YearCardBeYearView = class("YearCardBeYearView", TableViewComponent)

function YearCardBeYearView:ctor()
	YearCardBeYearView.super.ctor(self)
end

function YearCardBeYearView:buildUI()
	YearCardBeYearView.super.buildUI(self)

	self._items = {}

	for i = 1, 3 do
		local item = {}
		local go = self:getGo("immediate/item" .. i)

		item.go = go
		item.iconGo = goutil.findChild(go, "con")
		item.getedGo = goutil.findChild(go, "receive")
		item.txtName = goutil.findChildTextComponent(go, "txtName")

		table.insert(self._items, item)
	end

	self._btnRecharge = self:getBtn("btnRecharge")
	self._txtRecharge = self:getTxt("btnRecharge/on/txtRecharge")
	self._rechargeRedPoint = self:getGo("btnRecharge/redPoint")
	self._activeGroup = self:getGo("btnRecharge/on"):GetComponent(typeof(UIChangeGroup))
	self._txtTotalPrice = self:getTxt("btnWeek/txt2")
	self._slider = self:getSlider("progress")
	self._txtSlider = self:getTxt("progress/txtProgress")
	self._btnWeek = self:getBtn("btnWeek")
	self._btnKachi = self:getBtn("immediate/item3/con")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._redpointChallenge = self:getGo("btnChallenge/redpoint")
	self._btnInfo = self:getBtn("btnInfo")
	self._effectParent = self:getGo("btnWeek/effect")
	self._receiveGo = self:getGo("btnChallenge/receive")
	self._btnTip = self:getBtn("btnWeek/btnTip")
	self._btnExplain = self:getBtn("moon/btnExplain")
	self._txtTip = self:getGo("txtTip")
	self._txtTip1 = self:getGo("txtTip1")
end

function YearCardBeYearView:_getPath()
	return {
		cellPath = "moon/cell",
		viewPath = "moon/tableview"
	}
end

function YearCardBeYearView:bindEvents()
	YearCardBeYearView.super.bindEvents(self)
	self._btnRecharge:AddClickListener(self._onClickRecharge, self)
	self._btnWeek:AddClickListener(self._onClickWeek, self)
	self._btnKachi:AddClickListener(self._onClickKachi, self)
	self._btnChallenge:AddClickListener(self._onClickSkillExplain, self)
	self._btnInfo:AddClickListener(self._onClickPetinfoExplain, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function YearCardBeYearView:unbindEvents()
	YearCardBeYearView.super.unbindEvents(self)
	self._btnRecharge:RemoveClickListener()
	self._btnWeek:RemoveClickListener()
	self._btnKachi:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function YearCardBeYearView:onEnter()
	YearCardBeYearView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	self:_refresh()
end

function YearCardBeYearView:onExit()
	YearCardBeYearView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	self:_resetImmeliateItems()
	self:_removeEffect()
end

function YearCardBeYearView:_onClickRecharge()
	local data = YearCardModel.instance:getAnnuityInfo(self.annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(self.annuityId)

	if data and cfg and data.money >= cfg.price then
		YearCardController.instance:activateAnnuity(self.annuityId)
	else
		PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
	end
end

function YearCardBeYearView:_onClickWeek()
	YearCardController.instance:onClickWeekReward(self.annuityId)
end

function YearCardBeYearView:_onClickKachi()
	local data = YearCardModel.instance:getAnnuityInfo(self.annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(self.annuityId)

	if data and data.active == true then
		FloatWordMgr.instance:show("【次元空间】专属UP召唤已开启")
	else
		FloatWordMgr.instance:show("成功激活年费卡后，\n将开启【万象·次元圣龙】专属UP召唤")
	end
end

function YearCardBeYearView:_onClickSkillExplain()
	local fixedGain = PayShopConfig.instance:getAnnuityCfgById(self.annuityId).fixedGain
	local petId = tonumber(string.split(fixedGain, ":")[2])

	FuncOpenController.instance:openFunc(149, petId)
end

function YearCardBeYearView:_onClickPetinfoExplain()
	local fixedGain = PayShopConfig.instance:getAnnuityCfgById(self.annuityId).fixedGain
	local petId = tonumber(string.split(fixedGain, ":")[2])

	PetbookController.instance:openPetinfoView(petId)
end

function YearCardBeYearView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "yearcarddiamond")
end

function YearCardBeYearView:_onClickExplain()
	UIStateManager.instance:open(ViewName.RulesView, "yearcardmonth")
end

function YearCardBeYearView:_refresh()
	self.annuityId = YearCardModel.instance:getCurAnnuityId()

	local data = YearCardModel.instance:getAnnuityInfo(self.annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(self.annuityId)

	if data and cfg then
		self:_refreshImmediateItems(data, cfg)
	end
end

function YearCardBeYearView:_refreshImmediateItems(data, cfg)
	local isGeted = data.active

	for i = 1, 3 do
		self._items[i].getedGo:SetActive(isGeted)
	end

	local fixedGain = string.split(cfg.fixedGain, "#")

	MaterialMgr.setCellByCfg(fixedGain[1], self._items[1].iconGo)
	MaterialMgr.setCellByCfg(fixedGain[2], self._items[2].iconGo)
	self:_refreshCanGetPerMonth(cfg.activityId)

	local arr = string.split(cfg.weeklyGain, ":")

	self._txtTotalPrice.text = checknumber(arr[3])

	goutil.setActive(self._receiveGo, data.active)
	goutil.setActive(self._btnRecharge.gameObject, not data.active)
	goutil.setActive(self._rechargeRedPoint, not data.active and data.money >= cfg.price)

	if data.money >= cfg.price then
		self._activeGroup:SetState(1)

		self._txtRecharge.text = "激活"
	else
		self._activeGroup:SetState(0)

		self._txtRecharge.text = "充值"
	end

	if cfg.price > 0 then
		self._slider:SetValue(data.money / cfg.price)
	else
		self._slider:SetValue(0)
	end

	self._txtSlider.text = string.format("%d/%d", data.money / 100, cfg.price / 100)

	local hasGainWeeklyPrize = YearCardModel.instance:getHasGainWeeklyPrize(self.annuityId)

	if data.active and not hasGainWeeklyPrize then
		self:_playEffect()
	else
		self:_removeEffect()
	end

	self:_updateChallengeRedPoint()
	self:_freshShowByActId()
end

function YearCardBeYearView:_resetImmeliateItems()
	MaterialMgr.resetAll(self._items[1].iconGo)
	MaterialMgr.resetAll(self._items[2].iconGo)
end

function YearCardBeYearView:_updateChallengeRedPoint()
	local fixedGain = PayShopConfig.instance:getAnnuityCfgById(self.annuityId).fixedGain
	local petId = tonumber(string.split(fixedGain, ":")[2])
	local isShowRedPoint = PetCollegeModel.instance:canBattleByRaceId(petId)

	GameUtil.SetActive(self._redpointChallenge, isShowRedPoint)
end

function YearCardBeYearView:_refreshCanGetPerMonth(activityId)
	local cfgs = YearCardConfig.instance:getRewardShowCfgs(activityId)

	if cfgs and #cfgs > 0 then
		self:updateListData(cfgs)
	end
end

function YearCardBeYearView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "con")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = data.name

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, data.icon)
end

function YearCardBeYearView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "con")

	uGuiUtil.clearImage(icon)
end

function YearCardBeYearView:_playEffect()
	self:_removeEffect()

	self.effectHandler = UIEffectManager.instance:playEffect(self, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", nil, nil, nil, true)

	self.effectHandler:setParent(self._effectParent.transform)
	self.effectHandler:setScale(1)
	self.effectHandler:setLocalPos(0, 0, 0)
end

function YearCardBeYearView:_removeEffect()
	if self.effectHandler then
		UIEffectManager.instance:stopEffect(self.effectHandler)

		self.effectHandler = nil
	end
end

function YearCardBeYearView:_freshShowByActId()
	local actIdNow = YearCardModel.instance:getCurActIdByServerTime()
	local data = YearCardModel.instance:getAnnuityInfo(self.annuityId)
	local isShow = actIdNow == self.annuityId

	goutil.setActive(self._txtTip, isShow)
	goutil.setActive(self._txtTip1, not isShow)
	goutil.setActive(self._receiveGo, isShow and data.active)
	goutil.setActive(self._btnRecharge.gameObject, isShow and not data.active)
	goutil.setActive(self._slider.gameObject, isShow)
end

return YearCardBeYearView

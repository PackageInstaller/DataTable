-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopyearView.lua

module("logic.extensions.payshop.view.PayshopyearView", package.seeall)

local PayshopyearView = class("PayshopyearView", ViewComponent)

function PayshopyearView:ctor()
	PayshopyearView.super.ctor(self)
end

function PayshopyearView:buildUI()
	PayshopyearView.super.buildUI(self)

	self._btnKachi = self:getBtn("regular/kachi")
	self._stateHasGet = self:getGo("regular/states")
	self._btnweekly = self:getBtn("period/icon")
	self._txtNum = goutil.findChildTextComponent(self.mainGO, "period/txtNum")
	self._periodEffect = self:getGo("period/effect")
	self.gobtnActive = goutil.findChild(self.mainGO, "btnActive")
	self.goActiveRedPoint = goutil.findChild(self.mainGO, "btnActive/redPoint")
	self._btnActive = self:getBtn("btnActive")
	self._activeGroup = goutil.findChildComponent(self.mainGO, "btnActive/on", "UIChangeGroup")
	self._txtActive = goutil.findChildTextComponent(self.mainGO, "btnActive/on/txt")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._redpointChallenge = self:getGo("btnChallenge/redpoint")
	self._btnInfo = self:getBtn("btnInfo")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "txtTime")
	self.itemPoint = {}
	self.itemPoint[1] = goutil.findChild(self.mainGO, "regular/icon1/item1")
	self.itemPoint[2] = goutil.findChild(self.mainGO, "regular/icon2/item2")
	self.itemPoint[3] = goutil.findChild(self.mainGO, "regular/icon3/item3")
	self.itemPoint[4] = goutil.findChild(self.mainGO, "period/item4")
	self.itemPoint[5] = goutil.findChild(self.mainGO, "period/item5")
	self._btnTips = self:getBtn("tipBtn")
end

function PayshopyearView:bindEvents()
	PayshopyearView.super.bindEvents(self)
	self._btnActive:AddClickListener(self._onClickActive, self)
	self._btnweekly:AddClickListener(self._GainWeeklyPrize, self)
	self._btnChallenge:AddClickListener(self._onClickSkillExplain, self)
	self._btnInfo:AddClickListener(self._onClickPetinfoExplain, self)
	self._btnKachi:AddClickListener(self._onClickKachi, self)
	self._btnTips:AddClickListener(self._onClickTipRule, self)
end

function PayshopyearView:unbindEvents()
	PayshopyearView.super.unbindEvents(self)
	self._btnActive:RemoveClickListener()
	self._btnweekly:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnKachi:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function PayshopyearView:destroyUI()
	PayshopyearView.super.destroyUI(self)
end

function PayshopyearView:onEnter()
	PayshopyearView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)
	PayShopController.instance:getUserAnnuityInfo()
end

function PayshopyearView:onEnterFinished()
	PayshopyearView.super.onEnterFinished(self)
end

function PayshopyearView:onExit()
	PayshopyearView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refresh, self)

	for i, v in ipairs(self.itemPoint) do
		MaterialMgr.resetAll(self.itemPoint[i])
	end

	UIEffectManager.instance:stopEffect(self.effectHandler)
end

function PayshopyearView:onExitFinished()
	PayshopyearView.super.onExitFinished(self)
end

function PayshopyearView:_refresh()
	self.annuityId = PayShopModel.instance:getCurAnnuityId()

	local data = PayShopModel.instance:getAnnuityInfo(self.annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(self.annuityId)

	goutil.setActive(self._stateHasGet, data and data.active)
	goutil.setActive(self.gobtnActive, data and not data.active)

	if data and data.money >= cfg.price then
		self._activeGroup:SetState(1)

		self._txtActive.text = "激活"
	else
		self._activeGroup:SetState(0)

		self._txtActive.text = "充值"
	end

	local arr = string.split(cfg.weeklyGain, ":")

	self._txtNum.text = checknumber(arr[3])

	local fixedGain = string.split(cfg.fixedGain, "#")

	MaterialMgr.setCellByCfg(fixedGain[1], self.itemPoint[1])
	MaterialMgr.setCellByCfg(fixedGain[2], self.itemPoint[2])
	MaterialMgr.setCellByCfg(fixedGain[3], self.itemPoint[3])
	MaterialMgr.setCellByCfg(cfg.weeklyGain, self.itemPoint[4])
	MaterialMgr.setCellByCfg(cfg.dailyGain, self.itemPoint[5])
	goutil.setActive(self.goActiveRedPoint, data and data.money >= cfg.price)

	local hasGainWeeklyPrize = PayShopModel.instance:getHasGainWeeklyPrize(self.annuityId)

	if data and data.active and not hasGainWeeklyPrize then
		self.effectHandler = UIEffectManager.instance:playEffect(self, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", nil, nil, nil, true)

		self.effectHandler:setParent(self._periodEffect.transform)
		self.effectHandler:setScale(1)
		self.effectHandler:setLocalPos(0, 0, 0)
	else
		UIEffectManager.instance:stopEffect(self.effectHandler)
	end

	self:_updateChallengeRedPoint()
end

function PayshopyearView:_GainWeeklyPrize()
	PayShopController.instance:gainWeeklyPrize(self.annuityId, function()
		return
	end)
end

function PayshopyearView:_GainFixedPrize()
	PayShopController.instance:gainFixedPrize(self.annuityId, function()
		return
	end)
end

function PayshopyearView:_onClickSkillExplain()
	local fixedGain = PayShopConfig.instance:getAnnuityCfgById(self.annuityId).fixedGain
	local petId = tonumber(string.split(fixedGain, ":")[2])

	FuncOpenController.instance:openFunc(149, petId)
end

function PayshopyearView:_onClickPetinfoExplain()
	PayShopModel.instance:setRecordTag(true)

	local fixedGain = PayShopConfig.instance:getAnnuityCfgById(self.annuityId).fixedGain
	local petId = tonumber(string.split(fixedGain, ":")[2])

	PetbookController.instance:openPetinfoView(petId)
end

function PayshopyearView:_onClickTipRule()
	local ruleCo = RulesConfig.instance:getRuleCo("annuityrule")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

function PayshopyearView:_onClickKachi()
	local data = PayShopModel.instance:getAnnuityInfo(self.annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(self.annuityId)

	if data and data.active == true then
		FloatWordMgr.instance:show("【次元空间】专属UP召唤已开启")
	else
		FloatWordMgr.instance:show("成功激活年费卡后，\n将开启【万象·次元圣龙】专属UP召唤")
	end
end

function PayshopyearView:_onClickActive()
	local data = PayShopModel.instance:getAnnuityInfo(self.annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(self.annuityId)

	if data and data.money >= cfg.price then
		PayShopController.instance:activateAnnuity(self.annuityId)
	else
		UIStateManager.instance:popByName(ViewName.PayShopMainView)
		PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
	end
end

function PayshopyearView:_updateChallengeRedPoint()
	local fixedGain = PayShopConfig.instance:getAnnuityCfgById(self.annuityId).fixedGain
	local petId = tonumber(string.split(fixedGain, ":")[2])
	local isShowRedPoint = PetCollegeModel.instance:canBattleByRaceId(petId)

	GameUtil.SetActive(self._redpointChallenge, isShowRedPoint)
end

return PayshopyearView

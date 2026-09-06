-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdPetSkinXiuerView.lua

module("logic.extensions.activitypopup.view.HdPetSkinXiuerView", package.seeall)

local HdPetSkinXiuerView = class("HdPetSkinXiuerView", ViewComponent)

function HdPetSkinXiuerView:ctor()
	HdPetSkinXiuerView.super.ctor(self)
end

function HdPetSkinXiuerView:buildUI()
	HdPetSkinXiuerView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTryLY = self:getGo("skin1/btnTry")
	self.btnViewLY = self:getGo("skin1/btnView")
	self.btnPayLY = self:getGo("skin1/btnPay")
	self.txtLyPay = self:getTxt("skin1/btnPay/Text")
	self.lingquGoL = self:getGo("skin1/lingquGo")
	self.priceLY = self:getGo("skin1/btnPay/price")
	self.txtLyPay = self:getTxt("skin1/btnPay/Text")
	self.txtLYPayGo = self:getGo("skin1/btnPay/Text")
	self.txtLyPayOld = self:getTxt("skin1/btnPay/price/txtOld")
	self.txtLyPayNow = self:getTxt("skin1/btnPay/price/Now")
	self.btnObtainLy = self:getGo("skin1/btnObtain")
	self.leftItems = {}

	for i = 1, 10 do
		local go = self:getGo("skin1/item" .. i)

		if go then
			table.insert(self.leftItems, go)
		end
	end

	self.btnObtainXX = self:getGo("skin2/btnObtain")
	self.btnTryXX = self:getGo("skin2/btnTry")
	self.btnViewXX = self:getGo("skin2/btnView")
	self.btnPayXX = self:getGo("skin2/btnPay")
	self.lingquGoX = self:getGo("skin2/lingquGo")
	self.txtXXPayGo = self:getGo("skin2/btnPay/Text")
	self.priceXX = self:getGo("skin2/btnPay/price")
	self.txtXXPay = self:getTxt("skin2/btnPay/Text")
	self.txtXXPayOld = self:getTxt("skin2/btnPay/price/txtOld")
	self.txtXXPayNow = self:getTxt("skin2/btnPay/price/Now")
	self.txtTime = self:getTxt("time/txtTime")
	self.rightItems = {}

	for i = 1, 10 do
		local go = self:getGo("skin2/item" .. i)

		if go then
			table.insert(self.rightItems, go)
		end
	end

	self.btnHelp = self:getGo("btnHelp")
end

function HdPetSkinXiuerView:bindEvents()
	HdPetSkinXiuerView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTryLY, self.onTryLongyan, self)
	GameUtil.addClickHandler(self.btnTryXX, self.onTryXixi, self)
	GameUtil.addClickHandler(self.btnViewLY, self.onViewLeft, self)
	GameUtil.addClickHandler(self.btnViewXX, self.onViewRight, self)
	GameUtil.addClickHandler(self.btnObtainLy, GameUtil.handler(self.onObtain, self, self.leftId))
	GameUtil.addClickHandler(self.btnObtainXX, GameUtil.handler(self.onObtain, self, self.rightId))
	GameUtil.addClickHandler(self.btnPayLY, self.onPayLongyan, self)
	GameUtil.addClickHandler(self.btnPayXX, self.onPayXixi, self)
	GameUtil.addClickHandler(self.btnHelp, self.onClickHelp, self)
end

function HdPetSkinXiuerView:unbindEvents()
	HdPetSkinXiuerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTryLY)
	GameUtil.rmClickHandler(self.btnTryXX)
	GameUtil.rmClickHandler(self.btnObtainLy)
	GameUtil.rmClickHandler(self.btnObtainXX)
	GameUtil.rmClickHandler(self.btnPayLY)
	GameUtil.rmClickHandler(self.btnPayXX)
	GameUtil.rmClickHandler(self.btnHelp)
	GameUtil.rmClickHandler(self.btnViewLY)
	GameUtil.rmClickHandler(self.btnViewXX)
end

function HdPetSkinXiuerView:destroyUI()
	HdPetSkinXiuerView.super.destroyUI(self)
end

function HdPetSkinXiuerView:onEnter()
	HdPetSkinXiuerView.super.onEnter(self)

	local funcId = 289
	local cfg_multiple_skin = ActivityPopupConfig.instance:getLyXxMSkinCfg(funcId)

	if cfg_multiple_skin == nil or #cfg_multiple_skin == 0 then
		printError(string.format("无法读取配置，请检查 funcId为%s 的相关配置", funcId))

		return
	end

	self.leftId = cfg_multiple_skin.lyId1
	self.rightId = cfg_multiple_skin.lyId2

	local effPath = "fx_ui_2021930/fx_ui_xiandingpifu/fx_ui_xiandingpifu.prefab"

	self._effect = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._effect:setParent(self.mainGO.transform)
	self._effect:setLocalPos(10, 0, 0)
	self._effect:setScale(1)

	local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
	local openTime = funcCfg.openTime
	local times = string.split(openTime, "#")
	local startTime = GameUtil.string2time(times[1])
	local endTime = GameUtil.string2time(times[2])
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self.txtTime.text = string.format("%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	local cfg1 = ActivityPopupConfig.instance:getLyXxCfg(self.leftId)
	local extraPrize = cfg1.extraPrize
	local arr = string.split(extraPrize, "#")

	for i, go in ipairs(self.leftItems) do
		MaterialMgr.resetAll(go)
		GameUtil.rmClickHandler(go)

		local str = arr[i]

		if not string.nilorempty(str) then
			local matType, cfgId, num = MaterialMgr.getMatParams(str)

			MaterialMgr.setIcon(go, matType, cfgId)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:openMaterialTips(go, matType, cfgId)
			end)
		end
	end

	self.txtLyPay.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg1.normalPrice)
	self.txtLyPayOld.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg1.normalPrice)
	self.txtLyPayNow.text = " " .. PayConfig.instance:getPayMoneyYuan(cfg1.discountPrice)

	GameUtil.SetActive(self.btnPayLY, not PetskinController.instance:checkHasForeverSkinBySkinId(cfg1.skinId))
	GameUtil.SetActive(self.lingquGoL, PetskinController.instance:checkHasForeverSkinBySkinId(cfg1.skinId))

	local itemStr = cfg1.discountCost

	if not string.nilorempty(itemStr) then
		if MaterialMgr.getMatEnough(itemStr) then
			GameUtil.SetActive(self.priceLY, true)
			GameUtil.SetActive(self.txtLYPayGo, false)
			GameUtil.SetActive(self.btnObtainLy, false)
		else
			GameUtil.SetActive(self.priceLY, false)
			GameUtil.SetActive(self.txtLYPayGo, true)
			GameUtil.SetActive(self.btnObtainLy, true)
		end
	else
		GameUtil.SetActive(self.priceLY, false)
		GameUtil.SetActive(self.txtLYPayGo, true)
		GameUtil.SetActive(self.btnObtainLy, false)
	end

	GameUtil.SetActive(self.btnObtainLy, false)

	local cfg2 = ActivityPopupConfig.instance:getLyXxCfg(self.rightId)
	local extraPrize = cfg1.extraPrize
	local arr = string.split(extraPrize, "#")

	for i, go in ipairs(self.rightItems) do
		MaterialMgr.resetAll(go)

		local str = arr[i]

		GameUtil.rmClickHandler(go)

		if not string.nilorempty(str) then
			local matType, cfgId, num = MaterialMgr.getMatParams(str)

			MaterialMgr.setIcon(go, matType, cfgId)
			GameUtil.addClickHandler(go, function()
				CommonTipsMgr.instance:openMaterialTips(go, matType, cfgId)
			end)
		end
	end

	self.txtXXPay.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg2.normalPrice)
	self.txtXXPayOld.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg2.normalPrice)
	self.txtXXPayNow.text = " " .. PayConfig.instance:getPayMoneyYuan(cfg2.discountPrice)

	GameUtil.SetActive(self.btnPayXX, not PetskinController.instance:checkHasForeverSkinBySkinId(cfg2.skinId))
	GameUtil.SetActive(self.lingquGoX, PetskinController.instance:checkHasForeverSkinBySkinId(cfg2.skinId))

	local itemStr = cfg2.discountCost

	if not string.nilorempty(itemStr) then
		if MaterialMgr.getMatEnough(itemStr) then
			GameUtil.SetActive(self.priceXX, true)
			GameUtil.SetActive(self.txtXXPayGo, false)
			GameUtil.SetActive(self.btnObtainXX, false)
		else
			GameUtil.SetActive(self.priceXX, false)
			GameUtil.SetActive(self.txtXXPayGo, true)
			GameUtil.SetActive(self.btnObtainXX, true)
		end
	else
		GameUtil.SetActive(self.priceXX, false)
		GameUtil.SetActive(self.txtXXPayGo, true)
		GameUtil.SetActive(self.btnObtainXX, false)
	end

	GameUtil.SetActive(self.btnObtainXX, false)
end

function HdPetSkinXiuerView:onEnterFinished()
	HdPetSkinXiuerView.super.onEnterFinished(self)
end

function HdPetSkinXiuerView:onExit()
	HdPetSkinXiuerView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effect)

	self._effect = nil
end

function HdPetSkinXiuerView:onExitFinished()
	HdPetSkinXiuerView.super.onExitFinished(self)
end

function HdPetSkinXiuerView:onObtain(id)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_XIXI_GIFT)

	local cfg = ActivityPopupConfig.instance:getLyXxCfg(id)
	local itemStr = cfg.discountCost

	MaterialMgr.openGetSourceByStr(itemStr)
end

function HdPetSkinXiuerView:onPayLongyan()
	local cfg1 = ActivityPopupConfig.instance:getLyXxCfg(self.leftId)
	local skinName = PetSkinConfig.instance:getPetSkinName(cfg1.skinId)
	local itemStr = cfg1.discountCost

	if not PetskinController.instance:checkHasForeverSkinBySkinId(cfg1.skinId) then
		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = self.leftId

		if not string.nilorempty(itemStr) then
			if MaterialMgr.getMatEnough(itemStr) then
				PayController.instance:pay(cfg1.discountPrice, subGoodsType, subGoodsId)
			else
				PayController.instance:pay(cfg1.normalPrice, subGoodsType, subGoodsId)
			end
		else
			PayController.instance:pay(cfg1.normalPrice, subGoodsType, subGoodsId)
		end
	else
		TipsFacade.instance:openCommonTips(langPara("已经拥有%s,不需要购买", skinName))
	end
end

function HdPetSkinXiuerView:onPayXixi()
	local cfg2 = ActivityPopupConfig.instance:getLyXxCfg(self.rightId)
	local itemStr = cfg2.discountCost
	local skinName = PetSkinConfig.instance:getPetSkinName(cfg2.skinId)

	if not PetskinController.instance:checkHasForeverSkinBySkinId(cfg2.skinId) then
		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = self.rightId

		if not string.nilorempty(itemStr) then
			if MaterialMgr.getMatEnough(itemStr) then
				PayController.instance:pay(cfg2.discountPrice, subGoodsType, subGoodsId)
			else
				PayController.instance:pay(cfg2.normalPrice, subGoodsType, subGoodsId)
			end
		else
			PayController.instance:pay(cfg2.normalPrice, subGoodsType, subGoodsId)
		end
	else
		TipsFacade.instance:openCommonTips(langPara("已经拥有%s,不需要购买", skinName))
	end
end

function HdPetSkinXiuerView:onClickHelp()
	local cfgKey = ActivityPopupConfig.instance:getLyxxCommonValue("PET_SKIN_RULES_KEY")

	UIStateManager.instance:open(ViewName.RulesView, cfgKey)
end

function HdPetSkinXiuerView:onViewLeft()
	local cfg = ActivityPopupConfig.instance:getLyXxCfg(self.leftId)
	local skinId = cfg.skinId

	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, skinId)
end

function HdPetSkinXiuerView:onViewRight()
	local cfg = ActivityPopupConfig.instance:getLyXxCfg(self.rightId)
	local skinId = cfg.skinId

	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, skinId)
end

function HdPetSkinXiuerView:onTryLongyan()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_TRY_LONGYAN)
	self:goTryBattle(self.leftId)
end

function HdPetSkinXiuerView:onTryXixi()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_TRY_XIXI)
	self:goTryBattle(self.rightId)
end

function HdPetSkinXiuerView:goTryBattle(id)
	local cfg = ActivityPopupConfig.instance:getLyXxCfg(id)
	local skinId = cfg.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

return HdPetSkinXiuerView

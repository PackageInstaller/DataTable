-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/LongGuGiftView.lua

module("logic.extensions.dressactivityshop.view.LongGuGiftView", package.seeall)

local LongGuGiftView = class("LongGuGiftView", ViewComponent)

function LongGuGiftView:buildUI()
	LongGuGiftView.super.buildUI(self)

	self._btnBuy = self:getGo("btnBuy")
	self._txtGiftCost = goutil.findChildTextComponent(self._btnBuy, "Text")
	self._goTag = self:getGo("tag")
	self._txtTag = self:getTxt("tag/txt")
	self._txtActTime = self:getTxt("txtTime")
	self._giftCellList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("com_" .. i)
		cell.cfg = nil
		cell.role = nil
		cell.roleCom = goutil.findChild(cell.go, "role")
		cell.petInfo = goutil.findChild(cell.go, "petInfo")
		cell.btnSkill = goutil.findChild(cell.petInfo, "btnSkill")
		cell.btnBuy = goutil.findChild(cell.go, "btnBuy")
		cell.markHasBuy = goutil.findChild(cell.go, "markHasBuy")
		cell.txtCost = goutil.findChildTextComponent(cell.btnBuy, "Text")
		cell.txtName = goutil.findChildTextComponent(cell.go, "petInfo/txtName")
		cell.rare = goutil.findChild(cell.go, "petInfo/rare")
		cell.hasBuy = false
		self._giftCellList[i] = cell
	end

	self._bgGo = self:getGo("bg")
	self._txtDesc1 = self:getTxt("com_1/tip/txt")
	self._txtDesc2 = self:getTxt("com_2/tip/txt")
	self._txtDesc3 = self:getTxt("txtTip")
	self._txtDesc4 = self:getTxt("com_2/btnBuy/tip1/txt")
	self._txtDesc5 = self:getTxt("com_2/btnBuy/tip2/txt")
	self._btnOriginEvelop = self:getGo("btnOriginEvelop")
end

function LongGuGiftView:bindEvents()
	LongGuGiftView.super.bindEvents(self)

	for k, v in ipairs(self._giftCellList) do
		GameUtil.addClickHandler(v.btnSkill, GameUtil.handler(self._onClickSkill, self, k))
		GameUtil.addClickHandler(v.btnBuy, GameUtil.handler(self._onClickBuy, self, k))
	end

	GameUtil.addClickHandler(self._btnOriginEvelop, self._onClickBtnOriginEvelop, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuyGift, self)
end

function LongGuGiftView:unbindEvents()
	LongGuGiftView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnOriginEvelop)

	for k, v in ipairs(self._giftCellList) do
		GameUtil.rmClickHandler(v.btnSkill)
		GameUtil.rmClickHandler(v.btnBuy)
	end
end

function LongGuGiftView:onEnter()
	LongGuGiftView.super.onEnter(self)

	self._actId = checkint(self:getFirstParam())

	if self._actId and ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DressActivityShopGodGem, self._actId) then
		self:_onGetPayTrussInfo()
		self:refreshViewByCfg()
		self:_loadBgImage()
		self:_updateTxtInfo()
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	GlobalDispatcher:addListener(PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes, self._onGetPayTrussInfo, self)
	GlobalDispatcher:addListener(PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes, self.refreshViewByInfo, self)

	if self._actId == 120016 then
		self.addGEvent(self, GlobalNotify.DE_UpdataFreeZoneInfo, self.refreshViewByInfo, self)
		DoubleElevenController.instance:csGetFreePayStoreGetInfoReq(211003)
	end

	if self._actId == 120019 then
		GameUtil.SetActive(self._giftCellList[2].btnSkill, false)
	else
		GameUtil.SetActive(self._giftCellList[2].btnSkill, true)
	end
end

function LongGuGiftView:onExit()
	LongGuGiftView.super.onExit(self)
	GlobalDispatcher:removeListener(PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes, self._onGetPayTrussInfo, self)
	GlobalDispatcher:removeListener(PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes, self.refreshViewByInfo, self)

	for k, v in ipairs(self._giftCellList) do
		v.role = RoleObjectPool.instance:removeRole(v.role)

		MaterialMgr.resetAll(v.rare)
	end

	removetimer(self._onCountDown, self)
	self:_clearBgImage()
end

function LongGuGiftView:refreshViewByCfg()
	local singleCfgs = DressActivityShopGodGemConfig.instance:getSingleCfgByActId(self._actId)

	for k, v in ipairs(self._giftCellList) do
		v.cfg = singleCfgs[k]

		if v.cfg then
			v.role = RoleObjectPool.instance:addRoleToParent(v.role, v.cfg.skinId, v.roleCom, 1)

			local matType, id, matNum = MaterialMgr.getMatParams(v.cfg.price)

			v.txtCost.text = langPara("%s%s", matNum, MaterialMgr.getMaterialsName(matType, id))

			local skinId = v.cfg.skinId

			v.txtName.text = PetSkinConfig.instance:getPetSkinName(skinId)

			MaterialMgr.setCell(MatType.PetSkin_Rare, skinId, v.rare)
		end
	end

	self._actTimeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.DressActivityShopGodGem, self._actId)

	if self._actTimeCfg then
		removetimer(self._onCountDown, self)

		self._curEndTime = GameUtil.string2time(self._actTimeCfg.endTime)

		self:_onCountDown()
		settimer(1, self._onCountDown, self)
	end
end

function LongGuGiftView:refreshViewByInfo()
	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self._actId, hasPurchasedIds)

	if cfg_line_coalition then
		local matType, id, matNum = MaterialMgr.getMatParams(cfg_line_coalition.price)

		self._txtTag.text = langPara("限时\n%s折", cfg_line_coalition.showDiscount)

		goutil.setActive(self._goTag, true)

		self._txtGiftCost.text = langPara("%s%s", matNum, MaterialMgr.getMaterialsName(matType, id))
	else
		self._txtGiftCost.text = lang("已购买")

		goutil.setActive(self._goTag, false)
	end

	local hasBuy9 = false
	local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(9)

	if info and info.buyTime and info.buyTime > 0 then
		local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(3, 9)

		if info.buyTime >= cfg.personLimit then
			hasBuy9 = true
		end
	end

	for k, v in pairs(self._giftCellList) do
		local isHasBuy = table.indexof(hasPurchasedIds, k)

		if not isHasBuy and hasBuy9 then
			isHasBuy = true
		elseif not isHasBuy and self._actId == 120016 then
			local itemId = 7

			if k == 2 then
				itemId = 8
			end

			local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(itemId)

			if info and info.buyTime and info.buyTime > 0 then
				local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(3, itemId)

				if info.buyTime >= cfg.personLimit then
					isHasBuy = true
				end
			end
		end

		goutil.setActive(v.markHasBuy, isHasBuy)
	end
end

function LongGuGiftView:_onGetPayTrussInfo()
	PayTrussGodGemController.instance:_sendPayTrussGodGemInfoReq(self._actId)
end

function LongGuGiftView:_onClickSkill(id)
	local cell = self._giftCellList[id]

	if cell then
		::label_9_0::

		local var_9_0 = cell.cfg

		if cell.cfg then
			local skinId = cell.cfg.skinId
			local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if skinCfg then
				local raceId = skinCfg.raceId

				PetbookController.instance:previewBattle(raceId, skinId)
			end
		end
	end
end

function LongGuGiftView:_onClickBuy(id)
	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local isHasBuy = table.indexof(hasPurchasedIds, id)

	if isHasBuy then
		FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

		return
	end

	local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(9)

	if info and info.buyTime > 0 then
		local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(3, 9)

		if info.buyTime >= cfg.personLimit then
			FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

			return
		end
	end

	if self._actId == 120016 then
		local itemId = 7

		if id == 2 then
			itemId = 8
		end

		local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(itemId)

		if info and info.buyTime > 0 then
			local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(3, itemId)

			if info.buyTime >= cfg.personLimit then
				FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

				return
			end
		end

		UIStateManager.instance:popByName(ViewName.PreferentialView)
		GotoMgr.gotoByString("func#545#54")

		return
	end

	local value = ""
	local tips = ""
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self._actId, hasPurchasedIds)
	local price = self._giftCellList[id].cfg.price
	local matType, matId, matNum = MaterialMgr.getMatParams(price)

	if cfg_line_coalition == nil then
		value = string.split(price, ":")[3] or "错误配置"

		local conStr = MaterialMgr.getContentMatStr(price, 40, -10, MaterialMgr.ICON_TYPE_ICON)

		tips = string.format("确定花费%s%s，购买%s吗？", value, conStr, self._giftCellList[id].cfg.name)
	else
		local simValue = string.split(price, ":")[3] or "错误配置"
		local conStr = MaterialMgr.getContentMatStr(price, 40, -10, MaterialMgr.ICON_TYPE_ICON)

		value = string.split(cfg_line_coalition.price, ":")[3] or "错误配置"
		tips = string.format("确定花费%s%s购买%s，购买该礼包后将无法以%s%s一键购买全部礼包，是否继续？", simValue, conStr, self._giftCellList[id].cfg.name, value, conStr)
	end

	local function okFunc()
		local buyId = id

		PayTrussGodGemController.instance:_sendPM_PayTrussGodGemBuyReq(self._actId, buyId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, tips, okFunc)
end

function LongGuGiftView:_onClickBuyGift()
	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()
	local cfg_line_coalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActIdAndHasOwnTab(self._actId, hasPurchasedIds)

	if cfg_line_coalition == nil then
		FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

		return
	end

	if self._actId == 120016 then
		for i = 7, 9 do
			local itemId = i
			local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(itemId)

			if info and info.buyTime > 0 then
				local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(3, itemId)

				if info.buyTime >= cfg.personLimit then
					FloatWordMgr.instance:show(lang("text_buy_you_have_purchased"))

					return
				end
			end
		end

		UIStateManager.instance:popByName(ViewName.PreferentialView)
		GotoMgr.gotoByString("func#545#54")

		return
	end

	local price = cfg_line_coalition.price
	local matType, matId, matNum = MaterialMgr.getMatParams(price)
	local matNameArr = {}
	local singleCfgs = DressActivityShopGodGemConfig.instance:getSingleCfgByActId(self._actId) or {}

	for i, v in ipairs(singleCfgs) do
		table.insert(matNameArr, v.name)
	end

	local content = langPara("确定要花费%s神钻，打包购买%s吗？", matNum, table.concat(matNameArr, "+"))

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		local buyId = -1

		PayTrussGodGemController.instance:_sendPM_PayTrussGodGemBuyReq(self._actId, buyId)
	end)
end

function LongGuGiftView:_onClickBtnOriginEvelop()
	GotoMgr.gotoByString("func#1292")
end

function LongGuGiftView:_onCountDown()
	local timeLeft = self._curEndTime - ServerTime.now()

	if timeLeft > 0 then
		self._txtActTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(timeLeft))
	else
		FloatWordMgr.instance:show(lang("当前活动结束"))
		self:close()
	end
end

function LongGuGiftView:_loadBgImage()
	local cfgLineCoalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActId(self._actId)

	if cfgLineCoalition then
		uGuiUtil.setSpriteToImage(self._bgGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfgLineCoalition.bgName))
	end
end

function LongGuGiftView:_clearBgImage()
	uGuiUtil.clearImage(self._bgGo)
end

function LongGuGiftView:_updateTxtInfo()
	local cfgLineCoalition = DressActivityShopGodGemConfig.instance:getSuitCfgByActId(self._actId)

	if cfgLineCoalition then
		self._txtDesc1.text = cfgLineCoalition.desc1
		self._txtDesc2.text = cfgLineCoalition.desc2
		self._txtDesc3.text = cfgLineCoalition.desc3
		self._txtDesc4.text = cfgLineCoalition.desc4
		self._txtDesc5.text = cfgLineCoalition.desc5
	end
end

return LongGuGiftView

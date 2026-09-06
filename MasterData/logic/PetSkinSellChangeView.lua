-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/petskinsell/PetSkinSellChangeView.lua

module("logic.extensions.firstcharge.view.petskinsell.PetSkinSellChangeView", package.seeall)

local PetSkinSellChangeView = class("PetSkinSellChangeView", ViewComponent)

PetSkinSellChangeView.ItemNum = 4

function PetSkinSellChangeView:buildUI()
	PetSkinSellChangeView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bgImg = self:getImg("bgImg")
	self._sloganImg = self:getImg("sloganImg")
	self._limitImg = self:getImg("limitImg")
	self._roleGo = self:getGo("role")
	self._btnSkill = self:getBtn("btnSkill")
	self._bgImgRectTrans = self._bgImg:GetComponent(goutil.Type_RectTransform)
	self._sloganImgRectTrans = self._sloganImg:GetComponent(goutil.Type_RectTransform)
	self._btnSkillRectTrans = self._btnSkill:GetComponent(goutil.Type_RectTransform)
	self._roleRectTrans = self._roleGo:GetComponent(goutil.Type_RectTransform)
	self._items = {}

	for i = 1, PetSkinSellChangeView.ItemNum do
		local element = {}
		local go = self:getGo("item" .. i)

		element.go = go
		element.btn = Framework.ButtonAdapter.Get(go)
		element.icon = goutil.findChild(go, "icon")
		element.txtNum = goutil.findChildTextComponent(go, "txtNum")
		self._items[i] = element
	end

	self._btnBuy = self:getBtn("btnBuy")
	self._txtPrize = self:getTxt("btnBuy/Text")
	self._txtTime = self:getTxt("txtTime")
	self._txtTime2 = self:getTxt("txtTime2")
	self._txtSkinDesc = self:getTxt("skinDesc")
	self._btnShopGoto = self:getGo("btnShopGoto")
	self._btnOtherGoto = self:getGo("btnOtherGoto")
	self._tag = goutil.findChild(self._btnBuy, "tag")
	self._txtTag = goutil.findChildTextComponent(self._tag, "txt")
	self._oldPrice = self:getGo("txtOldPrice")
	self._txtOldPrice = self:getTxt("txtOldPrice")
	self._fullBgImgGo = self:getGo("fullBgImg")
end

function PetSkinSellChangeView:bindEvents()
	PetSkinSellChangeView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnShopGoto, self._onClickGotoShop, self)
	GameUtil.addClickHandler(self._btnOtherGoto, self._onClickGotoOther, self)
end

function PetSkinSellChangeView:unbindEvents()
	PetSkinSellChangeView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnShopGoto)
	GameUtil.rmClickHandler(self._btnOtherGoto)
end

function PetSkinSellChangeView:onEnter()
	PetSkinSellChangeView.super.onEnter(self)
	GlobalDispatcher:addListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)

	self._curSelectCfg = nil

	local id = checknumber(self:getFirstParam())

	if id and id > 0 then
		local list = self:_getAvailableSkinCfgs()

		for i, v in ipairs(list) do
			if v.id == id then
				self._curSelectCfg = v

				break
			end
		end
	end

	self:_updateView()
	settimer(1, self._onSecond, self)
end

function PetSkinSellChangeView:onExit()
	PetSkinSellChangeView.super.onExit(self)
	GlobalDispatcher:removeListener(ClockMgr.TickDailyRefresh, self._onFiveClockRefresh, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	removetimer(self._onSecond, self)
end

function PetSkinSellChangeView:onExitFinished()
	self:_removeRole()

	for i = 1, PetSkinSellChangeView.ItemNum do
		MaterialMgr.clearIcon(self._items[i].icon)
	end

	self:_clearImage()
end

function PetSkinSellChangeView:_onClickBuy()
	if self._curSelectCfg == nil then
		return
	end

	if self._hasBuy then
		self._txtPrize.text = "已购买"

		FloatWordMgr.instance:show("已售罄")

		return
	end

	if self._curSelectCfg.shopType == 1 then
		if self._curSelectCfg then
			if not self._curSelectCfg.shopId then
				local id = 0

				if not self._hasBuyTimes then
					local data = {
						id = id,
						times = self._hasBuyTimes
					}

					UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
				end
			end
		end
	elseif self._curSelectCfg.shopType == 2 then
		local goodsCfg = ActivityPopupConfig.instance:getLyXxCfg(self._curSelectCfg.shopId)
		local price = ""
		local strArr = string.split(goodsCfg.discountCost, ":")

		price = MaterialMgr.getModel(strArr[1], strArr[2]) and goodsCfg.discountPrice or goodsCfg.normalPrice

		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = self._curSelectCfg.shopId

		PayController.instance:pay(price, subGoodsType, subGoodsId)

		local status, msg = 0

		self:handlePayShopItemBuySucRes(status, msg)
	end
end

function PetSkinSellChangeView:_onClickSkill()
	if self._curSelectCfg == nil then
		return
	end

	local skinId = self:_getSkinId(self._curSelectCfg.shopId)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, skinId)
	end
end

function PetSkinSellChangeView:_updateView()
	if self._curSelectCfg then
		self:_updateBuyInfo(self._curSelectCfg)
	else
		self:_showClosePopupView()
	end
end

function PetSkinSellChangeView:_getAvailableSkinCfgs()
	local cfgs = PetSkinConfig.instance:getPetSkinSellCfgs()

	if cfgs then
		local resultList = {}

		for i, v in ipairs(cfgs) do
			local timeStrs = string.split(v.time, "#")

			if timeStrs and timeStrs[1] and timeStrs[2] and GameUtil.checkIsInTimePeriod(timeStrs[1], timeStrs[2]) then
				table.insert(resultList, v)
			end
		end

		return resultList
	else
		return {}
	end
end

function PetSkinSellChangeView:_showClosePopupView()
	removetimer(self._onSecond, self)

	local content = "当前不在活动时间内哦"
	local btnText = "知道了"

	local function func()
		self:close()
	end

	TipsFacade.instance:openTipWindow(lang("tip"), content, func, btnText)
end

function PetSkinSellChangeView:_updateBuyInfo(cfg)
	if cfg == nil then
		return
	end

	self._curSelectCfg = cfg

	self:_updateImage(cfg)
	self:_updateImgRect(cfg)
	self:_loadRole(cfg.shopId)
	self:_updateSkinDesc(cfg.desc)
	goutil.setActive(self._tag, false)

	local goodsCfg

	if self._curSelectCfg.shopType == 1 then
		goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfg.shopId)
	elseif self._curSelectCfg.shopType == 2 then
		goodsCfg = ActivityPopupConfig.instance:getLyXxCfg(cfg.shopId)
	end

	if goodsCfg == nil then
		return
	end

	local prizes = ""

	if self._curSelectCfg.shopType == 1 then
		prizes = MaterialMgr.changeItemStrArr(goodsCfg.content)

		GameUtil.SetActive(self._oldPrice, goodsCfg.showOldPrice > 0)

		local matType, matId, matNum = MaterialMgr.getMatParams(goodsCfg.originalGoodsId)

		self._txtOldPrice.text = langPara("原价%s%s", matNum, MaterialMgr.getMaterialsName(matType, matId))
	elseif self._curSelectCfg.shopType == 2 then
		local skinStr = "17:" .. goodsCfg.skinId .. ":-1:1"
		local content = skinStr .. "#" .. goodsCfg.extraPrize

		prizes = MaterialMgr.changeItemStrArr(content)

		GameUtil.SetActive(self._oldPrice, true)
	end

	for i = 1, PetSkinSellChangeView.ItemNum do
		GameUtil.rmClickHandler(self._items[i].icon)
		MaterialMgr.clearIcon(self._items[i].icon)

		if not GameUtil.isEmptyString(prizes[i]) then
			goutil.setActive(self._items[i].go, true)

			self._items[i].matStr = prizes[i]

			MaterialMgr.updateItemByStr(self._items[i].icon, prizes[i])
			GameUtil.addClickHandler(self._items[i].icon, function()
				if self._items and self._items[i] and not goutil.isNil(self._items[i].go) then
					CommonTipsMgr.instance:openTipsByConfStr(self._items[i].go, prizes[i])
				end
			end)

			local matType, matId, matNum = MaterialMgr.getMatParams(prizes[i])

			self._items[i].txtNum.text = matNum <= 1 and "" or "x" .. matNum
		else
			goutil.setActive(self._items[i].go, false)
		end
	end

	local cost

	if self._curSelectCfg.shopType == 1 then
		cost = goodsCfg.originalGoodsId

		local showDiscount = goodsCfg.disCount

		if showDiscount > 0 then
			goutil.setActive(self._tag, true)

			self._txtTag.text = langPara("%s折", checknumber(showDiscount / 100))
		end

		local disCountPlanId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(goodsCfg.id)

		if disCountPlanId > 0 then
			local dcfg = PayShopConfig.instance:getDiscountPlanCfg(disCountPlanId)

			cost = dcfg and dcfg.discountPrice
		end
	elseif self._curSelectCfg.shopType == 2 then
		local price = ""

		if not string.nilorempty(goodsCfg.discountCost) then
			local strArr = string.split(goodsCfg.discountCost, ":")

			price = MaterialMgr.getModel(strArr[1], strArr[2]) and goodsCfg.discountPrice or goodsCfg.normalPrice
		else
			price = goodsCfg.normalPrice
		end

		cost = price
	end

	local costRmb = PayConfig.instance:getPayMoneyYuan(cost)

	if costRmb <= 0 then
		local matType, matId, matNum = MaterialMgr.getMatParams(cost)

		self._txtPrize.text = langPara("%s%s", matNum, MaterialMgr.getMaterialsName(matType, matId))
	else
		self._txtPrize.text = costRmb .. "元"
	end

	self:_updateBtnBuyInfo()
	self:_updateTimeTxt()
	goutil.setActive(self._btnShopGoto, not string.nilorempty(cfg.shopGoto))
	goutil.setActive(self._btnOtherGoto, not string.nilorempty(cfg.otherGoto))
	self:_firstPlayAni()
end

function PetSkinSellChangeView:_updateSkinDesc(desc)
	self._txtSkinDesc.text = desc
end

function PetSkinSellChangeView:_onFiveClockRefresh()
	self:_updateView()
end

function PetSkinSellChangeView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:_updateBtnBuyInfo()
	end
end

function PetSkinSellChangeView:_onSecond()
	self:_updateTimeTxt()
end

function PetSkinSellChangeView:_updateBtnBuyInfo()
	if self._curSelectCfg == nil then
		return
	end

	if self._curSelectCfg.shopType == 1 then
		local times = PayShopModel.instance:getMibaoBuyTimesById(self._curSelectCfg.shopId)

		self._hasBuyTimes = times

		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._curSelectCfg.shopId)

		self._hasBuy = goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 and times and times >= goodsCfg.limitTimes
	elseif self._curSelectCfg.shopType == 2 then
		self._hasBuyTimes = 999999

		local skinId = self:_getSkinId(self._curSelectCfg.shopId)

		self._hasBuy = PetskinController.instance:checkHasForeverSkinBySkinId(skinId)
	end

	GameUtil.SetGray(self._btnBuy.gameObject, self._hasBuy)

	if self._hasBuy then
		self._txtPrize.text = "已购买"
	end
end

function PetSkinSellChangeView:_updateTimeTxt()
	if self._curSelectCfg == nil then
		return
	end

	local timeStrs = string.split(self._curSelectCfg.time, "#")

	if timeStrs and timeStrs[1] and timeStrs[2] then
		local startTime = GameUtil.string2time(timeStrs[1])
		local endTime = GameUtil.string2time(timeStrs[2])
		local startDate = GameUtil.time2date(startTime)
		local endDate = GameUtil.time2date(endTime)
		local leftTime = endTime - ServerTime.now()

		leftTime = leftTime > 0 and leftTime or 0
		self._txtTime.text = GameUtil.FormatTimeSymbol(leftTime)
		self._txtTime2.text = string.format("%02d月%02d日 ~ %02d月%02d日", startDate.month, startDate.day, endDate.month, endDate.day)
	end
end

function PetSkinSellChangeView:_updateImage(cfg)
	goutil.setActive(self._fullBgImgGo, cfg.isBgFull)

	if cfg.isBgFull then
		uGuiUtil.setSpriteToImage(self._fullBgImgGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.bgImg))
	else
		uGuiUtil.setSpriteToImage(self._bgImg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.bgImg), function()
			return
		end)
	end

	uGuiUtil.setSpriteToImage(self._sloganImg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.sloganImg), function()
		if not goutil.isNil(self._sloganImg) then
			self._sloganImg:SetNativeSize()
		end
	end)
	uGuiUtil.setSpriteToImage(self._limitImg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/bgskin/%s.png", cfg.limitImg), function()
		if not goutil.isNil(self._limitImg) then
			self._limitImg:SetNativeSize()
		end
	end)
end

function PetSkinSellChangeView:_clearImage()
	Framework.ImageBigBG.Get(self._bgImg.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._sloganImg.gameObject):ClearImage()
	Framework.ImageBigBG.Get(self._limitImg.gameObject):ClearImage()
end

function PetSkinSellChangeView:_updateImgRect(cfg)
	Framework.TransformUtil.SetAnchoredPos(self._bgImgRectTrans, cfg.bgPos[1], cfg.bgPos[2])
	Framework.TransformUtil.SetAnchoredPos(self._sloganImgRectTrans, cfg.sloganPos[1], cfg.sloganPos[2])
	Framework.TransformUtil.SetAnchoredPos(self._btnSkillRectTrans, cfg.skillIconPos[1], cfg.skillIconPos[2])
	Framework.TransformUtil.SetAnchoredPos(self._roleRectTrans, cfg.rolePos[1], cfg.rolePos[2])
	Framework.TransformUtil.SetLocalScale(self._roleRectTrans, cfg.roleScale[1], cfg.roleScale[2], cfg.roleScale[3])

	self._roleRectTrans.sizeDelta = Vector2.New(cfg.roleRect[1], cfg.roleRect[2])
end

function PetSkinSellChangeView:_getSkinId(shopId)
	local skinId = 0

	if self._curSelectCfg.shopType == 1 then
		local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopId)

		if not cfg then
			return 0
		end

		local arr = string.split(cfg.content, "#")
		local itemArr = string.split(arr[1], ":")

		skinId = itemArr[2] or 0
	elseif self._curSelectCfg.shopType == 2 then
		local cfg = ActivityPopupConfig.instance:getLyXxCfg(shopId)

		skinId = cfg and cfg.skinId or 0
	end

	return checknumber(skinId)
end

function PetSkinSellChangeView:_loadRole(shopId)
	local skinId = self:_getSkinId(shopId)

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleGo, 1)
end

function PetSkinSellChangeView:_removeRole()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PetSkinSellChangeView:_onClickGotoShop()
	if self._curSelectCfg == nil then
		return
	end

	GotoMgr.gotoByString(self._curSelectCfg.shopGoto)
end

function PetSkinSellChangeView:_onClickGotoOther()
	if self._curSelectCfg == nil then
		return
	end

	GotoMgr.gotoByString(self._curSelectCfg.otherGoto)
end

function PetSkinSellChangeView:_firstPlayAni()
	if self._curSelectCfg == nil then
		return
	end

	local aniPath = self._curSelectCfg.aniPath

	if not string.nilorempty(aniPath) then
		local playerDataKey = "petskinsellchangeview_animation" .. self._curSelectCfg.id

		if checknumber(GameUtil.getUserDayData(playerDataKey)) <= 0 then
			GameUtil.saveUserDayData(playerDataKey, 1)

			local animConfig = {
				passable = false,
				animName = aniPath,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
		end
	end
end

return PetSkinSellChangeView

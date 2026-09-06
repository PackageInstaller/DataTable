-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressPreView.lua

module("logic.extensions.dressactivityshop.view.DiscountDressPreView", package.seeall)

local DiscountDressPreView = class("DiscountDressPreView", ViewComponent)

function DiscountDressPreView:ctor()
	DiscountDressPreView.super.ctor(self)
end

function DiscountDressPreView:unbindEvents()
	DiscountDressPreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnPreview)
	self._drag:RemoveDragListener()

	for id, cell in ipairs(self._collectCells) do
		GameUtil.rmClickHandler(cell.btnGoto)
		GameUtil.rmClickHandler(cell.btnReceive)
	end
end

function DiscountDressPreView:bindEvents()
	DiscountDressPreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickPreview, self)
	self._drag:AddDragListener(self._onDrag, self)

	for id, cell in ipairs(self._collectCells) do
		GameUtil.addClickHandler(cell.btnGoto, GameUtil.handler(self._onClickGoto, self, id))
		GameUtil.addClickHandler(cell.btnReceive, GameUtil.handler(self._onClickReceive, self, id))
	end
end

function DiscountDressPreView:buildUI()
	DiscountDressPreView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._btnBuy = self:getBtn("btnBuy")
	self._goRole = self:getGo("modsFrame")
	self._drag = Framework.UIDragTrigger.Get(goutil.findChild(self._goRole, "rayTrigger"))
	self._btnRight = goutil.findChild(self._goRole, "btnRight")
	self._btnLeft = goutil.findChild(self._goRole, "btnLeft")
	self._btnPreview = self:getBtn("collect/preview/btnGoto")
	self._sellTip = self:getGo("sellTip")
	self._txtSellTip = self:getTxt("sellTip/txt")
	self._tag = self:getGo("tag")
	self._txtTag = self:getTxt("tag/txt")
	self._txtOldPrice = self:getTxt("txtOldPrice")
	self._txtHasBuy = self:getTxt("txtHasBuy")
	self._txtTip = self:getTxt("tip/txtTip")
	self._txtPrice = self:getTxt("btnBuy/txt")
	self._collectCells = {}

	for i = 1, 3 do
		local cell = {}

		cell.btnGoto = self:getBtn("collect/cell_" .. i .. "/btnGoto")
		cell.btnReceive = self:getBtn("collect/cell_" .. i .. "/btnReceive")
		cell.receive = self:getGo("collect/cell_" .. i .. "/receive")
		cell.redPoint = self:getGo("collect/cell_" .. i .. "/redPoint")

		table.insert(self._collectCells, cell)
	end
end

function DiscountDressPreView:onExit()
	DiscountDressPreView.super.onExit(self)
	self._photoEff:clear()

	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnSetParentFinish, self.onFemaleLoadEnd, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function DiscountDressPreView:onEnter()
	DiscountDressPreView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DiscountDressMoorInfoUpdate, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DressDisscountGainCollectPrizeRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.DiscountDressMoorBuyError, self._onBuyItemError, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MoorDiscountDressGift)

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("此时间段无可售卖的套装哦~")
		self:close()

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.MoorDiscountDressGift, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
	self._photoEff = AvatarPhotoShow.Get(goutil.findChild(self._goRole, "con"))

	self._photoEff:setRawWidthAndHeight(1280, 720)
	self._photoEff:setCameraPosition(5, 1.1, -2)
	self._photoEff:setCamSize(1.2)
	self._photoEff:setRTAdjust(1, 1, 1, 0.45)
	self:_initInfo()
	self:_sendGetInfoReq()
	self:_showRoleModel()
end

function DiscountDressPreView:_sendGetInfoReq()
	DressSellController.instance:sendGetDressDiscountInfo(self._activityId)
end

function DiscountDressPreView:_initInfo()
	self._currId = 1
	self._curCost = nil
	self._curGapId = 0
	self._isBuy = false
	self._isCanBuy = DressSellController.instance:checkIsAfterCfgTime(self._activityId, self._currId)
	self._discountCfg = DressSellConfig.instance:getDiscountCfgById(self._activityId, self._currId)

	GameUtil.SetActive(self._sellTip, not self._isCanBuy)

	self._txtTip.text = self._discountCfg.desc
	self._costType = self._discountCfg.type

	local curCost

	if self._costType == 1 then
		curCost = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._discountCfg.cost))
	else
		local matType, matId, matNum = MaterialMgr.getMatParams(self._discountCfg.cost)

		curCost = langPara("%s%s", matNum, MaterialMgr.getMaterialsName(matType, matId))
	end

	self._costPriceDesc = curCost
	self._txtOldPrice.text = curCost
	self._txtPrice.text = curCost
end

function DiscountDressPreView:_refresh()
	self._info = DressDiscountModel.instance:getInfoById(self._activityId, self._currId) or {}

	for id, cell in ipairs(self._collectCells) do
		local cfg = DressSellConfig.instance:getDiscountCollectCfgs(self._activityId, id)
		local hasCount = MaterialModel.instance:getMaterialsNumber(cfg.type, cfg.param)
		local isGainPrize = DressDiscountModel.instance:isGainCollectPrize(id)
		local isHide = checkbool(cfg.hide)

		GameUtil.SetActive(cell.btnGoto, isHide or hasCount <= 0)
		GameUtil.SetActive(cell.btnReceive, not isHide and hasCount > 0 and not isGainPrize)
		GameUtil.SetActive(cell.receive, not isHide and isGainPrize)
		GameUtil.SetActive(cell.redPoint, not isHide and hasCount > 0 and not isGainPrize)
	end

	self._isBuy = checkbool(self._info.isBuy)

	uGuiUtil.setGoGrayState(self._btnBuy.gameObject, self._isBuy or not self._isCanBuy)

	local curBuyNum = checknumber(self._info.buyUserNum)

	self._txtHasBuy.text = "当前已购买人数：" .. curBuyNum

	local planCfg, isNormal = self:getCurDiscuontPlanCfg(curBuyNum)

	GameUtil.SetActive(self._tag, planCfg)
	GameUtil.SetActive(self._txtOldPrice.gameObject, planCfg)

	if planCfg then
		local curDiscount

		if self._costType == 1 then
			curDiscount = langPara("%s元", PayConfig.instance:getPayMoneyYuan(planCfg.discountCost))
		else
			local matType, matId, matNum = MaterialMgr.getMatParams(planCfg.discountCost)

			curDiscount = langPara("%s%s", matNum, MaterialMgr.getMaterialsName(matType, matId))
		end

		self._txtPrice.text = curDiscount
		self._costPriceDesc = curDiscount
		self._txtTag.text = langPara("限时\n%s折", planCfg.showDiscount)
		self._curGapId = planCfg.id
		self._curCost = planCfg.discountCost
	end
end

function DiscountDressPreView:_onBuyItemError()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("购买失败，折扣信息有更新，请再次购买。"))
	self:_sendGetInfoReq()
end

function DiscountDressPreView:getCurDiscuontPlanCfg(curNum)
	local list = DressSellConfig.instance:getDiscountPlanCfgs(self._discountCfg.planId) or {}

	ArraySort.sortOn(list, "userNum")

	local isNoraml = true
	local curCfg

	for i, v in ipairs(list) do
		if curNum + 1 <= v.userNum then
			curCfg = v

			if v.userNum - curNum <= 100 then
				isNoraml = false
			end

			break
		end
	end

	return curCfg, isNoraml
end

function DiscountDressPreView:_showRoleModel()
	local gender = RoleModel.instance:getGender()

	self._avatar = self:addAvatarShow(gender)

	self._avatar:addListener(AvatarNotify.OnSetParentFinish, self.onFemaleLoadEnd, self)
	self._photoEff:setRTAdjust(1, 1, 1, 0.45)
end

function DiscountDressPreView:onFemaleLoadEnd(avatar)
	local avatarGo = avatar:getGameObject()

	if avatarGo then
		GameUtil.setLocalPos(avatarGo, -5, 0, 0)
	end
end

function DiscountDressPreView:addAvatarShow(gender)
	local mo = gender == GameEnum.Gender.Female and AvatarConfig.instance:getAvatarMoByCfgId(1) or AvatarConfig.instance:getAvatarMoByCfgId(2)
	local params = string.splitToNumber(self._discountCfg.addParams, "#")
	local curDressCfgs = {}

	for i, v in ipairs(params) do
		local cfg = MaterialMgr.getMatCfg(MatType.Cloth, checkint(v))

		if cfg and (cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == gender) then
			table.insert(curDressCfgs, cfg)
		end
	end

	for i, v in ipairs(curDressCfgs) do
		local cfg = curDressCfgs[i]

		if cfg then
			mo:dressCloth(cfg.id)
		end
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)

	self._photoEff:addShowAvatarEffect(avatar)

	return avatar
end

function DiscountDressPreView:_onClickLeft()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + 30, 0)
		end
	end
end

function DiscountDressPreView:_onClickRight()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y - 30, 0)
		end
	end
end

function DiscountDressPreView:_onDrag(eventData)
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

function DiscountDressPreView:_onClickBuy()
	if not DressSellController.instance:checkIsAfterCfgTime(self._activityId, self._currId) then
		return
	end

	if self._isBuy then
		FloatWordMgr.instance:show("已购买该礼包")

		return
	end

	if self._costType == 1 then
		local curBuyNum = checknumber(self._info.buyUserNum)
		local planCfg, _ = self:getCurDiscuontPlanCfg(curBuyNum)
		local tips = string.format("确定花费%s购买该礼包吗？", self._costPriceDesc)

		local function okFunc()
			local para = {}

			para.id = self._activityId

			local goodsId = self._curCost
			local subGoodsType = GameEnum.PaySubGoodsType.DRESS_DISCOUNT
			local subGoodsId = self._activityId
			local extParams = GameUtil.jsonToString(para)

			PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)
	else
		local curBuyNum = checknumber(self._info.buyUserNum)
		local planCfg, _ = self:getCurDiscuontPlanCfg(curBuyNum)
		local itemsStr = ""
		local prizeStrs = MaterialMgr.changeItemStrArr(self._discountCfg.giftContent)

		for i, v in ipairs(prizeStrs) do
			local vv = MaterialMgr.getContentMatStr(v, 90, -10, MaterialMgr.ICON_TYPE_CFGID)

			itemsStr = itemsStr .. vv
		end

		local content = ""

		content = planCfg and langPara("当前已购买人数：%s人，已享受%s折折扣，是否确认购买？\n\n%s", curBuyNum, planCfg.showDiscount, itemsStr) or langPara("当前已购买人数：%s人，将以原价购买，是否确认购买？\n\n%s", curBuyNum, itemsStr)

		local matType, matId, matNum = MaterialMgr.getMatParams(self._curCost)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
			DressSellController.instance:buyMoorGoods(self._activityId, self._discountCfg.id, self._curGapId)
		end)
	end
end

function DiscountDressPreView:_onClickGoto(id)
	local cfg = DressSellConfig.instance:getDiscountCollectCfgs(self._activityId, id)

	GotoMgr.gotoByString(cfg.jumpto)
end

function DiscountDressPreView:_onClickReceive(id)
	DressSellController.instance:sendPM_DressDisscountGainCollectPrizeReq(self._activityId, id)
end

function DiscountDressPreView:_onClickPreview()
	UIStateManager.instance:push(ViewName.DiscountDressIdlePreView)
end

return DiscountDressPreView

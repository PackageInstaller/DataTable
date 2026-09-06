-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressShopMoorView.lua

module("logic.extensions.dressactivityshop.view.DiscountDressShopMoorView", package.seeall)

local DiscountDressShopMoorView = class("DiscountDressShopMoorView", ViewComponent)
local json = require("cjson")

function DiscountDressShopMoorView:buildUI()
	DiscountDressShopMoorView.super.buildUI(self)

	self._goGift = self:getGo("gift")
	self._giftItemList = {}

	for i = 1, 3 do
		self._giftItemList[i] = goutil.findChild(self._goGift, "reward/item" .. i)
	end

	self._giftTag = goutil.findChild(self._goGift, "tag")
	self._giftTxtName = goutil.findChildTextComponent(self._goGift, "txtName")
	self._descGo = self:getGo("desc")
	self._btnBuy = self:getGo("btnBuy")
	self._txtBtnBuy = goutil.findChildTextComponent(self._btnBuy, "Text")
	self._goTag = self:getGo("tag")
	self._txtTag = goutil.findChildTextComponent(self._goTag, "txt")
	self._txtOldPrizeGo = self:getGo("txtOldPrice")
	self._txtOldPrize = self:getTxt("txtOldPrice")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._txtCount = self:getTxt("txtCount")
	self._txtTips = self:getTxt("tips/txtTips")
	self._goRole = self:getGo("modsFrame")
	self._photoEff = AvatarPhotoShow.Get(goutil.findChild(self._goRole, "con"))

	self._photoEff:setRawWidthAndHeight(1280, 720)
	self._photoEff:setCameraPosition(-0.1, 1.43, -2)
	self._photoEff:setCamSize(1.48)
	self._photoEff:setRTAdjust(1, 1, 1, 0.45)

	self._drag = Framework.UIDragTrigger.Get(goutil.findChild(self._goRole, "rayTrigger"))
	self._btnRight = goutil.findChild(self._goRole, "btnRight")
	self._btnLeft = goutil.findChild(self._goRole, "btnLeft")
	self._drag2 = Framework.UIDragTrigger.Get(goutil.findChild(self._goRole, "rayTrigger_2"))
	self._btnRight2 = goutil.findChild(self._goRole, "btnRight_2")
	self._btnLeft2 = goutil.findChild(self._goRole, "btnLeft_2")
end

function DiscountDressShopMoorView:bindEvents()
	DiscountDressShopMoorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	self._drag:AddDragListener(self._onDrag, self)
	GameUtil.addClickHandler(self._btnRight2, self._onClickRight2, self)
	GameUtil.addClickHandler(self._btnLeft2, self._onClickLeft2, self)
	self._drag2:AddDragListener(self._onDrag2, self)
end

function DiscountDressShopMoorView:unbindEvents()
	DiscountDressShopMoorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
	self._drag:RemoveDragListener()
end

function DiscountDressShopMoorView:onEnter()
	DiscountDressShopMoorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._actId = checknumber(params[1])
	self.currId = checknumber(params[2])

	if self._actId <= 0 then
		self._actId = DressDiscountModel.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._actId)

	if not isInTime then
		self:close()

		return
	end

	self.curCost = nil
	self.curGapId = 0

	GameUtil.SetActive(self._descGo, false)

	self.isCanBuy = false

	if self.currId <= 0 then
		self.currId = 1
	end

	self._actCfg = DressSellConfig.instance:getDiscountCfgById(self._actId, self.currId)

	self:refreshViewByCfg()
	GlobalDispatcher:addListener(GlobalNotify.DiscountDressMoorBuyError, self._onBuyItemError, self)
	GlobalDispatcher:addListener(GlobalNotify.DiscountDressMoorInfoUpdate, self.refreshViewByInfo, self)
	DressSellController.instance:sendGetDressDiscountInfo(self._actId)

	if DressSellController.instance:checkIsAfterCfgTime(self._actId, self.currId) then
		self.isCanBuy = true

		RedPointController:saveUserOnceRedPoint(RedPointModel.ID_DISCOUNTDRESS_MOOR, true)
	else
		GameUtil.SetActive(self._descGo, true)
	end
end

function DiscountDressShopMoorView:onExit()
	DiscountDressShopMoorView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DiscountDressMoorBuyError, self._onBuyItemError, self)
	GlobalDispatcher:removeListener(GlobalNotify.DiscountDressMoorInfoUpdate, self.refreshViewByInfo, self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._giftItemList[i])
	end

	self._photoEff:clear()

	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnSetParentFinish, self.onFemaleLoadEnd, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end

	if self._avatar2 then
		self._avatar2:removeListener(AvatarNotify.OnSetParentFinish, self.onMaleLoadEnd, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar2)

		self._avatar2 = nil
	end

	removetimer(self._onCountDown, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end
end

function DiscountDressShopMoorView:refreshViewByCfg()
	self._txtCount.text = ""
	self._txtTips.text = ""

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._actCfg then
		local activityType = ActivityDefineController.instance:getActTypeByActId(self._actId)

		self._txtOpenTime.text = GameUtil.getActTimeDesc(activityType, self._actId)

		local path = "fx_ui_shouchong/fx_ui_30yuanshouchong_fenwei.prefab"

		self._mainEff = UIEffectManager.instance:playEffect(self, path, self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
			eff.effGo.transform:SetParent(self.mainGO.transform)
			GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
			GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		end)
		self._txtTips.text = self._actCfg.desc
		self._giftTxtName.text = self._actCfg.name

		local prizeStrs = MaterialMgr.changeItemStrArr(self._actCfg.giftContent)
		local temId = 0

		for i, data in pairs(prizeStrs) do
			if not GameUtil.isEmptyString(data) then
				temId = temId + 1

				MaterialMgr.setCellByCfg(data, self._giftItemList[temId])
			end
		end

		self._costType = self._actCfg.type

		local curCost = ""

		if self._costType == 1 then
			curCost = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._actCfg.cost))
		else
			local costMatType, costId, costMatNum = MaterialMgr.getMatParams(self._actCfg.cost)

			curCost = langPara("%s%s", costMatNum, MaterialMgr.getMaterialsName(costMatType, costId))
		end

		self._txtOldPrize.text = curCost
		self._avatar = self:addAvatarShow(GameEnum.Gender.Female)
		self._avatar2 = self:addAvatarShow(GameEnum.Gender.Male)

		self._avatar:addListener(AvatarNotify.OnSetParentFinish, self.onFemaleLoadEnd, self)
		self._avatar2:addListener(AvatarNotify.OnSetParentFinish, self.onMaleLoadEnd, self)
		self._photoEff:setRTAdjust(1, 1, 1, 0.45)
	end
end

function DiscountDressShopMoorView:onFemaleLoadEnd(avatar)
	local avatarGo = avatar:getGameObject()

	if avatarGo then
		GameUtil.setLocalPos(avatarGo, -0.5, 0, 0)
	end
end

function DiscountDressShopMoorView:onMaleLoadEnd(avatar)
	local avatarGo = avatar:getGameObject()

	if avatarGo then
		GameUtil.setLocalPos(avatarGo, 0.8, 0, 0)
	end
end

function DiscountDressShopMoorView:addAvatarShow(gender)
	local mo = gender == GameEnum.Gender.Female and AvatarConfig.instance:getAvatarMoByCfgId(1) or AvatarConfig.instance:getAvatarMoByCfgId(2)
	local params = string.splitToNumber(self._actCfg.addParams, "#")
	local curDressCfgs = {}

	for i, v in ipairs(params) do
		local cfg = MaterialMgr.getMatCfg(MatType.Cloth, checkint(v))

		if cfg and (cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == gender) then
			table.insert(curDressCfgs, cfg)
		end
	end

	for _, cfg in ipairs(curDressCfgs) do
		mo:dressCloth(cfg.id)
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)

	self._photoEff:addShowAvatarEffect(avatar)

	return avatar
end

function DiscountDressShopMoorView:refreshViewByInfo()
	local info = DressDiscountModel.instance:getInfoById(self._actId, self.currId) or {}

	self._isHasBuy = info.isBuy

	local curNum = checknumber(info.buyUserNum)

	self._txtCount.text = langPara("已购买人数：%s人", curNum)

	if self._isHasBuy then
		self._txtBtnBuy.text = lang("已购买")
	else
		self._costType = self._actCfg.type

		do
			local curCost = ""

			if self._costType == 1 then
				curCost = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._actCfg.cost))
			else
				local costMatType, costId, costMatNum = MaterialMgr.getMatParams(self._actCfg.cost)

				curCost = langPara("%s%s", costMatNum, MaterialMgr.getMaterialsName(costMatType, costId))
			end

			self._txtBtnBuy.text = curCost
		end
	end

	GameUtil.SetGray(self._btnBuy, self._isHasBuy or not self.isCanBuy)
	removetimer(self._onCountDown, self)
	GameUtil.SetActive(self._goTag, false)
	GameUtil.SetActive(self._txtOldPrizeGo, false)

	if self._actCfg then
		local curCfg, isNoraml = self:getCurDiscuontCfg(self._actCfg, curNum)

		if curCfg then
			GameUtil.SetActive(self._goTag, true)
			GameUtil.SetActive(self._txtOldPrizeGo, true)

			local curDiscount = ""

			if self._costType == 1 then
				curDiscount = langPara("%s元", PayConfig.instance:getPayMoneyYuan(curCfg.discountCost))
			else
				local discountMatType, discountId, discountMatNum = MaterialMgr.getMatParams(curCfg.discountCost)

				curDiscount = langPara("%s%s", discountMatNum, MaterialMgr.getMaterialsName(discountMatType, discountId))
			end

			self._txtBtnBuy.text = curDiscount
			self._txtTag.text = langPara("限时\n%s折", curCfg.showDiscount)

			if isNoraml then
				settimer(120, self._onCountDown, self)
			else
				settimer(10, self._onCountDown, self)
			end

			self.curGapId = curCfg.id
			self.curCost = curCfg.discountCost
		else
			self.curGapId = 0
			self.curCost = self._actCfg.cost
		end
	end
end

function DiscountDressShopMoorView:getCurDiscuontCfg(_actCfg, curNum)
	local list = DressSellConfig.instance:getDiscountPlanCfgs(_actCfg.planId) or {}

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

function DiscountDressShopMoorView:_onBuyItemError()
	TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("购买失败，折扣信息有更新，请再次购买。"))
	self:_onCountDown()
end

function DiscountDressShopMoorView:_onCountDown()
	print(">>>>>>>>>> 发送信息 刷新界面")
	DressSellController.instance:sendGetDressDiscountInfo(self._actId)
end

function DiscountDressShopMoorView:_onClickBuy()
	if not DressSellController.instance:checkIsAfterCfgTime(self._actId, self.currId) then
		return
	end

	if self.curCost == nil then
		FloatWordMgr.instance:show("购买人数更新中，请稍候~")

		return
	end

	if self._isHasBuy then
		FloatWordMgr.instance:show("已购买该礼包")

		return
	elseif self._costType == 1 then
		local para = {
			actId = self._actId
		}

		json.encode(para)

		local goodId = self.curCost

		PayController.instance:pay(goodId, GameEnum.PaySubGoodsType.DRESS_DISCOUNT, self._actCfg.id, json.encode(para))
	else
		local info = DressDiscountModel.instance:getInfoById(self._actId, self.currId) or {}
		local curNum = checknumber(info.buyUserNum)
		local cfg, _ = self:getCurDiscuontCfg(self._actCfg, curNum)
		local itemsStr = ""
		local prizeStrs = MaterialMgr.changeItemStrArr(self._actCfg.giftContent)

		for i, v in ipairs(prizeStrs) do
			local vv = MaterialMgr.getContentMatStr(v, 90, -10, MaterialMgr.ICON_TYPE_CFGID)

			itemsStr = itemsStr .. vv
		end

		local content = ""

		content = cfg and langPara("当前已购买人数：%s人，已享受%s折折扣，是否确认购买？\n\n%s", curNum, cfg.showDiscount, itemsStr) or langPara("当前已购买人数：%s人，将以原价购买，是否确认购买？\n\n%s", curNum, itemsStr)

		local curCost = self.curCost
		local matType, id, num = MaterialMgr.getMatParams(curCost)

		TipsFacade.instance:openPopupCostMatViewNew(matType, id, num, content, function()
			DressSellController.instance:buyMoorGoods(self._actId, self._actCfg.id, self.curGapId)
		end)
	end
end

function DiscountDressShopMoorView:_onClickLeft()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + 30, 0)
		end
	end
end

function DiscountDressShopMoorView:_onClickRight()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y - 30, 0)
		end
	end
end

function DiscountDressShopMoorView:_onDrag(eventData)
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

function DiscountDressShopMoorView:_onClickLeft2()
	if self._avatar2 then
		local avatarGo = self._avatar2:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + 30, 0)
		end
	end
end

function DiscountDressShopMoorView:_onClickRight2()
	if self._avatar2 then
		local avatarGo = self._avatar2:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y - 30, 0)
		end
	end
end

function DiscountDressShopMoorView:_onDrag2(eventData)
	if self._avatar2 then
		local avatarGo = self._avatar2:getGameObject()

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

return DiscountDressShopMoorView

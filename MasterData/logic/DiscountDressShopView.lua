-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DiscountDressShopView.lua

module("logic.extensions.dressactivityshop.view.DiscountDressShopView", package.seeall)

local DiscountDressShopView = class("DiscountDressShopView", ViewComponent)
local json = require("cjson")

function DiscountDressShopView:buildUI()
	DiscountDressShopView.super.buildUI(self)

	self._goGift = self:getGo("gift")
	self._giftItemList = {}

	for i = 1, 3 do
		self._giftItemList[i] = goutil.findChild(self._goGift, "itemcon/item" .. i)
	end

	self._giftTag = goutil.findChild(self._goGift, "tag")
	self._giftTxtName = goutil.findChildTextComponent(self._goGift, "txtName")
	self._txtActivityTime = self:getTxt("time/txtTime")
	self._sellTime = self:getGo("sellTime")
	self._txtSellTime = self:getTxt("sellTime/txtSellTime")
	self._btnBuy = self:getGo("btnBuy")
	self._txtBtnBuy = goutil.findChildTextComponent(self._btnBuy, "Text")
	self._goTag = self:getGo("tag")
	self._txtTag = goutil.findChildTextComponent(self._goTag, "txt")
	self._txtOldPrize = self:getTxt("txtOldPrice")
	self._txtTime = self:getTxt("txtTime")
	self._showCellList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("show/cell_" .. i)
		cell.txt = goutil.findChildTextComponent(cell.go, "txtTitle")
		cell.change = cell.go:GetComponent("UIImageSpriteChange")
		self._showCellList[i] = cell
	end

	self._goRole = self:getGo("modsFrame")
	self._modelCam = self:getGo("modelCam")
	self._rolePoint = goutil.findChild(self._modelCam, "rolePoint")
	self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatar:setParent(self._rolePoint.transform)
	self._avatar:setLayer(SceneLayer.UI3D_Value)

	self._drag = Framework.UIDragTrigger.Get(goutil.findChild(self._goRole, "rayTrigger"))
	self._btnRight = goutil.findChild(self._goRole, "btnRight")
	self._btnLeft = goutil.findChild(self._goRole, "btnLeft")
end

function DiscountDressShopView:bindEvents()
	DiscountDressShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickLeft, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function DiscountDressShopView:unbindEvents()
	DiscountDressShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
	self._drag:RemoveDragListener()
end

function DiscountDressShopView:onEnter()
	DiscountDressShopView.super.onEnter(self)

	self._actTimeCfg = DressSellModel.instance:getCurActTimeCfg()

	self:refreshViewByCfg()
	DressSellController.instance:getInfo(self._actId)
	DressSellController.instance:closeRedPointById(self._actId)
	GlobalDispatcher:addListener(GlobalNotify.DiscountDressSellInfoUpdate, self.refreshViewByInfo, self)

	local startTime, endTime = self._actTimeCfg.startTime, self._actTimeCfg.endTime
	local startDate, endDate = GameUtil.string2date(startTime), GameUtil.string2date(endTime)

	self._txtActivityTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	self._mainEff = UIEffectManager.instance:playEffect(self, "20221223/banbenfuzhuang/fx_ui_bangbenfuzhuang.prefab", self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self.mainGO.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
	end)

	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
end

function DiscountDressShopView:onEnterFinished()
	DiscountDressShopView.super.onEnterFinished(self)

	if self._showDressIds then
		local avatarMo = DressModel.instance:getAvatarMoWithDefaultSuit(self._curRoleGender)

		for _, clothe in ipairs(self._showDressIds) do
			avatarMo:dressCloth(clothe)
		end

		self._avatar:updateByMo(avatarMo)
	end
end

function DiscountDressShopView:onExit()
	DiscountDressShopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DiscountDressSellInfoUpdate, self.refreshViewByInfo, self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._giftItemList[i])
	end

	removetimer(self._onCountDown, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
end

function DiscountDressShopView:destroyUI()
	DiscountDressShopView.super.destroyUI(self)

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function DiscountDressShopView:refreshViewByCfg()
	self._actId = self._actTimeCfg.activityId

	DressSellModel.instance:setActId(self._actId)

	local actCfgs = DressSellConfig.instance:getActfgsByActId(self._actId)

	if actCfgs then
		self._actCfg = actCfgs[1]

		local sellTimeCfg = self._actCfg.sellStartTime
		local sellStartTime = GameUtil.string2time(sellTimeCfg)
		local time = GameUtil.time2date(sellStartTime)
		local nowTime = ServerTime.now()

		self._isSellTime = sellStartTime < nowTime

		GameUtil.SetActive(self._sellTime, self._isSellTime)

		self._txtSellTime.text = langPara("%02d月%02d日5:00开始售卖", time.month, time.day)

		GameUtil.SetGray(self._btnBuy, nowTime < sellStartTime)

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
		local curDiscount = ""

		if self._costType == 1 then
			curCost = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._actCfg.cost))
			curDiscount = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._actCfg.discountCost))
		else
			local costMatType, costId, costMatNum = MaterialMgr.getMatParams(self._actCfg.cost)

			curCost = langPara("%s%s", costMatNum, MaterialMgr.getMaterialsName(costMatType, costId))

			local discountMatType, discountId, discountMatNum = MaterialMgr.getMatParams(self._actCfg.discountCost)

			curDiscount = langPara("%s%s", discountMatNum, MaterialMgr.getMaterialsName(discountMatType, discountId))
		end

		self._txtBtnBuy.text = curDiscount
		self._txtOldPrize.text = curCost
		self._txtTag.text = langPara("限时%s折", self._actCfg.showDiscount)
		self._showDressIds = nil

		if self._actCfg.paramType == "dress" then
			self._showDressIds = {}
			self._curRoleGender = RoleModel.instance:getGender() or GameEnum.Gender.Female

			local params = string.splitToNumber(self._actCfg.addParams, "#")
			local curDressCfgs = {}

			for i, v in ipairs(params) do
				local cfg = MaterialMgr.getMatCfg(MatType.Cloth, checkint(v))

				if cfg and (cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == self._curRoleGender) then
					table.insert(curDressCfgs, cfg)
					table.insert(self._showDressIds, checkint(v))
				end
			end

			for i = 1, 2 do
				local cfg = curDressCfgs[i]

				if cfg then
					self._showCellList[i].change:SetState(self._curRoleGender)

					self._showCellList[i].txt.text = cfg.name
				end
			end
		end
	end
end

function DiscountDressShopView:refreshViewByInfo()
	self._curInfo = DressSellModel.instance:getInfo()
	self._isHasBuy = true
	self._isCurDiscountTime = false
	self._disCountEndTime = 0
	self._txtTime.text = ""

	removetimer(self._onCountDown, self)

	if self._curInfo then
		self._isHasBuy = self._curInfo.isBuy
		self._disCountEndTime = self._curInfo.endTime

		if self._disCountEndTime > 0 then
			self._isCurDiscountTime = ServerTime.now() * 1000 <= self._disCountEndTime

			if self._isCurDiscountTime then
				settimer(0.5, self._onCountDown, self)
			end
		end
	end

	if self._isHasBuy then
		self._txtBtnBuy.text = lang("已购买")
	elseif not self._isCurDiscountTime then
		self._txtBtnBuy.text = self._txtOldPrize.text
	end

	GameUtil.SetGray(self._btnBuy, self._isHasBuy)
	goutil.setActive(self._txtOldPrize.gameObject, self._isCurDiscountTime)
	goutil.setActive(self._goTag, self._isCurDiscountTime)
	goutil.setActive(self._giftTag, self._isCurDiscountTime)
end

function DiscountDressShopView:_onCountDown()
	local leftTime = self._disCountEndTime - ServerTime.now() * 1000

	if leftTime > 0 then
		self._txtTime.text = langPara("倒计时：%s", GameUtil.FormatTimeWords(checkint(leftTime / 1000)))
	else
		FloatWordMgr.instance:show("折扣结束")
		UIStateManager.instance:popByName(ViewName.PopupCostMat)
		self:refreshViewByInfo()
	end
end

function DiscountDressShopView:_onClickBuy()
	if self._isHasBuy then
		FloatWordMgr.instance:show("已购买该礼包")

		return
	elseif not self._isSellTime then
		FloatWordMgr.instance:show("未到售卖时间")

		return
	elseif self._costType == 1 then
		local para = {
			id = self._actCfg.id
		}

		json.encode(para)

		if self._isCurDiscountTime then
			if not self._actCfg.discountCost then
				local goodId = self._actCfg.cost

				PayController.instance:pay(goodId, GameEnum.PaySubGoodsType.DISCOUNT_DRESS_SHOP, self._actId, json.encode(para))
			end
		end
	elseif self._isCurDiscountTime then
		if not self._actCfg.discountCost then
			local curCost = self._actCfg.cost
			local matType, id, num = MaterialMgr.getMatParams(curCost)
			local content = langPara("确定花费%s%s购买礼包吗？", num, MaterialMgr.getMaterialsName(matType, id))

			TipsFacade.instance:openPopupCostMatViewNew(matType, id, num, content, function()
				DressSellController.instance:buyGoods(self._actId, self._actCfg.id)
			end)
		end
	end
end

function DiscountDressShopView:_onClickLeft()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + 30, 0)
		end
	end
end

function DiscountDressShopView:_onClickRight()
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y - 30, 0)
		end
	end
end

function DiscountDressShopView:_onDrag(eventData)
	if self._avatar then
		local avatarGo = self._avatar:getGameObject()

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

return DiscountDressShopView

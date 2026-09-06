-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardDress2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardDress2023View", package.seeall)

local YearCardDress2023View = class("YearCardDress2023View", ViewComponent)

function YearCardDress2023View:buildUI()
	YearCardDress2023View.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._roleCellList = {}

	for i = 1, 2 do
		local cell = {}
		local rolePoint = goutil.findChild(self._modelCam, "rolePoint_" .. i)
		local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		avatar:setParent(rolePoint.transform)
		avatar:setLayer(SceneLayer.UI3D_Value)

		cell.avatar = avatar
		cell.gender = i - 1
		cell.avatarMo = DressModel.instance:getAvatarMoWithDefaultSuit(cell.gender)

		local con = self:getGo("con" .. i)

		cell.drag = Framework.UIDragTrigger.Get(goutil.findChild(con, "drag"))
		cell.btnRRight = goutil.findChild(con, "btnRRight")
		cell.btnRLeft = goutil.findChild(con, "btnRLeft")
		self._roleCellList[i] = cell
	end

	self._goGift = self:getGo("gift")
	self._giftItemList = {}

	for i = 1, 3 do
		self._giftItemList[i] = goutil.findChild(self._goGift, "itemcon/item" .. i)
	end

	self._giftTag = goutil.findChild(self._goGift, "tag")
	self._giftTxtName = goutil.findChildTextComponent(self._goGift, "txtName")
	self._sellTime = self:getGo("sellTime")
	self._txtSellTime = self:getTxt("sellTime/txtSellTime")
	self._btnBuy = self:getGo("btnBuy")
	self._txtBtnBuy = goutil.findChildTextComponent(self._btnBuy, "Text")
	self._goTag = self:getGo("tag")
	self._txtTag = goutil.findChildTextComponent(self._goTag, "txt")
	self._txtOldPrize = self:getTxt("txtOldPrice")
	self._btnBuy = self:getGo("btnBuy")
end

function YearCardDress2023View:bindEvents()
	YearCardDress2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)

	for i, v in ipairs(self._roleCellList) do
		GameUtil.addClickHandler(v.btnRRight, GameUtil.handler(self._onClickTrunR, self, i, true))
		GameUtil.addClickHandler(v.btnRLeft, GameUtil.handler(self._onClickTrunR, self, i, false))

		if i == 1 then
			v.drag:AddDragListener(self._onDrag1, self)
		elseif i == 2 then
			v.drag:AddDragListener(self._onDrag2, self)
		end
	end
end

function YearCardDress2023View:unbindEvents()
	YearCardDress2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuy)

	for i, v in ipairs(self._roleCellList) do
		GameUtil.rmClickHandler(v.btnRRight)
		GameUtil.rmClickHandler(v.btnRLeft)
		v.drag:RemoveDragListener()
	end
end

function YearCardDress2023View:onEnter()
	YearCardDress2023View.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)

	self._actId = checkint(self:getFirstParam())

	DressSellModel.instance:setActId(self._actId)
	self:refreshViewByCfg()
	DressSellController.instance:getInfo(self._actId)
	GlobalDispatcher:addListener(GlobalNotify.DiscountDressSellInfoUpdate, self.refreshViewByInfo, self)

	local path = self:_getEffectPath()

	self._eff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)
end

function YearCardDress2023View:onEnterFinished()
	YearCardDress2023View.super.onEnterFinished(self)

	for i, v in ipairs(self._roleCellList) do
		if v.avatar then
			v.avatar:updateByMo(v.avatarMo)

			local avatarGo = v.avatar:getGameObject()

			if avatarGo then
				Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, 0, 0)
			end
		end
	end
end

function YearCardDress2023View:onExit()
	YearCardDress2023View.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	GlobalDispatcher:removeListener(GlobalNotify.DiscountDressSellInfoUpdate, self.refreshViewByInfo, self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._giftItemList[i])
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function YearCardDress2023View:destroyUI()
	YearCardDress2023View.super.destroyUI(self)

	for i, v in ipairs(self._roleCellList) do
		if v.avatar then
			AvatarsMgrNew.instance:removeAvatar(v.avatar)

			v.avatar = nil
		end
	end
end

function YearCardDress2023View:refreshViewByCfg()
	local actCfgs = DressSellConfig.instance:getActfgsByActId(self._actId)

	self._goodCfg = actCfgs and actCfgs[1]

	if self._goodCfg then
		local sellTimeCfg = self._goodCfg.sellStartTime
		local sellStartTime = GameUtil.string2time(sellTimeCfg)
		local time = GameUtil.time2date(sellStartTime)
		local nowTime = ServerTime.now()

		self._isSellTime = sellStartTime < nowTime
		self._txtSellTime.text = langPara("%02d月%02d日5:00开始售卖", time.month, time.day)

		GameUtil.SetGray(self._btnBuy, nowTime < sellStartTime)

		self._giftTxtName.text = self._goodCfg.name

		local prizeStrs = MaterialMgr.changeItemStrArr(self._goodCfg.giftContent)
		local temId = 0

		for i, data in pairs(prizeStrs) do
			if not GameUtil.isEmptyString(data) then
				temId = temId + 1

				MaterialMgr.setCellByCfg(data, self._giftItemList[temId])
			end
		end

		self._costType = self._goodCfg.type

		local curCost = ""
		local curDiscount = ""

		if self._costType == 1 then
			curCost = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._goodCfg.cost))
			curDiscount = langPara("%s元", PayConfig.instance:getPayMoneyYuan(self._goodCfg.discountCost))
		else
			local costMatType, costId, costMatNum = MaterialMgr.getMatParams(self._goodCfg.cost)

			curCost = langPara("%s%s", costMatNum, MaterialMgr.getMaterialsName(costMatType, costId))

			local discountMatType, discountId, discountMatNum = MaterialMgr.getMatParams(self._goodCfg.discountCost)

			curDiscount = langPara("%s%s", discountMatNum, MaterialMgr.getMaterialsName(discountMatType, discountId))
		end

		self._txtBtnBuy.text = curDiscount
		self._txtOldPrize.text = curCost
		self._txtTag.text = langPara("%s折", self._goodCfg.showDiscount)

		if self._goodCfg.paramType == "dress" then
			local params = string.splitToNumber(self._goodCfg.addParams, "#")

			for i, v in ipairs(self._roleCellList) do
				for i1, v1 in ipairs(params) do
					local cfg = MaterialMgr.getMatCfg(MatType.Cloth, checkint(v1))

					if cfg and (cfg.clothesGender == GameEnum.Gender.Neutral or cfg.clothesGender == v.gender) then
						v.avatarMo:dressCloth(cfg.id)
					end
				end
			end
		end
	end
end

function YearCardDress2023View:refreshViewByInfo()
	self._curInfo = DressSellModel.instance:getInfo()
	self._isHasBuy = true
	self._isCurDiscountTime = MaterialMgr.getMatEnough(self._goodCfg.discountItem)

	if self._curInfo then
		self._isHasBuy = self._curInfo.isBuy
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

function YearCardDress2023View:_onDrag1(eventData)
	local id = 1

	if self._roleCellList[id] then
		local avatarGo = self._roleCellList[id] and self._roleCellList[id]:getGameObject() or nil

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

function YearCardDress2023View:_onDrag2(eventData)
	local id = 2

	if self._roleCellList[id] then
		local avatarGo = self._roleCellList[id] and self._roleCellList[id]:getGameObject() or nil

		if avatarGo then
			local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
		end
	end
end

function YearCardDress2023View:_onClickTrunR(i, isTrunRight)
	if self._roleCellList[i] then
		local avatarGo = self._roleCellList[i] and self._roleCellList[i]:getGameObject() or nil

		if avatarGo then
			local localRotation = avatarGo.transform.localRotation
			local addAngle = isTrunRight and -30 or 30
			local eulerAngles = localRotation.eulerAngles

			Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y + addAngle, 0)
		end
	end
end

function YearCardDress2023View:_onClickBuy()
	if self._isHasBuy then
		FloatWordMgr.instance:show("已购买该礼包")

		return
	elseif not self._isSellTime then
		FloatWordMgr.instance:show("未到售卖时间")

		return
	elseif self._costType == 1 then
		local para = {
			id = self._goodCfg.id
		}

		json.encode(para)

		if self._isCurDiscountTime then
			if not self._goodCfg.discountCost then
				local goodId = self._goodCfg.cost

				PayController.instance:pay(goodId, GameEnum.PaySubGoodsType.DISCOUNT_DRESS_SHOP, self._actId, json.encode(para))
			end
		end
	elseif self._isCurDiscountTime then
		if not self._goodCfg.discountCost then
			local curCost = self._goodCfg.cost
			local matType, id, num = MaterialMgr.getMatParams(curCost)
			local content = langPara("确定花费%s%s购买礼包吗？", num, MaterialMgr.getMaterialsName(matType, id))

			TipsFacade.instance:openPopupCostMatViewNew(matType, id, num, content, function()
				DressSellController.instance:buyGoods(self._actId, self._goodCfg.id)
			end)
		end
	end
end

function YearCardDress2023View:_getEffectPath()
	return "20221223/2023nianfei/fx_ui_2023nianfei_fuzhuang.prefab"
end

return YearCardDress2023View

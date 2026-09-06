-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/XinxiyaShopView.lua

module("logic.extensions.xinxiyamirror.view.XinxiyaShopView", package.seeall)

local XinxiyaShopView = class("XinxiyaShopView", TableViewComponent)

function XinxiyaShopView:ctor()
	XinxiyaShopView.super.ctor(self)

	self._isActiEnd = false
end

function XinxiyaShopView:bindEvents()
	XinxiyaShopView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._xiaohaoBtn:AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._xiaohaoBtn, MatType.ACTIVITY_ITEM, XinxiyaMirrorModel.instance.activityMatId, 0)
	end, self)
end

function XinxiyaShopView:unbindEvents()
	XinxiyaShopView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._xiaohaoBtn:RemoveClickListener()
end

function XinxiyaShopView:onExit()
	XinxiyaShopView.super.onExit(self)
	GlobalModel.instance:visibleSceneHUDs(true)
	self._mainModelTran:SetParent(self.mainGO.transform)
	RoleObjectPool.instance:removeRole(self._roleObj)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopListAndMaterial, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function XinxiyaShopView:destroyUI()
	XinxiyaShopView.super.destroyUI(self)

	local xhBig = self._xiaohaoIma.gameObject:GetComponent("ImageBigBG")

	if xhBig then
		xhBig:ClearImage()
	end
end

function XinxiyaShopView:buildUI()
	XinxiyaShopView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._mainModelTran = goutil.findChild(self.mainGO, "mainModelGo").transform
	self._mainModelBg = goutil.findChild(self._mainModelTran.gameObject, "mainModelBg")
	self._middleBG = goutil.findChild(self._mainModelTran.gameObject, "middleBg")
	self._mainRolePos = goutil.findChild(self._mainModelTran.gameObject, "mainRole/mainRolePos")
	self._spriteRole = self:getGo("spriteModelGo/spriteRole")
	self._bubbleGo = self:getGo("spriteModelGo/bubbleGo")
	self._bubbleTxt = goutil.findChildTextComponent(self._bubbleGo, "bubbleTxt")
	self._bubbleTxt.text = ""

	self._bubbleGo:SetActive(false)

	self._supTimeTxt = goutil.findChildTextComponent(self.mainGO, "supTimeTxt")
	self._xiaohaoBtn = self:getBtn("xiaohaoItem")
	self._xiaohaoIma = goutil.findChild(self._xiaohaoBtn.gameObject, "xiaohaoIma"):GetComponent("Image")
	self._xiaohaoTxt = goutil.findChildTextComponent(self._xiaohaoBtn.gameObject, "xiaohaoTxt")
	self._itemTxt = goutil.findChildTextComponent(self.mainGO, "itemImaGo/itemTxt")
	self._itemRed = self:getGo("itemImaGo/itemRed")
	self._supTimeTxt.text = ""

	self._itemRed:SetActive(false)
end

function XinxiyaShopView:onEnter()
	XinxiyaShopView.super.onEnter(self)
	GlobalModel.instance:visibleSceneHUDs(false)
	self._mainModelTran:SetParent(nil)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updataShopListAndMaterial, self)

	self._isActiEnd = false
	self._actiId = XinxiyaMirrorConfig.instance:getOpenActivityId()

	if checknumber(self._actiId) <= 0 then
		self._actiId = XinxiyaMirrorModel.instance.lastActivityId
	end

	if checknumber(self._actiId) <= 0 then
		printError("sr---镜像 XinxiyaShopView:onEnter()   获取的活动时间id为空 = " .. self._actiId)

		self._isActiEnd = true

		return
	end

	self._curViewDatas, self._shopCfg, self._shopName = XinxiyaMirrorConfig.instance:getMirrorShopsCfg(self._actiId)

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---镜像 XinxiyaShopView:onEnter()   获取商店配置空 = " .. self._actiId)

		self._isActiEnd = true

		return
	end

	local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, XinxiyaMirrorModel.instance.activityMatId)

	self._xiaohaoTxt.text = tostring(count)

	MaterialMgr.setIcon(self._xiaohaoIma, MatType.ACTIVITY_ITEM, XinxiyaMirrorModel.instance.activityMatId)
	self:_setRoleModelOrSprite()
	self._tableview:ReloadData()

	local actiCfg = ActivityDefineConfig.instance:getCfgById(XinxiyaMirrorModel.instance.activityType, self._actiId)

	self._endTime = 0

	if actiCfg and not string.nilorempty(actiCfg.endTime) then
		self._endTime = GameUtil.string2time(actiCfg.endTime)
	end

	self:_showActivityTimer()
	ActivityshopController.instance:getAllShopItemInfo(XinxiyaMirrorModel.instance.activityType, self._actiId)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

function XinxiyaShopView:_updataShopListAndMaterial()
	local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, XinxiyaMirrorModel.instance.activityMatId)

	self._xiaohaoTxt.text = tostring(count)

	self._tableview:ReloadData()
end

function XinxiyaShopView:_setRoleModelOrSprite()
	self._itemTxt.text = self._shopName

	goutil.setActive(self._mainRolePos, self._shopCfg.isShowRole)
	goutil.setActive(self._spriteRole, not self._shopCfg.isShowRole)

	if not self._shopCfg.isShowRole then
		local function loadCallBack(go)
			RoleObjectPool.instance:playAnimation(go, "idle", true, nil, true)
		end

		self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._shopCfg.raceId, self._spriteRole, self._shopCfg.scale, loadCallBack, true, self._shopCfg.pos[1], self._shopCfg.pos[2])

		if string.nilorempty(self._shopCfg.content) then
			self._bubbleTxt.text = ""

			goutil.setActive(self._bubbleGo, false)
		else
			goutil.setActive(self._bubbleGo, true)

			self._bubbleTxt.text = self._shopCfg.content
		end

		return
	end

	if self._avatar then
		self._avatar:setVisible(true)

		return
	end

	self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatar:setParent(self._mainRolePos.transform)
	self._avatar:setLayer(SceneLayer.UI_Value)

	if RoleModel.instance:getGender() == GameEnum.Gender.Female then
		if not DressModel.defaultFemaleSkelId then
			local default = DressModel.defaultMaleSkelId
			local avatarMo = DressModel.instance:getDefaultAvatarMo(default)

			if self._shopCfg.roleDressIds then
				local tempList = string.split(self._shopCfg.roleDressIds, "#")

				for _, aaStr in ipairs(tempList) do
					local subList = string.split(aaStr, ":")

					if checknumber(subList[1]) == RoleModel.instance:getGender() or checknumber(subList[1]) == GameEnum.Gender.Neutral then
						local list = {}

						for _, drssId in ipairs(string.split(subList[2], ",")) do
							table.insert(list, checknumber(drssId))
						end

						for _, idStr in ipairs(list) do
							local dressCfg = DressConfig.instance:getDressCfgById(idStr)
							local partId = dressCfg.partId
							local partType = AvatarConfig.instance:getPartCfgById(partId).partType
							local isOnDress = avatarMo:isExistDataByCfgId(partId)

							if not isOnDress then
								avatarMo:setDataByCfgId(partId)
							end
						end
					end
				end
			end

			self._avatar:updateExtBgParent(self._mainModelBg, self._middleBG, self)
			avatarMo:setDefaultState()
			self._avatar:updateByMo(avatarMo)
			Framework.TransformUtil.SetLocalPos(self._mainRolePos.transform, self._shopCfg.pos[1], self._shopCfg.pos[2], 0)
			Framework.TransformUtil.SetLocalScale(self._mainRolePos.transform, self._shopCfg.scale[1], self._shopCfg.scale[2], 1)
		end
	end
end

function XinxiyaShopView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._supTimeTxt.text = "活动结束"
		self._isActiEnd = true

		return
	end

	if self._endTime > ServerTime.now() then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function XinxiyaShopView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._supTimeTxt.text = "活动结束"
		self._isActiEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._supTimeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function XinxiyaShopView:_getPath()
	return {
		cellPath = "buyItem",
		viewPath = "buyGoodsSR"
	}
end

function XinxiyaShopView:_cellSize()
	return 184, 236
end

function XinxiyaShopView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local consumeImaGo = goutil.findChild(cell, "consumeGo/consumeIma")
	local consumeTxt = goutil.findChildTextComponent(cell, "consumeGo/consumeTxt")
	local buyOutGo = goutil.findChild(cell, "buyOutGo")

	MaterialMgr.resetAll(goodsPos)

	local itemId = data.shopItemId
	local actiId = data.activityId
	local actType = data.activityType
	local matSplitList = string.split(data.sellContent, ":")
	local goodsType = checknumber(matSplitList[1])
	local goodsId = checknumber(matSplitList[2])
	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
	local colorStr = MaterialMgr.getGoodsColor(goodsType, goodsId)

	nameTxt.text = string.format("<color=%s>%s</color>", colorStr, data.name)

	local sellOut = false
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(actType, actiId, itemId)

	if data.sellPeriodLimit ~= "none" then
		sellOut = buyTime >= data.sellLimitCount
	end

	local limitStr = self:_getLimitTypeStr(data.sellPeriodLimit)

	limitTxt.text = string.nilorempty(limitStr) and "" or sellOut and string.format(limitStr, 0, data.sellLimitCount) or string.format(limitStr, data.sellLimitCount - buyTime, data.sellLimitCount)

	buyOutGo:SetActive(sellOut)

	local subLua = MaterialMgr.setCellByCfg(data.sellContent, goodsPos)
	local sellPriceSplit = string.split(data.sellPrice, ":")
	local priceType = sellPriceSplit[1] and checknumber(sellPriceSplit[1]) or 104
	local priceId = sellPriceSplit[2] and checknumber(sellPriceSplit[2]) or 1

	if not sellPriceSplit[3] then
		local priceCount = 100

		consumeTxt.text = MaterialFacade.instance:getGoodCost(priceType, priceId, priceCount)

		MaterialMgr.setIcon(consumeImaGo, priceType, priceId)

		local len = StringUtil.GetUtf8Length(priceCount)

		Framework.TransformUtil.SetLocalPos(consumeImaGo.transform, -25 - (len - 1) * 10, 2, 0)
		GameUtil.asBtn(cell):AddClickListener(function()
			if self._isActiEnd then
				FloatWordMgr.instance:show("活动结束")

				return
			end

			if sellOut then
				FloatWordMgr.instance:show("已售罄")

				return
			end

			local haveNum = MaterialModel.instance:getMaterialsNumber(priceType, priceId) or 0

			if priceType == MatType.Diamond_Consume then
				priceType = MatType.Diamond
				priceId = MatType.Diamond_Binding
			end

			if ((priceType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(priceCount) then
				local cfg = MaterialMgr.getMatCfg(priceType, priceId)

				if cfg then
					FloatWordMgr.instance:show(string.format("所需%s不足！", cfg.name))
				else
					FloatWordMgr.instance:show("所需货币不足！")
				end
			else
				UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, actType, actiId, itemId)
			end
		end, self)
	end
end

function XinxiyaShopView:_getLimitTypeStr(str)
	if string.nilorempty(str) or str == "none" then
		return
	end

	if str == "daily" then
		return "每日限购 %s/%s"
	end

	if str == "allTime" then
		return "活动限购 %s/%s"
	end

	if str == "weekly" then
		return "每周限购 %s/%s"
	end
end

return XinxiyaShopView

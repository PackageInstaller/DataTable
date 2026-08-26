-- chunkname: @modules/logic/battlepass/view/BpChargeView.lua

module("modules.logic.battlepass.view.BpChargeView", package.seeall)

local BpChargeView = class("BpChargeView", BaseView)

function BpChargeView:onInitView()
	self._btnBuyNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Root/left/#btnBuy")
	self._goBuyedNormal = gohelper.findChild(self.viewGO, "Root/left/#go_hasBuy")
	self._btnBuy2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/right/#btnBuy")
	self._txtPayStatus = gohelper.findChildText(self.viewGO, "Root/left/#btnBuy/txt")
	self._txtPayStatus2 = gohelper.findChildText(self.viewGO, "Root/right/#btnBuy/txt")
	self._txtPayStatus3 = gohelper.findChildText(self.viewGO, "Root/right/#btnBuy/txt_discount")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "Root/center/#simage_signature")
	self._goBuyed2 = gohelper.findChild(self.viewGO, "Root/right/#go_hasBuy")
	self._goleftitem = gohelper.findChild(self.viewGO, "Root/left/#scroll_new/viewport/content/Normal/Items/#go_Items")
	self._goleftitemup = gohelper.findChild(self.viewGO, "Root/left/#scroll_new/viewport/content/LvUp/#go_Items")
	self._gorightgriditem = gohelper.findChild(self.viewGO, "Root/right/layout/#scroll_new/viewport/content/Grid/#go_griditem")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Root/center/#txt_centerDesc/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpChargeView:addEvents()
	self._btnBuyNormal:AddClickListener(self._onClickbuyNormal, self)
	self._btnBuy2:AddClickListener(self._onClickbuy2, self)
	self._btnDetail:AddClickListener(self._btndetailOnClick, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._onUpdatePayStatus, self)
end

function BpChargeView:removeEvents()
	self._btnBuyNormal:RemoveClickListener()
	self._btnBuy2:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._onUpdatePayStatus, self)
end

function BpChargeView:_editableInitView()
	local skinId = BpConfig.instance:getCurSkinId(BpModel.instance.id)
	local heroId = lua_skin.configDict[skinId].characterId
	local heroCo = lua_character.configDict[heroId]

	self._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))

	local co = BpConfig.instance:getBpCO(BpModel.instance.id)

	if co then
		local skinname = gohelper.findChildTextMesh(self.viewGO, "Root/center/#txt_centerDesc")
		local name = gohelper.findChildTextMesh(self.viewGO, "Root/center/#txt_centerDesc/#txt_name")
		local nameEn = gohelper.findChildTextMesh(self.viewGO, "Root/center/#txt_centerDesc/#txt_name/#txt_nameEn")

		skinname.text = co.bpSkinDesc
		name.text = co.bpSkinNametxt
		nameEn.text = co.bpSkinEnNametxt
	end

	local normalCo = BpConfig.instance:getDesConfig(BpModel.instance.id, 1)
	local payCo = BpConfig.instance:getDesConfig(BpModel.instance.id, 2)
	local upLvCo = BpConfig.instance:getDesConfig(BpModel.instance.id, 3)
	local noShowNum = (tonumber(PlayerModel.instance:getMyUserId()) or 0) % 2 == 0

	self._itemGetTags = {
		self:getUserDataTb_(),
		self:getUserDataTb_()
	}

	self:createItems(self._goleftitem, normalCo, 1)
	self:createItems(self._goleftitemup, upLvCo, nil, noShowNum)
	self:createPay2Items(self._gorightgriditem, payCo, 2)
end

function BpChargeView:onOpenFinish()
	local cfg = BpModel.instance:checkOpenBpUpdatePopup()

	if cfg then
		ViewMgr.instance:openView(ViewName.BpReceiveRewardView, cfg)
	end
end

function BpChargeView:_btndetailOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function BpChargeView:createItems(go, colist, type, noShowNum)
	if not colist then
		return
	end

	gohelper.setActive(go, false)

	for i, co in ipairs(colist) do
		local dict = GameUtil.splitString2(co.items, true) or {}

		for index, arr in ipairs(dict) do
			local cloneGo = gohelper.cloneInPlace(go, "item" .. index)

			gohelper.setActive(cloneGo, true)

			if type == 2 and i == 1 then
				transformhelper.setLocalScale(cloneGo.transform, 0.8, 0.8, 1)
				transformhelper.setLocalRotation(cloneGo.transform, 0, 0, 13)
			end

			local limit = gohelper.findChild(cloneGo, "#go_Limit")
			local limit2 = gohelper.findChild(cloneGo, "#go_Limit_2")
			local txtLimit = gohelper.findChildTextMesh(cloneGo, "#go_Limit/txt_Limit")
			local txtLimit2 = gohelper.findChildTextMesh(cloneGo, "#go_Limit_2/txt_Limit")
			local itemGo = gohelper.findChild(cloneGo, "#go_item")
			local isGet = gohelper.findChild(cloneGo, "#goHasGet")
			local isNew = gohelper.findChild(cloneGo, "#go_new")
			local go_cruise = gohelper.findChild(cloneGo, "#go_cruise")
			local txtCruise = gohelper.findChildTextMesh(cloneGo, "#go_cruise/txt_Limit")
			local txt_num = gohelper.findChildTextMesh(cloneGo, "#txt_num")
			local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemGo)

			itemIcon:setMOValue(arr[1], arr[2], arr[3], nil, true)

			if not noShowNum then
				if arr[3] then
					local showNum = arr[3] ~= 0

					if arr[1] == MaterialEnum.MaterialType.HeroSkin then
						showNum = false
					end

					if type == 1 or type == 2 then
						showNum = false

						itemIcon:isShowQuality(false)

						local num = GameUtil.numberDisplay(arr[3])

						if num > 0 then
							gohelper.setActive(txt_num.gameObject, true)

							txt_num.text = luaLang("multiple") .. num
						else
							gohelper.setActive(txt_num.gameObject, false)
						end
					end

					itemIcon:isShowEquipAndItemCount(showNum)

					if showNum then
						itemIcon:setCountText(GameUtil.numberDisplay(arr[3]))
					end

					itemIcon:setCountFontSize(43)

					local isLimit = co.tagType == 1 or co.tagType == 3

					gohelper.setActive(limit, co.tagType == 1)

					if limit2 then
						gohelper.setActive(limit2, co.tagType == 3)
					end

					if isLimit then
						if co.tagType == 1 then
							txtLimit.text = co.tagTxt
						elseif co.tagType == 3 and limit2 then
							txtLimit2.text = co.tagTxt
						end
					end

					gohelper.setActive(isNew, arr[5] == 1)

					if type then
						table.insert(self._itemGetTags[type], isGet)
					end

					local isCruise = co.tagType == 2

					gohelper.setActive(go_cruise, isCruise)

					if isCruise then
						txtCruise.text = co.tagTxt
					end

					itemIcon:setCanShowDeadLine(not isCruise)
					itemIcon:setOnBeforeClickCallback(self._statItemOnClick, self, arr)
				end
			end
		end
	end
end

function BpChargeView:createPay2Items(go, colist, pType)
	if not colist then
		return
	end

	gohelper.setActive(go, false)

	for i, co in ipairs(colist) do
		local arrList = GameUtil.splitString2(co.items, true) or {}

		for _, arr in ipairs(arrList) do
			local cloneGo = gohelper.cloneInPlace(go)

			gohelper.setActive(cloneGo, true)
			self:_onCreatePay2Item(cloneGo, arr, co, pType)
		end
	end
end

function BpChargeView:_onCreatePay2Item(go, arr, co, pType)
	local goLimit = gohelper.findChild(go, "#go_Items/#go_Limit")
	local txtLimit = gohelper.findChildTextMesh(go, "#go_Items/#go_Limit/txt_Limit")
	local itemGo = gohelper.findChild(go, "#go_Items/#go_item")
	local goNew = gohelper.findChild(go, "#go_Items/#go_new")
	local goHasGet = gohelper.findChild(go, "#go_Items/#goHasGet")
	local txtName = gohelper.findChildTextMesh(go, "image_name/#txt_name")
	local txtDesc = gohelper.findChildTextMesh(go, "#txt_desc")
	local itemType, itemId, itemNum = arr[1], arr[2], arr[3]
	local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemGo)

	itemIcon:setMOValue(itemType, itemId, itemNum, nil, true)
	itemIcon:isShowEquipAndItemCount(false)
	gohelper.setActive(goLimit, co.tagType ~= 0)

	txtLimit.text = co.tagTxt

	gohelper.setActive(goNew, arr[5] == 1)
	itemIcon:setCanShowDeadLine(co.tagType ~= 2)

	local nameStr, descStr = self:_getShowNameAndDesc(itemType, itemId, itemNum, co.iconDesc)

	txtName.text = nameStr

	local isHasDesc = not string.nilorempty(descStr)

	gohelper.setActive(txtDesc, isHasDesc)

	if pType then
		table.insert(self._itemGetTags[pType], goHasGet)
	end

	if isHasDesc then
		txtDesc.text = descStr
	end

	itemIcon:setOnBeforeClickCallback(self._statItemOnClick, self, arr)
end

function BpChargeView:_getShowNameAndDesc(itemType, itemId, itemNum, descStr)
	local itemConfig = ItemModel.instance:getItemConfig(itemType, itemId)

	if itemConfig then
		if not itemNum or itemNum < 1 then
			return itemConfig.name, descStr
		end

		local lang = luaLang("v3a9_bpcharge_pay2item_name_num")

		return GameUtil.getSubPlaceholderLuaLangTwoParam(lang, itemConfig.name, itemNum), descStr
	end

	return "", descStr
end

function BpChargeView:onDestroyView()
	self._simagesignature:UnLoadImage()
end

function BpChargeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)
	self:_onUpdatePayStatus()
end

function BpChargeView:_onClickbuyNormal()
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1)
	end
end

function BpChargeView:_onClickbuy2()
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId2)
	else
		PayController.instance:startPay(lua_bp.configDict[BpModel.instance.id].chargeId1to2)
	end
end

function BpChargeView:_onUpdatePayStatus()
	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		local shopCo1 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1)
		local shopCo2 = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId2)

		self._txtPayStatus.text = string.format("%s%s", StoreModel.instance:getCostStr(shopCo1.price))
		self._txtPayStatus2.text = string.format("%s%s", StoreModel.instance:getCostStr(shopCo2.price))
		self._txtPayStatus3.text = string.format("<s>%s%s</s>", StoreModel.instance:getCostStr(shopCo2.originalCost))

		gohelper.setActive(self._btnBuyNormal.gameObject, true)
		gohelper.setActive(self._btnBuy2.gameObject, true)
		gohelper.setActive(self._goBuyedNormal, false)
		gohelper.setActive(self._goBuyed2, false)
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		local shopCo = StoreConfig.instance:getChargeGoodsConfig(lua_bp.configDict[BpModel.instance.id].chargeId1to2)

		gohelper.setActive(self._btnBuyNormal.gameObject, false)
		gohelper.setActive(self._btnBuy2.gameObject, true)
		gohelper.setActive(self._goBuyedNormal, true)
		gohelper.setActive(self._goBuyed2, false)

		self._txtPayStatus2.text = string.format("%s%s", StoreModel.instance:getCostStr(shopCo.price))
		self._txtPayStatus3.text = ""
	else
		gohelper.setActive(self._btnBuyNormal.gameObject, false)
		gohelper.setActive(self._btnBuy2.gameObject, false)
		gohelper.setActive(self._goBuyedNormal, true)
		gohelper.setActive(self._goBuyed2, true)
	end

	for _, go in pairs(self._itemGetTags[1]) do
		gohelper.setActive(go, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay)
	end

	for _, go in pairs(self._itemGetTags[2]) do
		gohelper.setActive(go, BpModel.instance.payStatus == BpEnum.PayStatus.Pay2)
	end
end

function BpChargeView:_statItemOnClick(params)
	if params then
		local itemType, itemId = params[1], params[2]

		BpController.instance:statItemClick(itemType, itemId, self.viewName)
	end
end

return BpChargeView

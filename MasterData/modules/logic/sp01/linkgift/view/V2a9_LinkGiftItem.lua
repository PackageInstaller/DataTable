-- chunkname: @modules/logic/sp01/linkgift/view/V2a9_LinkGiftItem.lua

module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftItem", package.seeall)

local V2a9_LinkGiftItem = class("V2a9_LinkGiftItem", LuaCompBase)

function V2a9_LinkGiftItem:init(go)
	self.viewGO = go
	self.go = go
	self._txtprice = gohelper.findChildText(self.viewGO, "btn/#btn_buy/#txt_buy")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_buy")
	self._gohasget = gohelper.findChild(self.viewGO, "btn/#go_hasget")
	self._txtnum = gohelper.findChildText(self.viewGO, "reward01/bg/#txt_num")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "reward02/bg/#txt_num")
	self._txttitle = gohelper.findChildText(self.viewGO, "txt_title")

	if self._editableInitView then
		self:_editableInitView()
	end

	self:addEvents()
end

function V2a9_LinkGiftItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V2a9_LinkGiftItem:removeEvents()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end
end

function V2a9_LinkGiftItem:_btnclickOnClick()
	if self._charageGoodsCfg and self._packageGoodsMO then
		if ViewMgr.instance:isOpen(ViewName.SummonADView) then
			StoreController.instance:openPackageStoreGoodsView(self._packageGoodsMO)
		else
			StoreController.instance:openStoreView(self._charageGoodsCfg.belongStoreId, self._charageGoodsCfg.id)
		end
	end
end

function V2a9_LinkGiftItem:_editableInitView()
	self._tbItem = self:_createTBItem(gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewarditem1"))
	self._condTbItem = self:_createTBItem(gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewarditem2"))
	self._condTbItem.txtlock = gohelper.findChildText(self._condTbItem.go, "txt_extra")
end

function V2a9_LinkGiftItem:onUpdateMO(charageGoodsCfg)
	self._charageGoodsCfg = charageGoodsCfg
	self._packageGoodsMO = charageGoodsCfg and StoreModel.instance:getGoodsMO(charageGoodsCfg.id)

	gohelper.setActive(self.go, charageGoodsCfg ~= nil)

	if not charageGoodsCfg then
		return
	end

	local condCfg = StoreConfig.instance:getChargeConditionalConfig(charageGoodsCfg.taskid)

	if self._packageGoodsMO then
		local isBuy = self._packageGoodsMO.buyCount > 0

		if self._packageGoodsMO then
			local goodsId = self._packageGoodsMO.id
			local isTaskFinsish = isBuy and StoreCharageConditionalHelper.isCharageTaskFinish(goodsId)
			local isCanGet = isBuy and StoreCharageConditionalHelper.isHasCanFinishGoodsTask(goodsId)
			local isUnlock = StoreCharageConditionalHelper.isCharageCondition(goodsId)

			self._isCanGet = isCanGet

			if charageGoodsCfg.product then
				local bonusList = GameUtil.splitString2(charageGoodsCfg.product, true)
				local condBonusList = condCfg and GameUtil.splitString2(condCfg.bonus, true)

				gohelper.setActive(self._tbItem.goreceive, isBuy)
				gohelper.setActive(self._condTbItem.goreceive, isTaskFinsish)
				gohelper.setActive(self._condTbItem.gocanget, isCanGet)
				gohelper.setActive(self._condTbItem.golock, not isUnlock)
				gohelper.setActive(self._btnclick, not isBuy)
				gohelper.setActive(self._gohasget, isBuy)
				self:_setIconBouns(self._tbItem.iconList, bonusList, self._tbItem.goicon)
				self:_setIconBouns(self._condTbItem.iconList, condBonusList, self._condTbItem.goicon, true)
				self:_setCurrencyIcon(self._tbItem.simagecurrency, bonusList)
				self:_setCurrencyIcon(self._condTbItem.simagecurrency, condBonusList)

				if goodsId and self._txtprice then
					self._txtprice.text = StoreModel.instance:getCostPriceFull(goodsId)
				end

				if isBuy and goodsId then
					local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.V2a9_LinkGiftItemGoodsAnim .. goodsId)

					if isCanGet then
						self:_playGoAnimByKey(self._condTbItem.gocanget, key .. "_gocanget")
					end

					if isTaskFinsish then
						self:_playGoAnimByKey(self._condTbItem.goreceive, key .. "_goreceive")
					end
				end

				local bounsCount, summonCount = self:_getRewardCount(bonusList)
				local condBonusCount, condSummonCount = self:_getRewardCount(condBonusList)

				self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_v2a9linkgiftview_itemcount_txt"), bounsCount)
				self._txtnum2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_v2a9linkgiftview_itemcount_txt"), condBonusCount)
				self._txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_v2a9linkgiftview_title_txt"), summonCount + condSummonCount)
				self._condTbItem.txtlock.text = isUnlock and luaLang("store_linkfigt_getitnow_txt") or condCfg and condCfg.conDesc
			end
		end
	end
end

function V2a9_LinkGiftItem:_playGoAnimByKey(go, key)
	local num = PlayerPrefsHelper.getNumber(key, 0)

	if num ~= 1 then
		PlayerPrefsHelper.setNumber(key, 1)

		if go then
			local animator = go:GetComponent(gohelper.Type_Animator)

			if animator then
				animator:Play("open", 0, 0)
			end
		end
	end
end

function V2a9_LinkGiftItem:_updateItemUI(tb, bonusList, txtStr)
	return
end

function V2a9_LinkGiftItem:_createTBItem(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goicon = gohelper.findChild(go, "#go_icon")
	tb.golock = gohelper.findChild(go, "#go_lock")
	tb.gocanget = gohelper.findChild(go, "#go_canget")
	tb.goreceive = gohelper.findChild(go, "#go_receive")
	tb.simagecurrency = gohelper.findChildSingleImage(go, "bg/icon")
	tb.iconList = self:getUserDataTb_()

	gohelper.setActive(tb.golock, false)
	gohelper.setActive(tb.gocanget, false)
	gohelper.setActive(tb.goreceive, false)

	return tb
end

function V2a9_LinkGiftItem:_getRewardCount(bonusList)
	local count = 0
	local summonCount = 0

	if bonusList and #bonusList > 0 then
		for i, bonus in ipairs(bonusList) do
			if bonus and #bonus >= 3 then
				count = count + bonus[3]
				summonCount = summonCount + SummonConfig.instance:getSummonCountByItemId(bonus[2]) * bonus[3]
			end
		end
	end

	return count, summonCount
end

function V2a9_LinkGiftItem:_setCurrencyIcon(simageIcon, bonusList)
	StoreLinkGiftGoodsView.setCurrencyIconByBouns(simageIcon, bonusList)
end

function V2a9_LinkGiftItem:_setIconBouns(iconList, bonusList, parentGO, iscall)
	if not bonusList then
		return
	end

	local countIdx = 0

	for i, bonus in ipairs(bonusList) do
		if bonus and #bonus >= 2 then
			countIdx = countIdx + 1

			local itemIcon = iconList[countIdx]

			if not itemIcon then
				itemIcon = IconMgr.instance:getCommonItemIcon(parentGO)

				table.insert(iconList, itemIcon)

				if iscall == true then
					itemIcon:setInterceptClick(self._onItemIconClick, self)
				end
			end

			local itemType = bonus[1]
			local itemId = bonus[2]

			if not bonus[3] then
				self:_setIcon(itemIcon, itemType, itemId, bonus[3])
			end
		end
	end
end

function V2a9_LinkGiftItem:_setIcon(icon, type, id, quantity)
	icon:setMOValue(type, id, quantity, nil, true)
	icon:setCantJump(true)
	icon:setCountFontSize(36)
	icon:SetCountLocalY(43.6)
	icon:SetCountBgHeight(25)
end

function V2a9_LinkGiftItem:_onItemIconClick()
	if self._charageGoodsCfg and self._isCanGet then
		StoreGoodsTaskController.instance:sendFinishTaskRequest(self._charageGoodsCfg.taskid)

		return true
	end

	return false
end

function V2a9_LinkGiftItem:onDestroy()
	self:removeEvents()
	self:__onDispose()
end

return V2a9_LinkGiftItem

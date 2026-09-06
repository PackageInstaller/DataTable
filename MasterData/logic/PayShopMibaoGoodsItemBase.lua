-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/mibaogoodsitem/PayShopMibaoGoodsItemBase.lua

module("logic.extensions.payshop.view.mibaogoodsitem.PayShopMibaoGoodsItemBase", package.seeall)

local PayShopMibaoGoodsItemBase = class("PayShopMibaoGoodsItemBase", BaseLuaOnce)

function PayShopMibaoGoodsItemBase:buildUI()
	local btn = goutil.findChild(self.mainGO, "btnBuy2")

	self._btnBuy2 = GameUtil.asBtn(btn)
	self.dot = goutil.findChild(self.mainGO, "dot")
	self.sellOut = goutil.findChild(self.mainGO, "sellOut")
	self._textConGo = goutil.findChild(self.mainGO, "textCon")
	self._norText = goutil.findChildTextComponent(self.mainGO, "textCon/norText")
	self._norTextTr = self._norText.transform
	self._payIconChange = goutil.findChild(self.mainGO, "textCon/norText"):GetComponent(ComponentType.UIChangeGroup)
	self._payIconGo = goutil.findChild(self.mainGO, "textCon/norText/payIcon")
	self._discountPayIconGo = self:getGo("textCon/disCountTxt/payIcon")
	self._discountPayIconChange = self:getGo("textCon/disCountTxt"):GetComponent(ComponentType.UIChangeGroup)
	self._disCountText = goutil.findChildTextComponent(self.mainGO, "textCon/disCountTxt")
	self._disCountCon = self._disCountText.gameObject
	self._disCountConTr = self._disCountCon.transform
	self._discountLineGo = self:getGo("textCon/norText/payIcon/discountLine")
	self._imgState = goutil.findChild(self.mainGO, "imgState")
	self._tagState = goutil.findChild(self.mainGO, "tagState")
	self._imgStateTxt = goutil.findChildTextComponent(self._tagState, "txtState")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "tipText")
	self._disCountImgGo = goutil.findChild(self.mainGO, "disCountImg")
	self._disCountImgText = goutil.findChildTextComponent(self._disCountImgGo, "Text")
	self._disCountImgChange = goutil.findChild(self.mainGO, "disCountImg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._disCountTextChange = goutil.findChild(self.mainGO, "disCountImg/Text"):GetComponent(ComponentType.UITextColorChange)

	local bgGo = goutil.findChild(self.mainGO, "bg")

	self._effectCon = bgGo.transform
	self._bgChange = bgGo:GetComponent(ComponentType.UIImageSpriteChange)
	self._sellOutBtn = GameUtil.asBtn(self:getGo("sellOut"))
	self._txtJump = self:getTxt("txtJump")
end

function PayShopMibaoGoodsItemBase:bindEvents()
	self._btnBuy2:AddClickListener(self._onClickBuy, self)
	self._sellOutBtn:AddClickListener(self._onClickSellOut, self)
end

function PayShopMibaoGoodsItemBase:unbindEvents()
	self._btnBuy2:RemoveClickListener()
	self._sellOutBtn:RemoveClickListener()
end

function PayShopMibaoGoodsItemBase:onEnter(refTarget, scrollRect, data, showLeftTime)
	GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self.changeBuyTime, self)

	self._refTarget = refTarget
	self._scrollRect = scrollRect
	self._data = data.goodsData
	self._showLeftTime = showLeftTime
	self._discountPlanId = 0
	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._data.id)

	self:_updateView()
end

function PayShopMibaoGoodsItemBase:onExit()
	UIEffectManager.instance:stopEffect(self._effect)
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self.changeBuyTime, self)
	MaterialMgr.resetAll(self._payIconGo)
	MaterialMgr.resetAll(self._discountPayIconGo)
end

function PayShopMibaoGoodsItemBase:_onClickBuy(showTips)
	if showTips == nil then
		showTips = true
	end

	if self:_isJumpGoods() then
		GotoMgr.gotoByString(self._goodsCfg.jumpTo)

		return
	end

	if self.isSellOut then
		if showTips then
			FloatWordMgr.instance:show("已售罄")
		end

		return
	end

	local sellKey = ""

	if checknumber(self._goodsCfg.deducePlanId) > 0 then
		local matType, id, matNum = MaterialMgr.getMatParams(self._goodsCfg.originalGoodsId)

		if matType == MatType.Coin then
			if id == MatType.Coin_Skin then
				sellKey = GameEnum.PayShopTabSellType.SellSkin
			elseif id == MatType.Coin_Mount then
				sellKey = GameEnum.PayShopTabSellType.SellMount
			end
		end
	end

	local bestPlanId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsCfg.id)

	if not string.nilorempty(sellKey) then
		UIStateManager.instance:push(ViewName.PayshoppetdetailView, sellKey, self._goodsCfg.id, bestPlanId, self._showLeftTime, false)
	else
		UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, self._data, self._showLeftTime, bestPlanId)
	end
end

function PayShopMibaoGoodsItemBase:_onClickSellOut()
	FloatWordMgr.instance:show("已售罄")
end

function PayShopMibaoGoodsItemBase:_updateView()
	self.isSellOut = false

	local goodsCfg = self._goodsCfg
	local quality = 0

	self._payIconChange:SetState(0)

	if goodsCfg then
		quality = goodsCfg.quality

		if not self:_isJumpGoods() then
			self:_setLimitContent(goodsCfg)
			self:setDisCount(goodsCfg)

			self.isSellOut = self:_checkGoodsSellOut(goodsCfg)
		end

		self:_setGoodsName(goodsCfg)

		local tagDesc = goodsCfg.tag

		goutil.setActive(self._tagState, not string.nilorempty(tagDesc) and tagDesc ~= "热")
		goutil.setActive(self._imgState, not string.nilorempty(tagDesc) and tagDesc == "热")

		self._imgStateTxt.text = tagDesc

		goutil.setActive(self.sellOut, self.isSellOut)
		self:setIcon(goodsCfg)
		self:_setVipTag(goodsCfg)
	end

	self:_setBgEffect(quality)
	self:checkRedDot()
	self:_onSetJumpGoods()
end

function PayShopMibaoGoodsItemBase:_setBgEffect(quality)
	if self._bgChange then
		self._bgChange:SetState(quality)
	end
end

function PayShopMibaoGoodsItemBase:changeBuyTime(id, times)
	if self._data.id == id then
		self._data.times = times

		self:_updateView()
	end
end

function PayShopMibaoGoodsItemBase:_isFirstBuy(cfg)
	if self._data and self._data.totalBuyTimes and self._data.totalBuyTimes <= 0 and string.trim(cfg.firstBuyExtraContent) ~= "" then
		return true
	end

	return false
end

function PayShopMibaoGoodsItemBase:checkRedDot()
	goutil.setActive(self.dot, (self._data or nil) and PayShopModel.instance:checGoodsFreeBuyDot(self._data.id))
end

function PayShopMibaoGoodsItemBase:_setLimitContent(goodsCfg)
	local isLimitBuy, preStr = self:_checkIsLimitAndGetLimitPreStr(goodsCfg)
	local txtLimit = self:_getLimitTxt()

	txtLimit.text = isLimitBuy and preStr .. math.max(0, goodsCfg.limitTimes - self._data.times) .. "/" .. goodsCfg.limitTimes or ""
end

function PayShopMibaoGoodsItemBase:_checkIsLimitAndGetLimitPreStr(goodsCfg)
	local isLimitBuy = goodsCfg.sellTargetLimit ~= "none" and goodsCfg.limitTimes > 0

	return isLimitBuy, (isLimitBuy or nil) and PayShopModel.instance:getLimitPerStr(goodsCfg)
end

function PayShopMibaoGoodsItemBase:_getLimitTxt()
	printError("重写_getLimitTxt！！！")
end

function PayShopMibaoGoodsItemBase:setIcon(goodsCfg)
	printError("重写setIcon！！！")
end

function PayShopMibaoGoodsItemBase:_setNorIcon(goodsCfg)
	goutil.setActive(self._boxIcon, false)
	goutil.setActive(self._showRewardCon, true)
	uGuiUtil.setSpriteToImage(self._boxIcon2, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon))

	local t2 = string.split(goodsCfg.content, "#")
	local dataList = {}

	for i, v in ipairs(t2) do
		table.insert(dataList, {
			cfgStr = v
		})
	end

	local isgift = goodsCfg.groupId > 0

	if isgift then
		local gcfg = PayShopConfig.instance:getGroupCfg(goodsCfg.groupId)
		local presentGains = string.split(gcfg.presentGain, "#")

		for i, v in ipairs(presentGains) do
			table.insert(dataList, {
				isgift = true,
				cfgStr = v,
				totalDays = gcfg.totalDays
			})
		end
	end

	self._showRewardGroup:updateWithMoArray(dataList, function(item, data)
		local parent = goutil.findChild(item.mainGO, "cell")
		local giftTag = goutil.findChild(item.mainGO, "giftTag")
		local giftTagText = goutil.findChildTextComponent(item.mainGO, "giftTag/text")
		local proxy = MaterialMgr.setCellByCfg(data.cfgStr, parent)

		goutil.setActive(giftTag, data.isgift)

		if data.isgift then
			giftTagText.text = data.totalDays .. "天"
		end
	end)
end

function PayShopMibaoGoodsItemBase:_setRechargeIcon(goodsCfg)
	goutil.setActive(self._boxIcon, true)
	goutil.setActive(self._showRewardCon, false)
	uGuiUtil.setSpriteToImage(self._boxIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon))
end

function PayShopMibaoGoodsItemBase:_setVipTag(goodsCfg)
	if goodsCfg.sellTargetLimit == "vip" then
		local isVip = VipModel.instance:isVip()
		local needShow = false

		if not isVip then
			needShow = true
		else
			local vipLv = VipModel.instance:getCurVipLv()

			if vipLv < goodsCfg.vipLevel then
				needShow = true
			end
		end

		if needShow then
			GameUtil.SetActive(self._disCountImgGo, true)

			self._disCountImgText.text = "VIP" .. goodsCfg.vipLevel
		end
	end
end

function PayShopMibaoGoodsItemBase:_checkGoodsSellOut(goodsCfg)
	local matArr = string.split(goodsCfg.content, "#")
	local emojiSellOut = false
	local pigraiseSellOut = false

	for _, matStr in ipairs(matArr) do
		local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

		if matType == MatType.EmojiPack then
			emojiSellOut = self:_checkEmojiSellOut(matId)
		else
			pigraiseSellOut = self:_checkPigraiseSellOut(goodsCfg)
		end
	end

	if emojiSellOut or pigraiseSellOut or PayShopModel.instance:chechShopGoodsSkillHave(goodsCfg) then
		return true
	else
		return goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 and self._data.times >= goodsCfg.limitTimes
	end
end

function PayShopMibaoGoodsItemBase:_checkEmojiSellOut(groupId)
	local emojiUnLockIds = NewChatModel.instance:getUnlockedEmoticonGroupIds()

	if emojiUnLockIds then
		return emojiUnLockIds[groupId]
	end
end

function PayShopMibaoGoodsItemBase:_checkPigraiseSellOut(goodsCfg)
	local petDatas = PigraiseModel.instance:getAllPetInfo()
	local allPetCfgs = PigraiseConfig.instance:getAllPetCfgs()
	local matArr = string.split(goodsCfg.content, "#")

	for _, matStr in ipairs(matArr) do
		for _, cfg in ipairs(allPetCfgs) do
			if cfg.activateItem == matStr then
				for _, data in ipairs(petDatas) do
					if checknumber(data.defineId) == cfg.defineId then
						return data:isAbleUnlockOrOwn()
					end
				end
			end
		end
	end
end

function PayShopMibaoGoodsItemBase:setDisCount(goodsCfg)
	local payGoodsId = goodsCfg.originalGoodsId
	local isFree = string.nilorempty(payGoodsId)

	if isFree then
		self:_setPayBtnTextAndIcon()
	elseif string.find(payGoodsId, "rmb") then
		goutil.setActive(self._payIconGo, true)
	end

	if not isFree then
		self:_setPayBtnTextAndIcon(goodsCfg.payType, goodsCfg.originalGoodsId)
		self:_setDiscountPayBtnTextAndIcon(goodsCfg)
	end

	if goodsCfg.disCount > 0 then
		self._disCountImgText.text = string.format("%s折", goodsCfg.disCount / 100)
	end

	local isFirstBuy = self:_isFirstBuy(goodsCfg)

	if isFirstBuy then
		self._disCountImgText.text = goodsCfg.disCountTxt

		local t = GameUtil.parseItemStr(goodsCfg.firstBuyExtraContent)
		local name = MaterialMgr.getMaterialsName(t[1].itemType, t[1].itemId)

		self._tipText.text = "首充额外赠送" .. t[1].count .. name
	else
		self._tipText.text = ""
	end

	self._disCountImgChange:SetState(isFirstBuy and 1 or 0)
	self._disCountTextChange:SetState(isFirstBuy and 1 or 0)
	goutil.setActive(self._disCountImgGo, goodsCfg.disCount > 0 or isFirstBuy)
	self:_setDeducePayBtnTextAndIcon()
end

function PayShopMibaoGoodsItemBase:_setPayBtnTextAndIcon(payType, payGoodsId)
	goutil.setActive(self._discountLineGo, false)
	goutil.setActive(self._disCountCon, false)
	Framework.TransformUtil.SetAnchoredPos(self._norTextTr, 12, 0)

	if payType == GameEnum.PayShopPayType.RMB then
		goutil.setActive(self._payIconGo, true)
		self._payIconChange:SetState(0)
		self._payIconChange:SetState(2)

		self._norText.text = PayConfig.instance:getPayMoneyYuan(payGoodsId)
	elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
		self._payIconChange:SetState(0)
		goutil.setActive(self._payIconGo, true)

		local list = string.split(payGoodsId, ":")
		local matType = checknumber(list[1])
		local matId = checknumber(list[2])

		self._norText.text = list[#list]

		MaterialMgr.setIcon(self._payIconGo, matType, matId)
	else
		goutil.setActive(self._payIconGo, false)

		self._norText.text = "免费"
	end
end

function PayShopMibaoGoodsItemBase:_setDiscountPayBtnTextAndIcon(goodsCfg)
	local useTime = PayShopModel.instance:getUseDiscountTimes(goodsCfg.id)

	if goodsCfg.discountLimitTimes > 0 and useTime >= goodsCfg.discountLimitTimes then
		goutil.setActive(self._discountLineGo, false)
		goutil.setActive(self._disCountCon, false)

		return
	end

	local planId = PayShopController.instance:getBestFreeDiscountPlanIdByGoodsDefineId(goodsCfg.id)

	if planId > 0 then
		self._discountPlanId = planId

		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)
		local payType = dcfg.payType
		local payGoodsId = dcfg.discountPrice

		goutil.setActive(self._discountLineGo, true)
		goutil.setActive(self._disCountCon, true)
		self:_setHasDiscPlanPos()

		if payType == GameEnum.PayShopPayType.RMB then
			goutil.setActive(self._discountPayIconGo, true)
			self._discountPayIconChange:SetState(0)
			self._discountPayIconChange:SetState(2)

			self._disCountText.text = PayConfig.instance:getPayMoneyYuan(payGoodsId)
		elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
			self._discountPayIconChange:SetState(0)
			goutil.setActive(self._discountPayIconGo, true)

			local list = string.split(payGoodsId, ":")
			local matType = checknumber(list[1])
			local matId = checknumber(list[2])

			self._disCountText.text = list[#list]

			MaterialMgr.setIcon(self._discountPayIconGo, matType, matId)
		else
			goutil.setActive(self._discountPayIconGo, false)

			self._disCountText.text = "免费"
		end
	end
end

function PayShopMibaoGoodsItemBase:_setGoodsName(goodsCfg)
	self._txtName.text = goodsCfg.name
end

function PayShopMibaoGoodsItemBase:_setHasDiscPlanPos()
	Framework.TransformUtil.SetAnchoredPos(self._norTextTr, -40, 0)
	Framework.TransformUtil.SetAnchoredPos(self._disCountConTr, 55, 0)
end

function PayShopMibaoGoodsItemBase:_setDeducePayBtnTextAndIcon()
	local planId = PayShopModel.instance:getBestDiscountPlanIdByGoodsDefineId(self._goodsCfg.id)

	if planId > 0 then
		return
	end

	if self._goodsCfg.deducePlanId > 0 then
		goutil.setActive(self._discountLineGo, false)
		goutil.setActive(self._disCountCon, true)
		self:_setHasDiscPlanPos()

		local cfg = PayShopConfig.instance:getDeduceCfg(self._goodsCfg.deducePlanId)
		local originalGoodsId = self._goodsCfg.originalGoodsId
		local oriList = string.split(originalGoodsId, ":")
		local oriNum = checkint(oriList[#oriList])
		local replaceList = string.split(cfg.deduction, ":")
		local replaceMatType = checkint(replaceList[1])
		local replaceMatId = checkint(replaceList[2])

		self._disCountText.text = math.ceil(oriNum / cfg.deduceFactor)

		MaterialMgr.setIcon(self._discountPayIconGo, replaceMatType, replaceMatId)
	end
end

function PayShopMibaoGoodsItemBase:_isJumpGoods()
	return self._goodsCfg.payType == GameEnum.PayShopPayType.JUMPGOODS
end

function PayShopMibaoGoodsItemBase:_onSetJumpGoods()
	local is_JumpGoods = self:_isJumpGoods()

	goutil.setActive(self._textConGo, not is_JumpGoods)

	self._txtJump.text = is_JumpGoods and self._goodsCfg.jumpToDesc or ""
end

function PayShopMibaoGoodsItemBase:_getCurrDiscPlanId()
	return self._discountPlanId
end

return PayShopMibaoGoodsItemBase

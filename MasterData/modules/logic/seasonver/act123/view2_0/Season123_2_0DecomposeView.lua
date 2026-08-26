-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0DecomposeView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0DecomposeView", package.seeall)

local Season123_2_0DecomposeView = class("Season123_2_0DecomposeView", BaseView)

function Season123_2_0DecomposeView:onInitView()
	self._gocardpos = gohelper.findChild(self.viewGO, "object/Info/card/#go_cardpos")
	self._txtcardName = gohelper.findChildText(self.viewGO, "object/Info/card/#txt_cardName")
	self._simagegetCoin = gohelper.findChildSingleImage(self.viewGO, "object/Info/coin/#simage_getCoin")
	self._txtcoinName = gohelper.findChildText(self.viewGO, "object/Info/coin/#txt_coinName")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "object/#go_decompose/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "object/#go_decompose/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "object/#go_decompose/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "object/#go_decompose/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "object/#go_decompose/#btn_max")
	self._simagecoin = gohelper.findChildSingleImage(self.viewGO, "object/#go_decompose/decomposeGet/txt/#simage_coin")
	self._txtgetCoin = gohelper.findChildText(self.viewGO, "object/#go_decompose/decomposeGet/#txt_getCoin")
	self._btndecompose = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_decompose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0DecomposeView:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btndecompose:AddClickListener(self._btndecomposeOnClick, self)
	self._inputvalue:AddOnEndEdit(self._onEndEdit, self)
end

function Season123_2_0DecomposeView:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btndecompose:RemoveClickListener()
	self._inputvalue:RemoveOnEndEdit()
end

function Season123_2_0DecomposeView:_btnminOnClick()
	self.curCount = self.minDecomposeCount

	self:refreshInfoBySelectCount()
end

function Season123_2_0DecomposeView:_btnsubOnClick()
	if self.curCount <= self.minDecomposeCount then
		self.curCount = self.minDecomposeCount

		return
	else
		self.curCount = self.curCount - 1
	end

	self:refreshInfoBySelectCount()
end

function Season123_2_0DecomposeView:_btnaddOnClick()
	if self.curCount >= self.maxDecomposeCount then
		self.curCount = self.maxDecomposeCount

		GameFacade.showToast(ToastEnum.MaxEquips)

		return
	else
		self.curCount = self.curCount + 1
	end

	self:refreshInfoBySelectCount()
end

function Season123_2_0DecomposeView:_btnmaxOnClick()
	self.curCount = self.maxDecomposeCount

	self:refreshInfoBySelectCount()
end

function Season123_2_0DecomposeView:_btndecomposeOnClick()
	self.selectDecomposeList = {}

	for i = 1, #self.decomposeItemList do
		if i <= self.curCount then
			table.insert(self.selectDecomposeList, self.decomposeItemList[i])
		end
	end

	local isItemUsedByHero = Season123DecomposeModel.instance:isDecomposeItemUsedByHero(self.selectDecomposeList)

	if isItemUsedByHero then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, self.sendDecomposeEquipRequest, nil, nil, self)
	else
		self:sendDecomposeEquipRequest()
	end
end

function Season123_2_0DecomposeView:sendDecomposeEquipRequest()
	local list = {}

	for k, mo in ipairs(self.selectDecomposeList) do
		table.insert(list, mo.uid)
	end

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeEffectPlay, list)
	self:closeThis()
end

function Season123_2_0DecomposeView:_onEndEdit()
	local decomposeCount = tonumber(self._inputvalue:GetText())

	decomposeCount = decomposeCount and math.floor(decomposeCount)

	if not decomposeCount or decomposeCount <= 0 then
		decomposeCount = self.minDecomposeCount
	end

	self.curCount = math.max(math.min(decomposeCount, self.maxDecomposeCount), self.minDecomposeCount)

	self:refreshInfoBySelectCount()
end

function Season123_2_0DecomposeView:_editableInitView()
	return
end

function Season123_2_0DecomposeView:onOpen()
	self.itemId = self.viewParam.itemId
	self.actId = self.viewParam.actId
	self.curCount = 1
	self.minDecomposeCount = 1
	self.decomposeItemList = Season123DecomposeModel.instance:getDecomposeItemsByItemId(self.actId, self.itemId)
	self.maxDecomposeCount = GameUtil.getTabLen(self.decomposeItemList)

	self:CreateCardIcon()
	self:refreshUI()
end

function Season123_2_0DecomposeView:refreshUI()
	self.itemConfig = Season123Config.instance:getSeasonEquipCo(self.itemId)
	self._txtcardName.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_decompose_cardName"), {
		self.itemConfig.name,
		"1"
	})

	local coinId = Season123Config.instance:getEquipItemCoin(self.actId, Activity123Enum.Const.EquipItemCoin)

	self.coinConfig = CurrencyConfig.instance:getCurrencyCo(coinId)

	self._simagegetCoin:LoadImage(ResUrl.getCurrencyItemIcon(self.coinConfig.icon))
	self._simagecoin:LoadImage(ResUrl.getCurrencyItemIcon(self.coinConfig.icon))

	self._txtcoinName.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_decompose_cardName2"), {
		self.coinConfig.name,
		self.itemConfig.decomposeGet
	})
	self._txtgetCoin.text = luaLang("multiple") .. self.curCount * self.itemConfig.decomposeGet
end

function Season123_2_0DecomposeView:refreshInfoBySelectCount()
	self._inputvalue:SetText(self.curCount)

	self._txtgetCoin.text = luaLang("multiple") .. self.curCount * self.itemConfig.decomposeGet
end

function Season123_2_0DecomposeView:CreateCardIcon()
	if not self.cardIcon then
		local path = self.viewContainer:getSetting().otherRes[1]
		local go = self:getResInst(path, self._gocardpos, "icon")

		self.cardIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season123_2_0CelebrityCardEquip)
	end

	self.cardIcon:updateData(self.itemId)
	self.cardIcon:setClickCall(self.showMaterialInfoTip, self)
end

function Season123_2_0DecomposeView:showMaterialInfoTip()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, self.itemId)
end

function Season123_2_0DecomposeView:onClose()
	return
end

function Season123_2_0DecomposeView:onDestroyView()
	if self.cardIcon then
		self.cardIcon:disposeUI()
	end
end

return Season123_2_0DecomposeView

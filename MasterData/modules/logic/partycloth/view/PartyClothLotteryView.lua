-- chunkname: @modules/logic/partycloth/view/PartyClothLotteryView.lua

module("modules.logic.partycloth.view.PartyClothLotteryView", package.seeall)

local PartyClothLotteryView = class("PartyClothLotteryView", BaseView)

function PartyClothLotteryView:onInitView()
	self._scrollSuit = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_Suit")
	self._btnDress = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_Dress")
	self._btnSummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Summon1")
	self._txtNum1 = gohelper.findChildText(self.viewGO, "#btn_Summon1/#txt_Num1")
	self._txtSummon1 = gohelper.findChildText(self.viewGO, "#btn_Summon1/#txt_Summon1")
	self._btnSummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Summon10")
	self._txtNum10 = gohelper.findChildText(self.viewGO, "#btn_Summon10/#txt_Num10")
	self._txtSummon10 = gohelper.findChildText(self.viewGO, "#btn_Summon10/#txt_Summon10")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyClothLotteryView:addEvents()
	self._btnDress:AddClickListener(self._btnDressOnClick, self)
	self._btnSummon1:AddClickListener(self._btnSummon1OnClick, self)
	self._btnSummon10:AddClickListener(self._btnSummon10OnClick, self)
end

function PartyClothLotteryView:removeEvents()
	self._btnDress:RemoveClickListener()
	self._btnSummon1:RemoveClickListener()
	self._btnSummon10:RemoveClickListener()
end

function PartyClothLotteryView:_btnDressOnClick()
	PartyClothController.instance:openPartyClothView()
	self:closeThis()
end

function PartyClothLotteryView:_btnSummon1OnClick()
	if self.leftPrize < 1 then
		GameFacade.showToast(ToastEnum.PartyClothPrizeNotEnough)

		return
	elseif self.coinCnt < self.summon1Cost then
		GameFacade.showToast(ToastEnum.PartyClothCoinNotEnough)

		return
	end

	PartyClothRpc.instance:sendSummonPartyClothRequest(self.poolMo.poolId, 1)
end

function PartyClothLotteryView:_btnSummon10OnClick()
	if self.leftPrize < self.Summon10Cnt then
		GameFacade.showToast(ToastEnum.PartyClothPrizeNotEnough)

		return
	elseif self.coinCnt < self.Summon10Cnt * self.summon1Cost then
		GameFacade.showToast(ToastEnum.PartyClothCoinNotEnough)

		return
	end

	PartyClothRpc.instance:sendSummonPartyClothRequest(self.poolMo.poolId, 10)
end

function PartyClothLotteryView:_editableInitView()
	self.poolMo = PartyClothModel.instance:getSummonPoolMo()

	local costParams = PartyClothConfig.instance:getSummonCost(self.poolMo.poolId)

	self.summon1Cost = costParams[3]
	self._txtNum1.text = string.format("×%s", self.summon1Cost)
	self._txtSummon1.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partycloth_summon"), GameUtil.getNum2Chinese(1))

	local param = ScrollAudioParam.New()

	param.scrollDir = ScrollEnum.ScrollDirV

	MonoHelper.addLuaComOnceToGo(self._scrollSuit.gameObject, ScrollAudioComp, param)
end

function PartyClothLotteryView:onOpen()
	self.addEventCb(self, PartyClothController.instance, PartyClothEvent.SummonReply, self.refreshInfo, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrecnyChange, self)
	self:refreshInfo()
	self:onCurrecnyChange()
end

function PartyClothLotteryView:refreshInfo()
	PartyClothSuitListModel.instance:initData(true)

	self.leftPrize = self.poolMo.leftPrizeNum
	self.Summon10Cnt = self.leftPrize == 0 and 10 or Mathf.Clamp(self.leftPrize, 1, 10)
	self._txtNum10.text = string.format("×%s", self.Summon10Cnt * self.summon1Cost)
	self._txtSummon10.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("partycloth_summon"), GameUtil.getNum2Chinese(self.Summon10Cnt))
end

function PartyClothLotteryView:onCurrecnyChange()
	local cueerncyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a9PartyGameStoreCoin)

	if cueerncyMo then
		self.coinCnt = cueerncyMo.quantity or 0
	end
end

return PartyClothLotteryView

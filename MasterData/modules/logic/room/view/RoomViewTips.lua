-- chunkname: @modules/logic/room/view/RoomViewTips.lua

module("modules.logic.room.view.RoomViewTips", package.seeall)

local RoomViewTips = class("RoomViewTips", BaseView)

function RoomViewTips:onInitView()
	self._btnfishingResources = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_fishingResource")
	self._gotips = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips")
	self._btntipsmask = gohelper.findChildClickWithAudio(self.viewGO, "go_normalroot/#go_tips/#btn_tipsMask")
	self._goresrourcestips = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips/#go_resourcesTip")
	self._goresourcesitem = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips/#go_resourcesTip/#go_Item")
	self._gofishingtips = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips/#go_fishingTip")
	self._gofishingContent = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips/#go_fishingTip/List")
	self._gofishingItem = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips/#go_fishingTip/List/#go_Item")
	self.resTipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goresrourcestips)
	self.fishingTipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gofishingtips)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewTips:addEvents()
	self._btnfishingResources:AddClickListener(self._btnFishingResourcesOnClick, self)
	self._btntipsmask:AddClickListener(self._btnTipsMaskOnClick, self)
	self.addEventCb(self, FishingController.instance, FishingEvent.OnFishingInfoUpdate, self._onFishingInfoUpdate, self)
	self.addEventCb(self, FishingController.instance, FishingEvent.ShowFishingTip, self._onShowFishingTip, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function RoomViewTips:removeEvents()
	self._btnfishingResources:RemoveClickListener()
	self._btntipsmask:RemoveClickListener()
	self.removeEventCb(self, FishingController.instance, FishingEvent.OnFishingInfoUpdate, self._onFishingInfoUpdate, self)
	self.removeEventCb(self, FishingController.instance, FishingEvent.ShowFishingTip, self._onShowFishingTip, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function RoomViewTips:_btnFishingResourcesOnClick()
	local resourceList = FishingModel.instance:getBackpackItemList()

	if #resourceList <= 0 then
		GameFacade.showToast(ToastEnum.NoRoomFishingResources)

		return
	end

	self._showFishingResourcesTip = not self._showFishingResourcesTip

	if self._showFishingResourcesTip then
		gohelper.CreateObjList(self, self._onFishingResourceItemShow, resourceList, self._goresrourcestips, self._goresourcesitem, RoomFishingResourceItem)
		self:_checkResourcesTipShow()
		self.resTipAnimatorPlayer:Play(UIAnimationName.Open)
	else
		self.resTipAnimatorPlayer:Play(UIAnimationName.Close, self._checkResourcesTipShow, self)
	end

	self:refreshTipMask()
end

function RoomViewTips:_onFishingResourceItemShow(obj, data, index)
	obj:onUpdateMO(data)
	obj:setCanClick(true)
end

function RoomViewTips:_checkResourcesTipShow()
	gohelper.setActive(self._goresrourcestips, self._showFishingResourcesTip)
end

function RoomViewTips:_btnFishOnClick(times)
	FishingController.instance:beginFishing(times)
end

function RoomViewTips:_btnTipsMaskOnClick()
	if self._showFishingResourcesTip then
		self:_btnFishingResourcesOnClick()
	end

	if self._showFishingTip then
		self:_onShowFishingTip()
	end

	self:refreshTipMask()
end

function RoomViewTips:_onFishingInfoUpdate()
	if not self._showFishingTip then
		return
	end

	self:clearFishingItem()

	local optionList = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishOption, true, "#")

	gohelper.CreateObjList(self, self._onFishingItemShow, optionList, self._gofishingContent, self._gofishingItem)
end

function RoomViewTips:_onShowFishingTip(showPos)
	self._showFishingTip = not not showPos

	if self._showFishingTip then
		local pos = self._transtip:InverseTransformPoint(showPos)

		transformhelper.setLocalPosXY(self._transfishingtips, pos.x, pos.y)
		self:clearFishingItem()

		local optionList = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FishOption, true, "#")

		gohelper.CreateObjList(self, self._onFishingItemShow, optionList, self._gofishingContent, self._gofishingItem)
		self:_checkFishingTipsShow()
		self.fishingTipAnimatorPlayer:Play(UIAnimationName.Open)
		AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_tan)
	else
		self.fishingTipAnimatorPlayer:Play(UIAnimationName.Close, self._checkFishingTipsShow, self)
		AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.play_ui_home_mingdi_shou)
	end

	self:refreshFishingItem()
	self:refreshTipMask()
end

function RoomViewTips:_onFishingItemShow(obj, data, index)
	local item = self:getUserDataTb_()

	item.go = obj
	item.fishingTimes = data
	item.txtTime = gohelper.findChildText(item.go, "#txt_Time")
	item.simageProp = gohelper.findChildSingleImage(item.go, "Prop/#simage_Prop")
	item.txtNum = gohelper.findChildText(item.go, "Prop/#txt_Num")
	item.txtFishing = gohelper.findChildText(item.go, "#btn_Fishing/txt_Fishing")
	item.txtCost = gohelper.findChildText(item.go, "#btn_Fishing/#txt_Num")
	item.btn = gohelper.findChildButtonWithAudio(item.go, "#btn_Fishing")
	item.goBtn = item.btn.gameObject

	local poolId = FishingModel.instance:getCurFishingPoolId()
	local needTime = FishingConfig.instance:getFishingTime(poolId)

	if needTime then
		item.txtTime.text = string.format("%s%s", TimeUtil.secondToRoughTime(needTime * item.fishingTimes, true))
	end

	local itemData = FishingModel.instance:getCurFishingPoolItem()
	local _, icon = ItemModel.instance:getItemConfigAndIcon(itemData[1], itemData[2])

	item.simageProp:LoadImage(icon)

	item.txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), itemData[3] * item.fishingTimes)
	item.txtFishing.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("RoomFishing_times"), item.fishingTimes)

	local costData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local needCost = item.fishingTimes * costData[2]

	item.txtCost.text = string.format("-%d", needCost)

	item.btn:AddClickListener(self._btnFishOnClick, self, item.fishingTimes)

	self._fishingItemList[index] = item
end

function RoomViewTips:_checkFishingTipsShow()
	gohelper.setActive(self._gofishingtips, self._showFishingTip)
end

function RoomViewTips:_onCurrencyChange()
	self:refreshFishingItem()
end

function RoomViewTips:_editableInitView()
	self._transfishingtips = self._gofishingtips.transform
	self._transtip = self._gotips.transform
	self._showFishingResourcesTip = false
	self._showFishingTip = false
end

function RoomViewTips:onOpen()
	self:_checkResourcesTipShow()
	self:_checkFishingTipsShow()
	self:refreshTipMask()
end

function RoomViewTips:refreshTipMask()
	gohelper.setActive(self._btntipsmask, self._showFishingTip or self._showFishingResourcesTip)
end

function RoomViewTips:refreshFishingItem()
	if not self._showFishingTip then
		return
	end

	if self._fishingItemList then
		for _, fishingItem in ipairs(self._fishingItemList) do
			local isEnough = FishingModel.instance:isEnoughToFish(fishingItem.fishingTimes)
			local hexColor = isEnough and "#101010" or "#972D1B"

			SLFramework.UGUI.GuiHelper.SetColor(fishingItem.txtFishing, hexColor)
			SLFramework.UGUI.GuiHelper.SetColor(fishingItem.txtCost, hexColor)
			ZProj.UGUIHelper.SetGrayscale(fishingItem.goBtn, not isEnough)
		end
	end
end

function RoomViewTips:clearFishingItem()
	if self._fishingItemList then
		for _, fishingItem in ipairs(self._fishingItemList) do
			fishingItem.simageProp:UnLoadImage()
			fishingItem.btn:RemoveClickListener()
		end
	end

	self._fishingItemList = {}
end

function RoomViewTips:onClose()
	self:clearFishingItem()
end

function RoomViewTips:onDestroyView()
	return
end

return RoomViewTips

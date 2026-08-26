-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191ShopView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191ShopView", package.seeall)

local Act191ShopView = class("Act191ShopView", BaseView)

function Act191ShopView:onInitView()
	self._goNodeList = gohelper.findChild(self.viewGO, "#go_NodeList")
	self._btnFreshShop = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/shopRoot/#btn_FreshShop")
	self._txtFreshCost = gohelper.findChildText(self.viewGO, "Middle/shopRoot/#btn_FreshShop/#txt_FreshCost")
	self._goFreeFresh = gohelper.findChild(self.viewGO, "Middle/shopRoot/#btn_FreshShop/#go_FreeFresh")
	self._goShopItem = gohelper.findChild(self.viewGO, "Middle/shopRoot/#go_ShopItem")
	self._goShopLevel = gohelper.findChild(self.viewGO, "Middle/shopRoot/#go_ShopLevel")
	self._txtShopLevel = gohelper.findChildText(self.viewGO, "Middle/shopRoot/#go_ShopLevel/#txt_ShopLevel")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/shopRoot/#go_ShopLevel/#btn_Detail")
	self._goDetail = gohelper.findChild(self.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail")
	self._btnCloseDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail/#btn_CloseDetail")
	self._txtDetail = gohelper.findChildText(self.viewGO, "Middle/shopRoot/#go_ShopLevel/#go_Detail/go_scroll/viewport/content/#txt_Detail")
	self._goEmpty = gohelper.findChild(self.viewGO, "Middle/shopRoot/#go_Empty")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "Bottom/#btn_Next")
	self._goTeam = gohelper.findChild(self.viewGO, "Bottom/#go_Team")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._txtCoin = gohelper.findChildText(self.viewGO, "go_topright/Coin/#txt_Coin")
	self._txtScore = gohelper.findChildText(self.viewGO, "go_topright/Score/#txt_Score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191ShopView:addEvents()
	self._btnFreshShop:AddClickListener(self._btnFreshShopOnClick, self)
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
	self._btnCloseDetail:AddClickListener(self._btnCloseDetailOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
end

function Act191ShopView:removeEvents()
	self._btnFreshShop:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnCloseDetail:RemoveClickListener()
	self._btnNext:RemoveClickListener()
end

function Act191ShopView:_btnCloseDetailOnClick()
	gohelper.setActive(self._goDetail, false)
end

function Act191ShopView:_btnDetailOnClick()
	Act191StatController.instance:statButtonClick(self.viewName, "_btnDetailOnClick")
	gohelper.setAsLastSibling(self._goShopLevel)
	gohelper.setActive(self._goDetail, true)
end

function Act191ShopView:_btnFreshShopOnClick()
	if self.freshLimit and self.freshLimit <= self.nodeDetailMo.shopFreshNum then
		GameFacade.showToast(ToastEnum.Act191FreshLimit)

		return
	end

	Act191StatController.instance:statButtonClick(self.viewName, "_btnFreshShopOnClick")

	if self.gameInfo.coin < self:getFreshShopCost() then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	for _, shopItem in ipairs(self.shopItemList) do
		shopItem:playFreshAnim()
	end

	TaskDispatcher.runDelay(self.delayFresh, self, 0.16)
end

function Act191ShopView:delayFresh()
	Activity191Rpc.instance:sendFresh191ShopRequest(self.actId, self._updateInfo, self)
end

function Act191ShopView:_btnNextOnClick()
	if self.isLeaving then
		return
	end

	self.isLeaving = true

	Activity191Rpc.instance:sendLeave191ShopRequest(self.actId, self.onLeaveShop, self)
	Act191StatController.instance:statButtonClick(self.viewName, "_btnNextOnClick")
end

function Act191ShopView:_editableInitView()
	gohelper.setActive(self._goShopItem, false)

	self.actId = Activity191Model.instance:getCurActId()
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.nodeDetailMo = self.gameInfo:getNodeDetailMo()

	local paramStr

	if self.nodeDetailMo.type == Activity191Enum.NodeType.TagShop then
		paramStr = lua_activity191_const.configDict[Activity191Enum.ConstKey.TagShopFreshCost].value
		self.freshLimit = tonumber(lua_activity191_const.configDict[Activity191Enum.ConstKey.TagShopFreshLimit].value)
	else
		paramStr = lua_activity191_const.configDict[Activity191Enum.ConstKey.ShopFreshCost].value
	end

	self.freshCostList = GameUtil.splitString2(paramStr, true)
	self.shopItemList = {}
	self.animBtnFresh = self._btnFreshShop.gameObject:GetComponent(gohelper.Type_Animator)

	local nodeListGo = self:getResInst(Activity191Enum.PrefabPath.NodeListItem, self._goNodeList)

	MonoHelper.addNoUpdateLuaComOnceToGo(nodeListGo, Act191NodeListItem, self)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_unfold)

	local teamPrefab = self:getResInst(Activity191Enum.PrefabPath.TeamComp, self._goTeam)

	self.teamComp = MonoHelper.addNoUpdateLuaComOnceToGo(teamPrefab, Act191TeamComp, self)
end

function Act191ShopView:_updateInfo()
	if self.isLeaving then
		return
	end

	self.nodeDetailMo = self.gameInfo:getNodeDetailMo()

	self:refreshShop()
end

function Act191ShopView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateGameInfo, self._updateInfo, self)

	if self.nodeDetailMo.type == Activity191Enum.NodeType.CollectionShop then
		self.teamComp:onClickSwitch(true)
	end

	self:refreshUI()
end

function Act191ShopView:onClose()
	local isManual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, isManual)
end

function Act191ShopView:refreshUI()
	self.shopConfig = lua_activity191_shop.configDict[self.actId][self.nodeDetailMo.shopId]
	self._txtShopLevel.text = self.shopConfig.name
	self._txtDetail.text = self.shopConfig.desc
	self._txtScore.text = self.gameInfo.score

	self:refreshShop()
end

function Act191ShopView:refreshShop()
	if self.freshLimit and self.freshLimit <= self.nodeDetailMo.shopFreshNum then
		ZProj.UGUIHelper.SetGrayscale(self._btnFreshShop.gameObject, true)
	else
		ZProj.UGUIHelper.SetGrayscale(self._btnFreshShop.gameObject, false)
	end

	local cost = self:getFreshShopCost()
	local animName = cost == 0 and "first" or "idle"

	self.animBtnFresh:Play(animName, 0, 0)

	self._txtFreshCost.text = cost
	self._txtCoin.text = self.gameInfo.coin

	local hasGoods = false

	for i = 1, 6 do
		local shopPos = self.nodeDetailMo.shopPosMap[tostring(i)]
		local shopItem = self.shopItemList[i]

		if shopPos then
			hasGoods = true
			shopItem = shopItem or self:createShopItem(i)

			local soldOut = tabletool.indexOf(self.nodeDetailMo.boughtSet, i)

			shopItem:setData(shopPos, soldOut)
			gohelper.setActive(shopItem.go, true)
		elseif shopItem then
			gohelper.setActive(shopItem.go, false)
		end
	end

	gohelper.setActive(self._goEmpty, not hasGoods)
	gohelper.setActive(self._btnFreshShop, hasGoods)
end

function Act191ShopView:createShopItem(index)
	local go = gohelper.cloneInPlace(self._goShopItem, "shopItem" .. index)
	local shopItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191ShopItem, self)

	shopItem:setIndex(index)

	self.shopItemList[index] = shopItem

	return shopItem
end

function Act191ShopView:onLeaveShop(_, resultCode)
	if resultCode == 0 then
		Activity191Controller.instance:nextStep()
		ViewMgr.instance:closeView(self.viewName)
	end

	self.isLeaving = false
end

function Act191ShopView:getFreshShopCost()
	if self.nodeDetailMo.freeRefreshNum > 0 then
		return 0
	end

	local freshNum = self.nodeDetailMo.shopFreshNum

	for i = #self.freshCostList, 1, -1 do
		local freshArr = self.freshCostList[i]

		if freshArr[1] <= freshNum + 1 then
			return freshArr[2]
		end
	end
end

return Act191ShopView

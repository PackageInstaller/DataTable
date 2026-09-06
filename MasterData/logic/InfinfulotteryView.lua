-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfulotteryView.lua

module("logic.extensions.infinitefuture.view.InfinfulotteryView", package.seeall)

local InfinfulotteryView = class("InfinfulotteryView", TableViewComponent)

function InfinfulotteryView:ctor()
	InfinfulotteryView.super.ctor(self)

	self._curActId = 112003
	self._middleItemList = nil
	self._curViewDatas = nil
end

function InfinfulotteryView:bindEvents()
	InfinfulotteryView.super.bindEvents(self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._poolCfg.raceId)
	end, self)
	self._lotteryBtn:AddClickListener(self._onClickLottery, self)
	self._buyBtn:AddClickListener(self._onClickExchangeShop, self)
	self._JackpotBtn:AddClickListener(self._onClickPreviewReward, self)
	GameUtil.addClickHandler(self.wishBtn, self.onCLickWish, self)
end

function InfinfulotteryView:unbindEvents()
	InfinfulotteryView.super.unbindEvents(self)
	self._introduceBtn:RemoveClickListener()
	self._lotteryBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._JackpotBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.wishBtn)
end

function InfinfulotteryView:onExit()
	InfinfulotteryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataDragonInfo, self._updateLotteryShow, self)

	self._curViewDatas = nil

	for _, go in pairs(self._middleItemList) do
		if go and go.itemGo then
			GameUtil.SetActive(go.itemGo, false)
		end
	end
end

function InfinfulotteryView:destroyUI()
	InfinfulotteryView.super.destroyUI(self)
	uGuiUtil.clearImage(self._countImaGo)

	for _, go in pairs(self._middleItemList) do
		if go and go.equipImaGo then
			uGuiUtil.clearImage(go.equipImaGo)
		end
	end
end

function InfinfulotteryView:buildUI()
	InfinfulotteryView.super.buildUI(self)

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._petNameTxt = goutil.findChildTextComponent(sprintInfoGo, "petNameTxt")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "introduceBtn")
	self._petNameTxt.text = ""
	self._middleItemList = {}
	self._middleItemList[1] = {
		itemGo = self:getGo("equipItem_1"),
		equipImaGo = self:getGo("equipItem_1/equipIma")
	}
	self._middleItemList[2] = {
		itemGo = self:getGo("equipItem_2"),
		equipImaGo = self:getGo("equipItem_2/equipIma")
	}
	self._middleItemList[3] = {
		itemGo = self:getGo("equipItem_3"),
		equipImaGo = self:getGo("equipItem_3/equipIma")
	}

	GameUtil.SetActive(self._middleItemList[1].itemGo, false)
	GameUtil.SetActive(self._middleItemList[2].itemGo, false)
	GameUtil.SetActive(self._middleItemList[3].itemGo, false)

	self._nobodyTxt = goutil.findChildTextComponent(self.mainGO, "luckyRankGo/nobodyTxt")
	self._nobodyTxt.text = ""

	local viewDownGo = self:getGo("viewDownGo")

	self._cycleNum_1 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_1"):GetComponent("UIImageSpriteChange")
	self._cycleNum_2 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_2"):GetComponent("UIImageSpriteChange")
	self._cycleNum_3 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_3"):GetComponent("UIImageSpriteChange")
	self._lotteryBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "lotteryBtn")
	self._countImaGo = goutil.findChild(viewDownGo, "countGo/countIma")
	self._countTxt = goutil.findChild(viewDownGo, "countGo/countTxt"):GetComponent("Text")
	self._buyBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "buyBtn")
	self._JackpotBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "JackpotBtn")
	self._taskShopTxt = goutil.findChildTextComponent(viewDownGo, "taskShopGo/taskShopTxt")
	self._countTxt.text = ""
	self._taskShopTxt.text = ""
	self.wishBtn = self:getGo("viewDownGo/wishBtn")
end

function InfinfulotteryView:onCLickWish()
	local actType = math.floor(self._curActId / 1000)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, self._curActId)

	if isInTime then
		FuncOpenController.instance:openFunc(191, actType, self._curActId)
	end
end

function InfinfulotteryView:onEnter()
	InfinfulotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonInfo, self._updateLotteryShow, self)

	local actCfg = DragonConfig.instance:getActivityCfg(self._curActId)

	if actCfg == nil then
		printError("sr---超神龙召唤      InfinfulotteryView:onEnter()    获取配置为空！")
		self:close()

		return
	end

	self._poolCfg = DragonConfig.instance:getDragonPoolCfg(actCfg.poolGroupId)

	MaterialMgr.updateItemByStr(self._countImaGo, self._poolCfg.lotteryCost, self._countTxt)

	self._petNameTxt.text = MaterialMgr.getMaterialsName(MatType.Pet, self._poolCfg.raceId)

	if self._poolCfg and not string.nilorempty(self._poolCfg.goodItems) then
		local goodsList = string.split(self._poolCfg.goodItems, "#")

		for i = 1, #goodsList do
			if goodsList[i] and not string.nilorempty(goodsList[i]) and self._middleItemList[i] then
				GameUtil.SetActive(self._middleItemList[i].itemGo, true)
				MaterialMgr.updateItemByStr(self._middleItemList[i].equipImaGo, goodsList[i])
			end
		end
	end

	self._taskShopTxt.text = lang("text_dragon_desc_14")

	self:_updateLotteryShow()
	DragonController.instance:csGodLotteryGetInfoReq(self._curActId, self._poolCfg.poolGroupId)
end

function InfinfulotteryView:_updateLotteryShow(str, param)
	self._baseInfo = DragonModel.instance:getDragonBaseInfo(self._poolCfg.poolGroupId)
	self._curViewDatas = self._baseInfo.rankList

	self._tableview:ReloadData()

	self._nobodyTxt.text = (self._curViewDatas == nil or #self._curViewDatas == 0) and lang("text_dragon_desc_10") or ""

	local supCount = self._poolCfg.floorTime - self._baseInfo.accumulateTime

	if supCount <= 0 then
		supCount = self._poolCfg.floorTime
	end

	local bai = math.floor(supCount / 100)
	local shi = math.floor(supCount % 100 / 10)
	local ge = supCount % 10

	goutil.setActive(self._cycleNum_1.gameObject, bai > 0)
	goutil.setActive(self._cycleNum_2.gameObject, bai > 0 or shi > 0)
	self._cycleNum_1:SetState(bai)
	self._cycleNum_2:SetState(shi)
	self._cycleNum_3:SetState(ge)

	if str == "Dcj" and checknumber(param) > 0 then
		ViewMgr.instance:open(ViewName.DragonEffect, param)

		return
	end
end

function InfinfulotteryView:_getPath()
	return {
		cellPath = "luckyRankGo/luckyItem",
		viewPath = "luckyRankGo/luckyListSR"
	}
end

function InfinfulotteryView:_cellSize()
	return 224, 32
end

function InfinfulotteryView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	nameTxt.text = data.playerName
	timeTxt.text = tostring(data.time)
end

function InfinfulotteryView:_onClickLottery()
	local params = {
		actId = self._curActId,
		dailyTime = self._baseInfo.dailyTime,
		poolCfg = self._poolCfg
	}

	UIStateManager.instance:push(ViewName.DragonBuy, params)
end

function InfinfulotteryView:_onClickExchangeShop()
	local actType = math.floor(self._curActId / 1000)

	UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, actType, self._curActId, 1)
end

function InfinfulotteryView:_onClickPreviewReward()
	UIStateManager.instance:push(ViewName.DragonPreview, self._poolCfg)
end

return InfinfulotteryView

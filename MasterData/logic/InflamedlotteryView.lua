-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflamedlotteryView.lua

module("logic.extensions.infinitefuture.view.InflamedlotteryView", package.seeall)

local InflamedlotteryView = class("InflamedlotteryView", TableViewComponent)

function InflamedlotteryView:ctor()
	InflamedlotteryView.super.ctor(self)

	self._curActId = 112008
	self._curDragonType = DragonController.DragonActType.Vireta
	self._middleItemList = nil
	self._curViewDatas = nil
end

function InflamedlotteryView:bindEvents()
	InflamedlotteryView.super.bindEvents(self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._poolCfg.raceId)
	end, self)
	self._lotteryBtn:AddClickListener(function()
		local params = {
			actId = self._curActId,
			dailyTime = self._baseInfo.dailyTime,
			poolCfg = self._poolCfg
		}

		UIStateManager.instance:push(ViewName.DragonBuy, params)
	end, self)
	self._buyBtn:AddClickListener(function()
		local actType = math.floor(self._curActId / 1000)

		UIStateManager.instance:push(ViewName.ActivityshopexchangebuyView, actType, self._curActId, 1)
	end, self)
	self._JackpotBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.DragonPreview, self._poolCfg)
	end, self)
	self._petVerifyBtn:AddClickListener(function()
		PetAwakenVerificationController.instance:gotoPetAwakenByKey("inflamedmotherview")
	end, self)
	GameUtil.addClickHandler(self.wishBtn, self.onCLickWish, self)
	self.zhaohuanBtn:AddClickListener(self.OpenLotteryCountView, self)
end

function InflamedlotteryView:unbindEvents()
	InflamedlotteryView.super.unbindEvents(self)
	self._introduceBtn:RemoveClickListener()
	self._petVerifyBtn:RemoveClickListener()
	self._lotteryBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._JackpotBtn:RemoveClickListener()
	self.zhaohuanBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.wishBtn)
end

function InflamedlotteryView:onExit()
	InflamedlotteryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataDragonInfo, self._updateLotteryShow, self)
	MaterialMgr.resetAll(self._taskGoods1)
	MaterialMgr.resetAll(self._taskGoods2)
	MaterialMgr.resetAll(self.iconGO)

	self._curViewDatas = nil

	for _, go in pairs(self._middleItemList) do
		if go and go.itemGo then
			GameUtil.SetActive(go.itemGo, false)
		end
	end

	MaterialMgr.resetAll(self._sprintRareGo)
end

function InflamedlotteryView:destroyUI()
	InflamedlotteryView.super.destroyUI(self)
	uGuiUtil.clearImage(self._countImaGo)

	for _, go in pairs(self._middleItemList) do
		if go and go.equipImaGo then
			uGuiUtil.clearImage(go.equipImaGo)
		end
	end
end

function InflamedlotteryView:buildUI()
	InflamedlotteryView.super.buildUI(self)

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._petNameTxt = goutil.findChildTextComponent(sprintInfoGo, "petNameTxt")
	self._sprintRareGo = goutil.findChild(sprintInfoGo, "rareGo")
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
	self._nobodyTxt = goutil.findChildTextComponent(self.mainGO, "luckyRankGo/nobodyTxt")
	self._nobodyTxt.text = ""

	local viewDownGo = self:getGo("viewDownGo")

	self._cycleNum_1 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_1"):GetComponent("UIImageSpriteChange")
	self._cycleNum_2 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_2"):GetComponent("UIImageSpriteChange")
	self._lotteryBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "lotteryBtn")
	self._countImaGo = goutil.findChild(viewDownGo, "countGo/countIma")
	self._countTxt = goutil.findChild(viewDownGo, "countGo/countTxt"):GetComponent("Text")
	self._buyBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "buyBtn")
	self._JackpotBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "JackpotBtn")
	self._petVerifyBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "btnPetVerify")
	self._taskNode = goutil.findChild(viewDownGo, "taskShopGo")
	self._taskGoods1 = goutil.findChild(viewDownGo, "taskShopGo/taskGoods1")
	self._taskGoods2 = goutil.findChild(viewDownGo, "taskShopGo/taskGoods2")
	self._taskShopTxt = goutil.findChildTextComponent(viewDownGo, "taskShopGo/taskShopTxt")
	self.wishBtn = self:getGo("viewDownGo/wishBtn")
	self.longyanGo = self:getGo("longyanGo")
	self.iconGO = goutil.findChild(self.longyanGo, "con")
	self.proogSlid = goutil.findChild(self.longyanGo, "proogSlid"):GetComponent("Slider")
	self.proogTxt = goutil.findChild(self.longyanGo, "proogTxt"):GetComponent("Text")
	self.startTxt = goutil.findChild(self.longyanGo, "startTxt"):GetComponent("Text")
	self.endTxt = goutil.findChild(self.longyanGo, "endTxt"):GetComponent("Text")
	self.hintText = goutil.findChild(self.longyanGo, "hintText")
	self.zhaohuanBtn = Framework.ButtonAdapter.GetFrom(self.longyanGo, "zhaohuanBtn")
end

function InflamedlotteryView:onCLickWish()
	local actType = math.floor(self._curActId / 1000)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, self._curActId)

	if isInTime then
		FuncOpenController.instance:openFunc(191, actType, self._curActId)
	end
end

function InflamedlotteryView:onEnter()
	InflamedlotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonInfo, self._updateLotteryShow, self)

	local actCfg = DragonConfig.instance:getActivityCfg(self._curActId)

	if actCfg == nil then
		printError("sr---超神龙召唤      InflamedlotteryView:onEnter()    获取配置为空！")
		self:close()

		return
	end

	MaterialMgr.setCell(MatType.Rare, 12005, self._sprintRareGo)

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

	local isHaveTask = not string.nilorempty(self._poolCfg.jumpItem)

	GameUtil.SetActive(self._taskNode, isHaveTask)

	if isHaveTask then
		local list = string.split(self._poolCfg.jumpItem, "#")

		if list and list[1] and self._taskGoods1 then
			MaterialMgr.setCellByCfg(list[1], self._taskGoods1)
		end

		if list and list[2] and self._taskGoods2 then
			MaterialMgr.setCellByCfg(list[2], self._taskGoods2)
		end

		self._taskShopTxt.text = lang("text_dragon_desc_14")
	end

	self:_updateLotteryShow()
	DragonController.instance:csGodLotteryGetInfoReq(self._curActId, self._curDragonType)
end

function InflamedlotteryView:_updateLotteryShow(str, param)
	self._baseInfo = DragonModel.instance:getDragonBaseInfo(self._curDragonType)
	self._curViewDatas = self._baseInfo.rankList

	self._tableview:ReloadData()

	self._nobodyTxt.text = (self._curViewDatas == nil or #self._curViewDatas == 0) and lang("text_dragon_desc_10") or ""

	local supCount = self._poolCfg.floorTime - self._baseInfo.accumulateTime

	if supCount <= 0 then
		supCount = self._poolCfg.floorTime
	end

	GameUtil.SetActive(self._cycleNum_1, true)

	if supCount > 9 then
		GameUtil.SetActive(self._cycleNum_2, true)

		local shi = math.floor(supCount / 10)
		local ge = supCount - shi * 10

		self._cycleNum_1:SetState(shi)
		self._cycleNum_2:SetState(ge)
	else
		self._cycleNum_1:SetState(supCount)
		GameUtil.SetActive(self._cycleNum_2, false)
	end

	self:_updateRewardNode()

	if str == "Dcj" and checknumber(param) > 0 then
		ViewMgr.instance:open(ViewName.DragonEffect, param)

		return
	end
end

function InflamedlotteryView:_updateRewardNode()
	local nextTimes, gapTimes, curTimes, overTimes, prize = DragonModel.instance:getDragonProgressCurInfo(self._baseInfo.totalTimes, self._curActId)
	local isover = gapTimes == 0

	self.proogSlid.value = isover and 1 or curTimes / gapTimes
	self.proogTxt.text = isover and "" or langPara("text_lottery_desc_5", overTimes)
	self.startTxt.text = isover and "" or "0"
	self.endTxt.text = isover and "" or tostring(nextTimes)

	self.hintText:SetActive(isover)
	self.proogSlid.gameObject:SetActive(not isover)
	MaterialMgr.resetAll(self.iconGO)

	if not isover then
		MaterialMgr.setCellByCfg(prize, self.iconGO)
	end
end

function InflamedlotteryView:OpenLotteryCountView()
	UIStateManager.instance:push(ViewName.DragonlotterycountView, self._baseInfo.totalTimes, self._curActId)
end

function InflamedlotteryView:_getPath()
	return {
		cellPath = "luckyRankGo/luckyItem",
		viewPath = "luckyRankGo/luckyListSR"
	}
end

function InflamedlotteryView:_cellSize()
	return 224, 32
end

function InflamedlotteryView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	nameTxt.text = data.playerName
	timeTxt.text = tostring(data.time)
end

return InflamedlotteryView

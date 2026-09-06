-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonLotteryView.lua

module("logic.extensions.lottery.view.DragonLotteryView", package.seeall)

local DragonLotteryView = class("DragonLotteryView", ViewComponent)

function DragonLotteryView:ctor()
	DragonLotteryView.super.ctor(self)

	self._leftBtnsList = nil
	self._middleItemList = nil
	self._curLuckyDatas = nil
	self._curRankDatas = nil
	self._choType = nil
	self._choIndex = nil
	self._lotteryTime = nil
	self._curActId = nil
	self._isFirstOpen = nil
	self._conMatStr = nil
end

function DragonLotteryView:bindEvents()
	DragonLotteryView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		DragonController.instance.openActType = nil
		DragonController.instance.openTableId = nil

		self:close()
	end, self)
	self._tipsBtn:AddClickListener(function()
		local actCfg = DragonConfig.instance:getActivityCfg(self._curActId)

		if not string.nilorempty(actCfg.rules) then
			UIStateManager.instance:push(ViewName.RulesView, actCfg.rules)
		else
			UIStateManager.instance:push(ViewName.RulesView, "dragonlottery")
		end
	end, self)
	self._daibiBtn:AddClickListener(function()
		if self._poolCfg and not string.nilorempty(self._poolCfg.lotteryCost) then
			MaterialMgr.openGetSourceByStr(self._poolCfg.lotteryCost)
		end
	end, self)
	self._shenzuanBtn:AddClickListener(function()
		if not string.nilorempty(self._conMatStr) then
			MaterialMgr.openGetSourceByStr(self._conMatStr)
		end
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._petRaceId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._petRaceId)
	end, self)
	GameUtil.asBtn(self._leftBtnsList[1].itemGo):AddClickListener(function()
		self:_onClickLeftBtn(1)
	end, self)
	GameUtil.asBtn(self._leftBtnsList[2].itemGo):AddClickListener(function()
		self:_onClickLeftBtn(2)
	end, self)
	self._powerBtn:AddClickListener(function()
		if self._choType == DragonController.DragonActType.Chaoshenlong or self._choType == DragonController.DragonActType.ChaoshenlongCopy then
			return
		end

		FuncOpenController.instance:openFunc(493, 115001, 1)
	end, self)
	self._lotteryBtn:AddClickListener(function()
		if checknumber(self._lotteryTime) > 0 then
			FloatWordMgr.instance:show(lang("text_dragon_desc_7"))

			return
		end

		if checknumber(self._curActId) <= 0 then
			loatWordMgr.instance:show(lang("text_activity_end"))

			return
		end

		local params = {
			actId = self._curActId,
			dailyTime = self._baseInfo.dailyTime,
			poolCfg = self._poolCfg
		}

		UIStateManager.instance:push(ViewName.DragonBuy, params)
	end, self)

	local function buyBtnHandler()
		local actType = math.floor(self._curActId / 1000)
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, self._curActId)

		if isInTime then
			FuncOpenController.instance:openFunc(191, actType, self._curActId)
		end
	end

	self._buyBtn:AddClickListener(buyBtnHandler)
	self._JackpotBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.DragonPreview, self._poolCfg)
	end, self)
	self._shopBtn:AddClickListener(function()
		GotoMgr.gotoByString(self._poolCfg.shopJumpTo)
	end, self)
	self._wishBtn:AddClickListener(function()
		local actType = math.floor(self._curActId / 1000)
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, self._curActId)

		if isInTime then
			FuncOpenController.instance:openFunc(191, actType, self._curActId)
		end
	end, self)
	self._gotoBtn:AddClickListener(function()
		if self._choType == DragonController.DragonActType.Chaoshenlong or self._choType == DragonController.DragonActType.ChaoshenlongCopy then
			return
		end

		UIStateManager.instance:push(ViewName.ZxlmainView)
	end, self)
end

function DragonLotteryView:unbindEvents()
	DragonLotteryView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._daibiBtn:RemoveClickListener()
	self._shenzuanBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	GameUtil.asBtn(self._leftBtnsList[1].itemGo):RemoveClickListener()
	GameUtil.asBtn(self._leftBtnsList[2].itemGo):RemoveClickListener()
	self._powerBtn:RemoveClickListener()
	self._lotteryBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._JackpotBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
end

function DragonLotteryView:onExit()
	DragonLotteryView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataDragonInfo, self._updataLeftBtnShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateActiveShopInfo, self._updateMaterialCountShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateMaterialCountShow, self)
	MaterialMgr.resetAll(self._mainGoods)
	MaterialMgr.resetAll(self._taskGoods1)
	MaterialMgr.resetAll(self._taskGoods2)

	for _, go in pairs(self._middleItemList) do
		if go and go.itemGo then
			GameUtil.SetActive(go.itemGo, false)
		end
	end

	self._isFirstOpen = nil
	self._curActId = nil

	PetAwakenVerificationController.instance:unRegRedAboutPetAwken(self._powerBtnRed)
end

function DragonLotteryView:destroyUI()
	DragonLotteryView.super.destroyUI(self)

	self._choType = nil
	self._choIndex = nil

	uGuiUtil.clearImage(self._daibiImaGo)
	uGuiUtil.clearImage(self._shenzuanImaGo)
	uGuiUtil.clearImage(self._countImaGo)
	uGuiUtil.clearImage(self._viewBgGo)

	for _, go in pairs(self._middleItemList) do
		if go and go.equipImaGo then
			uGuiUtil.clearImage(go.equipImaGo)
		end
	end
end

function DragonLotteryView:buildUI()
	DragonLotteryView.super.buildUI(self)

	self._mainNodeGo = self:getGo("mainNodeGo")
	self._taskNodeGo = self:getGo("taskNodeGo")
	self._viewBgGo = self:getGo("viewBgGo")

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._petNameTxt = goutil.findChildTextComponent(sprintInfoGo, "petNameTxt")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
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

	local luckyRankGo = self:getGo("luckyRankGo")

	self._nobodyTxt = goutil.findChildTextComponent(luckyRankGo, "nobodyTxt")
	self._luckyListSR = goutil.findChild(luckyRankGo, "luckyListSR"):GetComponent("UITableview")
	self._luckyItem = goutil.findChild(luckyRankGo, "luckyItem")

	self._luckyItem:SetActive(false)

	self._nobodyTxt.text = ""

	local viewDownGo = self:getGo("viewDownGo")

	self._cycleNum_1 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_1"):GetComponent("UIImageSpriteChange")
	self._cycleNum_2 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_2"):GetComponent("UIImageSpriteChange")
	self.cycleDesIma = goutil.findChild(viewDownGo, "cycleDesIma"):GetComponent("UIChangeGroup")
	self._lotteryBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "lotteryBtn")
	self._lotteryTxt = goutil.findChildTextComponent(viewDownGo, "lotteryBtn/text")
	self._countImaGo = goutil.findChild(viewDownGo, "countGo/countIma")
	self._countTxt = goutil.findChild(viewDownGo, "countGo/countTxt"):GetComponent("Text")
	self._buyBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "buyBtn")
	self._JackpotBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "JackpotBtn")
	self._powerBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "powerBtn")

	if self._powerBtn then
		self._powerBtnRed = goutil.findChild(self._powerBtn, "redPoint")
	end

	self._countTxt.text = ""

	self:_buildShenLongUI()
	self:_buildZhixuLongUI()

	self.viewNameTxt = self:getTxt("upShowTran/viewNameTxt")

	local upShowGo = self:getGo("upShowTran")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self._tipsBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewNameTxt/tipsBtn")
	self._daibiBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "daibiItem")
	self._daibiImaGo = goutil.findChild(self._daibiBtn.gameObject, "daibiIconIma")
	self._daibiTxt = goutil.findChild(self._daibiBtn.gameObject, "daibiCountTxt"):GetComponent("Text")
	self._shenzuanBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "shenzuanItem")
	self._shenzuanImaGo = goutil.findChild(self._shenzuanBtn.gameObject, "shenzuanIconIma")
	self._shenzuanTxt = goutil.findChild(self._shenzuanBtn.gameObject, "shenzuanCountTxt"):GetComponent("Text")
	self._viewTimeGo = goutil.findChild(upShowGo, "viewTimeGo")
	self._timeTxt = goutil.findChild(self._viewTimeGo, "timeTxt"):GetComponent("Text")
	self._daibiTxt.text = ""
	self._shenzuanTxt.text = ""
	self._timeTxt.text = ""
	self._leftBtnsList = {}

	local mainItemGo = self:getBtn("mainItem")

	self._leftBtnsList[1] = {
		itemGo = mainItemGo,
		choiseGo = goutil.findChild(mainItemGo, "choiseGo"),
		redpointGo = goutil.findChild(mainItemGo, "redpointGo"),
		tagImaGo = goutil.findChild(mainItemGo, "tagImaGo"),
		tagTxt = goutil.findChildTextComponent(mainItemGo, "tagImaGo/tagTxt")
	}

	local taskItemGo = self:getBtn("taskItem")

	self._leftBtnsList[2] = {
		itemGo = taskItemGo,
		choiseGo = goutil.findChild(taskItemGo, "choiseGo"),
		redpointGo = goutil.findChild(taskItemGo, "redpointGo"),
		tagImaGo = goutil.findChild(taskItemGo, "tagImaGo"),
		tagTxt = goutil.findChildTextComponent(taskItemGo, "tagImaGo/tagTxt")
	}

	self:_buildDragonTaskUI()
	self:_registCallbacks()
end

function DragonLotteryView:_buildShenLongUI()
	self._mainTranGo = self:getGo("mainTranGo")
	self._mainShopGo = goutil.findChild(self._mainTranGo, "mainShopGo")
	self._mainGoods = goutil.findChild(self._mainShopGo, "mainGoods")
	self._shopBtn = Framework.ButtonAdapter.GetFrom(self._mainShopGo, "shopBtn")
	self._shopDescTxt = goutil.findChildTextComponent(self._mainShopGo, "shopDescTxt")
	self._shopNameTxt = goutil.findChildTextComponent(self._mainShopGo, "shopNameTxt")
	self._shopDescTxt.text = ""
	self._shopNameTxt.text = ""

	GameUtil.SetActive(self._mainShopGo, false)
end

function DragonLotteryView:_buildZhixuLongUI()
	self._taskTranGo = self:getGo("taskTranGo")
	self._wishBtn = Framework.ButtonAdapter.GetFrom(self._taskTranGo, "wishBtn")
	self._gotoBtn = Framework.ButtonAdapter.GetFrom(self._taskTranGo, "gotoBtn")
	self._taskShopGo = goutil.findChild(self._taskTranGo, "taskShopGo")
	self._taskGoods1 = goutil.findChild(self._taskShopGo, "taskGoods1")
	self._taskGoods2 = goutil.findChild(self._taskShopGo, "taskGoods2")
	self._taskShopTxt = goutil.findChildTextComponent(self._taskShopGo, "taskShopTxt")
	self._taskShopTxt.text = ""
end

function DragonLotteryView:_buildDragonTaskUI()
	self._taskViewGo = self:getGo("taskViewGo")
	self._rankListSR = goutil.findChild(self._taskViewGo, "rankListSR"):GetComponent("UITableview")
	self._rankItem = goutil.findChild(self._taskViewGo, "rankItem")

	self._rankItem:SetActive(false)
	GameUtil.SetActive(self._taskViewGo, false)
end

function DragonLotteryView:_registCallbacks()
	self._luckyListSR:RegisterCallback(self._LuckyInView, function()
		return 224, 32
	end, self._LuckyAtIndex, self)
	self._luckyListSR:RegisterUpdateCellCallback(self._OnLuckyCellUpdate)
	self._rankListSR:RegisterCallback(self._RankInView, function()
		return 1000, 104
	end, self._RankAtIndex, self)
	self._rankListSR:RegisterUpdateCellCallback(self._OnRankCellUpdate)
end

function DragonLotteryView:_LuckyInView()
	if not self._curLuckyDatas then
		return 0
	end

	return #self._curLuckyDatas
end

function DragonLotteryView:_LuckyAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._luckyItem)

	local data = self._curLuckyDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateLuckyCell(view, cell, data)

	return cell
end

function DragonLotteryView:_OnLuckyCellUpdate(view, cell)
	local index = cell.index
	local data = self._curLuckyDatas[index + 1]

	cell.data = index + 1

	self:_UpdateLuckyCell(view, cell, data)
end

function DragonLotteryView:_RankInView()
	if not self._curRankDatas then
		return 0
	end

	return #self._curRankDatas
end

function DragonLotteryView:_RankAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankItem)

	local data = self._curRankDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRankCell(view, cell, data)

	return cell
end

function DragonLotteryView:_OnRankCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRankDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRankCell(view, cell, data)
end

function DragonLotteryView:onEnter()
	DragonLotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonInfo, self._updataLeftBtnShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateActiveShopInfo, self._updateMaterialCountShow, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateMaterialCountShow, self)

	if self._viewPresentor._openParam then
		self._curActId = checknumber(self._viewPresentor._openParam[1])
	end

	if checknumber(self._curActId) == 0 and enableDebug then
		error(">>> 电脑上才报错，传活动ID 进来 DragonLotteryView ")
	end

	local actCfg = DragonConfig.instance:getActivityCfg(self._curActId)

	self._choType = actCfg.poolGroupId
	self._choIndex = 1

	if checknumber(DragonController.instance.openTableId) > 0 then
		self._choIndex = DragonController.instance.openTableId
	end

	DragonController.instance.openActType = self._choType
	DragonController.instance.openTableId = self._choIndex
	self._isFirstOpen = true

	for _, go in pairs(self._leftBtnsList) do
		if go.tagTxt then
			go.tagTxt.text = ""
		end

		if go.choiseGo then
			GameUtil.SetActive(go.choiseGo, false)
		end

		if go.tagImaGo then
			GameUtil.SetActive(go.tagImaGo, false)
		end
	end

	if actCfg == nil then
		printError("sr---超神龙召唤      DragonLotteryView:_initViewBaseShow()    获取配置 = " .. self._curActId)
		self:close()

		return
	end

	self:_initViewBaseShow()
	self:_updataLeftBtnShow("All")
	self:_showActivityTimer()
	PetAwakenVerificationController.instance:regRedAboutPetAwken(self._powerBtnRed, "endlessdragonview")
end

function DragonLotteryView:_initViewBaseShow()
	self._conMatStr = nil

	MaterialMgr.resetAll(self._mainGoods)
	MaterialMgr.resetAll(self._taskGoods1)
	MaterialMgr.resetAll(self._taskGoods2)

	local actCfg = DragonConfig.instance:getActivityCfg(self._curActId)

	self._poolCfg = DragonConfig.instance:getDragonPoolCfg(actCfg.poolGroupId)
	self.viewNameTxt.text = self._poolCfg.title
	self._timeTxt.text = TimeGateController.instance:getActTimeShow(self._curActId)
	self._petRaceId = self._poolCfg.raceId

	uGuiUtil.setSpriteToImage(self._viewBgGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/%s", self._poolCfg.viewBg))
	MaterialMgr.updateItemByStr(self._daibiImaGo, self._poolCfg.lotteryCost)

	if self._choType == DragonController.DragonActType.Shenlong then
		self._lotteryTxt.text = "超神召唤"

		GameUtil.SetActive(self._leftBtnsList[1].itemGo, true)

		if not string.nilorempty(self._poolCfg.lotteryTag) then
			GameUtil.SetActive(self._leftBtnsList[1].tagImaGo, true)

			self._leftBtnsList[1].tagTxt.text = self._poolCfg.lotteryTag
		else
			self._leftBtnsList[1].tagTxt.text = ""

			GameUtil.SetActive(self._leftBtnsList[1].tagImaGo, false)
		end

		GameUtil.SetActive(self._leftBtnsList[2].itemGo, true)

		if not string.nilorempty(self._poolCfg.taskTag) then
			GameUtil.SetActive(self._leftBtnsList[2].tagImaGo, true)

			self._leftBtnsList[2].tagTxt.text = self._poolCfg.taskTag
		else
			self._leftBtnsList[2].tagTxt.text = ""

			GameUtil.SetActive(self._leftBtnsList[2].tagImaGo, false)
		end

		GameUtil.SetActive(self._taskTranGo, false)
		GameUtil.SetActive(self._mainTranGo, true)
		self.cycleDesIma:SetState(0)
	elseif self._choType == DragonController.DragonActType.Zhixulong then
		self._lotteryTxt.text = "秩序许愿"

		for i = 1, #self._leftBtnsList do
			GameUtil.SetActive(self._leftBtnsList[i].itemGo, false)
		end

		GameUtil.SetActive(self._mainTranGo, false)
		GameUtil.SetActive(self._taskTranGo, true)

		local list = string.split(self._poolCfg.jumpItem, "#")

		if list and list[1] and self._taskGoods1 then
			MaterialMgr.setCellByCfg(list[1], self._taskGoods1)
		end

		if list and list[2] and self._taskGoods2 then
			MaterialMgr.setCellByCfg(list[2], self._taskGoods2)
		end

		self._taskShopTxt.text = lang("text_dragon_desc_14")

		self.cycleDesIma:SetState(1)
	elseif self._choType == DragonController.DragonActType.Chaoshenlong or self._choType == DragonController.DragonActType.ChaoshenlongCopy then
		self._lotteryTxt.text = "超神圣龙降临"

		for i = 1, #self._leftBtnsList do
			GameUtil.SetActive(self._leftBtnsList[i].itemGo, true)
			GameUtil.SetActive(self._leftBtnsList[i].tagImaGo, false)
		end

		GameUtil.SetActive(self._mainTranGo, true)
		GameUtil.SetActive(self._taskTranGo, true)
		GameUtil.SetActive(self._powerBtn, false)
		GameUtil.SetActive(self._taskShopGo, false)
		self.cycleDesIma:SetState(0)
	end

	if not string.nilorempty(self._poolCfg.jumpItem) then
		local arr = string.split(self._poolCfg.jumpItem, "#")

		MaterialMgr.setCellByCfg(arr[1], self._mainGoods)
	end

	if not string.nilorempty(self._poolCfg.jumpDesc) then
		local arr = string.split(self._poolCfg.jumpDesc, "#")

		self._shopNameTxt.text = arr[1] or ""
		self._shopDescTxt.text = arr[2] or ""
	end

	GameUtil.SetActive(self._gotoBtn, self._poolCfg.poolGroupId == 2)
	goutil.setActive(self._mainShopGo, not string.nilorempty(self._poolCfg.shopJumpTo))
	MaterialMgr.updateItemByStr(self._countImaGo, self._poolCfg.lotteryCost, self._countTxt)

	self._petNameTxt.text = MaterialMgr.getMaterialsName(MatType.Pet, self._poolCfg.raceId)

	if not string.nilorempty(self._poolCfg.goodItems) then
		local goodsList = string.split(self._poolCfg.goodItems, "#")

		for i = 1, #goodsList do
			if goodsList[i] and self._middleItemList[i] then
				GameUtil.SetActive(self._middleItemList[i].itemGo, true)
				MaterialMgr.updateItemByStr(self._middleItemList[i].equipImaGo, goodsList[i])
			end
		end
	end

	local actType = math.floor(self._curActId / 1000)
	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(actType, self._curActId, 1)

	if cfg == nil or string.nilorempty(cfg.sellPrice) then
		self._shenzuanTxt.text = "0"
	else
		self._conMatStr = cfg.sellPrice

		MaterialMgr.updateItemByStr(self._shenzuanImaGo, self._conMatStr)
	end

	DragonController.instance:csGodLotteryGetInfoReq(self._curActId, self._choType)
end

function DragonLotteryView:_updataLeftBtnShow(str, param)
	if str == "All" then
		self:_onClickLeftBtn(self._choIndex, true)

		return
	end

	if str == "Dcj" then
		self:_updateCycleNumShow()
		self:_updateMaterialCountShow()

		if checknumber(param) > 0 then
			ViewMgr.instance:open(ViewName.DragonEffect, param)
		end

		return
	end

	if str == "Ddh" then
		self:_updateMaterialCountShow()

		return
	end

	if self._choIndex ~= 2 then
		return
	end

	if str == "Trw" or str == "Tlj" then
		GameUtil.SetActive(self._leftBtnsList[2].redpointGo, DragonModel.instance:getTaskRedpoint())

		self._curRankDatas = DragonModel.instance:getDragonTaskInfo(self._choType)

		self:_calcTaskTimes(self._choType)
		self._rankListSR:ReloadData()

		return
	end
end

function DragonLotteryView:_calcTaskTimes(choType)
	self._taskGainTimesMap = {}

	local list = DragonModel.instance:getGodLotteryGainLimit(choType) or {}

	for i, v in ipairs(list) do
		self._taskGainTimesMap[v.type] = self._taskGainTimesMap[v.type] or {}
		self._taskGainTimesMap[v.type][v.id] = v.times
	end
end

function DragonLotteryView:_getTaskTime(type, id)
	if self._taskGainTimesMap[type] then
		return checknumber(self._taskGainTimesMap[type][id])
	end

	return 0
end

function DragonLotteryView:_updateMaterialCountShow(matType, matId)
	local have = MaterialMgr.getMatCount(self._poolCfg.lotteryCost)

	self._daibiTxt.text = tostring(have)

	local actType = math.floor(self._curActId / 1000)
	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(actType, self._curActId, 1)

	if string.nilorempty(self._conMatStr) then
		self._shenzuanTxt.text = "0"

		return
	end

	have = MaterialMgr.getMatCount(self._conMatStr)
	self._shenzuanTxt.text = tostring(have)
end

function DragonLotteryView:_showActivityTimer()
	GameUtil.SetActive(self._buyBtn, false)
	removetimer(self._calculationSurplusTime, self)

	if string.nilorempty(self._poolCfg.startTime) then
		GameUtil.SetActive(self._buyBtn, true)

		self._lotteryTime = nil

		return
	end

	local openTime = GameUtil.string2time(self._poolCfg.startTime)

	self._lotteryTime = openTime - ServerTime.now()

	if self._lotteryTime <= 0 then
		GameUtil.SetActive(self._buyBtn, true)

		self._lotteryTime = nil

		return
	end

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function DragonLotteryView:_calculationSurplusTime()
	self._lotteryTime = self._lotteryTime - 1

	if self._lotteryTime <= 0 then
		self._lotteryTime = nil

		GameUtil.SetActive(self._buyBtn, true)
		removetimer(self._calculationSurplusTime, self)

		return
	end
end

function DragonLotteryView:_onClickLeftBtn(index, isForce)
	index = checknumber(index)

	if self._leftBtnsList[index] == nil then
		index = 1
	end

	if index == self._choIndex and not isForce then
		return
	end

	self:_updateMaterialCountShow()

	if self._leftBtnsList[self._choIndex] then
		GameUtil.SetActive(self._leftBtnsList[self._choIndex].choiseGo, false)
	end

	self._curRankDatas = {}

	GameUtil.SetActive(self._leftBtnsList[2].redpointGo, DragonModel.instance:getTaskRedpoint())

	if DragonModel.instance:getCountRedpoint() and self._curActId then
		local value = GameUtil.getUserDayData("DragonCountRed_" .. self._curActId)

		if checknumber(value) ~= 1 then
			GameUtil.saveUserDayData("DragonCountRed_" .. self._curActId, 1)
		end
	end

	if index == 2 then
		local taskActId = DragonController.instance:clickDragonTaskView(true)

		if taskActId <= 0 then
			GameUtil.SetActive(self._leftBtnsList[2].choiseGo, false)

			self._choIndex = 1

			GameUtil.SetActive(self._leftBtnsList[1].choiseGo, true)
		else
			self._choIndex = 2

			GameUtil.SetActive(self._taskViewGo, true)
			GameUtil.SetActive(self._leftBtnsList[2].choiseGo, true)

			self._curRankDatas = DragonModel.instance:getDragonTaskInfo(self._choType)

			self:_calcTaskTimes(self._choType)
			self._rankListSR:ReloadData()
			DragonController.instance:csGodLotteryGetTasksReq(taskActId, self._choType)
		end
	else
		self._choIndex = index

		if self._taskViewGo.activeSelf then
			self._rankListSR:ReloadData()
			GameUtil.SetActive(self._taskViewGo, false)
		end

		if self._leftBtnsList[self._choIndex] then
			GameUtil.SetActive(self._leftBtnsList[self._choIndex].choiseGo, true)
		end
	end

	DragonController.instance.openTableId = self._choIndex

	if self._choIndex == 1 then
		goutil.addChildToParent(self._viewBgGo, self._mainNodeGo)
	else
		goutil.addChildToParent(self._viewBgGo, self._taskNodeGo)
	end

	self:_updateCycleNumShow()

	self._curLuckyDatas = self._baseInfo.rankList

	self._luckyListSR:ReloadData()

	self._nobodyTxt.text = (self._curLuckyDatas == nil or #self._curLuckyDatas == 0) and lang("text_dragon_desc_10") or ""
end

function DragonLotteryView:_updateCycleNumShow()
	self._baseInfo = DragonModel.instance:getDragonBaseInfo(self._choType)

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
end

function DragonLotteryView:_UpdateLuckyCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	nameTxt.text = data.playerName
	timeTxt.text = tostring(data.time)
end

function DragonLotteryView:_UpdateRankCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local matList = {
		goutil.findChild(cell, "matGo_1"),
		goutil.findChild(cell, "matGo_2"),
		goutil.findChild(cell, "matGo_3")
	}
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")
	local gotoBtnGo = goutil.findChild(cell, "gotoBtn")
	local gotoBtnIma = gotoBtnGo:GetComponent("UIImageSpriteChange")
	local gotoTxt = goutil.findChildTextComponent(gotoBtnGo, "gotoTxt")
	local redpoint = goutil.findChild(gotoBtnGo, "redpoint")
	local finishGo = goutil.findChild(cell, "finishGo")
	local txtTime = goutil.findChildTextComponent(cell, "nameTxt/txtTime")

	txtTime.text = ""

	local gainLimit = checknumber(data.gainLimit)

	if gainLimit > 0 then
		local time = self:_getTaskTime(data.type, data.id)

		txtTime.text = time < gainLimit and langPara("次数：<color=#20b376>%s</color>/%s", time, gainLimit) or langPara("次数：<color=#eb4642>%s</color>/%s", time, gainLimit)
	end

	GameUtil.asBtn(gotoBtnGo):RemoveClickListener()

	for i = 1, #matList do
		MaterialMgr.resetAll(matList[i])
	end

	nameTxt.text = data.name
	descTxt.text = data.des

	local goodsList = string.split(data.prize, "#")

	for i = 1, #goodsList do
		if matList[i] and goodsList[i] then
			MaterialMgr.setCellByCfg(goodsList[i], matList[i])
		end
	end

	if data.isFinish then
		timeTxt.text = ""

		GameUtil.SetActive(redpoint, false)
		GameUtil.SetActive(gotoBtnGo, false)
		GameUtil.SetActive(finishGo, true)

		return
	end

	timeTxt.text = string.format("%s/%s", math.min(data.haveProgress, data.progress), data.progress)

	GameUtil.SetActive(finishGo, false)
	GameUtil.SetActive(gotoBtnGo, true)
	GameUtil.SetActive(redpoint, data.haveProgress >= data.progress)

	local isFull = data.haveProgress >= data.progress

	if isFull then
		gotoTxt.text = lang("mail_get")

		gotoBtnIma:SetState(1)
	else
		gotoTxt.text = lang("goto")

		gotoBtnIma:SetState(0)
	end

	GameUtil.asBtn(gotoBtnGo):AddClickListener(function()
		local actId = DragonConfig.instance:getOpenTaskActivityId()

		if checknumber(actId) <= 0 then
			FloatWordMgr.instance:show(lang("text_activity_end"))

			return
		end

		if isFull then
			DragonController.instance:csGodLotteryGainPrizeReq(self._choType, actId, data.type, data.id)

			return
		end

		if not string.nilorempty(data.jumpTo) then
			GotoMgr.gotoByString(data.jumpTo)

			return
		end

		FloatWordMgr.instance:show(lang("text_recall_desc_10"))
	end, self)
end

return DragonLotteryView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipFactoryView.lua

module("logic.extensions.equipment.view.EquipFactoryView", package.seeall)

local EquipFactoryView = class("EquipFactoryView", ViewComponent)

function EquipFactoryView:ctor()
	EquipFactoryView.super.ctor(self)

	self._entranceItemList = nil
	self._curTabDatas = nil
	self._curGoodsDatas = nil
	self._middleEquipList = nil
	self._choIndex = 1
	self._isHaveCount = true
	self._sifterParams = nil
	self._sifterItems = nil
	self._choSifterId = nil
	self._sifterInfoList = nil
end

function EquipFactoryView:bindEvents()
	EquipFactoryView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "equipfactory")
	end, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
	self._oneKeyBtn:AddClickListener(self._onClickOneKeyBtn, self)
	self._recycleBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.EquipRecycle, MatType.Equipment)
	end, self)
	GameUtil.asBtn(self._sifterBtnGo):AddClickListener(function()
		local cfg = self._curTabDatas[self._choIndex]

		UIStateManager.instance:push(ViewName.StarGodSelect, {
			alchemyType = self._alchemyType,
			cfg = cfg,
			sifterId = self._choSifterId
		})
	end, self)
end

function EquipFactoryView:unbindEvents()
	EquipFactoryView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._oneKeyBtn:RemoveClickListener()
	self._recycleBtn:RemoveClickListener()
	GameUtil.asBtn(self._sifterBtnGo):RemoveClickListener()

	for _, item in pairs(self._middleEquipList or {}) do
		if item and item.equipBtnGo then
			GameUtil.asBtn(item.equipBtnGo):RemoveClickListener()
		end
	end

	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end
end

function EquipFactoryView:onExit()
	EquipFactoryView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	if self.targetEff then
		UIEffectManager.instance:stopEffect(self.targetEff)
	end

	self.targetEff = nil

	for _, item in pairs(self._middleEquipList or {}) do
		if item.itemEff then
			UIEffectManager.instance:stopEffect(item.itemEff)

			item.itemEff = nil
		end
	end

	MaterialMgr.resetAll(self._sifterPos)

	self._curTabDatas = nil
	self._curGoodsDatas = nil
	self._isHaveCount = nil
	self._sifterParams = nil
	self._choSifterId = nil
	self._sifterInfoList = nil
end

function EquipFactoryView:destroyUI()
	EquipFactoryView.super.destroyUI(self)

	local costBig = self._costIma.gameObject:GetComponent("ImageBigBG")

	if costBig then
		costBig:ClearImage()
	end

	local costBig1 = self._costIma1.gameObject:GetComponent("ImageBigBG")

	if costBig1 then
		costBig1:ClearImage()
	end

	local tarBig = self._targetImaGo:GetComponent("ImageBigBG")

	if tarBig then
		tarBig:ClearImage()
	end

	for _, item in pairs(self._middleEquipList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._middleEquipList = nil
	self._sifterItems = nil
end

function EquipFactoryView:buildUI()
	EquipFactoryView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._viewNameTxt = self:getTxt("viewNameTxt")
	self._goldbarCon = self:getGo("goldbarCon")
	self._tabListSR = self:getGo("tabListSR"):GetComponent("UITableview")
	self._tabItemGo = self:getGo("tabItemGo")

	self._tabItemGo:SetActive(false)

	local middleGo = self:getGo("middleGo")

	self._qualityIma = goutil.findChild(middleGo, "qualityIma"):GetComponent("UIImageColorChange")
	self._targetImaGo = goutil.findChild(middleGo, "targetImaGo")
	self._sifterGo = goutil.findChild(self._targetImaGo, "sifterGo")
	self._sifterPos = goutil.findChild(self._sifterGo, "sifterPos")
	self._sifterBtnGo = goutil.findChild(self._sifterGo, "sifterBtn")
	self._targetEquipTxt = goutil.findChildTextComponent(middleGo, "targetEquipTxt")
	self._middleEquipPos = goutil.findChild(middleGo, "middleEquipPos").transform
	self._equipGo = goutil.findChild(middleGo, "equipGo")
	self._costTxt = goutil.findChildTextComponent(middleGo, "costTxt")
	self._costIma = goutil.findChild(middleGo, "costTxt/costIma"):GetComponent("Image")
	self._sureBtn = Framework.ButtonAdapter.GetFrom(middleGo, "sureBtn")
	self._costTxt1 = goutil.findChildTextComponent(middleGo, "costTxt_1")
	self._costIma1 = goutil.findChild(middleGo, "costTxt_1/costIma_1"):GetComponent("Image")

	self._equipGo:SetActive(false)

	self._txtGo = goutil.findChild(middleGo, "txtGo")

	GameUtil.SetActive(self._costTxt1, false)

	self._supCountGo = goutil.findChild(middleGo, "supCountGo")
	self._supCountTxt = goutil.findChildTextComponent(self._supCountGo, "supCountTxt")

	GameUtil.SetActive(self._supCountGo, false)

	self._supTimeGo = goutil.findChild(middleGo, "supTimeGo")
	self._supTimeTxt = goutil.findChildTextComponent(self._supTimeGo, "supTimeTxt")

	GameUtil.SetActive(self._supTimeGo, false)

	self._rightGo = self:getGo("rightGo")
	self._oneKeyBtn = Framework.ButtonAdapter.GetFrom(self._rightGo, "oneKeyBtn")
	self._goodsListSR = goutil.findChild(self._rightGo, "goodsListSR"):GetComponent("UITableview")
	self._goodsItemGo = goutil.findChild(self._rightGo, "goodsItemGo")

	self._goodsItemGo:SetActive(false)

	self._quaDesTxt = goutil.findChildTextComponent(self._rightGo, "quaDesTxt")
	self._noGoodsGo = goutil.findChild(self._rightGo, "noGoodsGo")
	self._noGoodsTxt = goutil.findChildTextComponent(self._noGoodsGo, "noGoodsTxt")
	self._quaDesTxt.text = ""
	self._noGoodsTxt.text = ""

	self._noGoodsGo:SetActive(false)

	self._recycleBtn = self:getBtn("recycleBtn")
	self._sifterItem = goutil.findChild(self._rightGo, "sifterItem")

	GameUtil.SetActive(self._sifterItem, false)
	self:_RegistCallbacks()
end

function EquipFactoryView:_RegistCallbacks()
	self._tabListSR:RegisterCallback(self._TabInView, function()
		return 114, 112
	end, self._TabAtIndex, self)
	self._tabListSR:RegisterUpdateCellCallback(self._OnTabCellUpdate)
	self._goodsListSR:RegisterCallback(self._GoodsInView, function()
		return 90, 90
	end, self._GoodsAtIndex, self)
	self._goodsListSR:RegisterUpdateCellCallback(self._OnGoodsCellUpdate)
end

function EquipFactoryView:_TabInView()
	if not self._curTabDatas then
		return 0
	end

	return #self._curTabDatas
end

function EquipFactoryView:_TabAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tabItemGo)

	local data = self._curTabDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateTabCell(view, cell, data)

	return cell
end

function EquipFactoryView:_OnTabCellUpdate(view, cell)
	local index = cell.index
	local data = self._curTabDatas[index + 1]

	cell.data = index + 1

	self:_UpdateTabCell(view, cell, data)
end

function EquipFactoryView:_GoodsInView()
	if not self._curGoodsDatas then
		return 0
	end

	return #self._curGoodsDatas
end

function EquipFactoryView:_GoodsAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._goodsItemGo)

	local data = self._curGoodsDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateGoodsCell(view, cell, data)

	return cell
end

function EquipFactoryView:_OnGoodsCellUpdate(view, cell)
	local index = cell.index
	local data = self._curGoodsDatas[index + 1]

	cell.data = index + 1

	self:_UpdateGoodsCell(view, cell, data)
end

function EquipFactoryView:onEnter()
	EquipFactoryView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.Factory_UpdataShowInfo, self._updataEquipFactoryShow, self)
	self.addGEvent(self, GlobalNotify.Factory_UpdataShowCount, self._updataEquipFactoryCount, self)
	self.addGEvent(self, GlobalNotify.Factory_UpdataShowSifter, self._updataEquipFactorySifter, self)
	self.addGEvent(self, GlobalNotify.Factory_UpdataShowSelectMat, self._showStarGodTargetMat, self)

	self._alchemyType = checknumber(self:getFirstParam())

	if self._alchemyType == 0 then
		self._alchemyType = PetEquipModel.AlchemyType.Equip
	end

	self._selectingItems = {}

	local cfg = EquipmentConfig.instance:GetComposeDdefineCfgs(self._alchemyType)

	if cfg then
		if not cfg.planId then
			local planId = 1

			self._curTabDatas, self._choIndex = PetEquipModel.instance:getAlchemyTableList(planId)

			if self._curTabDatas == nil or #self._curTabDatas == 0 or self._choIndex == 0 then
				printError("sr---装备合成  EquipFactoryView:onEnter()       为毛是空的？？？")

				return
			end

			self._nowLevel = RoleModel.instance:getMyLevel()

			self:_preHandle()
			PetEquipModel.instance:setSingleEquipAlchemyRedpoint(self._alchemyType)

			if cfg and not string.nilorempty(cfg.tabName) then
				self._viewNameTxt.text = cfg.tabName
			end

			self:_setTopGoldBar(cfg.topShowMat)
			self:_updataEquipFactoryShow(self._alchemyType)

			local effPath = "fx_ui_zhuangbeijiemian/fx_ui_jiemian_tongyong_zhuangbie.prefab"

			self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

			self.pmEff:setParent(self.mainGO.transform)
			self.pmEff:setLocalPos(0, 0, 0)
			self.pmEff:setScale(1)
			PetEquipController.instance:csGetComposeTimesReq()
		end
	end
end

function EquipFactoryView:_setTopGoldBar(str)
	if string.nilorempty(str) then
		return
	end

	local list = string.split(str, "#")

	if list == nil or #list == 0 then
		return
	end

	local temp = {}

	for i = 1, #list do
		table.insert(temp, {
			showAdd = true,
			id = list[i]
		})
	end

	MainUIController.instance:showGlodBar(self._goldbarCon, self._viewPresentor, temp, false)
end

function EquipFactoryView:_updataEquipFactoryShow(aType)
	if self._alchemyType ~= aType then
		return
	end

	self:_choiseTabByIndex(self._choIndex, true)
end

function EquipFactoryView:_choiseTabByIndex(index, isForce)
	index = index or self._choIndex

	if index == self._choIndex and not isForce then
		return
	end

	self._choIndex = index
	self._costInfo = {}

	self:_updataMiddleEquipShow()
	self:_updataEquipFactoryCount()
	self:_updataShowSifterInfo()

	local cfg = self._curTabDatas[self._choIndex]

	PetEquipModel.instance:setSingleEquipFactoryRedpoint(cfg, self._alchemyType)

	self._curGoodsDatas = PetEquipModel.instance:getFactorySifterList(self._alchemyType, cfg, self._sifterParams)

	if self._curGoodsDatas and #self._curGoodsDatas > 0 then
		self._noGoodsGo:SetActive(false)
	else
		self._noGoodsGo:SetActive(true)

		self._noGoodsTxt.text = "当前没有该品质的材料哦！"
	end

	self._tabListSR:ReloadData()

	self._quaDesTxt.text = cfg.scrollDes

	self._goodsListSR:ReloadData()
end

function EquipFactoryView:_updataMiddleEquipShow()
	local cfg = self._curTabDatas[self._choIndex]

	self._qualityIma:SetState(cfg.qualityBase - 2)
	uGuiUtil.setSpriteToImage(self._targetImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.qualityIcon))

	self._targetEquipTxt.text = cfg.targetName
	self._middleEquipList = self._middleEquipList or {}

	if self._middleEquipList and #self._middleEquipList > 0 then
		for i = 1, #self._middleEquipList do
			if self._middleEquipList[i].itemEff then
				UIEffectManager.instance:stopEffect(self._middleEquipList[i].itemEff)

				self._middleEquipList[i].itemEff = nil
			end

			if self._middleEquipList[i].nameTxt then
				self._middleEquipList[i].nameTxt.text = ""
			end

			if self._middleEquipList[i].equipPos then
				MaterialMgr.resetAll(self._middleEquipList[i].equipPos)
			end

			if self._middleEquipList[i].petIconGo then
				MaterialMgr.resetAll(self._middleEquipList[i].petIconGo)
			end

			if self._middleEquipList[i].equipBtnGo then
				GameUtil.asBtn(self._middleEquipList[i].equipBtnGo):RemoveClickListener()
			end

			if self._middleEquipList[i].itemGo then
				GameUtil.SetActive(self._middleEquipList[i].itemGo, false)
			end
		end
	end

	local posList = string.split(cfg.costPos, "#")

	for i = 1, cfg.costNum do
		if self._middleEquipList[i] == nil or self._middleEquipList[i].itemGo == nil then
			self._middleEquipList[i] = {}

			local go = UnityEngine.GameObject.Instantiate(self._equipGo, self._middleEquipPos)

			GameUtil.SetActive(go, true)

			self._middleEquipList[i] = {
				itemGo = go,
				equipPos = goutil.findChild(go, "equipPos"),
				nameTxt = goutil.findChildTextComponent(go, "nameTxt"),
				addEquipGo = goutil.findChild(go, "addEquipGo"),
				petShowGo = goutil.findChild(go, "petShowGo"),
				petIconGo = goutil.findChild(go, "petShowGo/mask/petIcon"),
				equipBtnGo = goutil.findChild(go, "equipBtnGo")
			}
		end

		GameUtil.SetActive(self._middleEquipList[i].itemGo, true)
		GameUtil.SetActive(self._middleEquipList[i].petShowGo, false)

		self._middleEquipList[i].nameTxt.text = ""

		local x, y = 0, 0

		if posList and posList[i] then
			local list = string.split(posList[i], ",")

			x = list and checknumber(list[1]) or 0
			y = list and checknumber(list[2]) or 0
		end

		Framework.TransformUtil.SetLocalPos(self._middleEquipList[i].itemGo.transform, x, y, 0)
		GameUtil.SetActive(self._middleEquipList[i].addEquipGo, true)

		self._middleEquipList[i].onlyId = nil

		GameUtil.asBtn(self._middleEquipList[i].equipBtnGo):AddClickListener(function()
			self:_onClickEquipItemBtn(i)
		end)
	end
end

function EquipFactoryView:_updataEquipFactorySifter(viewName, ayType, planId, attrs, isReset)
	if viewName == nil or viewName ~= self._viewPresentor.viewName or ayType == nil or self._alchemyType ~= ayType then
		return
	end

	self._sifterParams = self._sifterParams or {}

	if isReset then
		self._sifterParams = {}
	else
		planId = checknumber(planId)
		self._sifterParams[planId] = attrs
	end

	self:_choiseTabByIndex(self._choIndex, true)
end

function EquipFactoryView:_updataShowSifterInfo()
	self._sifterInfoList = nil

	MaterialMgr.resetAll(self._sifterPos)

	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	GameUtil.SetActive(self._sifterBtnGo, false)
	GameUtil.SetActive(self._sifterGo, false)

	local cfg = self._curTabDatas[self._choIndex]
	local selectingId = checknumber(self._selectingItems[self._choIndex])

	if checknumber(cfg.targetMatId) == 0 and selectingId > 0 then
		self:_showStarGodTargetMat(selectingId)
	else
		self:_showStarGodTargetMat(cfg.targetMatId)
	end

	if not cfg.randomPool and cfg.targetMatId == 0 then
		GameUtil.SetActive(self._sifterGo, true)
		GameUtil.SetActive(self._sifterBtnGo, true)
	end

	self._sifterInfoList = PetEquipModel.instance:getFactorySifterCfgs(cfg.sifter, self._viewPresentor.viewName)

	if self._sifterInfoList == nil or #self._sifterInfoList == 0 then
		self._sifterParams = nil

		return
	end

	self._sifterItems = self._sifterItems or {}

	for i = 1, #self._sifterInfoList do
		local index = i

		if self._sifterItems[index] == nil or self._sifterItems[index].itemGo == nil then
			self._sifterItems[index] = {}

			local go = UnityEngine.GameObject.Instantiate(self._sifterItem, self._rightGo.transform)

			go.name = "sifterItem_" .. index
			self._sifterItems[index].itemGo = go
			self._sifterItems[index].itemGrg = go:GetComponent("UIImageSpriteChange")
			self._sifterItems[index].nameTxt = goutil.findChildTextComponent(go, "sifterTxt")
		end

		GameUtil.SetActive(self._sifterItems[index].itemGo, true)

		self._sifterItems[index].nameTxt.text = self._sifterInfoList[index].btnName

		Framework.TransformUtil.SetLocalPos(self._sifterItems[index].itemGo.transform, checknumber(self._sifterInfoList[index].btnPos[1]), checknumber(self._sifterInfoList[index].btnPos[2]), 0)
		GameUtil.asBtn(self._sifterItems[index].itemGo):AddClickListener(function()
			self:_onClickSifterItemBtn(index)
		end, self)
	end
end

function EquipFactoryView:_showStarGodTargetMat(id)
	MaterialMgr.resetAll(self._sifterPos)

	self._choSifterId = checknumber(id)
	self._selectingItems[self._choIndex] = self._choSifterId

	if self._choSifterId <= 0 then
		return
	end

	local cfg = self._curTabDatas[self._choIndex]

	GameUtil.SetActive(self._sifterGo, true)

	local matStr = string.format("%s:%s:%s", cfg.matType, self._choSifterId, 0)
	local proxy = MaterialMgr.setCellByCfg(matStr, self._sifterPos)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy.binder:setLvl(0)
	end

	self._targetEquipTxt.text = MaterialMgr.getMaterialsName(cfg.matType, self._choSifterId)
end

function EquipFactoryView:_onClickSifterItemBtn(index)
	if self._sifterInfoList == nil or self._sifterInfoList[index] == nil then
		return
	end

	local info = self._sifterInfoList[index]

	if info.planId <= 0 or info.subList == nil or info.subList[1] and info.subList[1].showType <= 0 then
		self:_updataEquipFactorySifter(self._viewPresentor.viewName, self._alchemyType, nil, nil, true)

		return
	end

	ViewMgr.instance:open(ViewName.EquipFactorySifter, {
		alchemyType = self._alchemyType,
		btnTabInfo = info,
		choList = (self._sifterParams and self._sifterParams[info.planId] or nil) and self._sifterParams[info.planId],
		itemGo = self._sifterItems[index].itemGo
	})
end

function EquipFactoryView:_updataEquipFactoryCount()
	removetimer(self._calculationSurplusTime, self)

	local cfg = self._curTabDatas[self._choIndex]

	self._isHaveCount = true

	local countInfo = PetEquipModel.instance:getEquipFactoryCount(self._alchemyType)
	local useCount = checknumber(countInfo[cfg.costQuality])

	self:_showActivityTimer(cfg.periodType, cfg.limitTimes, useCount)

	local list = PetEquipModel.instance:getEquipFactoryCostPlanCfg(cfg.costPlanId, useCount + 1)

	if list and #list > 0 then
		if #list == 1 then
			GameUtil.SetActive(self._costTxt1, false)
			Framework.TransformUtil.SetLocalPos(self._costTxt.gameObject.transform, 30, -205, 0)
			Framework.TransformUtil.SetLocalPos(self._txtGo.transform, -78, -205, 0)
		else
			GameUtil.SetActive(self._costTxt1, true)
			Framework.TransformUtil.SetLocalPos(self._costTxt.gameObject.transform, -20, -205, 0)
			Framework.TransformUtil.SetLocalPos(self._costTxt1.gameObject.transform, 134, -205, 0)
			Framework.TransformUtil.SetLocalPos(self._txtGo.transform, -130, -205, 0)

			local mats = string.split(list[2], ":")

			self._costTxt1.text = mats[3]

			MaterialMgr.setIcon(self._costIma1, checknumber(mats[1]), checknumber(mats[2]))

			local have = MaterialModel.instance:getMaterialsNumber(checknumber(mats[1]), checknumber(mats[2]))

			self._costInfo[2] = {
				matType = checknumber(mats[1]),
				matId = checknumber(mats[2]),
				need = checknumber(mats[3]),
				have = have
			}
		end

		local matInfo = string.split(list[1], ":")
		local count = MaterialModel.instance:getMaterialsNumber(checknumber(matInfo[1]), checknumber(matInfo[2]))

		self._costTxt.text = matInfo[3]

		MaterialMgr.setIcon(self._costIma, checknumber(matInfo[1]), checknumber(matInfo[2]))

		self._costInfo[1] = {
			matType = checknumber(matInfo[1]),
			matId = checknumber(matInfo[2]),
			need = checknumber(matInfo[3]),
			have = count
		}
	end

	if cfg == nil or string.nilorempty(cfg.periodType) or cfg.periodType == "none" then
		GameUtil.SetActive(self._supCountGo, false)
		GameUtil.SetActive(self._supTimeGo, false)

		return
	end
end

function EquipFactoryView:_showActivityTimer(strType, limitTimes, useCount)
	self._supCountTxt.text = ""

	GameUtil.SetActive(self._supCountGo, false)

	local now = ServerTime.nowDateServerLook()
	local server_now = ServerTime.now()
	local str
	local nowSec = (now.hour * 60 + now.min) * 60 - now.sec

	if now.hour < 5 then
		self._supTime = 18000 - nowSec or 104400 - nowSec
	end

	if strType == "daily" then
		str = "今日"
	elseif strType == "weekly" then
		str = "本周"

		local nowTime = server_now - GameUtil.SERVER_TICK_DAILYR_EFRESH * 3600
		local timetable = GameUtil.time2date(nowTime)
		local currentWeekday = timetable.wday
		local daysToFriday = 6 - currentWeekday

		if daysToFriday <= 0 then
			daysToFriday = daysToFriday + 7
		end

		timetable.day = timetable.day + daysToFriday
		timetable.hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
		timetable.min = 0
		timetable.sec = 0

		local nextTime = os.time(timetable)

		self._supTime = nextTime - server_now
	elseif strType == "monthly" then
		str = "本月"

		if now.day > 1 or now.hour > GameUtil.SERVER_TICK_DAILYR_EFRESH then
			now.month = now.month + 1
		end

		now.day = 1
		now.hour = GameUtil.SERVER_TICK_DAILYR_EFRESH
		now.min = 0
		now.sec = 0

		local next_month_first_day = os.time(now)

		self._supTime = next_month_first_day - server_now
	end

	if limitTimes > 0 and self._supTime > 0 then
		GameUtil.SetActive(self._supCountGo, true)
	end

	if self._supTime <= 0 then
		GameUtil.SetActive(self._supTimeGo, false)

		self._supTimeTxt.text = "次数即将重置"
	else
		if limitTimes > 0 then
			if limitTimes <= useCount then
				self._isHaveCount = false
			end

			self._supCountTxt.text = string.format("%s剩余：%s/%s", str, limitTimes - useCount, limitTimes)
		end

		GameUtil.SetActive(self._supTimeGo, true)
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function EquipFactoryView:_calculationSurplusTime()
	if self._supTime <= 0 then
		self._supTimeTxt.text = "次数即将重置"

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._supTimeTxt.text = day > 0 and string.format("次数重置：%s天%s时%s分", day, hour, min) or string.format("次数重置：%s时%s分%s秒", hour, min, sec)
	self._supTime = self._supTime - 1
end

function EquipFactoryView:_onClickEquipItemBtn(index)
	if self._middleEquipList == nil or self._middleEquipList[index] == nil then
		return
	end

	local item = self._middleEquipList[index]

	if item.itemGo == nil or checknumber(item.onlyId) <= 0 then
		return
	end

	if self._curGoodsDatas == nil or #self._curGoodsDatas <= 0 then
		return
	end

	for i = 1, #self._curGoodsDatas do
		if self._curGoodsDatas[i] and not self._curGoodsDatas[i].isEmpty and self._curGoodsDatas[i].useCount > 0 then
			if self._alchemyType == PetEquipModel.AlchemyType.Artifact then
				if self._curGoodsDatas[i].onlyId == item.onlyId then
					self._curGoodsDatas[i].useCount = self._curGoodsDatas[i].useCount - 1

					self:_resetMiddleEquipItem(index)
					self._goodsListSR:ReloadData()
				end
			elseif self._curGoodsDatas[i].countList then
				for _, id in pairs(self._curGoodsDatas[i].countList) do
					if checknumber(id) == item.onlyId then
						self:_onClickGoodsItemBtn(i, false)

						return
					end
				end
			elseif self._curGoodsDatas[i].onlyId == item.onlyId then
				self:_onClickGoodsItemBtn(i, false)

				return
			end
		end
	end
end

function EquipFactoryView:_onClickOneKeyBtn()
	local cfg = self._curTabDatas[self._choIndex]

	if self._middleEquipList == nil or #self._middleEquipList < cfg.costNum then
		return
	end

	local emptyCount = 0

	for i = 1, cfg.costNum do
		if self._middleEquipList[i] and checknumber(self._middleEquipList[i].onlyId) <= 0 then
			emptyCount = emptyCount + 1
		end
	end

	if emptyCount <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_4"))

		return
	end

	if self._curGoodsDatas == nil or #self._curGoodsDatas <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_5"))

		return
	end

	local tempCount = 0

	for i = 1, #self._curGoodsDatas do
		if self._curGoodsDatas[i] and not self._curGoodsDatas[i].isEmpty and tempCount < emptyCount then
			if self._curGoodsDatas[i].countList and #self._curGoodsDatas[i].countList > 0 then
				while self._curGoodsDatas[i].useCount < #self._curGoodsDatas[i].countList and tempCount < emptyCount do
					tempCount = tempCount + 1
					self._curGoodsDatas[i].useCount = self._curGoodsDatas[i].useCount + 1

					self:_addMiddleEquipItem(self._curGoodsDatas[i].countList[self._curGoodsDatas[i].useCount], self._curGoodsDatas[i])
				end
			elseif self._curGoodsDatas[i].useCount == 0 then
				tempCount = tempCount + 1
				self._curGoodsDatas[i].useCount = 1

				self:_addMiddleEquipItem(self._curGoodsDatas[i].onlyId, self._curGoodsDatas[i])
			end
		end
	end

	if tempCount == 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_5"))

		return
	end

	self._goodsListSR:ReloadData()
end

function EquipFactoryView:_onClickSureBtn()
	local cfg = self._curTabDatas[self._choIndex]

	if self._middleEquipList == nil or #self._middleEquipList < cfg.costNum then
		return
	end

	local list = {}

	for i = 1, cfg.costNum do
		if checknumber(self._middleEquipList[i].onlyId) > 0 then
			table.insert(list, self._middleEquipList[i].onlyId)
		else
			FloatWordMgr.instance:show(lang("text_equip_desc_6"))

			return
		end
	end

	if not self._isHaveCount then
		FloatWordMgr.instance:show(lang("text_tili_desc_7"))

		return
	end

	if not cfg.randomPool and checknumber(self._choSifterId) <= 0 then
		if self._alchemyType == PetEquipModel.AlchemyType.StarGod then
			FloatWordMgr.instance:show("请选择要兑换的星神")
		elseif self._alchemyType == PetEquipModel.AlchemyType.Equip then
			FloatWordMgr.instance:show("请选择要兑换的装备")
		elseif self._alchemyType == PetEquipModel.AlchemyType.Artifact then
			FloatWordMgr.instance:show("请选择要兑换的收藏品")
		end

		return
	end

	if self._costInfo == nil or self._costInfo[1] == nil or self._costInfo[1].matType == nil then
		return
	end

	if self._costInfo[1].need > self._costInfo[1].have then
		MaterialMgr.openGetSource(self._costInfo[1].matType, self._costInfo[1].matId)

		return
	end

	if self._costInfo[2] and self._costInfo[2].matType and self._costInfo[2].need > self._costInfo[2].have then
		MaterialMgr.openGetSource(self._costInfo[2].matType, self._costInfo[2].matId)

		return
	end

	local countInfo = PetEquipModel.instance:getEquipFactoryCount(self._alchemyType)
	local useCount = checknumber(countInfo[cfg.costQuality])

	if self._alchemyType == PetEquipModel.AlchemyType.Equip or self._alchemyType == PetEquipModel.AlchemyType.Artifact then
		if not self:_checkPasswordLockPass(self._alchemyType, list) then
			return
		end

		PetEquipController.instance:CSComposeEquipmentReq(self._alchemyType, cfg.costQuality, list, useCount + 1, self._choSifterId)
	elseif self._alchemyType == PetEquipModel.AlchemyType.StarGod then
		if not self:_checkPasswordLockPass(self._alchemyType, list) then
			return
		end

		local name = cfg.tabDes

		if checknumber(self._choSifterId) > 0 then
			name = MaterialMgr.getMaterialsName(cfg.matType, checknumber(self._choSifterId))
		end

		if not ConstString.StarGodPlusQualityDesc[cfg.realCostQuality] then
			local quaName = ""
			local content = langPara("确认要消耗%s个%s星神,兑换一个【%s】吗", cfg.costNum, quaName, name)

			TipsFacade:openPopupWindow(lang("tip"), content, function()
				PetEquipController.instance:CSComposeEquipmentReq(self._alchemyType, cfg.costQuality, list, useCount + 1, self._choSifterId)
			end, nil, lang("mail_confirm"), lang("mail_cancel"))
		end
	end
end

function EquipFactoryView:_UpdateTabCell(view, cell, data)
	local itemGroup = cell:GetComponent("UIChangeGroup")
	local tabNameTxt = goutil.findChildTextComponent(cell, "tabNameTxt")
	local redpointGo = goutil.findChild(cell, "redpointGo")
	local lockGo = goutil.findChild(cell, "lockGo")
	local lockTxt = goutil.findChildTextComponent(lockGo, "lockTxt")

	GameUtil.asBtn(cell):RemoveClickListener()

	if data.requiredPlayerLevel <= self._nowLevel then
		GameUtil.SetActive(lockGo, false)
		GameUtil.SetActive(redpointGo, PetEquipModel.instance:getSingleEquipFactoryRedpoint(data, self._alchemyType))
	else
		GameUtil.SetActive(lockGo, true)
		GameUtil.SetActive(redpointGo, false)

		lockTxt.text = string.format("%s级可解锁", data.requiredPlayerLevel)
	end

	if cell.data == self._choIndex then
		itemGroup:SetState(1)
	else
		itemGroup:SetState(0)
	end

	tabNameTxt.text = data.tabDes

	GameUtil.asBtn(cell):AddClickListener(function()
		if data.requiredPlayerLevel > self._nowLevel then
			FloatWordMgr.instance:show(string.format("%s级可解锁", data.requiredPlayerLevel))

			return
		end

		if self._choIndex == cell.data then
			return
		end

		self._sifterParams = nil
		self._choSifterId = nil

		self:_choiseTabByIndex(cell.data)
	end)
end

function EquipFactoryView:_UpdateGoodsCell(view, cell, data)
	local equipPos = goutil.findChild(cell, "equipPos")
	local petShowGo = goutil.findChild(cell, "petShowGo")
	local petIconGo = goutil.findChild(petShowGo, "mask/petIcon")
	local equipBtnGo = goutil.findChild(cell, "equipBtnGo")
	local reduceBtnGo = goutil.findChild(cell, "reduceBtn")
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local nameChange = nameText.gameObject:GetComponent(ComponentType.UITextColorChange)

	GameUtil.asBtn(equipBtnGo):RemoveClickListener()
	GameUtil.asBtn(reduceBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(equipPos)
	MaterialMgr.resetAll(petIconGo)
	GameUtil.SetActive(petShowGo, false)

	nameText.text = ""

	if data.isEmpty then
		GameUtil.SetActive(reduceBtnGo, false)

		return
	end

	local subLua
	local allNum, useNum = 1, 0

	if self._alchemyType == PetEquipModel.AlchemyType.Equip then
		local equipInfo = PetEquipModel.instance:GetInfoMoByOnlyId(data.onlyId, MatType.Equipment)

		if equipInfo then
			subLua = MaterialMgr.setCellByData(MatType.Equipment, equipInfo, equipPos)
		end
	elseif self._alchemyType == PetEquipModel.AlchemyType.Artifact then
		subLua = MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.Throne, data.onlyId), equipPos)
	elseif self._alchemyType == PetEquipModel.AlchemyType.StarGod then
		subLua = MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.StarGodPlus, data.baseId), equipPos)

		if checknumber(data.petId) > 0 then
			GameUtil.SetActive(petShowGo, true)

			local petMo = BagPetsController.instance:getPet(data.petId)

			MaterialMgr.setIcon(petIconGo, MatType.Pet, petMo.raceId)
		end

		nameText.text = data.name

		nameChange:SetState(data.quality)
	end

	if data.countList and #data.countList > 1 then
		allNum = #data.countList
	end

	if data.useCount > 0 then
		useNum = data.useCount
	end

	if subLua and subLua.binder then
		if allNum <= 1 then
			subLua.binder:setNum(0)
		else
			subLua.binder:setNum(allNum, useNum)
		end

		subLua.binder:setAutoTips(false)
		subLua.binder:setSelected(useNum > 0)
	end

	GameUtil.SetActive(reduceBtnGo, useNum > 0)
	GameUtil.asBtn(equipBtnGo):AddClickListener(function()
		self:_onClickGoodsItemBtn(cell.data, true)
	end, self)
	GameUtil.asBtn(reduceBtnGo):AddClickListener(function()
		self:_onClickGoodsItemBtn(cell.data, false)
	end, self)
end

function EquipFactoryView:_onClickGoodsItemBtn(index, isAdd)
	if self._curGoodsDatas == nil or self._curGoodsDatas[index] == nil then
		return
	end

	if isAdd then
		if ((self._curGoodsDatas[index].countList and #self._curGoodsDatas[index].countList > 1 or nil) and #self._curGoodsDatas[index].countList) <= self._curGoodsDatas[index].useCount then
			FloatWordMgr.instance:show(lang("text_equip_desc_14"))

			return
		end

		if not self:_isHaveEmptyMiddleItem() then
			FloatWordMgr.instance:show("放入的材料已满！")

			return
		end

		self._curGoodsDatas[index].useCount = self._curGoodsDatas[index].useCount + 1

		self:_addMiddleEquipItem((self._curGoodsDatas[index].countList and #self._curGoodsDatas[index].countList > 0 or nil) and self._curGoodsDatas[index].countList[self._curGoodsDatas[index].useCount], self._curGoodsDatas[index])
	else
		if self._curGoodsDatas[index].useCount <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_16"))

			return
		end

		local onlyId = self._curGoodsDatas[index].onlyId

		if self._curGoodsDatas[index].countList and #self._curGoodsDatas[index].countList > 0 then
			onlyId = self._curGoodsDatas[index].countList[self._curGoodsDatas[index].useCount]
		end

		self._curGoodsDatas[index].useCount = self._curGoodsDatas[index].useCount - 1

		self:_removeMiddleEquipItem(onlyId)
	end

	self._goodsListSR:ReloadData()
end

function EquipFactoryView:_isHaveEmptyMiddleItem()
	local cfg = self._curTabDatas[self._choIndex]

	if cfg then
		if not cfg.costNum then
			local count = 3

			for i = 1, count do
				if self._middleEquipList[i] and checknumber(self._middleEquipList[i].onlyId) <= 0 then
					return true
				end
			end

			return false
		end
	end
end

function EquipFactoryView:_addMiddleEquipItem(onlyId, mo)
	if self._middleEquipList == nil or #self._middleEquipList <= 0 then
		return
	end

	local cfg = self._curTabDatas[self._choIndex]

	if cfg then
		if not cfg.costNum then
			local count = 3

			for i = 1, count do
				if self._middleEquipList[i] and self._middleEquipList[i].itemGo and checknumber(self._middleEquipList[i].onlyId) <= 0 then
					MaterialMgr.resetAll(self._middleEquipList[i].equipPos)
					MaterialMgr.resetAll(self._middleEquipList[i].petIconGo)
					GameUtil.SetActive(self._middleEquipList[i].addEquipGo, false)
					GameUtil.SetActive(self._middleEquipList[i].petShowGo, false)

					local subLua

					if self._alchemyType == PetEquipModel.AlchemyType.Equip then
						local equipInfo = PetEquipModel.instance:GetInfoMoByOnlyId(onlyId, MatType.Equipment)

						if equipInfo then
							subLua = MaterialMgr.setCellByData(MatType.Equipment, equipInfo, self._middleEquipList[i].equipPos)
						end
					elseif self._alchemyType == PetEquipModel.AlchemyType.Artifact then
						subLua = MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.Throne, onlyId), self._middleEquipList[i].equipPos)
					elseif self._alchemyType == PetEquipModel.AlchemyType.StarGod then
						subLua = MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.StarGodPlus, mo.baseId), self._middleEquipList[i].equipPos)
						self._middleEquipList[i].nameTxt.text = MaterialMgr.getMaterialsName(MatType.StarGodPlus, mo.baseId)

						if checknumber(mo.petId) > 0 then
							GameUtil.SetActive(self._middleEquipList[i].petShowGo, true)

							local petMo = BagPetsController.instance:getPet(mo.petId)

							MaterialMgr.setIcon(self._middleEquipList[i].petIconGo, MatType.Pet, petMo.raceId)
						end
					end

					if subLua and subLua.binder then
						subLua.binder:setAutoTips(false)
					end

					self._middleEquipList[i].onlyId = onlyId

					if self._middleEquipList[i].itemEff == nil then
						local effPath = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei.prefab"

						self._middleEquipList[i].itemEff = UIEffectManager.instance:playEffect(self, effPath, self._middleEquipList[i].itemGo, 0, 0, false, nil, nil, nil, self)

						self._middleEquipList[i].itemEff:setParent(self._middleEquipList[i].itemGo.transform)
						self._middleEquipList[i].itemEff:setLocalPos(0, 0, 0)
						self._middleEquipList[i].itemEff:setScale(1)
					end

					return
				end
			end
		end
	end
end

function EquipFactoryView:_removeMiddleEquipItem(onlyId)
	if self._middleEquipList == nil or #self._middleEquipList <= 0 then
		return
	end

	local cfg = self._curTabDatas[self._choIndex]

	if cfg then
		if not cfg.costNum then
			local count = 3

			for i = 1, count do
				if self._middleEquipList[i] and self._middleEquipList[i].itemGo and self._middleEquipList[i].onlyId == onlyId then
					self:_resetMiddleEquipItem(i)

					return
				end
			end
		end
	end
end

function EquipFactoryView:_resetMiddleEquipItem(index)
	if self._middleEquipList[index] == nil or self._middleEquipList[index].itemGo == nil then
		return
	end

	MaterialMgr.resetAll(self._middleEquipList[index].equipPos)
	MaterialMgr.resetAll(self._middleEquipList[index].petIconGo)

	self._middleEquipList[index].nameTxt.text = ""

	GameUtil.SetActive(self._middleEquipList[index].addEquipGo, true)
	GameUtil.SetActive(self._middleEquipList[index].petShowGo, false)

	self._middleEquipList[index].onlyId = nil

	if self._middleEquipList[index].itemEff then
		UIEffectManager.instance:stopEffect(self._middleEquipList[index].itemEff)

		self._middleEquipList[index].itemEff = nil
	end
end

function EquipFactoryView:_checkPasswordLockPass(alchemyType, ids)
	if #ids > 0 then
		local hasHighQualityEquip = false
		local info

		if alchemyType == PetEquipModel.AlchemyType.Equip then
			for i, id in ipairs(ids) do
				info = PetEquipModel.instance:GetEquipInfo(id)

				if info then
					local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(info.baseId)

					if cfg.qualityBase >= 4 then
						hasHighQualityEquip = true

						break
					end
				end
			end
		elseif alchemyType == PetEquipModel.AlchemyType.StarGod then
			for i, id in ipairs(ids) do
				info = StargodplusModel.instance:getStarGodMo(id)

				if info then
					local cfg = StargodplusConfig.instance:getFillerCfg(info:getDefineId())

					if cfg.quality >= 4 then
						hasHighQualityEquip = true

						break
					end
				end
			end
		end

		if hasHighQualityEquip and PasswordLockController.instance:checkNeedOpenVerifyView() then
			return false
		end
	end

	return true
end

function EquipFactoryView:_preHandle()
	if self._alchemyType == 2 then
		local initId = ThroneModel.instance:getFactoryInitthroneId()

		if initId > 0 then
			local tCfg = ThroneConfig.instance:getThroneCfg(initId)

			for i, v in ipairs(self._curTabDatas) do
				if not v.randomPool and v.targetMatId == 0 and tCfg.quality == v.qualityBase and v.requiredPlayerLevel <= self._nowLevel then
					self._choIndex = i

					self:_showStarGodTargetMat(initId)

					break
				end
			end
		end
	end
end

return EquipFactoryView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipTupoView.lua

module("logic.extensions.equipment.view.EquipTupoView", package.seeall)

local EquipTupoView = class("EquipTupoView", TableViewComponent)

function EquipTupoView:ctor()
	EquipTupoView.super.ctor(self)

	self._attrItemList = nil
	self._leftInfoMo = nil
	self._rightInfoMo = nil
	self._leftItemGo = nil
	self._rightItemGo = nil
	self._choiseItemList = nil
	self._curPetId = 0
end

function EquipTupoView:bindEvents()
	EquipTupoView.super.bindEvents(self)
	GameUtil.addClickHandler(self.attrStoneBtn, self._onClickBtnStone, self)
	GameUtil.addClickHandler(self._btnStone, self._onClickBtnStone, self)
	GameUtil.addClickHandler(self.tupoBtn, self._onClickTupoBtn, self)
	GameUtil.addClickHandler(self._btnPutIn, self._onClickPutIn, self)
	GameUtil.addClickHandler(self._btnPetName, self._onClickPetName, self)
end

function EquipTupoView:unbindEvents()
	EquipTupoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.attrStoneBtn)
	GameUtil.rmClickHandler(self._btnStone)
	GameUtil.rmClickHandler(self.tupoBtn)

	if self._leftItemGo and self._leftItemGo.choiBtnGo then
		GameUtil.rmClickHandler(self._leftItemGo.choiBtnGo)
	end

	if self._rightItemGo and self._rightItemGo.choiBtnGo then
		GameUtil.rmClickHandler(self._rightItemGo.choiBtnGo)
	end

	for _, item in pairs(self._choiseItemList or {}) do
		if item and item.choiBtnGo then
			GameUtil.rmClickHandler(item.choiBtnGo)
		end
	end

	GameUtil.rmClickHandler(self._btnPutIn)
	GameUtil.rmClickHandler(self._btnPetName)
end

function EquipTupoView:buildUI()
	EquipTupoView.super.buildUI(self)

	local middleGo = self:getGo("middleGo")

	self.equipItemGo = goutil.findChild(middleGo, "equipItemGo")
	self.leftEquipTran = goutil.findChild(middleGo, "leftEquipTran").transform
	self.rightEquipTran = goutil.findChild(middleGo, "rightEquipTran").transform
	self.equipAttrTran = goutil.findChild(middleGo, "equipAttrTran")

	local equipAttrTranContent = goutil.findChild(self.equipAttrTran, "content")

	self._attrItemList = {}

	for i = 1, equipAttrTranContent.transform.childCount do
		local go = equipAttrTranContent.transform:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self._attrItemList[tonumber(names[2])] = go:GetComponent("Text")
		self._attrItemList[tonumber(names[2])].text = ""
	end

	self.powerUpgradeGo = goutil.findChild(middleGo, "powerUpgradeGo")
	self.leftPowerTxt = goutil.findChildTextComponent(self.powerUpgradeGo, "leftPowerTxt")
	self.rightPowerTxt = goutil.findChildTextComponent(self.powerUpgradeGo, "rightPowerTxt")
	self.leftDescTxt = goutil.findChildTextComponent(self.powerUpgradeGo, "leftDescTxt")
	self.rightDescTxt = goutil.findChildTextComponent(self.powerUpgradeGo, "rightDescTxt")
	self.leftPowerTxt.text = ""
	self.rightPowerTxt.text = ""
	self.leftDescTxt.text = ""
	self.rightDescTxt.text = ""
	self._tupo2Go = goutil.findChild(middleGo, "tupo2Go")
	self._qhItemList = {}
	self._qhItemExtList = {}

	for i = 1, 3 do
		local go = goutil.findChild(middleGo, "tupo2Go/qhItem_" .. i)

		table.insert(self._qhItemList, go)
	end

	for i = 1, 2 do
		local go = goutil.findChild(middleGo, "tupo2Go/qhItem_ext_" .. i)

		table.insert(self._qhItemExtList, go)
	end

	self.choiseTran = goutil.findChild(middleGo, "choiseTran").transform
	self.attrStoneBtn = self:getGo("middleGo/attrStoneBtn")
	self.tupoBtn = self:getGo("middleGo/tupoBtn")

	self.equipItemGo:SetActive(false)

	local itemInfoGo = self:getGo("itemInfoGo")

	self.sifterItem = goutil.findChild(itemInfoGo, "sifterItem")
	self.noListGo = goutil.findChild(itemInfoGo, "noListGo")
	self._noListTxt = goutil.findChildTextComponent(itemInfoGo, "noListGo/noListTxt")

	GameUtil.SetActive(self.sifterItem, false)
	GameUtil.SetActive(self.noListGo, false)

	self._mask = self:getGo("mask")
	self._btnPutIn = self:getGo("itemInfoGo/btnPutIn")

	local equipAllTran = self:getGo("middleGo/equipAllTran/content")

	self.equipItemList = {}

	for i = 1, 6 do
		local go = equipAllTran.transform:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self.equipItemList[tonumber(names[2])] = {
			mainGo = go,
			itemGo = goutil.findChild(go, "itemGo"),
			choiseGo = goutil.findChild(go, "choiseGo"),
			stateSpt = goutil.findChildComponent(go, "stateSpt", "UIImageSpriteChange"),
			kuangIma = goutil.findChildComponent(go, "kuangIma", "UIImageSpriteChange")
		}
	end

	self._btnPetName = self:getGo("middleGo/btnPetName")
	self._txtPetName = self:getTxt("middleGo/btnPetName/txt")
	self._btnStone = self:getGo("middleGo/btnStone")
	self._iconBtnStone = self:getGo("middleGo/btnStone/icon")
	self._txtBtnStone = self:getTxt("middleGo/btnStone/txt")
end

function EquipTupoView:onExit()
	EquipTupoView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataEquipAttrShow", self._updataEquipAttrShow, self)
	GlobalDispatcher:removeListener("UpdataEquipTupoUpgrade", self._showViewDataByInfoMo, self)
	GlobalDispatcher:removeListener(GlobalNotify.PET_EQUIP_SELECT, self._showViewDataBySelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self._handleBagPetChanged, self)
	self:_clearAllEquipTran()

	if self._tupoEff then
		UIEffectManager.instance:stopEffect(self._tupoEff)
	end

	self._tupoEff = nil
	self._leftInfoMo = nil
	self._rightInfoMo = nil
	self._curPetId = 0

	goutil.setActive(self._mask, false)
	MaterialMgr.clearIcon(self._iconBtnStone)
end

function EquipTupoView:destroyUI()
	EquipTupoView.super.destroyUI(self)

	self._attrItemList = nil

	if self._leftItemGo and self._leftItemGo.itemGo then
		UnityEngine.GameObject.Destroy(self._leftItemGo.itemGo)
	end

	self._leftItemGo = nil

	if self._rightItemGo and self._rightItemGo.itemGo then
		UnityEngine.GameObject.Destroy(self._rightItemGo.itemGo)
	end

	self._rightItemGo = nil

	for _, item in pairs(self._choiseItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._choiseItemList = nil
end

function EquipTupoView:onEnter()
	EquipTupoView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataEquipAttrShow", self._updataEquipAttrShow, self)
	GlobalDispatcher:addListener("UpdataEquipTupoUpgrade", self._showViewDataByInfoMo, self)
	GlobalDispatcher:addListener(GlobalNotify.PET_EQUIP_SELECT, self._showViewDataBySelect, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self._handleBagPetChanged, self)
	goutil.setActive(self._mask, false)

	self.attrProb = EquipmentConfig.instance:GetAttrProbability()
	self.funcCfg = EquipmentConfig.instance:getEquipFunctionTabCfg(PetEquipModel.FunctionType.TupoType)
	self._leftInfoMo = nil
	self._curPetId = 0
	self._goodQuality = 9
	self._goodConsume = EquipmentConfig.instance:getTupoGoodConsume()

	self:_startCreatEquipItems()
	self:_showViewDataByInfoMo(PetEquipController.instance:getCurrentEquipInfoMo())
end

function EquipTupoView:_handleBagPetChanged()
	local petInfo = BagPetsController.instance:getPet(self._curPetId)

	if petInfo == nil then
		return
	end

	local wearList = PetEquipModel.instance:GetWearEquipInfosByPetInfo(petInfo)
	local wearInfo = wearList[self.currIndex]

	if not wearInfo.isWear or not wearInfo.isOpen then
		for i, v in ipairs(wearList) do
			if v.isWear and v.isOpen then
				wearInfo = v

				break
			end
		end
	end

	local infoMo = wearInfo and wearInfo.info

	self:_showViewDataByInfoMo(infoMo)
end

function EquipTupoView:_startCreatEquipItems()
	if self._leftItemGo == nil or self._leftItemGo.itemGo == nil then
		self._leftItemGo = self:_initCreatChoiseItem(self.leftEquipTran)

		Framework.TransformUtil.SetLocalPos(self._leftItemGo.itemGo.transform, 0, 0, 0)
	end

	GameUtil.addClickHandler(self._leftItemGo.choiBtnGo, function()
		self:_onClickTupoItemBtn(true)
	end)

	if self._rightItemGo == nil or self._rightItemGo.itemGo == nil then
		self._rightItemGo = self:_initCreatChoiseItem(self.rightEquipTran)

		Framework.TransformUtil.SetLocalPos(self._rightItemGo.itemGo.transform, 0, 0, 0)
	end

	GameUtil.addClickHandler(self._rightItemGo.choiBtnGo, function()
		self:_onClickTupoItemBtn(false)
	end)

	self._choiseItemList = self._choiseItemList or {}

	local count = EquipmentConfig.instance:GetManyMergeOne()

	if count < 2 then
		return
	end

	for i = 1, count - 1 do
		if self._choiseItemList[i] == nil or self._choiseItemList[i].itemGo == nil then
			self._choiseItemList[i] = self:_initCreatChoiseItem(self.choiseTran)
		end

		self._choiseItemList[i].choiOnlyId = -1

		GameUtil.addClickHandler(self._choiseItemList[i].choiBtnGo, function()
			self:_onClickChoiseItemBtn(i)
		end)
	end
end

function EquipTupoView:_initCreatChoiseItem(parent)
	local go = UnityEngine.GameObject.Instantiate(self.equipItemGo, parent)

	GameUtil.SetActive(go, true)

	local list = {
		itemGo = go,
		equipPos = goutil.findChild(go, "equipPos"),
		addEquipGo = goutil.findChild(go, "addEquipGo"),
		choiNameTxt = goutil.findChildTextComponent(go, "choiNameTxt"),
		choiBtnGo = goutil.findChild(go, "choiBtnGo"),
		choiCountTxt = goutil.findChildTextComponent(go, "choiCountTxt")
	}

	list.choiCountTxt.text = ""
	list.choiNameTxt.text = ""

	GameUtil.SetActive(list.addEquipGo, true)

	return list
end

function EquipTupoView:_initShowSifterItems()
	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.rmClickHandler(item.itemGo)
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self._sifterParams = {}

	if not string.nilorempty(self.funcCfg.viewSifter) then
		local list = string.split(self.funcCfg.viewSifter, "|")

		for _, v in pairs(list or {}) do
			if v and not string.nilorempty(v) then
				local aa = PetEquipModel.instance:getFactorySifterCfgs(v, self._viewPresentor.viewName)

				if aa and #aa > 0 then
					self._sifterParams = aa

					break
				end
			end
		end
	end

	self._sifterItems = self._sifterItems or {}

	for i = 1, #self._sifterParams do
		local index = i

		if self._sifterItems[index] == nil or self._sifterItems[index].itemGo == nil then
			self._sifterItems[index] = {}

			local go = UnityEngine.GameObject.Instantiate(self._sifterItem, self.itemInfoGo.transform)

			go.name = "sifterItem_" .. index
			self._sifterItems[index].itemGo = go
			self._sifterItems[index].itemGrg = go:GetComponent("UIImageSpriteChange")
			self._sifterItems[index].nameTxt = goutil.findChildTextComponent(go, "sifterTxt")
		end

		GameUtil.SetActive(self._sifterItems[index].itemGo, true)

		self._sifterItems[index].nameTxt.text = self._sifterParams[index].btnName

		Framework.TransformUtil.SetLocalPos(self._sifterItems[index].itemGo.transform, checknumber(self._sifterParams[index].btnPos[1]), checknumber(self._sifterParams[index].btnPos[2]), 0)
		GameUtil.addClickHandler(self._sifterItems[index].itemGo, function()
			self:_onClickSifterItemBtn(index)
		end)
	end
end

function EquipTupoView:_showViewDataBySelect(onlyId)
	local mo = PetEquipModel.instance:GetEquipInfo(onlyId)

	self:_showViewDataByInfoMo(mo)
end

function EquipTupoView:_showViewDataByInfoMo(mo)
	self._leftInfoMo = mo

	if mo then
		self._curPetId = mo.equipPetId or 0
	end

	self._rightInfoMo = nil
	self._curViewDatas = {}

	PetEquipModel.instance:ResetAttrStoneIndex()
	PetEquipModel.instance:ResetAttrRateList()
	PetEquipController.instance:setCurrentEquipInfoMo(self._leftInfoMo)
	MaterialMgr.resetAll(self._leftItemGo.equipPos)
	MaterialMgr.resetAll(self._rightItemGo.equipPos)

	self._leftItemGo.choiNameTxt.text = ""
	self._leftItemGo.choiCountTxt.text = ""
	self._rightItemGo.choiNameTxt.text = ""
	self._rightItemGo.choiCountTxt.text = ""

	GameUtil.SetActive(self._leftItemGo.addEquipGo, true)
	GameUtil.SetActive(self._rightItemGo.addEquipGo, true)
	GameUtil.SetActive(self.equipAttrTran, false)
	GameUtil.SetActive(self.powerUpgradeGo, false)
	GameUtil.SetActive(self.attrStoneBtn, false)
	GameUtil.SetActive(self._tupo2Go, false)
	GameUtil.SetActive(self.noListGo, true)
	GameUtil.SetActive(self._btnStone, false)
	MaterialMgr.clearIcon(self._iconBtnStone)

	self._txtBtnStone.text = ""
	self._noListTxt.text = lang("请放入主装备后，再进行突破")
	self._txtPetName.text = "未穿戴"

	self:_updateAllEquipTran()

	if self._leftInfoMo == nil or self._leftInfoMo.onlyId == nil then
		self._leftItemGo.choiNameTxt.text = lang("text_equip_desc_75")

		for i = 1, #self._choiseItemList do
			if self._choiseItemList[i] then
				self._choiseItemList[i].choiOnlyId = -1

				MaterialMgr.resetAll(self._choiseItemList[i].equipPos)

				self._choiseItemList[i].choiCountTxt.text = "<color=#FF0000FF>0/1</color>"

				GameUtil.SetActive(self._choiseItemList[i].addEquipGo, true)
			end
		end

		self:reloadData()

		return
	end

	if self._leftInfoMo:isCanTupo() then
		GameUtil.SetActive(self._rightItemGo.addEquipGo, false)

		self._rightInfoMo = PetEquipModel.instance:getTupoRightEquip(self._leftInfoMo)
		self._rightItemGo.choiNameTxt.text = self._rightInfoMo.name

		local subLua = MaterialMgr.setCellByData(self._rightInfoMo.matType, self._rightInfoMo, self._rightItemGo.equipPos)

		subLua.binder:setAutoTips(false)
	end

	GameUtil.SetActive(self._leftItemGo.addEquipGo, false)

	self._leftItemGo.choiNameTxt.text = self._leftInfoMo.name

	local petInfo = BagPetsController.instance:getPet(self._leftInfoMo.equipPetId)

	self._txtPetName.text = petInfo and string.format("%s", petInfo.name) or "未穿戴"

	local subLua = MaterialMgr.setCellByData(self._leftInfoMo.matType, self._leftInfoMo, self._leftItemGo.equipPos)

	subLua.binder:setAutoTips(false)
	PetEquipModel.instance:SetAttrRateByString(self._leftInfoMo.attrType, self.attrProb)
	PetEquipModel.instance:SetAttrRateByString("无", -self.attrProb)
	self:_updataConsumablesShow(0, true)
	GlobalDispatcher:dispatch(GlobalNotify.PetEquipCurEquipmentChange)
end

function EquipTupoView:_updataConsumablesShow(index, isReset)
	index = checknumber(index)

	for i = 1, #self._choiseItemList do
		if self._choiseItemList[i] and self._choiseItemList[i].itemGo and (index == 0 or index == i) then
			self._choiseItemList[i].choiNameTxt.text = ""

			MaterialMgr.resetAll(self._choiseItemList[i].equipPos)

			if isReset then
				self._choiseItemList[i].choiOnlyId = -1
			end

			if self._choiseItemList[i].choiOnlyId > 0 then
				self._choiseItemList[i].choiCountTxt.text = "<color=#11A568FF>1/1</color>"

				GameUtil.SetActive(self._choiseItemList[i].addEquipGo, false)

				local mo = PetEquipModel.instance:GetEquipInfo(self._choiseItemList[i].choiOnlyId)

				if mo then
					self._choiseItemList[i].choiNameTxt.text = mo.name

					local subLua = MaterialMgr.setCellByData(mo.matType, mo, self._choiseItemList[i].equipPos)

					subLua.binder:setAutoTips(false)
				end
			else
				self._choiseItemList[i].choiCountTxt.text = "<color=#FF0000FF>0/1</color>"

				GameUtil.SetActive(self._choiseItemList[i].addEquipGo, true)
			end

			if self._leftInfoMo and self._leftInfoMo:isCanTupo() and self._leftInfoMo.quality >= self._goodQuality and i == 3 then
				local matType, matId, matNum = MaterialMgr.getMatParams(self._goodConsume[self._leftInfoMo.wearPos])
				local haveCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

				self._choiseItemList[i].choiCountTxt.text = checknumber(haveCount) >= checknumber(matNum) and string.format("<color=#11A568FF>%s/%s</color>", checknumber(haveCount), checknumber(matNum)) or string.format("<color=#FF0000FF>%s/%s</color>", checknumber(haveCount), checknumber(matNum))

				GameUtil.SetActive(self._choiseItemList[i].addEquipGo, false)

				self._choiseItemList[i].choiNameTxt.text = MaterialMgr.getMaterialsName(matType, matId)

				local subLua = MaterialMgr.setCellByCfg(self._goodConsume[self._leftInfoMo.wearPos], self._choiseItemList[i].equipPos)

				if subLua then
					subLua.binder:setAutoTips(false)
					subLua.binder:setNum(0)
				end
			end
		end
	end

	self:_updataEquipAttrShow()

	self._curViewDatas = PetEquipModel.instance:getTupoEquipItemList(self._leftInfoMo, self._sifterList)

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self.noListGo, true)

		self._noListTxt.text = lang("当前列表没有装备可选择")
	else
		GameUtil.SetActive(self.noListGo, false)
	end

	self:_updateEquipListUI()
end

function EquipTupoView:_updateEquipListUI()
	local curAttr = self._leftInfoMo.attrType
	local stoneId = PetEquipModel.instance:GetAttrStoneIndex()
	local isHaveStone = stoneId and stoneId > 0 or false
	local map = {}

	for i, v in ipairs(self._choiseItemList) do
		if checknumber(v.choiOnlyId) > 0 then
			map[v.choiOnlyId] = true
		end
	end

	table.sort(self._curViewDatas, function(a, b)
		local choiA = map[a.onlyId] and 1 or 0
		local choiB = map[b.onlyId] and 1 or 0

		if choiA ~= choiB then
			return choiB < choiA
		end

		if isHaveStone then
			local emptyAttrA = a.attrType == "无" and 1 or 0
			local emptyAttrB = b.attrType == "无" and 1 or 0

			if emptyAttrA ~= emptyAttrB then
				return emptyAttrB < emptyAttrA
			end
		end

		local exclRaceA = a:GetEquipExclRaceId() and 1 or 0
		local exclRaceB = b:GetEquipExclRaceId() and 1 or 0

		if exclRaceA ~= exclRaceB then
			return exclRaceB < exclRaceA
		end

		local attrA = a.attrType == curAttr and 1 or 0
		local attrB = b.attrType == curAttr and 1 or 0

		if attrA ~= attrB then
			return attrB < attrA
		end

		local emptyAttrA = a.attrType == "无" and 1 or 0
		local emptyAttrB = b.attrType == "无" and 1 or 0

		if emptyAttrA ~= emptyAttrB then
			return emptyAttrB < emptyAttrA
		end

		if a.attrType ~= b.attrType then
			return a.attrType < b.attrType
		end

		if a.starCount == b.starCount then
			return a.baseId < b.baseId
		end

		return a.starCount < b.starCount
	end)
	self:reloadData()
end

function EquipTupoView:_updataEquipAttrShow()
	for _, item in pairs(self._attrItemList) do
		item.text = ""
	end

	GameUtil.SetActive(self.equipAttrTran, false)
	GameUtil.SetActive(self.powerUpgradeGo, false)
	GameUtil.SetActive(self.attrStoneBtn, false)
	GameUtil.SetActive(self._tupo2Go, false)
	GameUtil.SetActive(self._btnStone, false)
	MaterialMgr.clearIcon(self._iconBtnStone)

	self._txtBtnStone.text = ""

	if self._leftInfoMo == nil or not self._leftInfoMo:isCanTupo() then
		return
	end

	if self._leftInfoMo:isEquipArtifact() then
		GameUtil.SetActive(self.powerUpgradeGo, true)

		self.leftPowerTxt.text = tostring(self._leftInfoMo.commPower)
		self.rightPowerTxt.text = tostring(self._rightInfoMo.commPower)

		local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(self._leftInfoMo.baseId)

		self.leftDescTxt.text = PetEquipModel.instance:getArtifactAttrName(cfg.quality, ",") .. cfg.throneDes
		cfg = EquipmentConfig.instance:GetEquipDefineInfoById(self._rightInfoMo.baseId)
		self.rightDescTxt.text = PetEquipModel.instance:getArtifactAttrName(cfg.quality, ",") .. cfg.throneDes

		return
	end

	if self._leftInfoMo.quality >= self._goodQuality then
		GameUtil.SetActive(self._tupo2Go, true)

		local leftRes, leftResExt = self:_getProp(self._leftInfoMo)
		local rightRes, rightResExt = self:_getProp(self._rightInfoMo)
		local keyList = {}
		local keyExtList = {}

		for k, v in pairs(leftRes) do
			if table.indexof(keyList, k) == false then
				table.insert(keyList, k)
			end
		end

		for k, v in pairs(rightRes) do
			if table.indexof(keyList, k) == false then
				table.insert(keyList, k)
			end
		end

		for k, v in pairs(leftResExt) do
			if table.indexof(keyExtList, k) == false then
				table.insert(keyExtList, k)
			end
		end

		for k, v in pairs(rightResExt) do
			if table.indexof(keyExtList, k) == false then
				table.insert(keyExtList, k)
			end
		end

		self:_updateTuPoItem(keyList, self._qhItemList, leftRes, rightRes)
		self:_updateTuPoItem(keyExtList, self._qhItemExtList, leftResExt, rightResExt, true)
	else
		GameUtil.SetActive(self.equipAttrTran, true)

		local stoneId = PetEquipModel.instance:GetAttrStoneIndex()
		local stonePlanId = self._leftInfoMo.stonePlanId
		local stoneData = EquipmentConfig.instance:GetAttrStoneData(stonePlanId, stoneId)

		if stoneData then
			GameUtil.SetActive(self._btnStone, true)

			local matType, matId, matNum = MaterialMgr.getMatParams(stoneData.cost)

			MaterialMgr.setIcon(self._iconBtnStone, matType, matId, nil, nil)

			self._txtBtnStone.text = MaterialMgr.getMaterialsName(matType, matId)
		else
			GameUtil.SetActive(self.attrStoneBtn, true)
		end

		local attrList = PetEquipModel.instance:GetAttrRateList() or {}
		local num = 0

		for i, val in pairs(attrList or {}) do
			if val > 0 then
				num = num + 1

				if self._attrItemList[num] then
					local str = self:_getAttrNameByIndex(i)

					self._attrItemList[num].text = langPara("text_equip_desc_78", val, str)
				end
			end
		end
	end

	self:_updateEquipListUI()
end

function EquipTupoView:_getAttrNameByIndex(index)
	if index == 0 then
		return "无"
	end

	return ConstString.Race[index]
end

function EquipTupoView:_updateTuPoItem(keyList, qhItemList, leftRes, rightRes, isLang)
	for i, go in ipairs(qhItemList) do
		GameUtil.SetActive(go, false)

		local key = keyList[i]

		if key then
			GameUtil.SetActive(go, true)

			local attrIconSpt = goutil.findChild(go, "attrIconSpt")
			local ImageGo5 = goutil.findChild(go, "ImageGo5")
			local qhNameTxt = goutil.findChildTextComponent(go, "qhNameTxt")
			local qhNowCountTxt = goutil.findChildTextComponent(go, "qhNowCountTxt")
			local qhNextCountTxt = goutil.findChildTextComponent(go, "qhNextCountTxt")

			GameUtil.SetActive(attrIconSpt, false)

			if isLang then
				qhNameTxt.text = key
			else
				GameUtil.SetActive(attrIconSpt, true)
				GameUtil.setUIImageSpriteIdx(attrIconSpt, key - 1)

				qhNameTxt.text = ConstString.Attr[key]
			end

			local val = checknumber(leftRes[key])

			qhNowCountTxt.text = val ~= 0 and math.abs(val) < 1 and string.format("%.2f", val * 100) .. "%" or val

			GameUtil.SetActive(ImageGo5, false)

			qhNextCountTxt.text = ""

			if table.nums(rightRes) > 0 then
				GameUtil.SetActive(ImageGo5, true)

				local val = checknumber(rightRes[key])

				qhNextCountTxt.text = val < 1 and string.format("%.2f", val * 100) .. "%" or val
			end
		end
	end
end

function EquipTupoView:_getProp(infoMo)
	local res = {}
	local resExt = {}

	if infoMo then
		local petInfo = BagPetsController.instance:getPet(infoMo.equipPetId)
		local isAddAttr = false
		local isExclAttr = false

		if checknumber(infoMo.exclRaceId) > 0 then
			isExclAttr = true
		elseif petInfo and petInfo:checkHasRace(infoMo.attrType) then
			isAddAttr = true
		end

		local cfg = EquipmentConfig.instance:GetEquipDefineInfoById(infoMo.baseId)
		local equipInfo = EquipmentConfig.instance:GetEquipInfoByLvl(cfg.equipmentLvStrategy, infoMo.starCount)
		local attrs

		if isExclAttr then
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.racePropertyApp) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		elseif isAddAttr then
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp2) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		else
			attrs = FightingPowerFormula.instance:parseAttrValues(equipInfo.propertyApp) or {}
			res = AttrMo.addSameAttrs(attrs, res)
		end

		if cfg.quality == 10 then
			local attrs = string.split(equipInfo.attributeDisplay or "", "#")

			for i, attr in ipairs(attrs) do
				local attrName, attrVal = FightingPowerFormula.instance:getAttrNameValue(attr)

				if attrName then
					resExt[attrName] = attrVal
				end
			end
		end
	end

	return res, resExt
end

function EquipTupoView:_onClickTupoItemBtn(isLeft)
	if isLeft then
		if self._leftInfoMo then
			if not self._leftInfoMo.onlyId then
				do
					local onlyId = 0

					UIStateManager.instance:open(ViewName.EquipSelectList, self.funcCfg.tabId, {
						onlyId
					}, nil, self.funcCfg.viewSifter, self.funcCfg.isFilter)

					return
				end

				if self._leftInfoMo == nil then
					FloatWordMgr.instance:show("请先选择主装备")

					return
				end

				if not self._leftInfoMo:isCanTupo() then
					FloatWordMgr.instance:show("主装备需要达到最高等级，才可突破")

					return
				end

				if self._rightInfoMo == nil then
					printError("sr---EquipTupoView:_onClickTupoItemBtn()  装备突破  右侧空(不可能啊)")

					goto label_25_0
				end
			end
		end
	end

	CommonTipsMgr.instance:openMaterialTips(self._rightItemGo.itemGo, self._rightInfoMo.matType, self._rightInfoMo.baseId, 0)

	::label_25_0::
end

function EquipTupoView:_onClickChoiseItemBtn(index)
	if self._leftInfoMo == nil then
		FloatWordMgr.instance:show(lang("text_equip_desc_76"))

		return
	end

	if not self._leftInfoMo:isCanTupo() then
		FloatWordMgr.instance:show("主装备需要达到最高等级，才可突破")

		return
	end

	if index == 3 and self._leftInfoMo.quality >= self._goodQuality then
		MaterialMgr.openGetSourceByStr(self._goodConsume[self._leftInfoMo.wearPos])

		return
	end

	if self._choiseItemList[index].choiOnlyId <= 0 then
		if self._leftInfoMo.quality >= self._goodQuality then
			FloatWordMgr.instance:show("点击右侧列表放入和主装备同属性的装备")
		else
			FloatWordMgr.instance:show("点击右侧列表放入橙品装备")
		end

		return
	end

	if not self._leftInfoMo:isEquipArtifact() then
		local mo = PetEquipModel.instance:GetEquipInfo(self._choiseItemList[index].choiOnlyId)

		if mo then
			PetEquipModel.instance:SetAttrRateByString(mo.attrType, -self.attrProb)
			PetEquipModel.instance:SetAttrRateByString("无", self.attrProb)
		end
	end

	self._choiseItemList[index].choiOnlyId = -1

	self:_updataConsumablesShow(index)
end

function EquipTupoView:_onClickTupoBtn()
	if self._leftInfoMo == nil then
		FloatWordMgr.instance:show(lang("text_equip_desc_79"))

		return
	end

	if not self._leftInfoMo:isCanTupo() then
		FloatWordMgr.instance:show("主装备需要达到最高等级，才可突破")

		return
	end

	if self._leftInfoMo.quality >= self._goodQuality and EquipmentConfig.instance:getTupoGoodMinLevel() > RoleModel.instance:getMyLevel() then
		FloatWordMgr.instance:show(string.format("等级达到%s级，可进行橙+2装备突破！", EquipmentConfig.instance:getTupoGoodMinLevel()))

		return
	end

	if self:_isChoiseItemEmpty() then
		FloatWordMgr.instance:show(lang("text_equip_desc_73"))

		return
	end

	local isFull, otherIds, mjList = self:_isChoiseItemFull()

	if not isFull then
		FloatWordMgr.instance:show(lang("text_equip_desc_74"))

		return
	end

	if not self:_checkPasswordLockPass(otherIds or {}) then
		return
	end

	local function callBack()
		TipsFacade.instance:openPopupWindow(lang("text_equip_desc_80"), lang("text_equip_desc_81"), function()
			local effPath = "fx_ui_zhuangbeijiemian/fx_ui_chuizi_zhuangbei.prefab"

			self._tupoEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false, nil, function()
				local stoneId = PetEquipModel.instance:GetAttrStoneIndex()

				PetEquipController.instance:CSEquipTupoReq(self._leftInfoMo, otherIds, stoneId)
				goutil.setActive(self._mask, false)
			end, nil, self)

			self._tupoEff:setParent(self.mainGO.transform)
			self._tupoEff:setLocalPos(0, 0, 0)
			self._tupoEff:setScale(1)
			goutil.setActive(self._mask, true)
		end, nil, lang("text_equip_tupo"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
	end

	if mjList and #mjList > 0 then
		UIStateManager.instance:open(ViewName.StrengthenTips, mjList, callBack, lang("text_equip_desc_80"))
	else
		callBack()
	end
end

function EquipTupoView:_isChoiseItemFull()
	if self._choiseItemList then
		if not #self._choiseItemList then
			local count = 0

			if count == 0 then
				return false
			end

			local isGood = self._leftInfoMo.quality >= self._goodQuality
			local idList = {}
			local mjList = {}

			for i = 1, count do
				if self._choiseItemList[i] then
					if checknumber(self._choiseItemList[i].choiOnlyId) <= 0 and (not isGood or i < count) then
						return false
					end

					if checknumber(self._choiseItemList[i].choiOnlyId) > 0 then
						table.insert(idList, self._choiseItemList[i].choiOnlyId)

						local mo = PetEquipModel.instance:GetEquipInfo(self._choiseItemList[i].choiOnlyId)

						if mo:isStrengthenFull() then
							table.insert(mjList, {
								useCount = 1,
								onlyId = mo.onlyId,
								matType = MatType.Equipment
							})
						end
					end
				end
			end

			return true, idList, mjList
		end
	end
end

function EquipTupoView:_isChoiseItemEmpty()
	if self._choiseItemList then
		if not #self._choiseItemList then
			local count = 0

			if count == 0 then
				return true
			end

			local isGood = self._leftInfoMo.quality >= self._goodQuality

			if isGood then
				local itemStr = self._goodConsume[self._leftInfoMo.wearPos]

				if not MaterialMgr.getMatEnough(itemStr) then
					return true
				end
			end

			for i = 1, count do
				if self._choiseItemList[i] and checknumber(self._choiseItemList[i].choiOnlyId) <= 0 and (not isGood or i < count) then
					return true
				end
			end

			return false
		end
	end
end

function EquipTupoView:_onClickSifterItemBtn(index)
	if self._sifterParams == nil or self._sifterParams[index] == nil then
		return
	end

	local info = self._sifterParams[index]

	if info.planId <= 0 or info.subList == nil or info.subList[1] and info.subList[1].showType <= 0 then
		self._sifterList = {}

		self:_updataConsumablesShow(0, true)

		return
	end

	ViewMgr.instance:open(ViewName.EquipFactorySifter, {
		alchemyType = PetEquipModel.AlchemyType.Equip,
		btnTabInfo = info,
		choList = (self._sifterList and self._sifterList[info.planId] or nil) and self._sifterList[info.planId],
		itemGo = self._sifterItems[index].itemGo
	})
end

function EquipTupoView:_updataSelectSifter(viewName, ayType, planId, attrs, isReset)
	if viewName ~= self._viewPresentor.viewName or ayType ~= PetEquipModel.AlchemyType.Equip then
		return
	end

	self._sifterList = self._sifterList or {}

	if isReset then
		self._sifterList = {}
	else
		planId = checknumber(planId)
		self._sifterList[planId] = attrs
	end

	self:_updataConsumablesShow(0, true)
end

function EquipTupoView:_updateAllEquipTran()
	self:_clearAllEquipTran()

	self.wearInfoList = {}

	local isList, infoList, index = PetEquipModel.instance:getPetStrengthenInfoMos(self._leftInfoMo)

	self.wearInfoList = infoList or {}
	self.currIndex = Mathf.Min(#self.wearInfoList, checknumber(index))

	for i = 1, #self.equipItemList do
		if self.equipItemList[i] and self.equipItemList[i].itemGo then
			GameUtil.SetActive(self.equipItemList[i].itemGo, true)

			local wearInfo = self.wearInfoList[i]

			if wearInfo then
				if not wearInfo.isOpen then
					local isOpen = false

					if wearInfo then
						if not wearInfo.isWear then
							local isWear = false

							if not isOpen then
								GameUtil.SetActive(self.equipItemList[i].stateSpt, true)
								self.equipItemList[i].stateSpt:SetState(1)

								if i >= 5 then
									self.equipItemList[i].kuangIma:SetState(0)
								end
							elseif not isWear then
								GameUtil.SetActive(self.equipItemList[i].stateSpt, true)
								self.equipItemList[i].stateSpt:SetState(0)

								if i >= 5 then
									self.equipItemList[i].kuangIma:SetState(0)
								end
							else
								GameUtil.SetActive(self.equipItemList[i].stateSpt, false)

								local subLua = MaterialMgr.setCellByData(MatType.Equipment, wearInfo.info, self.equipItemList[i].itemGo)

								if subLua then
									subLua.binder:CancelBtnClick()

									if wearInfo.isAddSttr then
										subLua.binder:SetView(self)
										subLua.binder:PlayAttrTypeEffect()
									else
										subLua.binder:PlayAttrTypeEffect(true)
									end
								end

								if i >= 5 then
									self.equipItemList[i].kuangIma:SetState(1)
								end
							end

							GameUtil.addClickHandler(self.equipItemList[i].mainGo, function()
								self:_onClickEquipItemBtn(i)
							end)
							GameUtil.SetActive(self.equipItemList[i].choiseGo, false)

							if self.currIndex == i then
								GameUtil.SetActive(self.equipItemList[i].choiseGo, true)
							end
						end
					end
				end
			end
		end
	end
end

function EquipTupoView:_clearAllEquipTran()
	for _, item in pairs(self.equipItemList) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
			GameUtil.SetActive(item.choiseGo, false)
			MaterialMgr.resetAll(item.itemGo)
			GameUtil.rmClickHandler(item.mainGo)
		end
	end
end

function EquipTupoView:_onClickEquipItemBtn(index, isForce)
	if self.wearInfoList[index] == nil then
		local petInfo = BagPetsController.instance:getPet(self._curPetId)

		if petInfo then
			UIStateManager.instance:open(ViewName.PetEquipList, index, nil, petInfo)

			return
		else
			FloatWordMgr.instance:show("未选中精灵")

			return
		end
	end

	if not self.wearInfoList[index].isOpen then
		FloatWordMgr.instance:show("该部位未解锁")

		return
	end

	if not self.wearInfoList[index].isWear then
		local petInfo = BagPetsController.instance:getPet(self._curPetId)

		UIStateManager.instance:open(ViewName.PetEquipList, index, nil, petInfo)

		return
	end

	if self.currIndex == index and not isForce then
		local wearInfo = self.wearInfoList[index]
		local info = wearInfo and wearInfo.info

		if info then
			UIStateManager.instance:open(ViewName.PetEquipInfo, info)
		end

		return
	end

	if self.equipItemList[self.currIndex] and self.equipItemList[self.currIndex].choiseGo then
		GameUtil.SetActive(self.equipItemList[self.currIndex].choiseGo, false)
	end

	if self.equipItemList[index] and self.equipItemList[index].choiseGo then
		GameUtil.SetActive(self.equipItemList[index].choiseGo, true)
	end

	self.currIndex = index

	local infoMo = self.wearInfoList[self.currIndex].info

	self:_showViewDataByInfoMo(infoMo)
end

function EquipTupoView:_onClickPetName()
	local petId

	UIStateManager.instance:open(ViewName.EquipBagPetListView, (self._leftInfoMo or nil) and self._leftInfoMo.equipPetId)
end

function EquipTupoView:_getPath()
	return {
		cellPath = "itemInfoGo/itemCell",
		viewPath = "itemInfoGo/itemListSR"
	}
end

function EquipTupoView:_cellSize()
	return 90, 90
end

function EquipTupoView:_updateCell(view, cell, data)
	local reduceBtnGo = goutil.findChild(cell, "reduceBtn")

	GameUtil.rmClickHandler(reduceBtnGo)
	MaterialMgr.resetAll(cell)
	reduceBtnGo:SetActive(false)

	local isChois = self:_isChoiseExpendCell(data.onlyId)
	local subLua = MaterialMgr.setCellByData(data.matType, data, cell)

	subLua.binder:setNum()
	subLua.binder:setAutoTips(false)
	subLua.binder:setSelected(isChois)
	subLua.binder:setCallBack(function()
		if isChois then
			return
		end

		self:_setChoiseStrengthen(data, true)
	end)

	if isChois then
		reduceBtnGo:SetActive(true)
		reduceBtnGo.transform:SetAsLastSibling()
		GameUtil.addClickHandler(reduceBtnGo, function()
			self:_setChoiseStrengthen(data, false)
		end)
	end
end

function EquipTupoView:_setChoiseStrengthen(mo, isAdd)
	if isAdd then
		if self._leftInfoMo == nil then
			FloatWordMgr.instance:show(lang("text_equip_desc_72"))

			return
		end

		local index = checknumber(self:_isChoiseExpendFull(mo.onlyId))

		if index <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_83"))
		else
			PetEquipModel.instance:SetAttrRateByString(mo.attrType, self.attrProb)
			PetEquipModel.instance:SetAttrRateByString("无", -self.attrProb)
			self:_updataConsumablesShow(index)
		end
	else
		local index = 0

		for i = 1, #self._choiseItemList do
			if self._choiseItemList[i] and self._choiseItemList[i].choiOnlyId == mo.onlyId then
				PetEquipModel.instance:SetAttrRateByString(mo.attrType, -self.attrProb)
				PetEquipModel.instance:SetAttrRateByString("无", self.attrProb)

				self._choiseItemList[i].choiOnlyId = -1
				index = i

				break
			end
		end

		self:_updataConsumablesShow(index)
	end
end

function EquipTupoView:_isChoiseExpendCell(onlyId)
	for _, item in pairs(self._choiseItemList or {}) do
		if item and item.choiOnlyId == onlyId then
			return true
		end
	end

	return false
end

function EquipTupoView:_isChoiseExpendFull(onlyId)
	local isGood = self._leftInfoMo.quality >= self._goodQuality
	local count = #self._choiseItemList

	for i = 1, count do
		if self._choiseItemList[i] and self._choiseItemList[i].choiOnlyId <= 0 and (not isGood or i < count) then
			self._choiseItemList[i].choiOnlyId = onlyId

			return i
		end
	end

	return nil
end

function EquipTupoView:_checkPasswordLockPass(ids)
	if #ids > 0 then
		local hasHighQualityEquip = false
		local info

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

		if hasHighQualityEquip and PasswordLockController.instance:checkNeedOpenVerifyView() then
			return false
		end
	end

	return true
end

function EquipTupoView:_onClickPutIn()
	if self._leftInfoMo == nil then
		FloatWordMgr.instance:show(lang("text_equip_desc_72"))

		return
	end

	if not self._leftInfoMo:isCanTupo() then
		FloatWordMgr.instance:show("主装备需要达到最高等级，才可突破")

		return
	end

	for i = 1, #self._choiseItemList do
		if self._choiseItemList[i] then
			if self._choiseItemList[i].choiOnlyId > 0 then
				local mo = PetEquipModel.instance:GetEquipInfo(self._choiseItemList[i].choiOnlyId)

				if mo and not self._leftInfoMo:isEquipArtifact() then
					PetEquipModel.instance:SetAttrRateByString(mo.attrType, -self.attrProb)
					PetEquipModel.instance:SetAttrRateByString("无", self.attrProb)
				end
			end

			self._choiseItemList[i].choiOnlyId = -1
		end
	end

	PetEquipModel.instance:ResetAttrStoneIndex()

	local targetAttr = self._leftInfoMo.attrType

	if not self._curViewDatas then
		local sameAttrEquips = {}
		local noAttrEquips = {}

		for _, equip in ipairs(self._curViewDatas) do
			if equip.attrType == targetAttr then
				table.insert(sameAttrEquips, equip)
			elseif equip.attrType == "无" then
				table.insert(noAttrEquips, equip)
			end
		end

		local emptySlots = {}

		if self._leftInfoMo then
			local isFill = true

			if self._leftInfoMo:isCanTupo() then
				isFill = self._leftInfoMo.quality >= self._goodQuality

				for i = 1, #self._choiseItemList do
					if (i ~= 3 or not isFill) and self._choiseItemList[i] and self._choiseItemList[i].choiOnlyId <= 0 then
						table.insert(emptySlots, i)
					end
				end

				if #emptySlots > 0 and #sameAttrEquips >= #emptySlots then
					local putCount = math.min(#sameAttrEquips, #emptySlots)

					for i = 1, putCount do
						local slotIndex = emptySlots[i]

						self._choiseItemList[slotIndex].choiOnlyId = sameAttrEquips[i].onlyId

						if not self._leftInfoMo:isEquipArtifact() then
							PetEquipModel.instance:SetAttrRateByString(sameAttrEquips[i].attrType, self.attrProb)
							PetEquipModel.instance:SetAttrRateByString("无", -self.attrProb)
						end
					end

					self:_updataConsumablesShow(0)
					FloatWordMgr.instance:show(string.format("已放入%d件同属性装备", putCount))

					return
				end

				if #emptySlots > 0 and #noAttrEquips >= #emptySlots then
					local stonePlanId = self._leftInfoMo.stonePlanId

					if stonePlanId then
						local stoneInfoList = PetEquipModel.instance:GetAllAttrStones(stonePlanId) or {}
						local targetStone

						for _, stoneInfo in ipairs(stoneInfoList) do
							if stoneInfo.attr == targetAttr and stoneInfo.matHave > 0 then
								targetStone = stoneInfo

								break
							end
						end

						if targetStone then
							local putCount = math.min(#noAttrEquips, #emptySlots)
							local matName = MaterialMgr.getMaterialsName(targetStone.matType, targetStone.matId)
							local tipsContent = string.format("可放入的同属性材料装备不足，是否确认放入%s*1和无属性装备*%s？", matName, putCount)

							local function okFunc()
								PetEquipModel.instance:SetAttrStoneIndex(targetStone.index)

								for i = 1, putCount do
									local slotIndex = emptySlots[i]

									self._choiseItemList[slotIndex].choiOnlyId = noAttrEquips[i].onlyId

									if not self._leftInfoMo:isEquipArtifact() then
										PetEquipModel.instance:SetAttrRateByString(noAttrEquips[i].attrType, self.attrProb)
										PetEquipModel.instance:SetAttrRateByString("无", -self.attrProb)
									end
								end

								self:_updataConsumablesShow(0)
								self:_updataEquipAttrShow()
							end

							TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")

							return
						end
					end
				end

				FloatWordMgr.instance:show("无满足条件装备")
			end
		end
	end
end

function EquipTupoView:_onClickBtnStone()
	if self._leftInfoMo == nil then
		FloatWordMgr.instance:show(lang("text_equip_desc_72"))

		return
	end

	UIStateManager.instance:push(ViewName.TupoStone, self._leftInfoMo.stonePlanId)
end

return EquipTupoView

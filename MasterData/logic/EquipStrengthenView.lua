-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipStrengthenView.lua

module("logic.extensions.equipment.view.EquipStrengthenView", package.seeall)

local EquipStrengthenView = class("EquipStrengthenView", TableViewComponent)

function EquipStrengthenView:ctor()
	EquipStrengthenView.super.ctor(self)

	self.levelStarList = nil
	self.attrItemList = nil
	self.qhNeedCoin = 0
	self.isMax = false
	self.upgNextExp = 0
	self.wearInfoList = nil
	self.exclMatInfo = nil
	self.exclGridList = nil
	self._curPetId = 0
end

function EquipStrengthenView:bindEvents()
	EquipStrengthenView.super.bindEvents(self)
	GameUtil.asBtn(self.equipBtnGo):AddClickListener(function()
		if self.funcCfg == nil or self.funcCfg.tabId ~= PetEquipModel.FunctionType.SttnType then
			return
		end

		if self.infoMo then
			if not self.infoMo.onlyId then
				local onlyId = 0

				UIStateManager.instance:open(ViewName.EquipSelectList, PetEquipModel.FunctionType.SttnType, {
					onlyId
				}, nil, self.funcCfg.viewSifter, self.funcCfg.isFilter)
			end
		end
	end, self)
	self.putInBtn:AddClickListener(self._onClickPutInBtn, self)
	self.strengthenBtn:AddClickListener(self._onClickStrengthenBtn, self)
	self.jumpBtn:AddClickListener(self._onClickHuanjingBtn, self)
	self.matReduceBtn:AddClickListener(function()
		self:_onClickExclMatBtn(false)
	end, self)
	self.matGotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.EquipRecycle, MatType.Equipment)
	end, self)
	GameUtil.addClickHandler(self._toggleStrengthenMax, self._onClickToggleStrengthenMax, self)
	GameUtil.asBtn(self.sifterItem):AddClickListener(function()
		self:_onClickSifterItemBtn(index)
	end, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)
	GameUtil.addClickHandler(self.btnPetName, self._onClickPetName, self)
end

function EquipStrengthenView:unbindEvents()
	EquipStrengthenView.super.unbindEvents(self)
	GameUtil.asBtn(self.equipBtnGo):RemoveClickListener()
	self.putInBtn:RemoveClickListener()
	self.strengthenBtn:RemoveClickListener()
	self.jumpBtn:RemoveClickListener()
	self.matReduceBtn:RemoveClickListener()
	self.matGotoBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._toggleStrengthenMax)
	GameUtil.asBtn(self.sifterItem):RemoveClickListener()
	GameUtil.rmClickHandler(self._tipBtn)
	GameUtil.rmClickHandler(self.btnPetName)
end

function EquipStrengthenView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PET_EQUIP_UPGRADE, self._equipUpgradeInfoUpdata, self)
	GlobalDispatcher:removeListener(GlobalNotify.PET_EQUIP_SELECT, self._showViewDataBySelect, self)
	GlobalDispatcher:removeListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self._handleBagPetChanged, self)
	removetimer(self._setEquipUpgradePlayEff, self)
	PetEquipModel.instance:SetStrengthenFictitiousExp()
	MaterialMgr.resetAll(self.equipPosGo)

	self.equipLua = nil

	if self.upgEff then
		UIEffectManager.instance:stopEffect(self.upgEff)

		self.upgEff = nil
	end

	for _, grid in pairs(self.exclGridList or {}) do
		if grid then
			MaterialMgr.resetAll(grid)
		end
	end

	self.exclMatInfo = nil
end

function EquipStrengthenView:destroyUI()
	EquipStrengthenView.super.destroyUI(self)

	self.infoMo = nil
	self._curPetId = 0
	self.isPlaying = false
	self.isMax = false
	self.wearInfoList = nil

	for _, go in pairs(self.levelStarList or {}) do
		if go then
			UnityEngine.GameObject.Destroy(go)
		end
	end

	self.levelStarList = nil

	for _, item in pairs(self.attrItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrItemList = nil
	self.qhNeedCoin = 0
	self.upgNextExp = 0
	self.exclGridList = nil
end

function EquipStrengthenView:buildUI()
	EquipStrengthenView.super.buildUI(self)

	local subCanvas = goutil.findChildComponent(self.mainGO, "viewBgGo", "Canvas")
	local mainCanvas = UGUIToolHelper.FindCanvas(self.mainGO)

	subCanvas.sortingOrder = mainCanvas.sortingOrder + 2

	local leftInfoGo = self:getGo("viewBgGo/leftInfoGo")

	self.equipPosGo = goutil.findChild(leftInfoGo, "equipPos")
	self.equipBtnGo = goutil.findChild(leftInfoGo, "equipBtn")
	self.starGo = goutil.findChild(leftInfoGo, "starGo")
	self.levelStarTranL = goutil.findChild(leftInfoGo, "levelStarTranL").transform
	self.levelStarTranR = goutil.findChild(leftInfoGo, "levelStarTranR").transform
	self.arrowGo1 = goutil.findChild(leftInfoGo, "arrowGo1")
	self.arrowGo2 = goutil.findChild(leftInfoGo, "arrowGo2")
	self.qhBarSli = goutil.findChildComponent(leftInfoGo, "qhBarSli", "Slider")
	self.qhShowTran = goutil.findChild(leftInfoGo, "qhShowTran").transform
	self.qhItemGo = goutil.findChild(leftInfoGo, "qhItem")
	self.btnPetName = goutil.findChild(leftInfoGo, "btnPetName")
	self.petNameTxt = goutil.findChildTextComponent(leftInfoGo, "btnPetName/txt")
	self.equipNameTxt = goutil.findChildTextComponent(leftInfoGo, "equipNameTxt")
	self.qhNowTxt = goutil.findChildTextComponent(leftInfoGo, "qhNowTxt")
	self.qhNextTxt = goutil.findChildTextComponent(leftInfoGo, "qhNextTxt")
	self.qhNumTxt = goutil.findChildTextComponent(leftInfoGo, "qhNumTxt")

	self.starGo:SetActive(false)

	self.attrItemList = {
		self:_setGameObjectComponent(self.qhItemGo, 1)
	}

	self.attrItemList[1].itemGo:SetActive(false)

	self.lvupEffGo = goutil.findChild(leftInfoGo, "lvupEffGo")
	self.qhtjsxGo = goutil.findChild(leftInfoGo, "qhtjsxGo")

	self.qhtjsxGo:SetActive(false)

	self._noListGoLeft = goutil.findChild(leftInfoGo, "noListGoLeft")

	local equipAllTran = goutil.findChild(leftInfoGo, "equipAllTran/content").transform

	self._equipItemBg = self:getGo("viewBgGo/leftInfoGo/equipAllTran/bg")
	self.equipItemList = {}

	for i = 1, 6 do
		local go = equipAllTran:GetChild(i - 1).gameObject
		local names = string.split(go.name, "_")

		self.equipItemList[tonumber(names[2])] = {
			itemGo = go,
			choiseGo = goutil.findChild(go, "choiseGo"),
			stateSpt = goutil.findChildComponent(go, "stateSpt", "UIImageSpriteChange"),
			kuangIma = goutil.findChildComponent(go, "kuangIma", "UIImageSpriteChange")
		}

		GameUtil.asBtn(go):AddClickListener(function()
			self:OnClickEquipItem(tonumber(names[2]))
		end, self)
	end

	local rightInfoGo = self:getGo("viewBgGo/rightInfoGo")

	self.desTipsTxt = goutil.findChildTextComponent(rightInfoGo, "desTipsTxt")
	self.itemInfoGo = goutil.findChild(rightInfoGo, "itemInfoGo")
	self.sifterItem = goutil.findChild(self.itemInfoGo, "sifterItem")
	self.noListGo = goutil.findChild(self.itemInfoGo, "noListGo")
	self.noListTxt = goutil.findChildTextComponent(self.noListGo, "noListTxt")
	self.jumpBtn = Framework.ButtonAdapter.GetFrom(self.noListGo, "jumpBtn")

	GameUtil.SetActive(self.noListGo, false)

	self.moneyCountTxt = goutil.findChildTextComponent(rightInfoGo, "downInfoGo/moneyCountTxt")
	self.moneyCountTxtColorChange = goutil.findChildComponent(rightInfoGo, "downInfoGo/moneyCountTxt", "UITextColorChange")
	self.putInBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "downInfoGo/putInBtn")
	self.strengthenBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "downInfoGo/strengthenBtn")
	self.strengthenTxt = goutil.findChildTextComponent(self.strengthenBtn.gameObject, "strengthenTxt")
	self.recycleBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "downInfoGo/recycleBtn")
	self.desTipsTxt.text = ""
	self.moneyCountTxt.text = ""

	self.moneyCountTxtColorChange:SetState(0)
	GameUtil.SetActive(self.recycleBtn, false)

	self._noListGo = goutil.findChild(rightInfoGo, "noListGo")
	self.exclInfoGo = goutil.findChild(rightInfoGo, "exclInfoGo")
	self.matGridGo = goutil.findChild(self.exclInfoGo, "matGridGo")
	self.matReduceBtn = Framework.ButtonAdapter.GetFrom(self.matGridGo, "matReduceBtn")
	self.noMatItemGo = goutil.findChild(self.exclInfoGo, "noMatItemGo")
	self.noMatItemTxt = goutil.findChildTextComponent(self.noMatItemGo, "noMatItemTxt")
	self.matGotoBtn = Framework.ButtonAdapter.GetFrom(self.noMatItemGo, "matGotoBtn")
	self.exclGridList = {
		goutil.findChild(self.exclInfoGo, "matGrid_1"),
		goutil.findChild(self.exclInfoGo, "matGrid_2"),
		goutil.findChild(self.exclInfoGo, "matGrid_3"),
		goutil.findChild(self.exclInfoGo, "matGrid_4")
	}
	self.noMatItemTxt.text = ""

	GameUtil.SetActive(self.matGridGo, false)
	GameUtil.SetActive(self.matReduceBtn, false)
	GameUtil.SetActive(self.noMatItemGo, false)
	GameUtil.SetActive(self.exclInfoGo, false)
	GameUtil.SetActive(self._noListGoLeft, false)
	GameUtil.SetActive(self._noListGo, false)

	self._tipBtn = self:getGo("viewBgGo/rightInfoGo/limit/tipBtn")
	self._txtNum = self:getTxt("viewBgGo/rightInfoGo/limit/txtNum")
	self._limit = self:getGo("viewBgGo/rightInfoGo/limit")
	self._toggleStrengthenMax = self:getGo("viewBgGo/rightInfoGo/downInfoGo/toggleStrengthenMax")
	self._imgSelectStrengthenMax = self:getGo("viewBgGo/rightInfoGo/downInfoGo/toggleStrengthenMax/imgSelect")
end

function EquipStrengthenView:onEnter()
	EquipStrengthenView.super.onEnter(self)

	local param = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.PET_EQUIP_UPGRADE, self._equipUpgradeInfoUpdata, self)
	GlobalDispatcher:addListener(GlobalNotify.PET_EQUIP_SELECT, self._showViewDataBySelect, self)
	GlobalDispatcher:addListener(GlobalNotify.Factory_UpdataShowSifter, self._updataSelectSifter, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self._handleBagPetChanged, self)

	self.oneMaxNum = EquipmentConfig.instance:GetMaxOneStrthNum()
	self.equipLua = nil
	self.petNameTxt.text = ""
	self.funcCfg = EquipmentConfig.instance:getEquipFunctionTabCfg(PetEquipModel.FunctionType.SttnType)
	self._isMaxStrengthen = checkbool(GameUtil.getUserData("equip_strengthen_max"))

	GameUtil.SetActive(self._imgSelectStrengthenMax, self._isMaxStrengthen)
	self:_initShowSifterItems()

	self.infoMo = nil
	self._curPetId = 0

	self:_showViewDataByInfoMo(PetEquipController.instance:getCurrentEquipInfoMo())
	self:_showCurrLiitWithType()
end

function EquipStrengthenView:_onClickTips()
	local type = MatType.Equipment

	ItemBagController.instance:showLimitTipsWithType(type)
end

function EquipStrengthenView:_showCurrLiitWithType()
	local type = MatType.Equipment
	local cur, total = ItemBagController.instance:getCurrLiitWithType(type)

	self._txtNum.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
end

function EquipStrengthenView:_initShowSifterItems()
	for _, item in pairs(self._sifterItems or {}) do
		if item and item.itemGo then
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	GameUtil.SetActive(self._equipItemBg, false)

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
end

function EquipStrengthenView:_handleBagPetChanged()
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

function EquipStrengthenView:_showViewDataBySelect(onlyId)
	local mo = PetEquipModel.instance:GetEquipInfo(onlyId)

	self:_showViewDataByInfoMo(mo)
end

function EquipStrengthenView:_showViewDataByInfoMo(mo)
	self.infoMo = nil
	self._curPetId = 0

	if mo and mo.onlyId then
		self.infoMo = mo
		self._curPetId = mo.equipPetId
	end

	for _, item in pairs(self.equipItemList) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
			GameUtil.SetActive(item.choiseGo, false)
			MaterialMgr.resetAll(item.itemGo)
			GameUtil.asBtn(item.itemGo):RemoveClickListener()
		end
	end

	GameUtil.SetActive(self._equipItemBg, false)

	self.strengthenTxt.text = "确认强化"

	local isList, infoList, index = PetEquipModel.instance:getPetStrengthenInfoMos(self.infoMo)

	if self.infoMo == nil or not isList or infoList == nil or self.infoMo.equipPetId <= 0 then
		self.petNameTxt.text = "未穿戴"

		self:_showChoiseEquipInfo()

		return
	end

	local petInfo = BagPetsController.instance:getPet(self.infoMo.equipPetId)

	self.petNameTxt.text = petInfo and string.format("%s", petInfo.name) or "未穿戴"
	self.wearInfoList = infoList or {}
	self.currIndex = Mathf.Min(#self.wearInfoList, checknumber(index))

	local isHideAll = true

	for i = 1, #self.equipItemList do
		local wearInfo = self.wearInfoList[i]

		if wearInfo then
			if not wearInfo.isOpen then
				local isOpen = false

				if wearInfo then
					if not wearInfo.isWear then
						local isWear = false

						if self.equipItemList[i] and self.equipItemList[i].itemGo then
							GameUtil.SetActive(self.equipItemList[i].itemGo, true)

							isHideAll = false

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

									GameUtil.setLocalScale(subLua.view, 0.4, 0.4, 0.4)
								end

								if i >= 5 then
									self.equipItemList[i].kuangIma:SetState(1)
								end
							end

							GameUtil.asBtn(self.equipItemList[i].itemGo):AddClickListener(function()
								self:_onClickEquipItemBtn(i)
							end, self)
							GameUtil.SetActive(self.equipItemList[i].choiseGo, false)
						end
					end
				end
			end
		end
	end

	GameUtil.SetActive(self._equipItemBg, not isHideAll)
	self:_onClickEquipItemBtn(self.currIndex, true)
end

function EquipStrengthenView:_onClickEquipItemBtn(index, isForce)
	if self.wearInfoList[index] == nil then
		local petInfo = BagPetsController.instance:getPet(self._curPetId)

		UIStateManager.instance:open(ViewName.PetEquipList, index, nil, petInfo)

		return
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
		self.equipItemList[index].choiseGo.transform:SetAsLastSibling()
	end

	self.currIndex = index
	self.infoMo = self.wearInfoList[self.currIndex].info

	self:_showChoiseEquipInfo()
end

function EquipStrengthenView:_showChoiseEquipInfo()
	PetEquipController.instance:setCurrentEquipInfoMo(self.infoMo)
	PetEquipModel.instance:SetStrengthenFictitiousExp()

	if self.upgEff then
		UIEffectManager.instance:stopEffect(self.upgEff)

		self.upgEff = nil
	end

	self.isPlaying = false

	self:_updataStrengthenMatList()
	self._tableview:MoveCellInView(0, false)
	GlobalDispatcher:dispatch(GlobalNotify.PetEquipCurEquipmentChange)
end

function EquipStrengthenView:_equipUpgradeInfoUpdata()
	PetEquipModel.instance:SetStrengthenFictitiousExp()
	self:_playEquipUpgradeEff()
	self:_updataStrengthenMatList()

	local mo = PetEquipController.instance:getCurrentEquipInfoMo()

	self:_showViewDataByInfoMo(mo)
	self:_showCurrLiitWithType()
end

function EquipStrengthenView:_updataStrengthenMatList()
	self.exclMatInfo = nil

	MaterialMgr.resetAll(self.matGridGo)

	for _, grid in pairs(self.exclGridList or {}) do
		if grid then
			MaterialMgr.resetAll(grid)
		end
	end

	self.matLua = nil
	self.choiseNum = 0
	self.moneyCountTxt.text = "0"

	self.moneyCountTxtColorChange:SetState(0)

	if self.infoMo == nil then
		self:_showEmptyStrengthenView()

		return
	end

	self:_forceUpdataLeftInfo()

	if checknumber(self.infoMo.exclRaceId) > 0 then
		self:_showExclusivePetEquip()

		return
	end

	GameUtil.SetActive(self.exclInfoGo, false)
	GameUtil.SetActive(self.itemInfoGo, true)

	self._curViewDatas = PetEquipController.instance:mergeStrengthenEquipList(self.infoMo, self._sifterList, false)

	self:reloadData()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self.noListGo, true)
	else
		GameUtil.SetActive(self.noListGo, false)
	end
end

function EquipStrengthenView:_showEmptyStrengthenView()
	MaterialMgr.resetAll(self.equipPosGo)

	for _, go in pairs(self.levelStarList or {}) do
		if go then
			GameUtil.SetActive(go, false)
		end
	end

	self.equipNameTxt.text = "请放入主装备"

	GameUtil.SetActive(self.arrowGo1, true)
	GameUtil.SetActive(self.arrowGo2, true)

	self.qhBarSli.value = 0

	for _, item in pairs(self.attrItemList or {}) do
		if item and item.itemGo then
			GameUtil.SetActive(item.itemGo, false)
		end
	end

	self.qhNowTxt.text = "Lv.0"
	self.qhNextTxt.text = "Lv.1"
	self.qhNumTxt.text = "0/0"

	Framework.TransformUtil.SetLocalPos(self.qhNowTxt.gameObject.transform, -104, -85.5, 0)
	GameUtil.SetActive(self.qhtjsxGo, false)

	self.desTipsTxt.text = ""

	GameUtil.SetActive(self.itemInfoGo, false)
	GameUtil.SetActive(self.exclInfoGo, false)
	GameUtil.SetActive(self._noListGoLeft, self.infoMo == nil)
	GameUtil.SetActive(self._noListGo, self.infoMo == nil)
end

function EquipStrengthenView:_showExclusivePetEquip()
	GameUtil.SetActive(self.itemInfoGo, false)
	GameUtil.SetActive(self.exclInfoGo, true)

	local matList = EquipmentConfig.instance:GetExclusiveMaterial()

	if matList then
		if not matList[self.infoMo.wearPos] then
			local matInfo
			local haveCount = 0

			if matInfo and checknumber(matInfo.id) > 0 then
				local count = MaterialModel.instance:getMaterialsNumber(MatType.Item, matInfo.id)

				if checknumber(count) > 0 then
					haveCount = count
				end
			end

			if haveCount > 0 then
				self.noMatItemTxt.text = ""

				GameUtil.SetActive(self.matReduceBtn, false)
				GameUtil.SetActive(self.noMatItemGo, false)
				GameUtil.SetActive(self.matGridGo, true)

				self.matLua = MaterialMgr.setCell(MatType.Item, matInfo.id, self.matGridGo)

				self.matLua.binder:setNum(haveCount, 0)
				self.matLua.binder:setAutoTips(false)
				self.matLua.binder:setCallBack(function()
					self:_onClickExclMatBtn(true)
				end)

				self.exclMatInfo = {
					useCount = 0,
					matId = matInfo.id,
					matExp = matInfo.exp,
					allCount = haveCount
				}

				local index = 0
				local tempLua

				for i = 1, #matList do
					if matList[i] and matList[i].id ~= self.infoMo.wearPos then
						index = matList[i].id > self.infoMo.wearPos and i - 1 and i

						if self.exclGridList[index] then
							if not self.exclGridList[index].activeSelf then
								GameUtil.SetActive(self.exclGridList[index], true)
							end

							tempLua = MaterialMgr.setCell(MatType.Item, matList[i].id, self.exclGridList[index])

							tempLua.binder:setNum(0)
							tempLua.binder:setAutoTips(false)
							tempLua.binder:setGray(true)
						end
					end
				end
			else
				for _, grid in pairs((not self.exclGridList or nil) and {}) do
					if grid and grid.activeSelf then
						GameUtil.SetActive(grid, false)
					end
				end

				GameUtil.SetActive(self.matGridGo, false)
				GameUtil.SetActive(self.noMatItemGo, true)

				self.noMatItemTxt.text = lang("text_equip_desc_92")
			end
		end
	end
end

function EquipStrengthenView:_playEquipUpgradeEff()
	if self.isPlaying then
		return
	end

	self.isPlaying = true

	if self.upgEff then
		UIEffectManager.instance:stopEffect(self.upgEff)

		self.upgEff = nil
	end

	local effPath = "fx_ui_jingyanshengji/fx_ui_jingyan_shengji.prefab"

	settimer(0.3, self._setEquipUpgradePlayEff, self, false)

	self.upgEff = UIEffectManager.instance:playHUDEffect(effPath, self.lvupEffGo, false, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.lvupEffGo) + 1)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end, nil, false)
end

function EquipStrengthenView:_setEquipUpgradePlayEff()
	self.isPlaying = false
end

function EquipStrengthenView:_onClickSifterItemBtn(index)
	local var_30_0 = {
		alchemyType = PetEquipModel.AlchemyType.Equip,
		btnTabInfo = self._sifterParams
	}

	var_30_0.choList = self._sifterList or {}
	var_30_0.itemGo = self.sifterItem

	UIStateManager.instance:open(ViewName.EquipFilterView, var_30_0)
end

function EquipStrengthenView:_updataSelectSifter(viewName, ayType, planId, attrs, isReset)
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

	self:_showChoiseEquipInfo()
end

function EquipStrengthenView:_forceUpdataLeftInfo()
	GameUtil.SetActive(self._noListGoLeft, self.infoMo == nil)
	GameUtil.SetActive(self._noListGo, self.infoMo == nil)

	local _, colorStr = PetEquipController.instance:GetQualityStrByNum(self.infoMo.qualityBase, true)

	self.equipNameTxt.text = string.format("<color=%s>%s</color>", colorStr, self.infoMo.name)

	if self.qhtjsxGo.activeSelf then
		self.qhtjsxGo:SetActive(false)
	end

	self.levelStarList = self.levelStarList or {}
	self.costDecoRatio = EquipmentConfig.instance:GetCostDecoRatio()
	self.desTipsTxt.text = langPara("text_equip_desc_50", self.costDecoRatio)

	local nowEquipInfo, nextEquipInfo = PetEquipModel.instance:GetEquipNowNextAttrList(self.infoMo)
	local petInfo = BagPetsController.instance:getPet(self.infoMo.equipPetId)
	local isAddAttr = false
	local isExclAttr = false

	if checknumber(self.infoMo.exclRaceId) > 0 then
		isExclAttr = true
	elseif petInfo then
		isAddAttr = PetSkinConfig.instance:checkHasEleAttr(petInfo.curFaceId, self.infoMo.attrType) or AttrMo.checkHasYuanEle(petInfo.curFaceId, self.infoMo.attrType)
	end

	if self.equipLua == nil or self.equipLua.binder:getData().onlyId ~= self.infoMo.onlyId then
		MaterialMgr.resetAll(self.equipPosGo)

		self.equipLua = MaterialMgr.setCellByData(MatType.Equipment, self.infoMo, self.equipPosGo)

		if isAddAttr then
			self.equipLua.binder:SetView(self)
			self.equipLua.binder:PlayAttrTypeEffect()
		else
			self.equipLua.binder:PlayAttrTypeEffect(true)
		end
	end

	self.equipLua.binder:setLvl(nowEquipInfo.starCount)

	self.isMax = nextEquipInfo == nil

	self.arrowGo1:SetActive(not self.isMax)
	self.arrowGo2:SetActive(not self.isMax)

	self.strengthenTxt.text = "确认强化"

	self:_creatLeftXingxing(nowEquipInfo.starCount, self.isMax)

	local count = 0

	if self.isMax then
		self.qhBarSli.value = 1
		self.qhNumTxt.text = lang("text_equip_desc_53")
		self.qhNowTxt.text = "Lv" .. nowEquipInfo.starCount .. "(MAX)"

		Framework.TransformUtil.SetLocalPos(self.qhNowTxt.gameObject.transform, 4, -28, 0)

		self.qhNextTxt.text = ""
		self.upgNextExp = nowEquipInfo.levelExp
	else
		local rightStart = 2

		count = 1 + nextEquipInfo.starCount

		if nowEquipInfo.starCount >= 1 then
			rightStart = nowEquipInfo.starCount + 1
			count = nowEquipInfo.starCount + nextEquipInfo.starCount
		end

		self:_creatRightXingxing(rightStart, count)

		self.upgNextExp = nextEquipInfo.levelExp

		self:_calculationProgress(nowEquipInfo.levelExp, nextEquipInfo.levelExp, nowEquipInfo.starCount, nextEquipInfo.starCount)
	end

	if self.levelStarList and count < #self.levelStarList then
		for i = count + 1, #self.levelStarList do
			if self.levelStarList[i] and self.levelStarList[i].activeSelf then
				self.levelStarList[i]:SetActive(false)
			end
		end
	end

	count = nowEquipInfo.attrList and #nowEquipInfo.attrList or 0

	if isExclAttr then
		count = nowEquipInfo.attrExclList and #nowEquipInfo.attrExclList or 0
	elseif isAddAttr then
		count = nowEquipInfo.attrAddList and #nowEquipInfo.attrAddList or 0
	end

	if self.attrItemList and count < #self.attrItemList then
		for i = count + 1, #self.attrItemList do
			if self.attrItemList[i] and self.attrItemList[i].itemGo.activeSelf then
				self.attrItemList[i].itemGo:SetActive(false)
			end
		end
	end

	if count <= 0 then
		return
	end

	for i = 1, count do
		if self.attrItemList[i] == nil then
			local item = UnityEngine.GameObject.Instantiate(self.qhItemGo, self.qhShowTran)

			self.attrItemList[i] = self:_setGameObjectComponent(item, 1)
		end

		if i == 1 then
			self.attrItemList[i].itemGo.transform:SetParent(self.qhShowTran)
		end

		self.attrItemList[i].itemGo:SetActive(true)

		local num = i - math.floor(i / 2) * 2

		self.attrItemList[i].attrIconSpt:SetState(nowEquipInfo.attrList[i].index - 1)

		self.attrItemList[i].qhNameTxt.text = nowEquipInfo.attrList[i].name

		if isExclAttr then
			self.attrItemList[i].qhNowCountTxt.text = tostring(nowEquipInfo.attrExclList[i].extCount)

			if string.find(nowEquipInfo.attrExclList[i].name, lang("text_equip_lv")) then
				self.attrItemList[i].qhNowCountTxt.text = nowEquipInfo.attrExclList[i].extCount * 100 .. "%"
			end
		elseif isAddAttr then
			self.attrItemList[i].qhNowCountTxt.text = tostring(nowEquipInfo.attrAddList[i].extCount)

			if string.find(nowEquipInfo.attrAddList[i].name, lang("text_equip_lv")) then
				self.attrItemList[i].qhNowCountTxt.text = nowEquipInfo.attrAddList[i].extCount * 100 .. "%"
			end
		else
			self.attrItemList[i].qhNowCountTxt.text = tostring(nowEquipInfo.attrList[i].extCount)

			if string.find(nowEquipInfo.attrList[i].name, lang("text_equip_lv")) then
				self.attrItemList[i].qhNowCountTxt.text = nowEquipInfo.attrList[i].extCount * 100 .. "%"
			end
		end

		if self.isMax then
			self.attrItemList[i].ImageGo5:SetActive(false)

			self.attrItemList[i].qhNextCountTxt.text = ""
		else
			self.attrItemList[i].ImageGo5:SetActive(true)

			if isExclAttr then
				self.attrItemList[i].qhNextCountTxt.text = tostring(nextEquipInfo.attrExclList[i].extCount)

				if string.find(nextEquipInfo.attrExclList[i].name, lang("text_equip_lv")) then
					self.attrItemList[i].qhNextCountTxt.text = nextEquipInfo.attrExclList[i].extCount * 100 .. "%"
				end
			elseif isAddAttr then
				self.attrItemList[i].qhNextCountTxt.text = tostring(nextEquipInfo.attrAddList[i].extCount)

				if string.find(nextEquipInfo.attrAddList[i].name, lang("text_equip_lv")) then
					self.attrItemList[i].qhNextCountTxt.text = nextEquipInfo.attrAddList[i].extCount * 100 .. "%"
				end
			else
				self.attrItemList[i].qhNextCountTxt.text = tostring(nextEquipInfo.attrList[i].extCount)

				if string.find(nextEquipInfo.attrList[i].name, lang("text_equip_lv")) then
					self.attrItemList[i].qhNextCountTxt.text = nextEquipInfo.attrList[i].extCount * 100 .. "%"
				end
			end
		end
	end
end

function EquipStrengthenView:_creatLeftXingxing(xxNumL, isMax, count)
	if xxNumL <= 0 then
		if self.levelStarList[1] == nil then
			self.levelStarList[1] = UnityEngine.GameObject.Instantiate(self.starGo, self.levelStarTranL)
		else
			self.levelStarList[1].transform:SetParent(self.levelStarTranL)
		end

		self.levelStarList[1]:GetComponent("UIImageSpriteChange"):SetState(3)

		self.levelStarList[1].name = "levelStarGoL"

		self.levelStarList[1]:SetActive(true)

		return
	end

	if isMax then
		return
	end

	for i = 1, xxNumL do
		if self.levelStarList[i] == nil then
			self.levelStarList[i] = UnityEngine.GameObject.Instantiate(self.starGo, self.levelStarTranL)
		else
			self.levelStarList[i].transform:SetParent(self.levelStarTranL)
		end

		self.levelStarList[i]:GetComponent("UIImageSpriteChange"):SetState(0)

		self.levelStarList[i].name = "levelStarGoL"

		self.levelStarList[i]:SetActive(true)
	end
end

function EquipStrengthenView:_creatRightXingxing(xxNumL, xxNumR, count)
	if xxNumR < xxNumL then
		return
	end

	for i = xxNumL, xxNumR do
		if self.levelStarList[i] == nil then
			local go = UnityEngine.GameObject.Instantiate(self.starGo, self.levelStarTranR)

			go:GetComponent("RectTransform").sizeDelta = Vector2.New(35, 35)
			self.levelStarList[i] = go
		else
			self.levelStarList[i].transform:SetParent(self.levelStarTranR)
		end

		self.levelStarList[i]:GetComponent("UIImageSpriteChange"):SetState(0)

		self.levelStarList[i].name = "levelStarGoR"

		self.levelStarList[i]:SetActive(true)
	end
end

function EquipStrengthenView:_calculationProgress(nowExp, nextExp, nowStarCount, nextStarCount)
	local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()
	local exp = self.infoMo.haveAllExp + fictExp - nowExp

	exp = exp < 0 and 0 or exp
	self.qhBarSli.value = exp / (nextExp - nowExp)
	self.qhNumTxt.text = exp .. "/" .. nextExp - nowExp
	self.qhNowTxt.text = "Lv" .. nowStarCount

	Framework.TransformUtil.SetLocalPos(self.qhNowTxt.gameObject.transform, -57.7, -89.5, 0)

	self.qhNextTxt.text = "Lv" .. nextStarCount
end

function EquipStrengthenView:_setGameObjectComponent(cell, cellType)
	local cellComInfo = {}

	cellComInfo.itemGo = cell

	if cellType == 1 then
		cellComInfo.attrIconSpt = goutil.findChildComponent(cell, "attrIconSpt", "UIImageSpriteChange")
		cellComInfo.ImageGo5 = goutil.findChild(cell, "ImageGo5")
		cellComInfo.qhNameTxt = goutil.findChildTextComponent(cell, "qhNameTxt")
		cellComInfo.qhNowCountTxt = goutil.findChildTextComponent(cell, "qhNowCountTxt")
		cellComInfo.qhNextCountTxt = goutil.findChildTextComponent(cell, "qhNextCountTxt")
	elseif cellType == 2 then
		cellComInfo.itemTog = Framework.ToggleAdapter.GetFrom(cell, "itemTog")
		cellComInfo.itemTxt = goutil.findChildTextComponent(cell, "itemTxt")
	end

	return cellComInfo
end

function EquipStrengthenView:_getPath()
	return {
		cellPath = "viewBgGo/rightInfoGo/itemInfoGo/itemCell",
		viewPath = "viewBgGo/rightInfoGo/itemInfoGo/itemListSR"
	}
end

function EquipStrengthenView:_cellSize()
	return 110, 110
end

function EquipStrengthenView:_updateCell(view, cell, data)
	local itemSpt = cell:GetComponent(goutil.Type_UIImage)
	local reduceBtnGo = goutil.findChild(cell, "reduceBtn")

	GameUtil.asBtn(reduceBtnGo):RemoveClickListener()
	reduceBtnGo:SetActive(false)
	MaterialMgr.resetAll(cell)

	if data == nil or data.isEmpty then
		itemSpt.enabled = true

		return
	end

	local subLua
	local allNum, useNum = 1, 0

	if data.isEquip then
		local equipInfo = PetEquipModel.instance:GetInfoMoByOnlyId(data.onlyId, self.infoMo.matType)

		if equipInfo then
			subLua = MaterialMgr.setCellByData(self.infoMo.matType, equipInfo, cell)
		end

		if data.countList and #data.countList > 1 then
			allNum = #data.countList
		end

		if data.useCount > 0 then
			useNum = data.useCount
		end
	else
		subLua = MaterialMgr.setCell(MatType.Item, data.baseId, cell)
		allNum = data.count

		if data.useCount > 0 then
			useNum = data.useCount
		end
	end

	if subLua and subLua.binder then
		local index = cell.data

		itemSpt.enabled = false

		if allNum <= 1 then
			subLua.binder:setNum()
		else
			subLua.binder:setNum(allNum, useNum)
		end

		subLua.binder:setAutoTips(false)
		subLua.binder:setSelected(useNum > 0)
		subLua.binder:setCallBack(function()
			self:_setChoiseStrengthen(index, true)
		end)

		if useNum > 0 then
			reduceBtnGo:SetActive(true)
			reduceBtnGo.transform:SetAsLastSibling()
			GameUtil.asBtn(reduceBtnGo):AddClickListener(function()
				self:_setChoiseStrengthen(index, false)
			end, self)
		end
	else
		itemSpt.enabled = true

		MaterialMgr.resetAll(cell)
	end
end

function EquipStrengthenView:_setChoiseStrengthen(index, isAdd)
	if self._curViewDatas == nil or self._curViewDatas[index] == nil or self._curViewDatas[index].isEmpty then
		return
	end

	if isAdd then
		if self.isMax then
			FloatWordMgr.instance:show(lang("text_equip_desc_55"))

			return
		end

		self:_addChoiseStrengthen(index)
	elseif self._curViewDatas[index].isEquip then
		if self._curViewDatas[index].countList then
			if self._curViewDatas[index].useCount <= 0 then
				FloatWordMgr.instance:show(lang("text_equip_desc_9"))

				return
			end

			self._curViewDatas[index].useCount = self._curViewDatas[index].useCount - 1

			if self._curViewDatas[index].useCount <= 0 then
				self._curViewDatas[index].useCount = 0
			end
		else
			if self._curViewDatas[index].useCount <= 0 then
				FloatWordMgr.instance:show(lang("text_equip_desc_58"))

				return
			end

			self._curViewDatas[index].useCount = 0
		end

		PetEquipModel.instance:SetStrengthenFictitiousExp(-self._curViewDatas[index].allExp * self.costDecoRatio / 100)
	else
		if self._curViewDatas[index].useCount <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_16"))

			return
		end

		self._curViewDatas[index].useCount = self._curViewDatas[index].useCount - 1

		if self._curViewDatas[index].useCount <= 0 then
			self._curViewDatas[index].useCount = 0
		end

		PetEquipModel.instance:SetStrengthenFictitiousExp(-self._curViewDatas[index].allExp)
	end

	self:_calculationNeedCoin()
end

function EquipStrengthenView:_addChoiseStrengthen(index)
	if self._curViewDatas == nil or self._curViewDatas[index] == nil or self._curViewDatas[index].isEmpty then
		return
	end

	if self._curViewDatas[index].isEquip then
		if self.choiseNum >= self.oneMaxNum then
			FloatWordMgr.instance:show(lang("text_equip_desc_56"))

			return false
		end

		if self._curViewDatas[index].countList then
			if #self._curViewDatas[index].countList <= self._curViewDatas[index].useCount then
				FloatWordMgr.instance:show(lang("text_equip_desc_7"))

				return false
			end

			self._curViewDatas[index].useCount = self._curViewDatas[index].useCount + 1
		else
			if self._curViewDatas[index].useCount > 0 then
				FloatWordMgr.instance:show(lang("text_equip_desc_61"))

				return false
			end

			self._curViewDatas[index].useCount = 1
		end

		PetEquipModel.instance:SetStrengthenFictitiousExp(self._curViewDatas[index].allExp * self.costDecoRatio / 100)

		return true
	end

	if self.choiseNum >= self.oneMaxNum and self._curViewDatas[index].useCount <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_56"))

		return false
	end

	if self._curViewDatas[index].count <= self._curViewDatas[index].useCount then
		FloatWordMgr.instance:show(lang("text_equip_desc_14"))

		return false
	end

	self._curViewDatas[index].useCount = self._curViewDatas[index].useCount + 1

	PetEquipModel.instance:SetStrengthenFictitiousExp(self._curViewDatas[index].allExp)

	return true
end

function EquipStrengthenView:_onClickPutInBtn()
	if self.infoMo == nil then
		FloatWordMgr.instance:show("请先选择要强化的装备")

		return
	end

	if self.isMax then
		FloatWordMgr.instance:show(lang("text_equip_desc_63"))

		return
	end

	local diffExp = 0

	if self._isMaxStrengthen then
		diffExp = self:_calculateExpToReachableMaxExp()

		if diffExp <= 0 then
			FloatWordMgr.instance:show("材料不足，无法继续强化")

			return
		end
	else
		local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()

		diffExp = self.upgNextExp - self.infoMo.haveAllExp - fictExp

		if self.upgNextExp - self.infoMo.haveAllExp - fictExp <= 0 then
			local str = string.format("装备baseId = %s， 装备名称name = %s，装备等级starCount = %s， 装备已有经验haveExp = %s， 下一级经验nextExp = %s， 临时存储经验fictExp = %s， ", self.infoMo.baseId, self.infoMo.name, self.infoMo.starCount, self.infoMo.haveAllExp, self.upgNextExp, fictExp)

			printError("sr----  EquipStrengthenView:_onClickPutInBtn()    装备强化一键放入 = " .. str)

			return
		end
	end

	if checknumber(self.infoMo.exclRaceId) > 0 then
		if self.matLua == nil or self.exclMatInfo == nil or checknumber(self.exclMatInfo.allCount) <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_64"))

			return
		end

		self:_onClickExclPutInBtn(diffExp)
	else
		if self._curViewDatas == nil or self._curViewDatas[1] == nil or self._curViewDatas[1].isEmpty then
			FloatWordMgr.instance:show(lang("text_equip_desc_64"))

			return
		end

		self:_onClickPutInCommBtn(diffExp)
	end
end

function EquipStrengthenView:_onClickPutInCommBtn(diffExp)
	local tempExp = 0
	local maxNum = EquipmentConfig.instance:GetMaxOneClickNum()
	local isOrange = false
	local processOrder = {}

	if self._isMaxStrengthen then
		for i = 1, #self._curViewDatas do
			if not self._curViewDatas[i].isEmpty and not self._curViewDatas[i].isEquip then
				table.insert(processOrder, i)
			end
		end

		local equipList = {}

		for i = 1, #self._curViewDatas do
			if not self._curViewDatas[i].isEmpty and self._curViewDatas[i].isEquip then
				local var_45_1 = {
					index = i
				}

				var_45_1.quality = self._curViewDatas[i].quality or 0

				table.insert(equipList, var_45_1)
			end
		end

		table.sort(equipList, function(a, b)
			return a.quality < b.quality
		end)

		for _, item in ipairs(equipList) do
			table.insert(processOrder, item.index)
		end
	else
		for i = 1, #self._curViewDatas do
			table.insert(processOrder, i)
		end
	end

	for _, i in ipairs(processOrder) do
		local shouldProcess = not self._curViewDatas[i].isEmpty and (self.choiseNum < self.oneMaxNum or not self._curViewDatas[i].isEquip)

		shouldProcess = shouldProcess and tempExp < diffExp

		if shouldProcess then
			if self._curViewDatas[i].isEquip then
				if self._curViewDatas[i].countList then
					if maxNum <= self._curViewDatas[i].quality then
						isOrange = true
					else
						while self._curViewDatas[i].useCount < #self._curViewDatas[i].countList and self.choiseNum < self.oneMaxNum do
							if diffExp <= tempExp then
								break
							end

							if not self:_addChoiseStrengthen(i, 1) then
								break
							end

							self.choiseNum = self.choiseNum + 1
							tempExp = tempExp + self._curViewDatas[i].allExp * self.costDecoRatio / 100
						end
					end
				elseif self._curViewDatas[i].useCount < 1 then
					if maxNum <= self._curViewDatas[i].quality then
						isOrange = true
					elseif self:_addChoiseStrengthen(i, 1) then
						self.choiseNum = self.choiseNum + 1
						tempExp = tempExp + self._curViewDatas[i].allExp * self.costDecoRatio / 100
					end
				end
			else
				local isAdd = false

				while self._curViewDatas[i].useCount < self._curViewDatas[i].count do
					if diffExp <= tempExp then
						break
					end

					if not self:_addChoiseStrengthen(i, 1) then
						break
					end

					isAdd = true
					tempExp = tempExp + self._curViewDatas[i].allExp
				end

				if isAdd then
					self.choiseNum = self.choiseNum + 1
				end
			end
		end
	end

	if isOrange then
		local orangeStr = EquipmentConfig.instance:GetMaxOneClickTips()

		if not string.nilorempty(orangeStr) then
			FloatWordMgr.instance:show(orangeStr)
		end
	elseif tempExp <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_65"))

		return
	end

	self:_calculationNeedCoin()
end

function EquipStrengthenView:_calculationNeedCoin()
	self:reloadData()

	self.choiseNum = 0

	if self._curViewDatas == nil or self._curViewDatas[1] == nil or self._curViewDatas[1].isEmpty then
		self.moneyCountTxt.text = "0"

		self.moneyCountTxtColorChange:SetState(0)

		return
	end

	self:_forceUpdataLeftInfo()

	local need = 0

	if self.isMax then
		need = self.upgNextExp - self.infoMo.haveAllExp
	else
		for i = 1, #self._curViewDatas do
			if self._curViewDatas[i] and not self._curViewDatas[i].isEmpty then
				need = need + self._curViewDatas[i].useCount * self._curViewDatas[i].allExp

				if self._curViewDatas[i].isEquip then
					self.choiseNum = self.choiseNum + self._curViewDatas[i].useCount
				elseif self._curViewDatas[i].useCount > 0 then
					self.choiseNum = self.choiseNum + 1
				end
			end
		end
	end

	self.qhNeedCoin = need * self.infoMo.expCoinRatio

	local isEnough = MaterialModel.instance:IsEnough(MatType.Coin, 1, self.qhNeedCoin)

	if isEnough == true then
		self.moneyCountTxtColorChange:SetState(0)
	else
		self.moneyCountTxtColorChange:SetState(1)
	end

	self.moneyCountTxt.text = tostring(self.qhNeedCoin)
end

function EquipStrengthenView:_onClickExclPutInBtn(diffExp)
	local count = 0

	if self._isMaxStrengthen then
		local canUse = self.exclMatInfo.allCount - self.exclMatInfo.useCount
		local need = math.ceil(diffExp / self.exclMatInfo.matExp)

		count = math.min(canUse, need)
	else
		local tempExp = 0

		while self.exclMatInfo.useCount + count < self.exclMatInfo.allCount and tempExp < diffExp do
			count = count + 1
			tempExp = tempExp + self.exclMatInfo.matExp
		end

		if count + self.exclMatInfo.useCount > self.exclMatInfo.allCount then
			count = self.exclMatInfo.allCount - self.exclMatInfo.useCount
		end
	end

	if count <= 0 then
		if self._isMaxStrengthen then
			FloatWordMgr.instance:show("材料不足，无法继续强化")
		else
			FloatWordMgr.instance:show(lang("text_equip_desc_65"))
		end

		return
	end

	self:_onClickExclMatBtn(true, count)
end

function EquipStrengthenView:_onClickExclMatBtn(isAdd, count)
	if self.matLua == nil or self.exclMatInfo == nil or checknumber(self.exclMatInfo.allCount) <= 0 then
		return
	end

	count = count or 1

	if isAdd then
		if self.isMax then
			FloatWordMgr.instance:show(lang("text_equip_desc_55"))

			return
		end

		if self.exclMatInfo.useCount >= self.exclMatInfo.allCount then
			FloatWordMgr.instance:show(lang("text_equip_desc_14"))

			return
		end

		self.exclMatInfo.useCount = self.exclMatInfo.useCount + count

		PetEquipModel.instance:SetStrengthenFictitiousExp(self.exclMatInfo.matExp * count)
	else
		if self.exclMatInfo.useCount <= 0 then
			FloatWordMgr.instance:show(lang("text_equip_desc_16"))

			return
		end

		self.exclMatInfo.useCount = self.exclMatInfo.useCount - count

		PetEquipModel.instance:SetStrengthenFictitiousExp(-self.exclMatInfo.matExp * count)
	end

	self.matLua.binder:setNum(self.exclMatInfo.allCount, self.exclMatInfo.useCount)
	self.matLua.binder:setSelected(self.exclMatInfo.useCount > 0)
	GameUtil.SetActive(self.matReduceBtn, self.exclMatInfo.useCount > 0)

	if self.exclMatInfo.useCount > 0 then
		self.matReduceBtn.gameObject.transform:SetAsLastSibling()
	end

	self.qhNeedCoin = (self.isMax and self.upgNextExp - self.infoMo.haveAllExp or self.exclMatInfo.useCount * self.exclMatInfo.matExp) * self.infoMo.expCoinRatio
	self.moneyCountTxt.text = tostring(self.qhNeedCoin)

	self:_forceUpdataLeftInfo()
end

function EquipStrengthenView:_onClickStrengthenBtn()
	if self.infoMo == nil then
		FloatWordMgr.instance:show("请先选择要强化的装备")

		return
	end

	local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()

	if fictExp <= 0 and self.isMax then
		FloatWordMgr.instance:show(lang("text_equip_desc_55"))

		return
	end

	if checknumber(self.infoMo.exclRaceId) > 0 then
		self:_onClickStthenExclBtn()
	else
		self:_onClickStthenCommBtn()
	end
end

function EquipStrengthenView:_onClickStthenCommBtn()
	local isSelect = false
	local allCount = 0
	local equIds = {}
	local matIds = {}
	local desStr = lang("text_equip_desc_66")
	local tipsInfoList = {}
	local maxNum = EquipmentConfig.instance:GetMaxQualityNum()

	if self._curViewDatas and #self._curViewDatas > 0 then
		for i = 1, #self._curViewDatas do
			if self._curViewDatas[i] and not self._curViewDatas[i].isEmpty and self._curViewDatas[i].useCount > 0 then
				if self._curViewDatas[i].isEquip then
					local choNum = 0

					if self._curViewDatas[i].countList then
						for m = 1, self._curViewDatas[i].useCount do
							if self._curViewDatas[i].countList[m] then
								choNum = choNum + 1
								isSelect = true

								local id = self._curViewDatas[i].countList[m]

								table.insert(equIds, id)

								desStr = desStr .. id .. "，"
							end
						end
					else
						choNum = 1
						isSelect = true

						local id = self._curViewDatas[i].onlyId

						table.insert(equIds, id)

						desStr = desStr .. id .. "，"
					end

					allCount = allCount + self._curViewDatas[i].useCount

					if maxNum <= self._curViewDatas[i].quality and choNum > 0 then
						table.insert(tipsInfoList, {
							onlyId = self._curViewDatas[i].onlyId,
							matType = self.infoMo.matType,
							useCount = choNum
						})
					end
				else
					isSelect = true

					table.insert(matIds, {
						id = self._curViewDatas[i].onlyId,
						num = self._curViewDatas[i].useCount
					})

					desStr = desStr .. self._curViewDatas[i].onlyId .. "_" .. self._curViewDatas[i].useCount .. "，"
					allCount = allCount + 1
				end
			end
		end
	end

	if not isSelect then
		FloatWordMgr.instance:show(lang("text_equip_desc_67"))

		return
	end

	if allCount > self.oneMaxNum then
		FloatWordMgr.instance:show(lang("text_equip_desc_68"))

		return
	end

	local haveCoin = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

	if haveCoin < self.qhNeedCoin then
		FloatWordMgr.instance:show(lang("text_equip_desc_69"))

		return
	end

	if not self:_checkPasswordLockPass(tipsInfoList) then
		return
	end

	local function callBack()
		local data = {
			onlyId = self.infoMo.onlyId,
			starCount = self.infoMo.starCount,
			matType = self.infoMo.matType
		}

		PetEquipModel.instance:SetCurrentUpgradeInfo(data)
		PetEquipController.instance:CSStrengthenEquipReq(self.infoMo.onlyId, equIds, matIds)
	end

	if tipsInfoList and #tipsInfoList > 0 then
		UIStateManager.instance:open(ViewName.StrengthenTips, tipsInfoList, callBack)

		return
	end

	callBack()
end

function EquipStrengthenView:_onClickStthenExclBtn()
	if self.matLua == nil or self.exclMatInfo == nil or checknumber(self.exclMatInfo.allCount) <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_64"))

		return
	end

	if checknumber(self.exclMatInfo.useCount) <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_67"))

		return
	end

	local haveCoin = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

	if haveCoin < self.qhNeedCoin then
		FloatWordMgr.instance:show(lang("text_equip_desc_69"))

		return
	end

	local data = {
		onlyId = self.infoMo.onlyId,
		starCount = self.infoMo.starCount,
		matType = self.infoMo.matType
	}

	PetEquipModel.instance:SetCurrentUpgradeInfo(data)
	PetEquipController.instance:CSStrengthenEquipReq(self.infoMo.onlyId, {}, {
		{
			id = self.exclMatInfo.matId,
			num = self.exclMatInfo.useCount
		}
	})
end

function EquipStrengthenView:_onClickHuanjingBtn()
	if not MaterialChallengeModel.instance:isStageUnlock(4, 1) then
		local cfgStage = MaterialChallengeConfig.instance:getStageById(4, 1)
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(cfgStage.unlockId)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	MaterialChallengeController.instance:openChapterView(4)
end

function EquipStrengthenView:_checkPasswordLockPass(list)
	if #list > 0 and PasswordLockController.instance:checkNeedOpenVerifyView() then
		return false
	end

	return true
end

function EquipStrengthenView:_onClickToggleStrengthenMax()
	self._isMaxStrengthen = not self._isMaxStrengthen

	GameUtil.saveUserData("equip_strengthen_max", self._isMaxStrengthen)
	GameUtil.SetActive(self._imgSelectStrengthenMax, self._isMaxStrengthen)
end

function EquipStrengthenView:_calculateExpToReachableMaxExp()
	if self.infoMo == nil then
		return 0
	end

	local availableExp = 0

	if checknumber(self.infoMo.exclRaceId) > 0 then
		if self.exclMatInfo and checknumber(self.exclMatInfo.allCount) > 0 then
			availableExp = self.exclMatInfo.allCount * self.exclMatInfo.matExp
		end
	elseif self._curViewDatas then
		local maxNum = EquipmentConfig.instance:GetMaxOneClickNum()

		for i = 1, #self._curViewDatas do
			local d = self._curViewDatas[i]

			if d and not d.isEmpty then
				if d.isEquip then
					if maxNum > d.quality then
						availableExp = availableExp + (d.countList and #d.countList or 1) * d.allExp * self.costDecoRatio / 100
					end
				else
					availableExp = availableExp + d.count * d.allExp
				end
			end
		end
	end

	local planList = EquipmentConfig.instance:GetEquipLevelInfos(self.infoMo.attrPlan)

	if planList == nil then
		return 0
	end

	local lastIndex = 0

	while planList[lastIndex] do
		lastIndex = lastIndex + 1
	end

	lastIndex = lastIndex - 1

	if lastIndex < 0 or planList[lastIndex] == nil then
		return 0
	end

	local maxLevelExp = planList[lastIndex].exp
	local fictExp = PetEquipModel.instance:GetStrengthenFictitiousExp()
	local currentTotalExp = self.infoMo.haveAllExp + fictExp
	local needToFull = maxLevelExp - currentTotalExp

	if needToFull < 0 then
		needToFull = 0
	end

	return math.min(availableExp, needToFull)
end

function EquipStrengthenView:_onClickPetName()
	local petId

	UIStateManager.instance:open(ViewName.EquipBagPetListView, (self.infoMo or nil) and self.infoMo.equipPetId)
end

return EquipStrengthenView

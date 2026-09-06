-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/EquipLvUpView.lua

module("logic.extensions.starequipment.view.EquipLvUpView", package.seeall)

local EquipLvUpView = class("EquipLvUpView", TableViewComponent)
local costMatEnum = {
	Common = 0,
	Blue = 2,
	Purple = 3,
	Green = 1
}

function EquipLvUpView:ctor()
	EquipLvUpView.super.ctor(self)

	self._selectedEquips = {}
	self._selectedMatNum = 0
	self._equipItems = {}
	self._matItem = nil
end

function EquipLvUpView:getBigBgList()
	return {
		{
			goPath = "right/cost/mats/notMax/btnUpgrade/txtCostGold/imgGold",
			imageUrl = "ui/icon/items/icon_jinbi.png"
		}
	}
end

function EquipLvUpView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function EquipLvUpView:destroyUI()
	EquipLvUpView.super.destroyUI(self)
end

function EquipLvUpView:onExitFinished()
	EquipLvUpView.super.onExitFinished(self)
end

function EquipLvUpView:onEnterFinished()
	EquipLvUpView.super.onEnterFinished(self)
end

function EquipLvUpView:unbindEvents()
	EquipLvUpView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnOnekey:RemoveClickListener()
	self._btnOnekeyTakeOff:RemoveClickListener()
	self._btnTakeOff:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._costFilter:unbindEvents()
	self._equipFilter:unbindEvents()
end

function EquipLvUpView:bindEvents()
	EquipLvUpView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnOnekey:AddClickListener(self._onClickOnekey, self)
	self._btnOnekeyTakeOff:AddClickListener(self._onClickOnekeyTakeOff, self)
	self._btnTakeOff:AddClickListener(self._onClickTakeOff, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitchNew(true)
	end)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitchNew(false)
	end)
	self._costFilter:bindEvents()
	self._costFilter:relatedToBtn(self._btnMats)
	self._equipFilter:bindEvents()
	self._equipFilter:relatedToBtn(self._btnEquips)
	self._equipFilter:setValueChanged(self._updateEquipList, self)
end

function EquipLvUpView:onExit()
	EquipLvUpView.super.onExit(self)
	self:_clearSelectedMats()
end

function EquipLvUpView:buildUI()
	EquipLvUpView.super.buildUI(self)

	self._scrollRect = goutil.findChildComponent(self.mainGO, "tableview", "ScrollRect")
	self._animator = self.mainGO:GetComponent("Animator")
	self._btnGet = self:getBtn("btnGet")
	self._btnBuy = self:getBtn("btnBuy")
	self._matId = StarEquipmentConfig.instance:getEquipUpMatId()
	self._matCfg = ItemConfig.instance:getCfgById(self._matId)
	self._imgMatIcon = self:getGo("imgMatIcon")

	uGuiUtil.setSpriteToImage(self._imgMatIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._matCfg.icon))

	self._closeButton = self:getBtn("Left/btn_close")
	self._btnHome = self:getBtn("Left/btn_home")
	self._null = self:getGo("null")

	local right = self:getGo("right")

	self._btnTakeOff = Framework.ButtonAdapter.GetFrom(right, "btnTakeOff")
	self._btnSwitch = Framework.ButtonAdapter.GetFrom(right, "btnSwitch")
	self._curEquip = goutil.findChild(self._btnSwitch.gameObject, "curEquip")
	self._txtLeftLv = goutil.findChildComponent(right, "txtLeftLv", "Text")
	self._txtRightLv = goutil.findChildComponent(right, "txtRightLv", "Text")
	self._sliderAdd = goutil.findChildComponent(right, "exp/sliderAdd", "Slider")
	self._sliderExp = goutil.findChildComponent(right, "exp/sliderExp", "Slider")
	self._txtExpProgress = goutil.findChildComponent(right, "exp/txtExpProgress", "Text")
	self._rectTxtLeftLv = self._txtLeftLv:GetComponent("RectTransform")
	self._btnLeft = Framework.ButtonAdapter.GetFrom(right, "btnLeft")
	self._btnRight = Framework.ButtonAdapter.GetFrom(right, "btnRight")

	local attrs = goutil.findChild(right, "attrs/scrollrect/gridAttrs")

	self._itemEquipAttrs = ItemEquipAttrs.New(attrs)
	self._max = goutil.findChild(right, "cost/mats/max")
	self._notMax = goutil.findChild(right, "cost/mats/notMax")

	local mats = goutil.findChild(self._notMax, "mats")

	self._mats = {}

	for i = 1, 6 do
		local mat = {}
		local go = goutil.findChild(mats, i)

		mat.mainGO = go
		mat.itemPoint = goutil.findChild(go, "container/itemPoint")

		goutil.setActive(mat.itemPoint, false)

		mat.btn = Framework.ButtonAdapter.Get(go)
		mat.longPressed = go:GetComponent("UILongPressed")

		table.insert(self._mats, mat)
	end

	self._btnOnekey = Framework.ButtonAdapter.GetFrom(self._notMax, "btnOnekey")
	self._btnOnekeyTakeOff = Framework.ButtonAdapter.GetFrom(self._notMax, "btnOnekeyTakeOff")
	self._btnUpgrade = Framework.ButtonAdapter.GetFrom(self._notMax, "btnUpgrade")
	self._txtCostGold = goutil.findChildComponent(self._notMax, "btnUpgrade/txtCostGold", "Text")
	self._btnMats = Framework.ButtonAdapter.GetFrom(self._notMax, "btnMats")

	local costFilter = goutil.findChild(self._notMax, "costFilter")

	self._costFilter = ItemFilter.New(costFilter, 0, GameEnum.StarEquipmentQua.Purple)

	self._costFilter:setAllChecked()

	local equipFilter = self:getGo("qualityFilter/bg")

	self._equipFilter = ItemFilter.New(equipFilter, 0, GameEnum.StarEquipmentQua.Red)
	self._btnEquips = self:getBtn("btnEquips")

	goutil.setActive(self._null, false)
	goutil.setActive(self._imgMatIcon, false)

	self._equipTipsPoint = self:getGo("equipTipsPoint")
	self._txtRightTitle = goutil.findChildTextComponent(right, "imgBg/imgBgTitle/txtTitle")
	self._txtAttrTips = goutil.findChildTextComponent(right, "attrs/txtTips")
	self._txtCostTips = goutil.findChildTextComponent(right, "cost/txtTips")
	self._matsContainer = goutil.findChild(right, "cost/mats")
	self._btnConfirm = Framework.ButtonAdapter.GetFrom(right, "btnConfirm")
	self.goldBarCon = self:getGo("goldBarCon")
end

function EquipLvUpView:onEnter()
	EquipLvUpView.super.onEnter(self)

	local params = self:getOpenParam()

	self._equipMo = params[1]
	self._petMo = params[2]
	self._slotIndex = params[3]
	self._equipmentId = self._equipMo.equipmentId

	self:_updateUI()
	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor)
	print("self._slotIndex = " .. tostring(self._slotIndex))
end

function EquipLvUpView:_updateUI()
	self:_clearSelectedMats()

	if self._petMo ~= nil then
		self._equipMo = self._petMo:getSlotEquipById(self._slotIndex, self._equipmentId)
	end

	self:_updateCurEquip()
	self:_updateTargetUI()

	self._curViewDatas = self:getCurViewDatas(1)

	self:reloadData()
	goutil.setActive(self._btnTakeOff.gameObject, false)
end

function EquipLvUpView:_updateCurEquip()
	goutil.setActive(self._curEquip, self._equipMo ~= nil)
	goutil.setActive(self._matsContainer, self._equipMo ~= nil and not self._isInSwitch)

	if self._equipMo == nil then
		self._txtLeftLv.text = ""

		self._itemEquipAttrs:clearShowAttrs()

		self._txtAttrTips.text = "请先放入星辉"
		self._txtCostTips.text = "请先选择要升级的星辉"
		self._txtRightTitle.text = "请先放入星辉"
	else
		local equipId = self._equipMo.equipmentId
		local equipLv = self._equipMo.level
		local matStr = string.format("%s:%s:0", MatType.StarEquipment, equipId)

		MaterialMgr.setCellByCfg(matStr, self._curEquip)

		self._txtLeftLv.text = string.format("Lv.%s/%s", self._equipMo.level, StarEquipmentConfig.MaxStarEquipmentLv)

		local equipLvCfg = StarEquipmentConfig.instance:getEquipLvCfg(equipId, equipLv)
		local _, curExp = StarEquipmentConfig.instance:getCurLvAndExp(equipId, self._equipMo.totalExp)
		local needExp = StarEquipmentConfig.instance:getCurLvNeedExp(equipId, equipLv)
		local isMaxLv = self._equipMo.level >= StarEquipmentConfig.MaxStarEquipmentLv

		goutil.setActive(self._max, isMaxLv)
		goutil.setActive(self._notMax, not isMaxLv)
		self._itemEquipAttrs:onSetMo(self._equipMo.equipmentId, curLv)

		self._txtAttrTips.text = ""
		self._txtCostTips.text = self._isInSwitch and "请确认要升级的星辉" or ""
		self._txtRightTitle.text = self._isInSwitch and "确认选择星辉" or "星辉升级"
	end

	local equipMo, slotIndex = self:_getNextEquipMo(true)

	goutil.setActive(self._btnLeft.gameObject, equipMo ~= nil)

	equipMo, slotIndex = self:_getNextEquipMo(false)

	goutil.setActive(self._btnRight.gameObject, equipMo ~= nil)
end

function EquipLvUpView:_updateTargetUI()
	if self._equipMo == nil then
		goutil.setActive(self._txtRightLv.gameObject, false)

		self._sliderExp.value = 0
		self._txtExpProgress.text = "0"
		self._sliderAdd.value = 0

		return
	end

	local maxLv = StarEquipmentConfig.MaxStarEquipmentLv
	local addExp = self:_getCurAddExp()
	local maxNeedExp = StarEquipmentConfig.instance:getTargetLvNeedExp(self._equipMo.equipmentId, self._equipMo.totalExp, maxLv)

	addExp = math.min(addExp, maxNeedExp)

	local targetLv, targetExp = StarEquipmentConfig.instance:getCurLvAndExp(self._equipMo.equipmentId, self._equipMo.totalExp + addExp)
	local curLv = self._equipMo.level
	local _, curExp = StarEquipmentConfig.instance:getCurLvAndExp(self._equipMo.equipmentId, self._equipMo.totalExp)
	local needExp = StarEquipmentConfig.instance:getCurLvNeedExp(self._equipMo.equipmentId, self._equipMo.level)

	goutil.setActive(self._txtRightLv.gameObject, curLv < targetLv)

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._rectTxtLeftLv, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._rectTxtLeftLv, curLv < targetLv and -378 or -267, y)

	self._txtRightLv.text = string.format("Lv.<color=#ff0000>%s</color>/%s", targetLv, maxLv)

	if targetLv == maxLv then
		self._sliderAdd.value = 1
		self._txtExpProgress.text = "MAX"

		if needExp > 0 then
			self._sliderExp.value = curExp / needExp or 1
		end
	elseif curLv < targetLv then
		local targetNeedExp = StarEquipmentConfig.instance:getCurLvNeedExp(self._equipMo.equipmentId, targetLv)

		self._txtExpProgress.text = string.format("%s/%s", targetExp, targetNeedExp)

		if targetNeedExp > 0 then
			self._sliderAdd.value = targetExp / targetNeedExp or 1
		end

		self._sliderExp.value = 0
	else
		if needExp > 0 then
			self._sliderExp.value = curExp / needExp or 1
		end

		self._txtExpProgress.text = string.format("%s/%s", targetExp, needExp)

		if needExp > 0 then
			self._sliderAdd.value = (curExp + addExp) / needExp or 1
		end
	end

	local costGoldNum = addExp

	self._isGoldEnough = costGoldNum <= MaterialFacade.instance:getMatNumber(MatType.Coin, 1)
	self._txtCostGold.text = costGoldNum
	self._targetLv = targetLv

	local isOnekeyEquip = self:_getSelectMatTypeCounts() < 6 and targetLv < maxLv

	goutil.setActive(self._btnOnekey.gameObject, isOnekeyEquip)
	goutil.setActive(self._btnOnekeyTakeOff.gameObject, not isOnekeyEquip)
	self._itemEquipAttrs:onSetMo(self._equipMo.equipmentId, curLv, targetLv)
end

function EquipLvUpView:_updateCostMats()
	self:_clearSelectedMats()

	if self._selectedMatNum > 0 then
		self:_updateOneMatItem(MatType.Item, self._matId, self._selectedMatNum)
	end

	if self._selectedEquips ~= nil and #self._selectedEquips > 0 then
		for id, num in pairs(self._selectedEquips) do
			self:_updateOneMatItem(MatType.StarEquipment, id, num)
		end
	end
end

function EquipLvUpView:_updateOneMatItem(matType, matId, selectedNum)
	local item

	if matType == MatType.Item then
		if self._matItem == nil and selectedNum > 0 then
			self._matItem = self:_getFreeMatItem(matType, matId, selectedNum)
		end

		if self._matItem ~= nil then
			if selectedNum > 0 then
				self._matItem.proxy.binder:setNum(selectedNum)
			else
				self:_clearOneMatItem(self._matItem)

				self._matItem = nil
			end
		end
	elseif matType == MatType.StarEquipment then
		if self._equipItems[matId] == nil and selectedNum > 0 then
			self._equipItems[matId] = self:_getFreeMatItem(matType, matId, selectedNum)
		end

		if self._equipItems[matId] ~= nil then
			if selectedNum > 0 then
				self._equipItems[matId].proxy.binder:setNum(selectedNum)
			else
				self:_clearOneMatItem(self._equipItems[matId])

				self._equipItems[matId] = nil
			end
		end
	end
end

function EquipLvUpView:_clearSelectedMats()
	self._selectedEquips = {}
	self._selectedMatNum = 0

	if self._matItem ~= nil then
		self:_clearOneMatItem(self._matItem)

		self._matItem = nil
	end

	for _, v in pairs(self._equipItems) do
		self:_clearOneMatItem(v)

		v = nil
	end

	self._equipItems = {}
end

function EquipLvUpView:_clearOneMatItem(item)
	MaterialMgr.resetAll(item.itemPoint)
	goutil.setActive(item.itemPoint, false)
	item.btn:RemoveClickListener()
end

function EquipLvUpView:_getFreeMatItem(matType, matId, num)
	for i = 1, 6 do
		local item = self._mats[i]

		if not item.itemPoint.activeSelf then
			goutil.setActive(item.itemPoint, true)

			local matStr = string.format("%s:%s:%s", matType, matId, num)

			item.proxy = MaterialMgr.setCellByCfg(matStr, item.itemPoint)

			item.btn:AddClickListener(function()
				self:_onClickCostMats(matType, matId)
			end)
			item.longPressed:RemoveListener()
			item.longPressed:AddListener(function(target, isUp)
				self:_onLongPressMat(matType, matId, isUp)
			end, self)

			return item
		end
	end

	return nil
end

function EquipLvUpView:_getCurAddExp()
	local addExp = 0
	local matAddExp = StarEquipmentConfig.instance:getEquipUpMatExp()

	addExp = addExp + matAddExp * self._selectedMatNum

	for id, num in pairs(self._selectedEquips) do
		local equipCfg = StarEquipmentConfig.instance:getEquipCfg(id)

		addExp = addExp + equipCfg.provideExp * num
	end

	return addExp
end

function EquipLvUpView:getCurViewDatas(fliterType)
	if self._isInSwitch then
		return self:getDatasEquiped(fliterType)
	else
		return self:getDatasInBag(fliterType)
	end
end

function EquipLvUpView:getDatasInBag(fliterType)
	local equipCfgs = StarEquipmentConfig.instance:getEquipCfgs()
	local t = {}

	for _, cfg in pairs(equipCfgs) do
		if fliterType == 1 and self:_getEquipFilterType(cfg.quality) or fliterType == 2 and self:_getCostFilterType(cfg.quality) then
			local num = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, cfg.equipmentId)

			if num > 0 then
				local data = {
					matType = MatType.StarEquipment,
					cfg = cfg,
					num = num,
					matId = cfg.equipmentId
				}

				table.insert(t, data)
			end
		end
	end

	local num = MaterialFacade.instance:getMatNumber(MatType.Item, self._matId)
	local data = {
		matType = MatType.Item,
		cfg = self._matCfg,
		num = num,
		matId = self._matId
	}

	if num > 0 and (fliterType == 1 and self:_getEquipFilterType(0) or fliterType == 2 and self:_getCostFilterType(0)) then
		table.insert(t, data)
	end

	table.sort(t, function(a, b)
		if a.matType ~= b.matType then
			return a.matType == MatType.Item
		elseif a.cfg.quality ~= b.cfg.quality then
			return a.cfg.quality < b.cfg.quality
		else
			return a.cfg.equipmentId < b.cfg.equipmentId
		end
	end)

	return t
end

function EquipLvUpView:getDatasEquiped()
	local petMos = BagPetsController.instance:getBagPets()
	local t = {}

	for _, petMo in pairs(petMos) do
		for slotIndex = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
			local equipMos = petMo:getSlotEquipInfos(slotIndex)

			if equipMos ~= nil and #equipMos > 0 then
				for _, equipMo in ipairs(equipMos) do
					if equipMo.level < StarEquipmentConfig.MaxStarEquipmentLv then
						local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipMo.equipmentId)

						table.insert(t, {
							num = 0,
							matType = MatType.StarEquipment,
							matId = equipMo.equipmentId,
							cfg = equipCfg,
							level = equipMo.level,
							petId = petMo.petId,
							equipMo = equipMo,
							slotIndex = slotIndex
						})
					end
				end
			end
		end
	end

	return t
end

function EquipLvUpView:_updateCell(view, cell, data)
	local component = ItemStarEquip.AddOnce(cell.gameObject)

	component:onSetMo(data)
	component:setClickCall(self._onClickEquip, self)
	component:setLongPressedCall(self._onLongPressEquip, self)
	component:setSelectedNum(self:getSelectedNum(data.matType, data.matId))
	component:setSelected(self._isInSwitch and self._selectedMo == data)
end

function EquipLvUpView:getSelectedNum(matType, matId)
	if matType == MatType.Item then
		return self._selectedMatNum
	elseif matType == MatType.StarEquipment and self._selectedEquips ~= nil then
		return checknumber(self._selectedEquips[matId])
	end

	return 0
end

function EquipLvUpView:setSelectedNum(matType, matId, num)
	if matType == MatType.Item then
		self._selectedMatNum = num
	elseif matType == MatType.StarEquipment and self._selectedEquips ~= nil then
		self._selectedEquips[matId] = num
	end
end

function EquipLvUpView:_getSelectMatTypeCounts()
	local count = 0

	for id, num in pairs(self._selectedEquips) do
		if checknumber(num) > 0 then
			count = count + 1
		end
	end

	if self._selectedMatNum > 0 then
		count = count + 1
	end

	return count
end

function EquipLvUpView:_onClickClose()
	self:close()
end

function EquipLvUpView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function EquipLvUpView:_onClickEquip(starEquipItem, mo)
	if self._isInSwitch == true then
		self:_onSwitchEquip(mo)
	elseif self._equipMo == nil then
		FloatWordMgr.instance:show("请先选择要升级的星辉")
	elseif self._targetLv == StarEquipmentConfig.MaxStarEquipmentLv then
		FloatWordMgr.instance:show("已经满级了，不能再吃星辉了")
	elseif self:getSelectedNum(mo.matType, mo.matId) == 0 and self:_getSelectMatTypeCounts() >= 6 then
		FloatWordMgr.instance:show("一次性最多只能添加6种升级材料哦！")
	else
		local selectedNum = self:getSelectedNum(mo.matType, mo.matId)

		if selectedNum < mo.num then
			selectedNum = selectedNum + 1

			self:setSelectedNum(mo.matType, mo.matId, selectedNum)
			starEquipItem:setSelectedNum(selectedNum)
			self:_updateTargetUI()
			self:_updateOneMatItem(mo.matType, mo.matId, selectedNum)
		end

		return true
	end

	return false
end

function EquipLvUpView:_onClickCostMats(matType, matId)
	local selectedNum = self:getSelectedNum(matType, matId)

	if selectedNum > 0 then
		selectedNum = selectedNum - 1

		self:setSelectedNum(matType, matId, selectedNum)
		self:_updateOneMatItem(matType, matId, selectedNum)
		self:_updateStarEquipItem(matType, matId)
		self:_updateTargetUI()
	end
end

function EquipLvUpView:_updateStarEquipItem(matType, matId)
	for k, v in ipairs(self._curViewDatas) do
		if v.matType == matType and v.matId == matId then
			self._tableview:UpdateCellAtIndex(k - 1)
		end
	end
end

function EquipLvUpView:_updateStarEquipItemByMo(mo)
	for k, v in ipairs(self._curViewDatas) do
		if v == mo then
			self._tableview:UpdateCellAtIndex(k - 1)
		end
	end
end

function EquipLvUpView:_onClickUpgrade()
	if self:_getSelectMatTypeCounts() == 0 then
		FloatWordMgr.instance:show("请先选择消耗的材料")
	elseif not self._isGoldEnough then
		FloatWordMgr.instance:show("当前金币不足！")
	else
		local otherEquipments_pb_Ary = {}

		for id, num in pairs(self._selectedEquips) do
			local otherEquipments = StarEquipmentExtension_pb.SE_UpgradePair()

			otherEquipments.equipmentId = id
			otherEquipments.num = num

			table.insert(otherEquipments_pb_Ary, otherEquipments)
		end

		self._preMo = self._petMo:GetClone()
		self._beforeStarLv = self._petMo._starLevel
		self._preLv = self._equipMo.level

		StarEquipmentAgent.instance:sendSE_UpgradeReq(self._petMo.petId, self._slotIndex - 1, self._equipMo.equipmentId, self._selectedMatNum, otherEquipments_pb_Ary, self._onUpgradeFinished, self)
	end
end

function EquipLvUpView:_onUpgradeFinished()
	FloatWordMgr.instance:show("星辉升级成功了呢")
	self:_updateUI()

	if self._petMo._starLevel == self._beforeStarLv then
		if self._equipMo.level > self._preLv then
			UIStateManager.instance:open(ViewName.PetUp, GameEnum.PetUpType.PetEquipLvup, self._petMo, self._preMo, {
				preLv = self._preLv,
				equipMo = self._equipMo
			})
		end
	else
		self:close()
		BagPetsFacade.instance:checkAndOpenPetUp(self._petMo, self._preMo)
	end
end

function EquipLvUpView:_getCostFilterType(i)
	return self._costFilter:getIsChecked(i)
end

function EquipLvUpView:_onClickOnekey()
	if self._equipMo == nil then
		FloatWordMgr.instance:show("请先选择要升级的星辉")

		return
	end

	local costFilterChecked = false

	for i = costMatEnum.Common, costMatEnum.Purple do
		if self:_getCostFilterType(i) then
			costFilterChecked = true

			break
		end
	end

	if not costFilterChecked then
		FloatWordMgr.instance:show("请先选择消耗的材料")

		return
	end

	local maxLv = StarEquipmentConfig.MaxStarEquipmentLv
	local needExp = StarEquipmentConfig.instance:getTargetLvNeedExp(self._equipMo.equipmentId, self._equipMo.totalExp, maxLv)
	local curAddExp = self:_getCurAddExp()

	needExp = needExp - curAddExp

	local curViewDatas = self:getCurViewDatas(2)
	local hasMat = false
	local i = 1

	while i <= #curViewDatas and needExp > 0 and self:_getSelectMatTypeCounts() <= 6 do
		local data = curViewDatas[i]

		hasMat = hasMat or data.num > 0

		local selectedNum
		local addExpPer = 0

		if data.matType == MatType.Item then
			addExpPer = StarEquipmentConfig.instance:getEquipUpMatExp()
		elseif data.matType == MatType.StarEquipment then
			addExpPer = data.cfg.provideExp
		end

		if addExpPer > 0 then
			local curSelectedNum = self:getSelectedNum(data.matType, data.matId)
			local leftNum = data.num - curSelectedNum

			selectedNum = needExp >= addExpPer * leftNum and leftNum or math.ceil(needExp / addExpPer)
			needExp = needExp - selectedNum * addExpPer

			self:setSelectedNum(data.matType, data.matId, selectedNum + curSelectedNum)
			self:_updateOneMatItem(data.matType, data.matId, selectedNum + curSelectedNum)
		end

		i = i + 1
	end

	if not hasMat then
		FloatWordMgr.instance:show("当前没有对应材料哦")
	end

	self:reloadData()
	self:_updateTargetUI()
end

function EquipLvUpView:_onClickOnekeyTakeOff()
	self:_clearSelectedMats()
	self:_updateCostMats()
	self:reloadData()
	self:_updateTargetUI()
end

function EquipLvUpView:_getEquipFilterType(i)
	return self._equipFilter:getIsAllSame() or self._equipFilter:getIsChecked(i)
end

function EquipLvUpView:_updateEquipList()
	self._curViewDatas = self:getCurViewDatas(1)

	self:reloadData()
end

function EquipLvUpView:_onLongPressMat(matType, matId, isUp)
	if not isUp then
		self._longPressMatType = matType
		self._longPressMatId = matId

		settimer(0, self._onLongPressMatTick, self)
	else
		self._longPressMatType = nil
		self._longPressMatId = nil

		removetimer(self._onLongPressMatTick, self)
	end
end

function EquipLvUpView:_onLongPressMatTick()
	self:_onClickCostMats(self._longPressMatType, self._longPressMatId)
end

function EquipLvUpView:_onLongPressEquip(starEquipItem, equipMo, isUp)
	if not isUp then
		self._longPressEquipItem = starEquipItem
		self._longPressEquipMo = equipMo

		settimer(0, self._onLongPressEquipTick, self)
	else
		self._longPressEquipItem = nil
		self._longPressEquipMo = nil

		removetimer(self._onLongPressEquipTick, self)
	end
end

function EquipLvUpView:_onLongPressEquipTick()
	local isSuccess = self:_onClickEquip(self._longPressEquipItem, self._longPressEquipMo)

	if not isSuccess then
		removetimer(self._onLongPressEquipTick, self)
	end
end

function EquipLvUpView:_onClickTakeOff()
	self._equipMo = nil
	self._petMo = nil
	self._slotIndex = 0
	self._equipmentId = 0

	self:_updateUI()
end

function EquipLvUpView:_onClickSwitch()
	return
end

function EquipLvUpView:_onSwitchEquip(mo)
	self._petMo = BagPetsController.instance:getPet(mo.petId)
	self._equipMo = mo.equipMo
	self._slotIndex = mo.slotIndex
	self._equipmentId = mo.equipMo.equipmentId

	self:_updateCurEquip()
	self:_updateTargetUI()

	local preMo = self._selectedMo

	self._selectedMo = mo

	if preMo ~= nil then
		self:_updateStarEquipItemByMo(preMo)
	end

	self:_updateStarEquipItemByMo(self._selectedMo)
end

function EquipLvUpView:_onClickSwitchNew(isLeft)
	local equipMo, slotIndex = self:_getNextEquipMo(isLeft)

	if equipMo ~= nil then
		self._slotIndex = slotIndex
		self._equipmentId = equipMo.equipmentId

		self:_updateUI()
	end
end

function EquipLvUpView:_getNextEquipMo(isLeft)
	local interval = isLeft and -1 or 1

	i = self._slotIndex + interval

	while i <= CharacterConfig.MAX_STAR_SLOT_COUNT and i >= 1 do
		local equipMo = self._petMo:getSlotEquip(i)

		if equipMo ~= nil then
			return equipMo, i
		end

		i = i + interval
	end

	return nil, -1
end

function EquipLvUpView:_onClickConfirm()
	self._isInSwitch = false

	self:_updateUI()
end

function EquipLvUpView:_onClickGet()
	UIStateManager.instance:clear(true)

	local cfg = ItemConfig.instance:getSourceCfg("10")

	GotoMgr.gotoByString(cfg.jumpTo)
end

function EquipLvUpView:_onClickBuy()
	UIStateManager.instance:clear(true)

	local cfg = ItemConfig.instance:getSourceCfg("6")

	GotoMgr.gotoByString(cfg.jumpTo)
end

return EquipLvUpView

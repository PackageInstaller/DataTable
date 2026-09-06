-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetOneKeyLvUpView.lua

module("logic.extensions.bag.view.PetOneKeyLvUpView", package.seeall)

local PetOneKeyLvUpView = class("PetOneKeyLvUpView", ViewComponent)

function PetOneKeyLvUpView:ctor()
	PetOneKeyLvUpView.super.ctor(self)
end

local AttrName = {
	[GameEnum.AttrType.Attack] = "_attack",
	[GameEnum.AttrType.DefensePhysical] = "_physicalDefence",
	[GameEnum.AttrType.DefenseMagic] = "_magicDefence",
	[GameEnum.AttrType.Hp] = "_maxHp",
	[GameEnum.AttrType.Speed] = "_speed"
}
local AttrRank = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic,
	GameEnum.AttrType.Speed,
	GameEnum.AttrType.HitRate,
	GameEnum.AttrType.DodgeRate,
	GameEnum.AttrType.StrikeRate,
	GameEnum.AttrType.BlockRate,
	GameEnum.AttrType.CriticalRate,
	GameEnum.AttrType.AntiCriticalRate
}

function PetOneKeyLvUpView:unbindEvents()
	PetOneKeyLvUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMinus)
	GameUtil.rmClickHandler(self._btnOneKey)
	self._sldAdjust:RemoveOnValueChanged()
end

function PetOneKeyLvUpView:bindEvents()
	PetOneKeyLvUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self._onClickClose, self))
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickSwitchPet, self, true))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickSwitchPet, self, false))
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._onClickAdjustBtn, self, true))
	GameUtil.addClickHandler(self._btnMinus, GameUtil.handler(self._onClickAdjustBtn, self, false))
	GameUtil.addClickHandler(self._btnOneKey, GameUtil.handler(self._onClickBtnOneKey, self, false))
	self._sldAdjust:AddOnValueChanged(self._onAdjustOneKeyLv, self)
end

function PetOneKeyLvUpView:buildUI()
	PetOneKeyLvUpView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._itemPos = self:getGo("info/itemPos")
	self._btnLeft = self:getGo("info/btnLeft")
	self._btnRight = self:getGo("info/btnRight")
	self._txtItemName = self:getTxt("info/txtItemName")
	self._showLvUp = self:getGo("showLvUp")
	self._txtZdlBeforeLvUp = self:getTxt("showLvUp/leftNode/txtZdlBefore")
	self._txtExpLvUp = self:getTxt("showLvUp/leftNode/txtExp")
	self._txtLvAfterLvUpInfo = self:getTxt("showLvUp/leftNode/txtLvAfter")
	self._txtZdlAfterLvUp = self:getTxt("showLvUp/leftNode/txtZdlAfter")
	self._txtLvBeforeLvUpInfo = self:getTxt("showLvUp/leftNode/txtLvBefore")
	self._attr_childLvUp = self:getGo("showLvUp/leftNode/attrsLayout/attr_child")
	self._attrsLayoutLvUp = self:getGo("showLvUp/leftNode/attrsLayout"):GetComponent("UILayoutSingleLine")
	self._sldExpLvUp = self:getSlider("showLvUp/leftNode/sldExp")
	self._btnOneKey = self:getGo("showLvUp/btnOneKey")
	self._btnMinus = self:getGo("showLvUp/btnMinus")
	self._btnAdd = self:getGo("showLvUp/btnAdd")
	self._sldAdjust = self:getSlider("showLvUp/sldAdjust")
	self._txtAfterLvUp = self:getTxt("showLvUp/txtAfter")
	self._txtCostCoincost = self:getTxt("showLvUp/txtCostCoincost")
	self._txtLvBeforeLvUp = self:getTxt("showLvUp/txtLvBefore")
	self._txtLvAfterLvUp = self:getTxt("showLvUp/txtLvAfter")
	self._showOnly = self:getGo("showOnly")
	self._txtTipsShowOnly = self:getTxt("showOnly/txtTips")
	self._attrsLayoutShowOnly = self:getGo("showOnly/attrsLayout"):GetComponent("UILayoutSingleLine")
	self._txtLvShowOnly = self:getTxt("showOnly/txtLv")
	self._txtZdlShowOnly = self:getTxt("showOnly/txtZdl")
	self._attr_childShowOnly = self:getGo("showOnly/attrsLayout/attr_child")

	local itemcellCost = self:getGo("costMat/itemcell")
	local tableviewCost = self:getGo("costMat/tableview")

	self._tableviewCost = ScrollerList.create(tableviewCost, itemcellCost, GameUtil.handler(self._updateCellCost, self), GameUtil.handler(self._clearCellCost, self))
	self._emptyCost = self:getGo("costMat/empty")

	self:_buildAttrs()
	self:_buildExpCost()
end

function PetOneKeyLvUpView:_buildAttrs()
	local attrList = {}

	table.insert(attrList, GameEnum.AttrType.Attack)
	table.insert(attrList, GameEnum.AttrType.DefensePhysical)
	table.insert(attrList, GameEnum.AttrType.DefenseMagic)
	table.insert(attrList, GameEnum.AttrType.Hp)
	table.insert(attrList, GameEnum.AttrType.Speed)

	self._attrCellMap = {}

	for i = 1, #attrList do
		local attrType = attrList[i]
		local attrField = AttrName[attrType]
		local cell = {}
		local path = "attr" .. attrField
		local childAttrLvUp = goutil.findChild(self._attrsLayoutLvUp.gameObject, path)

		if not childAttrLvUp then
			childAttrLvUp = goutil.cloneAndSetParent(self._attr_childLvUp, self._attrsLayoutLvUp.transform, path)

			goutil.setActive(childAttrLvUp, true)
		end

		cell.childAttrLvUp = childAttrLvUp

		local txtNameLvUp = goutil.findChildTextComponent(childAttrLvUp, "txtName")

		txtNameLvUp.text = ConstString.Attr[attrType]
		cell.txtBefore = goutil.findChildTextComponent(childAttrLvUp, "txtBefore")
		cell.txtAfter = goutil.findChildTextComponent(childAttrLvUp, "txtAfter")
		cell.bgLvUp = goutil.findChild(childAttrLvUp, "bg")
		cell.iconAttrLvUp = goutil.findChildComponent(childAttrLvUp, "icon", "UIImageSpriteChange")

		local childAttrShow = goutil.findChild(self._attrsLayoutShowOnly, path)

		if not childAttrShow then
			childAttrShow = goutil.cloneAndSetParent(self._attr_childShowOnly, self._attrsLayoutShowOnly.transform, path)

			goutil.setActive(childAttrShow, true)
		end

		cell.childAttrShow = childAttrShow

		local txtNameShow = goutil.findChildTextComponent(childAttrShow, "txtName")

		txtNameShow.text = ConstString.Attr[attrType]
		cell.txtValue = goutil.findChildTextComponent(childAttrShow, "txtValue")
		cell.bgShow = goutil.findChild(childAttrShow, "bg")
		cell.iconAttrShow = goutil.findChildComponent(childAttrShow, "icon", "UIImageSpriteChange")

		if i % 2 == 1 then
			goutil.setActive(cell.bgShow, true)
			goutil.setActive(cell.bgLvUp, true)
		else
			goutil.setActive(cell.bgShow, false)
			goutil.setActive(cell.bgLvUp, false)
		end

		self._attrCellMap[attrType] = cell
	end

	self._attrsLayoutLvUp:Layout()
	self._attrsLayoutShowOnly:Layout()
	goutil.setActive(self._attr_childLvUp, false)
	goutil.setActive(self._attr_childShowOnly, false)
end

function PetOneKeyLvUpView:_buildExpCost()
	local expMatId = {
		2,
		3,
		25
	}

	self._expMatCellList = {}

	for i, matId in ipairs(expMatId) do
		local cell = {}

		cell.go = self:getGo("costMat/expCost/cell_" .. i)
		cell.itemPos = goutil.findChild(cell.go, "item")
		cell.txtNum = goutil.findChildTextComponent(cell.go, "txtNum")
		cell.txtExp = goutil.findChildTextComponent(cell.go, "txtExp")
		cell.mask = goutil.findChild(cell.go, "mask")

		local cfg = MaterialConfig.instance:getCfgByMatAndId(MatType.Item, matId)
		local addExp = 0

		if cfg then
			addExp = checknumber(cfg.content)
		end

		cell.txtExp.text = "经验+" .. addExp
		cell.addExp = addExp
		cell.matId = matId

		table.insert(self._expMatCellList, cell)
	end
end

function PetOneKeyLvUpView:onExit()
	PetOneKeyLvUpView.super.onExit(self)
	MaterialMgr.resetAll(self._itemPos)

	for i, cell in ipairs(self._expMatCellList) do
		MaterialMgr.resetAll(cell.itemPos)
	end

	self._tableviewCost:dispose()
end

function PetOneKeyLvUpView:onEnter()
	PetOneKeyLvUpView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BagPetAttrChanged, self._updatePetList, self)
	self.addGEvent(self, GlobalNotify.BagPetsInit, self._updatePetList, self)
	self.addGEvent(self, GlobalNotify.OnPetSelect, self._updatePetInfoByPerfectLv, self)
	self.addGEvent(self, GlobalNotify.PM_LevelUpWithTalentLvRes, self._onUpgradeSuccess, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._onMatCountChange, self)
	self.addGEvent(self, GlobalNotify.OnViewClose, self._onViewClose, self)

	for i, cell in ipairs(self._expMatCellList) do
		cell.txtNum.text = ""

		local proxy = MaterialMgr.setCell(MatType.Item, cell.matId, cell.itemPos)

		if proxy then
			proxy.binder:setNum(0)
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				MaterialMgr.openGetSource(MatType.Item, cell.matId)
			end)
		end
	end

	self:_updatePetList()

	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Coin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)

	self._canGainMap = {}
end

function PetOneKeyLvUpView:_updatePetList()
	self._curIndex = -1

	local curPetMo = BagPetsController.instance:GetCurPetMo()
	local list = BagModel.instance:getCurPetViewList()

	self._curViewDatas = list and list or BagPetsController.instance:getBagPets()
	curPetMo = curPetMo or self._curViewDatas[1]

	for i, petMo in ipairs(self._curViewDatas) do
		if petMo.petId == curPetMo.petId then
			self._curIndex = i

			break
		end
	end

	self:_updatePetInfoByPerfectLv()
end

function PetOneKeyLvUpView:_updatePetInfoByPerfectLv()
	local curPetMo = BagPetsController.instance:GetCurPetMo()

	if self:_checkAbleToLvUp() then
		self._copyPetMo = curPetMo:GetClone()
		self._copyPetMo.level = self:_getPerfectLV()
	else
		self._copyPetMo = nil
	end

	self:_updatePetInfo()
end

function PetOneKeyLvUpView:_updatePetInfo()
	goutil.setActive(self._btnLeft, self._curIndex > 1)
	goutil.setActive(self._btnRight, self._curIndex < #self._curViewDatas)

	local curPetMo = BagPetsController.instance:GetCurPetMo()

	MaterialMgr.resetAll(self._itemPos)
	MaterialMgr.setCell(MatType.Pet, curPetMo.curFaceId, self._itemPos)

	self._txtItemName.text = curPetMo:getName()

	goutil.setActive(self._showLvUp, self._copyPetMo)
	goutil.setActive(self._showOnly, not self._copyPetMo)
	self:_updateCurPetAttrs()
	self:_onAdjustOneKeyLv(self._copyPetMo and self._copyPetMo:getPetLv())
end

function PetOneKeyLvUpView:_getPerfectLV()
	local curPetMo = BagPetsController.instance:GetCurPetMo()
	local branch = GuideModel.instance:getGuideBranch(37)

	if branch and not branch:isFinished() then
		return 10
	end

	local curLv = curPetMo:getPetLv()
	local lvMax = CharacterConfig.instance:GetMaxLevel(curPetMo:getDefineId())
	local perfectLv = curLv
	local totalOwnExp = self:_getTotalOwnExp()
	local curPetExp = curPetMo:getCurExp()
	local lastTalentLevel = curPetMo:getTalentLevel()
	local curCoinNum = 0

	for i = curLv + 1, lvMax do
		local totalNeedExp = CharacterConfig.instance:GetCurLevelExp(curPetMo:getDefineId(), i)

		if totalOwnExp < totalNeedExp - curPetExp then
			break
		end

		local talentLevel = CharacterConfig.instance:getTalentLevelByLevel(i)

		if talentLevel > curPetMo:getTalentLevel() and lastTalentLevel ~= talentLevel then
			local cfg = CharacterConfig.instance:getPetTalentCfg(curPetMo:getDefineId(), math.max(0, talentLevel - 1))
			local isCostMatEnough = true
			local itemArr = MaterialMgr.changeItemStrArr(cfg.materialCost)

			for _, str in ipairs(itemArr) do
				if not MaterialMgr.getMatEnough(str) then
					isCostMatEnough = false
				end
			end

			if not isCostMatEnough then
				break
			end

			curCoinNum = curCoinNum + cfg.upgradeCoinCost

			if curCoinNum > MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1) then
				break
			end
		end

		if totalOwnExp < totalNeedExp - curPetExp then
			break
		end

		perfectLv = i
	end

	return perfectLv
end

function PetOneKeyLvUpView:_getTotalOwnExp()
	local totalOwnExp = 0

	for i, cell in pairs(self._expMatCellList) do
		local ownNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, cell.matId)

		totalOwnExp = totalOwnExp + ownNum * cell.addExp
	end

	return totalOwnExp
end

function PetOneKeyLvUpView:_getNeedExpLvUp(Lv)
	local curPetMo = BagPetsController.instance:GetCurPetMo()
	local totalNeedExp = CharacterConfig.instance:GetCurLevelExp(curPetMo:getDefineId(), Lv)
	local curExp = curPetMo:getCurExp()

	return totalNeedExp - curExp
end

function PetOneKeyLvUpView:_checkAbleToLvUp()
	local curPetMo = BagPetsController.instance:GetCurPetMo()

	if curPetMo:isMaxLv() then
		return false
	end

	if curPetMo:isBorrowPet() then
		return false
	end

	if BagModel.instance:isPowerCrystalFollower(curPetMo.petId) then
		return false
	end

	return true
end

function PetOneKeyLvUpView:_updateCurPetAttrs()
	local curPetMo = BagPetsController.instance:GetCurPetMo()

	self._txtZdlBeforeLvUp.text = curPetMo:getFightingPower()
	self._txtLvBeforeLvUpInfo.text = "Lv." .. curPetMo:getPetLv()
	self._txtLvBeforeLvUp.text = "Lv." .. curPetMo:getPetLv()
	self._txtZdlShowOnly.text = curPetMo:getFightingPower()
	self._txtLvShowOnly.text = "Lv." .. curPetMo:getPetLv()

	if curPetMo:isMaxLv() then
		self._txtLvShowOnly.text = "已满级"
	end

	for type, cell in pairs(self._attrCellMap) do
		local showStr = GameUtil.GetPropertyValue(type, curPetMo[AttrName[type]])

		cell.txtBefore.text = showStr
		cell.txtValue.text = showStr

		local attrRank = self:_getAttrRank(type)

		cell.iconAttrLvUp:SetState(attrRank - 1)
	end

	self._sldAdjust.slider.minValue = curPetMo:getPetLv()
	self._sldAdjust.slider.maxValue = CharacterConfig.instance:GetMaxLevel(curPetMo:getDefineId())
	self._txtExpLvUp.text = string.format("%s/%s", curPetMo:getCurExceedExp(), curPetMo:getNextLvlExp())

	self._sldExpLvUp:SetValue(curPetMo:getCurExceedExp() / curPetMo:getNextLvlExp())
end

function PetOneKeyLvUpView:_getAttrRank(lang)
	for k, v in pairs(AttrRank) do
		if v == lang then
			return k
		end
	end

	return 1
end

function PetOneKeyLvUpView:_updateNewPetAttrs()
	if self._copyPetMo then
		self._copyPetMo:calcAllAttr()

		self._txtZdlAfterLvUp.text = self._copyPetMo:getFightingPower()
		self._txtLvAfterLvUpInfo.text = "Lv." .. self._copyPetMo:getPetLv()
		self._txtLvAfterLvUp.text = "Lv." .. self._copyPetMo:getPetLv()

		for type, cell in pairs(self._attrCellMap) do
			local showStr = GameUtil.GetPropertyValue(type, self._copyPetMo[AttrName[type]])
			local attrRank = self:_getAttrRank(type)

			cell.iconAttrShow:SetState(attrRank - 1)

			cell.txtAfter.text = showStr
		end
	end
end

function PetOneKeyLvUpView:_getTalentCost(lv)
	local costMatStr = ""
	local costCoinNum = 0
	local curPetMo = BagPetsController.instance:GetCurPetMo()

	if curPetMo then
		local curTalentLevel = curPetMo:getTalentLevel()
		local newTalentLevel = lv
		local totalLvUpNum = newTalentLevel - curTalentLevel

		for i = 1, totalLvUpNum do
			local cfg = CharacterConfig.instance:getPetTalentCfg(curPetMo:getDefineId(), math.max(0, curTalentLevel + i - 1))

			costMatStr = GameUtil.isEmptyString(costMatStr) and cfg.materialCost or costMatStr .. "#" .. cfg.materialCost
			costCoinNum = costCoinNum + cfg.upgradeCoinCost
		end
	end

	return costMatStr, costCoinNum
end

function PetOneKeyLvUpView:_updateCostMat()
	self._coinLack = 0

	goutil.setActive(self._txtCostCoincost.gameObject, true)

	if self._copyPetMo then
		local costMatStr, costCoinNum = self:_getTalentCost(self._copyPetMo:getTalentLevel())
		local dataList = MaterialMgr.changeItemStrArr(costMatStr)

		self._costMatDatalist = dataList or {}

		self._tableviewCost:reloadData(dataList)
		self._tableviewCost:MoveCellInView(#dataList - 1)

		if #dataList > 0 then
			local coinNum = MaterialModel.instance:getMaterialsNumber(MatType.Coin, 1)

			self._txtCostCoincost.text = costCoinNum <= coinNum and string.format("<color=#%s>%s</color>", ColorConst.Green, costCoinNum) or string.format("<color=#%s>%s</color>", ColorConst.Red, costCoinNum)
			self._coinLack = costCoinNum - coinNum
		else
			self._txtCostCoincost.text = ""

			goutil.setActive(self._txtCostCoincost.gameObject, false)
		end
	else
		self._txtCostCoincost.text = ""

		goutil.setActive(self._txtCostCoincost.gameObject, false)
		self._tableviewCost:reloadData({})
	end
end

function PetOneKeyLvUpView:_getCurCostExpItemNum(lv)
	local costNumList = {
		0,
		0,
		0
	}
	local curPetMo = BagPetsController.instance:GetCurPetMo()
	local curPetLv = curPetMo and curPetMo:getPetLv() or 0

	if curPetLv < lv then
		local temExp = self:_getNeedExpLvUp(lv)

		for i, cell in pairs(self._expMatCellList) do
			local ownNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, cell.matId)
			local totalExp = ownNum * cell.addExp

			if totalExp <= temExp then
				costNumList[i] = ownNum
				temExp = temExp - totalExp
			else
				costNumList[i] = math.ceil(temExp / cell.addExp)
				temExp = 0

				break
			end
		end

		if temExp > 0 then
			costNumList[1] = costNumList[1] + math.ceil(temExp / self._expMatCellList[1].addExp)
		end
	end

	return costNumList
end

function PetOneKeyLvUpView:_updateExpCost()
	local newLv = 0

	self._expLack = 0

	if self._copyPetMo then
		newLv = self._copyPetMo:getPetLv()
	end

	self._expLack = self:_getNeedExpLvUp(newLv) - self:_getTotalOwnExp()

	local curCostExpItemNum = self:_getCurCostExpItemNum(newLv)

	for i, cell in ipairs(self._expMatCellList) do
		goutil.setActive(cell.mask, false)

		local num = curCostExpItemNum[i]
		local ownNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, cell.matId)

		if ownNum <= 0 then
			goutil.setActive(cell.mask, true)
		end

		if num <= 0 then
			num = 0
		end

		if ownNum < num then
			cell.txtNum.text = string.format("<color=#%s>%s</color>/%s", ColorConst.Red, ownNum, num)

			goutil.setActive(cell.mask, true)
		else
			cell.txtNum.text = string.format("<color=#%s>%s</color>/%s", ColorConst.Green, ownNum, num)
		end
	end
end

function PetOneKeyLvUpView:_onClickClose()
	self:close()
end

function PetOneKeyLvUpView:_onClickSwitchPet(isLeft)
	self._curIndex = isLeft and self._curIndex - 1 or self._curIndex + 1

	local mo = self._curViewDatas[self._curIndex]

	BagPetsController.instance:SetCurPetId(mo.petId)
	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
end

function PetOneKeyLvUpView:_onAdjustOneKeyLv(afterLv)
	if self._copyPetMo then
		local curPetMo = BagPetsController.instance:GetCurPetMo()
		local minLv = curPetMo:getPetLv()
		local maxLv = CharacterConfig.instance:GetMaxLevel(curPetMo:getDefineId())
		local legalLv = Mathf.Clamp(afterLv, minLv, maxLv)

		self._copyPetMo.level = legalLv
		self._copyPetMo.talentLevel = CharacterConfig.instance:getTalentLevelByLevel(legalLv)

		self._sldAdjust:SetValue(legalLv)
		self:_updateNewPetAttrs()
		goutil.setActive(self._emptyCost, legalLv <= minLv)
	else
		goutil.setActive(self._emptyCost, true)
	end

	self:_updateExpCost()
	self:_updateCostMat()
end

function PetOneKeyLvUpView:_onClickAdjustBtn(isAdd)
	if self._copyPetMo then
		local curLevel = self._copyPetMo:getPetLv()

		if isAdd then
			if not (curLevel + 1) then
				local newLevel = curLevel - 1

				self:_onAdjustOneKeyLv(newLevel)
			end
		end
	end
end

function PetOneKeyLvUpView:_updateCellCost(view, cell, data)
	local itemPos = goutil.findChild(cell, "item")
	local mask = goutil.findChild(cell, "mask")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local costType, costId, costNum = MaterialMgr.getMatParams(data)
	local proxy = MaterialMgr.setCell(costType, costId, itemPos)

	goutil.setActive(mask, false)

	if proxy then
		proxy.binder:setNum(0)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			MaterialMgr.openGetSource(costType, costId)
		end)
		proxy.binder:SetGray(false)

		local curCount = MaterialMgr.getMatCount(data)

		if MaterialMgr.getMatEnough(data) then
			txtNum.text = string.format("<color=#%s>%s</color>/%s", ColorConst.Green, curCount, costNum)
		else
			txtNum.text = string.format("<color=#%s>%s</color>/%s", ColorConst.Red, curCount, costNum)

			goutil.setActive(mask, true)

			if not self:_getIsCanGain(costId) then
				proxy.binder:SetGray(true)
				goutil.setActive(mask, false)
			end
		end
	end
end

function PetOneKeyLvUpView:_clearCellCost(cell)
	local itemPos = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(itemPos)
end

function PetOneKeyLvUpView:_getIsCanGain(costId)
	local isCanGain = self._canGainMap[costId]

	if isCanGain == nil then
		self._canGainMap[costId] = PlotCopyModel.instance:isOneWaySweepExistAtLeast(MatType.Item, costId)
	end

	return self._canGainMap[costId]
end

function PetOneKeyLvUpView:_onClickBtnOneKey()
	if not self:_checkAbleToLvUp() then
		return
	end

	if self._copyPetMo then
		local curPetMo = BagPetsController.instance:GetCurPetMo()
		local curLv = curPetMo:getPetLv()
		local newLv = self._copyPetMo:getPetLv()

		if newLv <= curLv then
			return
		end

		if self._coinLack > 0 or self._expLack > 0 then
			local newLv = self._copyPetMo:getPetLv()
			local costMatStr, costCoinNum = self:_getTalentCost(self._copyPetMo:getTalentLevel())

			UIStateManager.instance:push(ViewName.MatResSweepView, costCoinNum, self:_getNeedExpLvUp(newLv))

			return
		end

		local isAllCanGain = true
		local costMatStrLack = ""

		for i, matCost in ipairs(self._costMatDatalist) do
			local costType, costId, costNum = MaterialMgr.getMatParams(matCost)

			if costNum > MaterialModel.instance:getMaterialsNumber(costType, costId) then
				if not self:_getIsCanGain(costId) then
					isAllCanGain = false

					break
				end

				costMatStrLack = GameUtil.isEmptyString(costMatStrLack) and matCost or costMatStrLack .. "#" .. matCost
			end
		end

		if not GameUtil.isEmptyString(costMatStrLack) then
			if isAllCanGain then
				FloatWordMgr.instance:show("当前材料不足")
				MopupModel.instance:setPetTalentUpCostStr(costMatStrLack)
				MopupModel.instance:clickOneKeySweep(costMatStrLack)
			else
				FloatWordMgr.instance:show("材料不足，有部分突破材料无法获取，请尝试推进主线关卡吧！")
			end

			return
		end

		local useItems_pb_Ary = {}
		local curExpMatNums = self:_getCurCostExpItemNum(newLv)

		for i, cell in ipairs(self._expMatCellList) do
			local useItem = PetExtension_pb.LevelUpWithTalentLvUseItem()

			useItem.num = curExpMatNums[i]
			useItem.itemId = cell.matId

			if useItem.num > 0 then
				table.insert(useItems_pb_Ary, useItem)
			end
		end

		self._preMo = curPetMo:GetClone()

		PetAgent.instance:sendPM_LevelUpWithTalentLvReq(curPetMo:getId(), newLv, useItems_pb_Ary)
	end
end

function PetOneKeyLvUpView:_onUpgradeSuccess()
	if self._preMo then
		local curMo = BagPetsController.instance:GetCurPetMo()

		BagPetsFacade.instance:checkAndOpenPetUp(curMo, self._preMo)
	end
end

function PetOneKeyLvUpView:_onMatCountChange()
	self:_updateExpCost()
	self:_updateCostMat()
end

function PetOneKeyLvUpView:_onViewClose(view)
	if view.viewName == ViewName.MatResSweepView then
		local btn_list = {
			{
				showAdd = false,
				id = GameEnum.GoldType.Coin
			}
		}

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
	end
end

return PetOneKeyLvUpView

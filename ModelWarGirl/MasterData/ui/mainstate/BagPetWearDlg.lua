-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagPetWearDlg.lua

local ResPetMisc = require("ClientData/ResPetMisc")
local ResPetStar = require("ClientData/ResPetStar")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local EventConst = require("EventConst")
local PetAmuletCell = Class("BagPetWearDlg_PetAmuletCell", UIControls.Panel)

function PetAmuletCell:ctor()
	self.imgRedDot = UIControls.Image(self, self.mPath .. "/IconNew")
	self.amuletCell = UIControls.GridPetSkillChild(self, self.mPath .. "/GridPetSkill", "System/Pet/GridPetSkill", 0, 0, true)

	self.amuletCell:setVisible(false)

	self.amuletCell.mEventClick = Slot(self.onClickAmuletCell, self)
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.fakeAmuletTipsFuncItem = UIControls.TipsConfig()

	self.fakeAmuletTipsFuncItem:addConfig(self, Lang.get(1602), self.onTakeOffAmulet, nil, self.onAmuletTakeOffCheck, 1)
	self.fakeAmuletTipsFuncItem:addConfig(self, Lang.get(1189), self.onReplaceAmulet, nil, self.onAmuletReplaceCheck, 2)
end

function PetAmuletCell:init(getAllCanWearPetAmuletListFunc, amuletChangeCb)
	self.getAllCanWearPetAmuletListFunc = getAllCanWearPetAmuletListFunc
	self.amuletChangeCb = amuletChangeCb
end

function PetAmuletCell:setData(isEditPlan, pet, index, amulet)
	self.isEditPlan = isEditPlan
	self.pet = pet
	self.index = index
	self.amulet = amulet

	local checkAmulet = self.amulet ~= nil and not amulet.isDefault

	if not checkAmulet then
		self.amulet = nil
	end

	self.amuletCell:setVisible(checkAmulet)

	if checkAmulet then
		self.amuletCell:setObj(self.amulet)
		self.amuletCell:hideIconState()
	end

	self.btn:setEnable(not checkAmulet)
	self:refreshRedDot()
end

function PetAmuletCell:refreshRedDot()
	local checkRed = false

	if self.isEditPlan then
		checkRed = (self.amulet == nil or self.amulet.isDefault) and #self.getAllCanWearPetAmuletListFunc(self.index) > 0
	else
		checkRed = self.amulet == nil and self.pet:checkCanWearAmuletByPos(self.index)
	end

	self.imgRedDot:setVisible(checkRed)
end

function PetAmuletCell:onClickBtn()
	if self.isEditPlan then
		local amuletList = self.getAllCanWearPetAmuletListFunc(self.index)

		UIManager.getUI("petAmuletWearDlg", true):setFakeData(self.amulet, self.index, self.pet.id, amuletList, self.amuletChangeCb)
	else
		UIManager.getUI("petAmuletWearDlg", true):setData(self.amulet, self.index, self.pet.id)
	end
end

function PetAmuletCell:onClickAmuletCell(sender)
	if self.isEditPlan then
		UIManager.getUI("petAmuletTips"):show(sender, self.fakeAmuletTipsFuncItem, nil, nil, {
			pet = self.pet
		})
	else
		UIManager.getUI("petAmuletTips"):show(sender, CurAvatar.commonAmuletTipsFuncItem, nil, nil)
	end
end

function PetAmuletCell:onTakeOffAmulet()
	self.amuletChangeCb(Const.PET_AMULET_TYPE_OFF, Const.PET_AMULET_POS_TYPE[self.index], self.pet.id, self.amulet.id)
end

function PetAmuletCell:onReplaceAmulet()
	self:onClickBtn()
end

function PetAmuletCell:onAmuletTakeOffCheck()
	return true
end

function PetAmuletCell:onAmuletReplaceCheck()
	return true
end

local PetGemCell = Class("BagPetWearDlg_PetGemCell", UIControls.Panel)

function PetGemCell:ctor()
	self.imgRedDot = UIControls.Image(self, self.mPath .. "/IconNew")
	self.lockPanel = UIControls.Panel(self, self.mPath .. "/PetGemLock")
	self.gemCell = UIControls.GridPetGemChild(self, self.mPath .. "/GridPetGem", "System/Pet/GridPetGem")

	self.gemCell:setVisible(false)

	self.gemCell.mEventClick = Slot(self.onClickGemCell, self)
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.fakeGemTipsFuncItem = UIControls.TipsConfig()

	self.fakeGemTipsFuncItem:addConfig(self, Lang.get(1602), Slot(self.onTakeOffGem, self), nil, Slot(self.onTakeOffGemCheck, self), 1)
	self.fakeGemTipsFuncItem:addConfig(self, Lang.get(1189), Slot(self.onReplaceGem, self), nil, Slot(self.onReplaceGemCheck, self), 2)
end

function PetGemCell:init(getAllCanWearPetGemListFunc, gemChangeCb)
	self.getAllCanWearPetGemListFunc = getAllCanWearPetGemListFunc
	self.gemChangeCb = gemChangeCb
end

function PetGemCell:setData(isEditPlan, pet, isOpen, gem)
	self.isEditPlan = isEditPlan
	self.pet = pet
	self.isOpen = isOpen
	self.gem = gem

	self.lockPanel:setVisible(not self.isOpen)

	local checkGem = self.isOpen and self.gem ~= nil

	self.gemCell:setVisible(checkGem)

	if checkGem then
		self.gemCell:setObj(self.gem)
		self.gemCell:hideIconState()
	end

	self.btn:setEnable(not self.isOpen or self.isOpen and self.gem == nil)
	self:refreshRedDot()
end

function PetGemCell:refreshRedDot()
	local checkRed = false

	if self.isEditPlan then
		checkRed = self.isOpen and self.gem == nil and #self.getAllCanWearPetGemListFunc() > 0
	else
		checkRed = self.isOpen and self.gem == nil and CurAvatar:checkIsHasGemNotWearing()
	end

	self.imgRedDot:setVisible(checkRed)
end

function PetGemCell:onClickBtn()
	if not self.isOpen then
		MsgManager.notice(string.format(ResClientNotice[771].notice, Const.PET_GEM_MAX_NUM))

		return
	end

	if self.isEditPlan then
		local gemList = self.getAllCanWearPetGemListFunc()

		UIManager.getUI("petGemWearDlg", true):setFakeData(self.gem, self.pet.id, gemList, self.gemChangeCb)
	else
		UIManager.getUI("petGemWearDlg", true):setData(self.gem, self.pet.id)
	end
end

function PetGemCell:onClickGemCell(sender)
	if self.isEditPlan then
		UIManager.getUI("petGemTips"):show(sender, self.fakeGemTipsFuncItem, nil, nil, {
			hideIconState = true,
			checkShowPetGemChange = false,
			pet = self.pet
		})
	else
		UIManager.getUI("petGemTips"):show(sender, CurAvatar.commonGemTipsFuncItem, nil, nil, {
			checkShowPetGemChange = true
		})
	end
end

function PetGemCell:onTakeOffGem()
	self.gemChangeCb(Const.PET_GEM_TYPE_OFF, self.pet.id, nil, self.gem.gid)
end

function PetGemCell:onReplaceGem()
	self:onClickBtn()
end

function PetGemCell:onTakeOffGemCheck()
	return true
end

function PetGemCell:onReplaceGemCheck()
	return true
end

local PetWearCellLoop = Class("BagPetWearDlg_PetWearCellLoop", UIControls.ScrollViewLoopCell)

function PetWearCellLoop:ctor()
	self.imgFight = UIControls.Image(self, "ImgOnField")
	self.gridPetCard = UIControls.PetCardChild(self, "PetInfo/GridPetCard", "System/Pet/GridPetCardMini")

	self.gridPetCard:setVisible(true)
	self.gridPetCard:setSelectCallback(Slot(self.onClickPetCard, self))

	self.txtPetName = UIControls.Label(self, "PetInfo/BgPetName/Text")
	self.petAmuletCellList = {}

	for i = 1, 2 do
		if UIControls.checkControlFunc(self, "PetSkillPanel/PetSkillGrid" .. i) then
			local petAmuletCell = PetAmuletCell(self, "PetSkillPanel/PetSkillGrid" .. i)

			table.insert(self.petAmuletCellList, petAmuletCell)
		end
	end

	self.petGemCellList = {}

	for i = 1, Const.PET_GEM_MAX_NUM do
		if UIControls.checkControlFunc(self, "PetGemPanel/PetGemGrid" .. i) then
			local petGemCell = PetGemCell(self, "PetGemPanel/PetGemGrid" .. i)

			table.insert(self.petGemCellList, petGemCell)
		end
	end

	self.slotOnAmuletChange = Slot(self.onAmuletChange, self)
	self.slotOnGemChange = Slot(self.onGemChange, self)
end

function PetWearCellLoop:init(getAllCanWearPetAmuletListCb, getAllCanWearPetGemListCb, wearChangeCb)
	for _, cell in pairs(self.petAmuletCellList) do
		cell:init(getAllCanWearPetAmuletListCb, self.slotOnAmuletChange)
	end

	for _, cell in pairs(self.petGemCellList) do
		cell:init(getAllCanWearPetGemListCb, self.slotOnGemChange)
	end

	self.wearChangeCb = wearChangeCb
end

function PetWearCellLoop:setData(isEditPlan, pet, petWear, fightPetId)
	self.pet = pet
	self.petWear = petWear
	self.isEditPlan = isEditPlan

	self.gridPetCard:setPet(self.pet)
	self.txtPetName:setText(self.pet.name)
	self.imgFight:setVisible(self.pet.id == fightPetId)
	self:refreshShow()
end

function PetWearCellLoop:refreshShow()
	self:refreshAmuletShow()
	self:refreshGemShow()
end

function PetWearCellLoop:refreshAmuletShow()
	local defaultAmulet = Const.PET_DEFAULT_AMULET
	local mainAmulet, assistAmulet
	local amuletList = {}

	if self.isEditPlan then
		mainAmulet = CurAvatar.petAmuletDic[self.petWear.amulet1] or BaseObject.GetObject(defaultAmulet)
		assistAmulet = CurAvatar.petAmuletDic[self.petWear.amulet2]
	else
		mainAmulet, assistAmulet = self.pet:getBattleFightAmulet()
	end

	mainAmulet.battleSkillId = mainAmulet.mainSkill
	mainAmulet.pos = 1

	if mainAmulet.id == defaultAmulet then
		mainAmulet.isDefault = true
	end

	if assistAmulet then
		assistAmulet.battleSkillId = assistAmulet.assistantSkill
		assistAmulet.pos = 2
	end

	amuletList = {
		mainAmulet,
		assistAmulet
	}

	for i, cell in ipairs(self.petAmuletCellList) do
		cell:setData(self.isEditPlan, self.pet, i, amuletList[i])
	end
end

function PetWearCellLoop:refreshGemShow()
	local gemNum = ResPetStar[self.pet.star].gem_num
	local petGemList = {}

	if self.isEditPlan then
		local gemIdList = self.petWear.gemList

		for _, id in ipairs(gemIdList) do
			if CurAvatar.petGemDic[id] then
				table.insert(petGemList, CurAvatar.petGemDic[id])
			end
		end
	else
		petGemList = self.pet:getBattlePetGem() or {}
	end

	for i, cell in ipairs(self.petGemCellList) do
		local checkOpen = i <= gemNum

		cell:setData(self.isEditPlan, self.pet, checkOpen, petGemList[i])
	end
end

function PetWearCellLoop:onAmuletChange(operateType, posType, petId, amuletId)
	if operateType == Const.PET_AMULET_TYPE_WEAR then
		if posType == Const.PET_AMULET_POS_TYPE[1] then
			self.petWear.amulet1 = amuletId
		elseif posType == Const.PET_AMULET_POS_TYPE[2] then
			self.petWear.amulet2 = amuletId
		end
	elseif operateType == Const.PET_AMULET_TYPE_OFF then
		if posType == Const.PET_AMULET_POS_TYPE[1] then
			self.petWear.amulet1 = nil
		elseif posType == Const.PET_AMULET_POS_TYPE[2] then
			self.petWear.amulet2 = nil
		end
	end

	self:refreshAmuletShow()
	self.wearChangeCb()
end

function PetWearCellLoop:onGemChange(operateType, petId, wearGemGid, offGemGid)
	local idx = 0

	if offGemGid then
		for i, gid in ipairs(self.petWear.gemList) do
			if gid == offGemGid then
				idx = i

				break
			end
		end
	else
		idx = #self.petWear.gemList + 1
	end

	if operateType == Const.PET_GEM_TYPE_WEAR then
		local gem = CurAvatar.petGemDic[wearGemGid]

		if gem then
			self.petWear.gemList[idx] = wearGemGid
		end
	elseif operateType == Const.PET_GEM_TYPE_OFF then
		table.remove(self.petWear.gemList, idx)
	end

	self:refreshGemShow()
	self.wearChangeCb()
end

function PetWearCellLoop:onClickPetCard()
	if self.isEditPlan then
		MsgManager.clientNotice(772)
	else
		UIManager.getUI("petInfoTips", true):_setObj(self.pet)
	end
end

local BagPetWearDlg = Class("BagPetWearDlg", UIControls.Window)

function BagPetWearDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.txtPlanName = UIControls.Label(self, "InfoPanel/BgProgramName/TextProgramName")
	self.scrollPet = UIControls.ScrollViewLoopV(self, "InfoPanel/ItemListScroll")

	self.scrollPet:addEventCellChanged(self.onScrollPetCellChange)

	self.btnEquipOff = UIControls.Button(self, "InfoPanel/BtnEquipOff")

	self.btnEquipOff:addEventClick(self.onClickBtnEquipOff)

	self.btnSave = UIControls.Button(self, "InfoPanel/BtnSave")

	self.btnSave:addEventClick(self.onClickBtnSave)

	self.petCellDic = {}
	self.slotGetAllCanWearPetAmuletList = Slot(self.getAllCanWearPetAmuletList, self)
	self.slotGetAllCanWearPetGemList = Slot(self.getAllCanWearPetGemList, self)
	self.slotOnWearChange = Slot(self.onWearChange, self)
	self.slotOnPetGemChange = Slot(self.onPetGemChange, self)

	EventCenter.addEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
end

function BagPetWearDlg:destroy()
	EventCenter.removeEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
	BagPetWearDlg.super.destroy(self)
end

function BagPetWearDlg:setData(isEditPlan, planId, fightPetId)
	self.isEditPlan = isEditPlan
	self.planId = planId
	self.fightPetId = fightPetId
	self.checkWearChange = false

	self:refreshData()
end

function BagPetWearDlg:refreshData()
	if self.isEditPlan then
		local planData = CurAvatar:getEquipPlanData(self.planId)

		self.planData = utils.deepcopy(planData)
		self.petWearDic = utils.deepcopy(self.planData.petWearDic)

		for _, pet in ipairs(CurAvatar.petList) do
			local petId = pet.id

			self.petWearDic[petId] = self.petWearDic[petId] or {}
			self.petWearDic[petId].amulet1 = self.petWearDic[petId].amulet1
			self.petWearDic[petId].amulet2 = self.petWearDic[petId].amulet2
			self.petWearDic[petId].gemList = self.petWearDic[petId].gemList or {}
		end
	end

	self.petList = {}

	for _, pet in ipairs(CurAvatar.petList) do
		table.insert(self.petList, pet)
	end

	if self.isEditPlan then
		self.slotEditSortPet = self.slotEditSortPet or Slot(self.editSortPet, self)

		table.sort(self.petList, self.slotEditSortPet)
	else
		self.slotSortPet = self.slotSortPet or Slot(self.sortPet, self)

		table.sort(self.petList, self.slotSortPet)
	end

	self:refreshShow()
end

function BagPetWearDlg:refreshShow()
	self.txtPlanName:setText(not self.isEditPlan and Lang.get(98965) or self.planData.name)
	self.scrollPet:setTotalCount(#self.petList)
	self:refreshBtns()
end

function BagPetWearDlg:editSortPet(pet1, pet2)
	if pet1.id == self.fightPetId then
		return true
	end

	if pet2.id == self.fightPetId then
		return false
	end

	local checkPet1Wear = CurAvatar:checkPetHaveWearInPlanPetWearDic(self.petWearDic, pet1.id)
	local checkPet2Wear = CurAvatar:checkPetHaveWearInPlanPetWearDic(self.petWearDic, pet2.id)

	if checkPet1Wear and not checkPet2Wear then
		return true
	end

	if checkPet1Wear and not checkPet2Wear then
		return true
	end

	if checkPet2Wear and not checkPet1Wear then
		return false
	end

	if pet1.quality ~= pet2.quality then
		return pet1.quality > pet2.quality
	end

	if pet1.star ~= pet2.star then
		return pet1.star > pet2.star
	end

	return pet1.id < pet2.id
end

function BagPetWearDlg:sortPet(pet1, pet2)
	if pet1.id == self.fightPetId then
		return true
	end

	if pet2.id == self.fightPetId then
		return false
	end

	local checkPet1Wear = pet1:checkHaveWear()
	local checkPet2Wear = pet2:checkHaveWear()

	if checkPet1Wear and not checkPet2Wear then
		return true
	end

	if checkPet1Wear and not checkPet2Wear then
		return true
	end

	if checkPet2Wear and not checkPet1Wear then
		return false
	end

	if pet1.quality ~= pet2.quality then
		return pet1.quality > pet2.quality
	end

	if pet1.star ~= pet2.star then
		return pet1.star > pet2.star
	end

	return pet1.id < pet2.id
end

function BagPetWearDlg:onScrollPetCellChange(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = PetWearCellLoop(sender, "System/Pet/BtnPetWearingPanel", newIdx)
	else
		targetCell.mIndex = newIdx
	end

	local pet = self.petList[newIdx]
	local petWear = self.isEditPlan and self.petWearDic[pet.id]

	targetCell:init(self.slotGetAllCanWearPetAmuletList, self.slotGetAllCanWearPetGemList, self.slotOnWearChange)
	targetCell:setData(self.isEditPlan, pet, petWear, self.fightPetId)

	self.petCellDic[targetCell] = pet
end

function BagPetWearDlg:refreshBtns()
	self.btnEquipOff:setVisible(true)
	self.btnSave:setVisible(self.isEditPlan and self.checkWearChange)
end

function BagPetWearDlg:onWearChange()
	self.checkWearChange = true

	self:refreshBtns()
end

function BagPetWearDlg:getAllCanWearPetAmuletList(pos)
	local usedDic = {}

	for _, petWear in pairs(self.petWearDic) do
		if petWear.amulet1 then
			usedDic[petWear.amulet1] = true
		end

		if petWear.amulet2 then
			usedDic[petWear.amulet2] = true
		end
	end

	local amuletList = {}

	for _, amulet in pairs(CurAvatar.petAmuletDic) do
		if not usedDic[amulet.id] then
			if pos and pos == 2 then
				if amulet:checkCanWearedInAssist() then
					table.insert(amuletList, amulet)
				end
			else
				table.insert(amuletList, amulet)
			end
		end
	end

	return amuletList
end

function BagPetWearDlg:getAllCanWearPetGemList()
	local usedDic = {}

	for _, petWear in pairs(self.petWearDic) do
		for _, gid in ipairs(petWear.gemList) do
			usedDic[gid] = true
		end
	end

	local gemList = {}

	for _, gem in pairs(CurAvatar.petGemDic) do
		if not usedDic[gem.gid] then
			table.insert(gemList, gem)
		end
	end

	return gemList
end

function BagPetWearDlg:checkHaveWear()
	for _, pet in pairs(CurAvatar.petList) do
		if self.isEditPlan then
			if CurAvatar:checkPetHaveWearInPlanPetWearDic(self.petWearDic, pet.id) then
				return true
			end
		elseif pet:checkHaveWear() then
			return true
		end
	end

	return false
end

function BagPetWearDlg:onClickBtnEquipOff()
	if not self:checkHaveWear() then
		MsgManager.clientNotice(775)

		return
	end

	self.slotTakeOffAllWears = self.slotTakeOffAllWears or Slot(self.takeOffAllWears, self)

	UIManager.showConfirmWithId(1124, self.slotTakeOffAllWears)
end

function BagPetWearDlg:takeOffAllWears()
	if self.isEditPlan then
		for petId, pet in pairs(self.petWearDic) do
			self.petWearDic[petId].amulet1 = 0
			self.petWearDic[petId].amulet2 = 0
			self.petWearDic[petId].gemList = {}
		end

		self.checkWearChange = true

		self:refreshShow()
		MsgManager.clientNotice(774)
	else
		local petIdList = {}

		for _, pet in pairs(CurAvatar.petList) do
			table.insert(petIdList, pet.id)
		end

		RPC.petOffWears(petIdList)
	end
end

function BagPetWearDlg:onClickBtnSave()
	CurAvatar.isSaveingPlan = true

	local tmpPetWearDic = {}

	for id, petWear in pairs(self.petWearDic) do
		if CurAvatar:checkPetHaveWearInPlanPetWearDic(self.petWearDic, id) then
			tmpPetWearDic[id] = petWear
		end
	end

	self.planData.petWearDic = tmpPetWearDic

	local planItem = CurAvatar:getPlanItembyPlanData(self.planData)
	local rpcData = {
		{
			item_id = self.planData.id,
			item = planItem,
			name = planItem.name
		}
	}
	local update = 0

	RPC.equipSchemeUpdate(rpcData, CurAvatar.equipPlanVersion, update)

	self.checkCanApply = true
end

function BagPetWearDlg:onClickBtnClose()
	if self.isEditPlan then
		if self.checkWearChange then
			local function yesFunc()
				self:onClickBtnSave()
			end

			local function noFunc()
				self:setVisible(false)
			end

			UIManager.showConfirmWithId(1127, nil, Slot(yesFunc, self), noFunc)

			local ui = UIManager.tryGetUI("confirmui")

			if ui and ui.textContent then
				ui.textContent:setText(string.format(ResClientConfirm[1127].content, self.planData.name))
			end
		else
			self:setVisible(false)
		end
	else
		self:setVisible(false)
	end
end

function BagPetWearDlg:onPetChange(pet_id)
	self:refreshShow()
end

function BagPetWearDlg:onPetOffWearsResp()
	self:refreshShow()
	MsgManager.clientNotice(774)
end

function BagPetWearDlg:updatePlan(planData)
	if self.isEditPlan and planData and planData.id == self.planData.id then
		self.checkWearChange = false

		self:refreshData()
	end
end

function BagPetWearDlg:onPetGemChange(gid)
	local gem = CurAvatar.petGemDic[gid]

	if gem and gem.inWearing then
		self:onPetChange(gem.inWearing)
	end
end

return BagPetWearDlg

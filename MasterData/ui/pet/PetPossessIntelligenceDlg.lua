-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPossessIntelligenceDlg.lua

local ResPetPossessAttr = require("ClientData/ResPetPossessAttr")
local ResPetMisc = require("ClientData/ResPetMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResColor = require("ClientData/ResColor")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local EventConst = require("EventConst")
local PetPossessIntelligenceDlg = Class("PetPossessIntelligenceDlg", UIControls.Window)

function PetPossessIntelligenceDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnTips = UIControls.Button(self, "BgPanel/BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.washPanel = UIControls.Panel(self, "BgPanel/WashPanel")
	self.btnNormalWash = UIControls.Button(self, "BgPanel/WashPanel/BtnCommonWash")

	self.btnNormalWash:addEventClick(self.onClickBtnNormalWash, 0.5)

	self.txtNormalWash = UIControls.Label(self, "BgPanel/WashPanel/BtnCommonWash/Text")
	self.normalWashNmlPanel = UIControls.Panel(self, "BgPanel/WashPanel/BtnCommonWash/NmlPanel")
	self.normalWashDisPanel = UIControls.Panel(self, "BgPanel/WashPanel/BtnCommonWash/DisPanel")
	self.imgNormalWashCost = UIControls.Image(self, "BgPanel/WashPanel/BtnCommonTips/Icon")
	self.txtNormalWashCost = UIControls.Label(self, "BgPanel/WashPanel/BtnCommonTips/TextNum")
	self.btnMoney = UIControls.Button(self, "BgPanel/BtnMoney")

	self.btnMoney:addEventClick(self.onClickBtnMoney)

	self.imgMoney = UIControls.Image(self, "BgPanel/BtnMoney/Icon")
	self.txtMoney = UIControls.Label(self, "BgPanel/BtnMoney/TextNum")
	self.btnSeniorWash = UIControls.Button(self, "BgPanel/WashPanel/BtnSeniorWash")

	self.btnSeniorWash:addEventClick(self.onClickBtnSeniorWash, 0.5)

	self.txtSeniorWash = UIControls.Label(self, "BgPanel/WashPanel/BtnSeniorWash/Text")
	self.tenSwitchPanel = UIControls.Panel(self, "BgPanel/MoreWashPanel")
	self.togTenSwitch = UIControls.Toggle(self, "BgPanel/MoreWashPanel/AttentionSwitch")

	self.togTenSwitch:addEventValueChanged(self.onTogTenSwitch)

	self.seniorWashNmlPanel = UIControls.Panel(self, "BgPanel/WashPanel/BtnSeniorWash/NmlPanel")
	self.seniorWashDisPanel = UIControls.Panel(self, "BgPanel/WashPanel/BtnSeniorWash/DisPanel")
	self.imgSeniorWashCost1 = UIControls.Image(self, "BgPanel/WashPanel/BtnSeniorTips/Icon")
	self.txtSeniorWashCost1 = UIControls.Label(self, "BgPanel/WashPanel/BtnSeniorTips/TextNum")
	self.imgSeniorWashCost2 = UIControls.Image(self, "BgPanel/WashPanel/BtnSeniorTips/Icon1")
	self.txtSeniorWashCost2 = UIControls.Label(self, "BgPanel/WashPanel/BtnSeniorTips/TextNum1")
	self.savePanel = UIControls.Panel(self, "BgPanel/SavePanel")
	self.btnSaveNew = UIControls.Button(self, "BgPanel/SavePanel/BtnSave")

	self.btnSaveNew:addEventClick(self.onClickBtnSaveNew)

	self.btnSaveOld = UIControls.Button(self, "BgPanel/SavePanel/BtnCancel")

	self.btnSaveOld:addEventClick(self.onClickBtnSaveOld)

	self.oldAttrCellList = {}

	for i = 1, 4 do
		local cell = HeroAttrPanel(self, "BgPanel/AttrOldPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.oldAttrCellList, cell)
	end

	self.newAttrCellList = {}

	for i = 1, 4 do
		local cell = HeroAttrPanel(self, "BgPanel/AttrNewPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.newAttrCellList, cell)
	end

	self.newAttrPanel = UIControls.Panel(self, "BgPanel/AttrNewPanel/AttrLessPanel")
	self.noContentPanel = UIControls.Panel(self, "BgPanel/AttrNewPanel/NoContent")
	self.normalEfx = UIControls.LazyEffectPlayer(self, "BgPanel/AttrNewPanel/Efx1")
	self.seniorEfx = UIControls.LazyEffectPlayer(self, "BgPanel/AttrNewPanel/Efx2")
	self.saveEfx = UIControls.LazyEffectPlayer(self, "BgPanel/AttrOldPanel/Efx")
	self.slotOnIntelligenceChange = Slot(self.onIntelligenceChange, self)

	EventCenter.addEventListener(EventConst.PET_INTELLIGENCE_CHANGE, self.slotOnIntelligenceChange)
end

function PetPossessIntelligenceDlg:onOpen()
	PetPossessIntelligenceDlg.super.onOpen(self)

	local ui = UIManager.getUI("petPossessMainDlg")

	if ui then
		self:bindWindow(ui)
	end

	self:refreshView()

	local checkTenSwitch = CurAvatar.checkPetPossessTenSwitch or false

	self.togTenSwitch:setOn(checkTenSwitch)
end

function PetPossessIntelligenceDlg:destroy()
	PetPossessIntelligenceDlg.super.destroy(self)
	EventCenter.removeEventListener(EventConst.PET_INTELLIGENCE_CHANGE, self.slotOnIntelligenceChange)
end

function PetPossessIntelligenceDlg:setData(pet)
	self.pet = pet

	self:refreshView()

	if RedDotManager.getKeyState(UIConst.RD_HINT_PET_POSSESS_INTELLIGENCE) then
		CurAvatar:onOpenPetPossessIntelligenceDlg(self.pet)
	end
end

function PetPossessIntelligenceDlg:refreshView()
	if not self.pet then
		return
	end

	local cellNum = #self.oldAttrCellList
	local possessAttrConfig = ResPetPossessAttr[self.pet.quality]

	for index, config in ipairs(possessAttrConfig) do
		if cellNum < index then
			break
		end

		local petAttrName = BattleConst.PROP_TYPE_CONFIG[config.pet_attr]
		local zhName, attrValue = ClientUtils.getRolePropZhName(petAttrName, 0)
		local intelligence = self.pet.intelligenceList[index] or 0
		local intelligenceLimit = config.intelligence_limit[self.pet.star]
		local cell = self.oldAttrCellList[index]

		cell:setData(zhName, intelligence .. "/" .. intelligenceLimit, nil, petAttrName)
		cell:setSlider(intelligence / intelligenceLimit)
	end

	local checkUnSave = self.pet.unSaveIntelligenceList ~= nil

	self.newAttrPanel:setVisible(checkUnSave)
	self.noContentPanel:setVisible(not checkUnSave)
	self.savePanel:setVisible(checkUnSave)
	self.washPanel:setVisible(not checkUnSave)
	self.tenSwitchPanel:setVisible(not checkUnSave)
	self.btnMoney:setVisible(not checkUnSave)

	if checkUnSave then
		for index, config in ipairs(possessAttrConfig) do
			if cellNum < index then
				break
			end

			local petAttrName = BattleConst.PROP_TYPE_CONFIG[config.pet_attr]
			local zhName, attrValue = ClientUtils.getRolePropZhName(petAttrName, 0)
			local oldIntelligence = self.pet.intelligenceList[index] or 0
			local intelligence = self.pet.unSaveIntelligenceList[index] or 0
			local intelligenceLimit = config.intelligence_limit[self.pet.star]
			local cell = self.newAttrCellList[index]

			cell:setData(zhName, intelligence .. "/" .. intelligenceLimit, nil, petAttrName)
			cell:setSlider(intelligence / intelligenceLimit)
			cell:setArrow(intelligence - oldIntelligence)
		end
	else
		self:refreshBtns()
	end
end

function PetPossessIntelligenceDlg:refreshBtns()
	local isOn = self.togTenSwitch:isOn()
	local ratio = isOn and 10 or 1

	if isOn then
		self.txtNormalWash:setText(Lang.get(101438))
		self.txtSeniorWash:setText(Lang.get(101439))
	else
		self.txtNormalWash:setText(Lang.get(91232))
		self.txtSeniorWash:setText(Lang.get(91233))
	end

	local miscConfig = ResPetMisc[1]
	local normalCostId = miscConfig.nor_develop_cost_item
	local normalCostNum = miscConfig.nor_develop_cost_num * ratio

	self.normalItem = BaseObject.GetObject(normalCostId, normalCostNum)

	local normalIconPath = self.normalItem:getIconPath()

	self.imgNormalWashCost:setImage(normalIconPath[1], normalIconPath[2])
	self.imgSeniorWashCost1:setImage(normalIconPath[1], normalIconPath[2])
	self.imgMoney:setImage(normalIconPath[1], normalIconPath[2])

	local haveNormalCostNum = CurAvatar:getItemNumById(normalCostId)

	self.txtNormalWashCost:setText(normalCostNum)
	self.txtSeniorWashCost1:setText(normalCostNum)
	self.txtMoney:setText(haveNormalCostNum)

	self.checkNormalWashEnough = normalCostNum <= haveNormalCostNum

	self.txtNormalWashCost:setFontColor(self.checkNormalWashEnough and ResColor.COLORRANK05 or ResColor.RED)
	self.txtSeniorWashCost1:setFontColor(self.checkNormalWashEnough and ResColor.COLORRANK05 or ResColor.RED)
	self.normalWashNmlPanel:setVisible(self.checkNormalWashEnough)
	self.normalWashDisPanel:setVisible(not self.checkNormalWashEnough)

	local seniorCostId = miscConfig.spe_develop_cost_item
	local seniorCostNum = miscConfig.spe_develop_cost_num * ratio

	self.seniorItem = BaseObject.GetObject(seniorCostId, seniorCostNum)

	local seniorIconPath = self.seniorItem:getIconPath()

	self.imgSeniorWashCost2:setImage(seniorIconPath[1], seniorIconPath[2])

	local haveSeniorCostNum = CurAvatar:getItemNumById(seniorCostId)

	self.txtSeniorWashCost2:setText(seniorCostNum)

	self.checkSeniorWashEnough = seniorCostNum <= haveSeniorCostNum

	self.txtSeniorWashCost2:setFontColor(self.checkSeniorWashEnough and ResColor.COLORRANK05 or ResColor.RED)
	self.seniorWashNmlPanel:setVisible(self.checkNormalWashEnough and self.checkSeniorWashEnough)
	self.seniorWashDisPanel:setVisible(not self.checkNormalWashEnough or not self.checkSeniorWashEnough)
end

function PetPossessIntelligenceDlg:onClickBtnNormalWash()
	if CurAvatar:checkPetIntelligenceLimit(self.pet, true) then
		return
	end

	if not self.checkNormalWashEnough then
		MsgManager.notice(string.format(ResClientNotice[759].notice, self.normalItem.name))

		return
	end

	RPC.petDevelopIntelligence(self.pet.id, Const.PET_DEVELOP_INTELLIGENCE_TYPE.Normal, self.togTenSwitch:isOn() and 1 or 0)
end

function PetPossessIntelligenceDlg:onClickBtnSeniorWash()
	if CurAvatar:checkPetIntelligenceLimit(self.pet, true) then
		return
	end

	if not self.checkNormalWashEnough then
		MsgManager.notice(string.format(ResClientNotice[759].notice, self.normalItem.name))

		return
	end

	if not self.checkSeniorWashEnough then
		MsgManager.notice(string.format(ResClientNotice[759].notice, self.seniorItem.name))

		return
	end

	RPC.petDevelopIntelligence(self.pet.id, Const.PET_DEVELOP_INTELLIGENCE_TYPE.Senior, self.togTenSwitch:isOn() and 1 or 0)
end

function PetPossessIntelligenceDlg:onClickBtnMoney()
	UIManager.getUI("itemTips"):showObj(self, self.normalItem)
end

function PetPossessIntelligenceDlg:onClickBtnSaveNew()
	RPC.petChooseIntelligence(self.pet.id, Const.PET_CHOOSE_INTELLIGENCE_TYPE.New)
end

function PetPossessIntelligenceDlg:onClickBtnSaveOld()
	RPC.petChooseIntelligence(self.pet.id, Const.PET_CHOOSE_INTELLIGENCE_TYPE.Old)
end

function PetPossessIntelligenceDlg:onClickBtnClose()
	self:setVisible(false)
end

function PetPossessIntelligenceDlg:onClickBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_POSSESS_INTELLIGENCE)
end

function PetPossessIntelligenceDlg:onTogTenSwitch()
	self:refreshBtns()

	CurAvatar.checkPetPossessTenSwitch = self.togTenSwitch:isOn()
end

function PetPossessIntelligenceDlg:onPetDevelopIntelligenceResp(pet_id, develop_type)
	if develop_type == Const.PET_DEVELOP_INTELLIGENCE_TYPE.Normal then
		self.normalEfx:playEffect()
	elseif develop_type == Const.PET_DEVELOP_INTELLIGENCE_TYPE.Senior then
		self.seniorEfx:playEffect()
	end

	self:refreshView()
end

function PetPossessIntelligenceDlg:onIntelligenceChange(pet_id, op_type)
	self:refreshView()

	if op_type == Const.PET_CHOOSE_INTELLIGENCE_TYPE.New then
		self.saveEfx:playEffect()
	end
end

return PetPossessIntelligenceDlg

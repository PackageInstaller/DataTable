-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetTipsInfoPanel.lua

local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResPetStar = require("ClientData/ResPetStar")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local ResPetMisc = require("ClientData/ResPetMisc")
local ResColor = require("ClientData/ResColor")
local PetSkillPart = require("UI/Pet/PetSkillPart")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local strClassName = "PetInfoTipsInfoPanel"
local PetInfoTipsInfoPanel = Class(strClassName, UIControls.Panel)
local ATTR_DIC = {
	{
		floor = true,
		attrStr = "mhp",
		name = Lang.get(964)
	},
	{
		floor = true,
		attrStr = "atk",
		name = Lang.get(578)
	},
	{
		percent = true,
		attrStr = "cri_rate",
		name = Lang.get(12013)
	},
	{
		percent = true,
		attrStr = "cri_dmg",
		name = Lang.get(12010)
	}
}

function PetInfoTipsInfoPanel:ctor()
	self:initUI()
end

function PetInfoTipsInfoPanel:initUI()
	self.btnDetail = UIControls.Button(self, self.mPath .. "/StartPanel/BtnDetail")

	self.btnDetail:addEventClick(self.onBtnDetailClick)

	self.btnUpgrade = UIControls.Button(self, self.mPath .. "/StartPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.redStarUpNew = UIControls.Image(self, self.mPath .. "/StartPanel/BtnUpgrade/IconNew")
	self.textName = UIControls.Label(self, self.mPath .. "/InfoPanel/TextName")
	self.attrsPanel = {}

	for i = 1, 4 do
		local textName = UIControls.Label(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr" .. i .. "/TextName")
		local textNum = UIControls.Label(self, self.mPath .. "/AttrPanel/AttrLessPanel/Attr" .. i .. "/TextNum1")

		table.insert(self.attrsPanel, {
			textName = textName,
			textNum = textNum
		})
	end

	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, self.mPath .. "/StartPanel/StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, self.mPath .. "/StartPanel/StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end

	self.petSkillPart = PetSkillPart(self, self.mPath .. "/SkillPanel/SkillList")
	self.maxNode = UIControls.Panel(self, "PetInfoPanel/StartPanel/MaxNode")
	self.petItem = UIControls.Panel(self, "PetInfoPanel/StartPanel/PetItem")
	self.textPower = UIControls.Label(self, "PetInfoPanel/InfoPanel/ImgPower/TextTitle/TextPower")
end

function PetInfoTipsInfoPanel:setPet(pet)
	self.pet = pet

	self.textName:setText(self.pet.name)
	self:refreshAttrPanel()
	self:refreshStartPanel()
	self:refreshSkillPanel()
end

function PetInfoTipsInfoPanel:refreshAttrPanel()
	self.pet:becomePropsContainer()

	for i = 1, #ATTR_DIC do
		local name = ATTR_DIC[i].name

		self.attrsPanel[i].textName:setText(name)

		local value = self.pet[ATTR_DIC[i].attrStr] or 0

		if ATTR_DIC[i].percent then
			value = tostring(value * 100) .. "%"
		end

		if ATTR_DIC[i].floor then
			value = math.floor(value)
		end

		self.attrsPanel[i].textNum:setText(value)
	end
end

function PetInfoTipsInfoPanel:refreshStartPanel()
	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= self.pet.star)
	end

	local haveNum = CurAvatar:getItemNumById(self.pet.translateItemId)

	if not self.grid then
		self.grid = UIControls.ItemGridChild(self, "PetInfoPanel/StartPanel/PetItem", "System/Common/Grid/GridMaterialItem", 0, 0, true)
	end

	self.grid.mDisableWays = true

	local fakeItem = BaseObject.GetObject(self.pet.translateItemId)

	self.grid:setObj(fakeItem)

	if not self.pet:isMaxStar() then
		local needNum = ResPetStar[self.pet.star + 1].cost_same_num

		if self.grid.textNum then
			self.grid.textNum:setText(string.format("%d/%d", haveNum, needNum))

			local color = haveNum < needNum and ResColor.RED or ResColor.BLACK

			self.grid.textNum:setFontColor(color)
		end

		self.redStarUpNew:setVisible(needNum <= haveNum)
	end

	self.btnUpgrade:setVisible(not self.pet:isMaxStar())
	self.maxNode:setVisible(self.pet:isMaxStar())
	self.textPower:setText(CapacityHelper.getPetCapacity(self.pet))
end

function PetInfoTipsInfoPanel:refreshSkillPanel()
	self.petSkillPart:setSkill(self.pet, true)
	self.petSkillPart:setSkillGridCallBack(Slot(self.onGridClick, self))
	self.petSkillPart:setEmptySkillCallBack(Slot(self.onSkillClick, self))
end

function PetInfoTipsInfoPanel:onBtnDetailClick()
	UIManager.getUI("petUpStarPreviewDlg", true):setData(self.pet)
end

function PetInfoTipsInfoPanel:onBtnUpgradeClick()
	local needNum = ResPetStar[self.pet.star + 1].cost_same_num
	local haveNum = CurAvatar:getItemNumById(self.pet.translateItemId)

	if haveNum < needNum then
		MsgManager.notice(Lang.get(73231))

		return
	end

	RPC.petStarUp(self.pet.id)
end

function PetInfoTipsInfoPanel:onGridClick(sender)
	local mTipsConfig = CurAvatar.commonAmuletTipsFuncItem

	UIManager.getUI("petAmuletTips"):show(sender, mTipsConfig)
end

function PetInfoTipsInfoPanel:onSkillClick(index)
	UIManager.getUI("petAmuletWearDlg", true):setData(nil, index, self.pet.id)
end

return PetInfoTipsInfoPanel

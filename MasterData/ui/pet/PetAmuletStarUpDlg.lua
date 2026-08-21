-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetAmuletStarUpDlg.lua

local ResAmuletStar = require("ClientData/ResAmuletStar")
local ResPetMisc = require("ClientData/ResPetMisc")
local PetAmuletSkillInfoPart = require("UI/Pet/PetAmuletSkillInfoPart")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResColor = require("ClientData/ResColor")
local strClassName = "DetailCell"
local DetailCell = Class(strClassName, UIControls.Child)

function DetailCell:ctor()
	self:initUI()
end

function DetailCell:initUI()
	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end

	self.bgCurrent = UIControls.Image(self, "BgCurrent")
	self.skillUIs = {}

	for i = 1, 2 do
		local skillDesc = UIControls.Label(self, "Skill0" .. i)
		local skillTitle = UIControls.Label(self, "Skill0" .. i .. "/SkillTitle")

		table.insert(self.skillUIs, {
			skillDesc = skillDesc,
			skillTitle = skillTitle
		})
	end
end

function DetailCell:setData(data)
	self.amulet = self.mParent.amulet

	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= data.star)
		self.starGroup[i].star:setVisible(i <= self.amulet.maxStar)
	end

	self.bgCurrent:setVisible(data.star == self.amulet.star)

	if self.amulet.mainSkill and self.amulet.mainSkill ~= 0 then
		self.skillUIs[1].skillDesc:setVisible(true)

		local skillData = ResSkillConfig[self.amulet.mainSkill][data.star]

		if skillData then
			self.skillUIs[1].skillDesc:setText(skillData.skill_desc)
			self.skillUIs[1].skillTitle:setText(skillData.name)
		end
	else
		self.skillUIs[1].skillDesc:setVisible(false)
	end

	if self.amulet.assistantSkill and self.amulet.assistantSkill ~= 0 then
		self.skillUIs[2].skillDesc:setVisible(true)

		local skillData = ResPassiveSkill[self.amulet.assistantSkill][data.star]

		if skillData then
			self.skillUIs[2].skillDesc:setText(skillData.desc)
			self.skillUIs[2].skillTitle:setText(skillData.name)
		end
	else
		self.skillUIs[2].skillDesc:setVisible(false)
	end
end

local strClassName = "PetAmuletStarUpDlg"
local PetAmuletStarUpDlg = Class(strClassName, UIControls.Window)

function PetAmuletStarUpDlg:ctor()
	self:initUI()
end

function PetAmuletStarUpDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnUpgrade = UIControls.Button(self, "InfoPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.statUpRedNew = UIControls.Image(self, "InfoPanel/BtnUpgrade/IconNew")
	self.amuletSkillInfoPart = PetAmuletSkillInfoPart(self, "InfoPanel/SkillList")
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._infoAnimEnd)

	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "InfoPanel/StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "InfoPanel/StartGroup/Start0" .. i .. "/Background/Checkmark")
		local efx = UIControls.LazyEffectPlayer(self, "InfoPanel/StartGroup/Start0" .. i .. "/Efx")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark,
			efx = efx
		})
	end

	self.imgIcon = UIControls.Image(self, "InfoPanel/ImgIcon")
	self.textName = UIControls.Label(self, "InfoPanel/TextName")
	self.itemGroup = UIControls.Panel(self, "InfoPanel/ItemGroup")
	self.maxNode = UIControls.Panel(self, "InfoPanel/MaxNode")
	self.detailsPanel = UIControls.Panel(self, "InfoPanel/DetailsPanel")
	self.btnDetails = UIControls.Button(self, "InfoPanel/BtnDetails")

	self.btnDetails:addEventClick(self.onBtnDetailsClick)

	self.closeBtn = UIControls.Button(self, "InfoPanel/DetailsPanel/CloseBtn")

	self.closeBtn:addEventClick(self.onCloseBtnClick)

	self.listNode = UIControls.ScrollView(self, "InfoPanel/DetailsPanel/ListNode")
	self.detailCells = {}
	self.efx = UIControls.LazyEffectPlayer(self, "InfoPanel/ImgIcon/Efx")
end

function PetAmuletStarUpDlg:setData(amulet)
	self.amulet = amulet

	self:refreshOtherUI()
	self:refreshSkillUI()
end

function PetAmuletStarUpDlg:refreshOtherUI()
	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= self.amulet.star)
		self.starGroup[i].star:setVisible(i <= self.amulet.maxStar)
	end

	local iconPath = self.amulet:getIconPath()

	if iconPath and iconPath[1] and iconPath[2] then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	self.textName:setText(self.amulet.name)

	if not self.amulet:isMaxStar() then
		if not self.costGrid then
			self.costGrid = UIControls.ItemGridChild(self, "InfoPanel/ItemGroup/GridNode", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		self.costId = self.amulet.translateItemId
		self.costNum = ResAmuletStar[self.amulet.star + 1].need_piece_num

		local gridItem = BaseObject.GetObject(self.costId, self.costNum)

		self.costGrid:setObj(gridItem)

		local haveNum = CurAvatar:getItemNumById(self.costId)

		if self.costGrid.textNum then
			self.costGrid.textNum:setText(string.format("%d/%d", haveNum, self.costNum))

			local color = haveNum < self.costNum and ResColor.RED or ResColor.BLACK

			self.costGrid.textNum:setFontColor(color)
		end

		self.statUpRedNew:setVisible(haveNum >= self.costNum)
	end

	self.btnUpgrade:setVisible(not self.amulet:isMaxStar())
	self.itemGroup:setVisible(not self.amulet:isMaxStar())
	self.maxNode:setVisible(self.amulet:isMaxStar())

	self.detailData = {}

	for i = 1, self.amulet.maxStar do
		table.insert(self.detailData, {
			star = i
		})

		local cell = self.detailCells[i]

		if cell == nil then
			cell = DetailCell(self, "InfoPanel/DetailsPanel/ListNode/Content", "System/Pet/PetDetailsItem", 0, 0, true)
		end

		cell:setData(self.detailData[i])

		self.detailCells[i] = cell
	end
end

function PetAmuletStarUpDlg:refreshSkillUI()
	self.amuletSkillInfoPart:setData(self.amulet)
end

function PetAmuletStarUpDlg:onBtnUpgradeClick()
	local haveNum = CurAvatar:getItemNumById(self.costId)

	if haveNum < self.costNum then
		MsgManager.notice(Lang.get(74767))

		return
	end

	RPC.petAmuletStarUp(self.amulet.id)
end

function PetAmuletStarUpDlg:playStarUpEfx(amulet)
	self.amulet = amulet

	self.efx:setVisible(false)
	self.efx:setVisible(true)
	self.starGroup[self.amulet.star].efx:setVisible(false)
	self.starGroup[self.amulet.star].efx:setVisible(true)
	self.uiAni:startAni("ShowSkillList", true)
	self:refreshOtherUI()
end

function PetAmuletStarUpDlg:_infoAnimEnd(animCon, animName)
	if animName == "ShowSkillList" then
		self.amuletSkillInfoPart:playStarUpEfx()
		self:refreshSkillUI()
	end
end

function PetAmuletStarUpDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PetAmuletStarUpDlg:onCloseBtnClick()
	self.detailsPanel:setVisible(false)
end

function PetAmuletStarUpDlg:onBtnDetailsClick()
	self.detailsPanel:setVisible(true)
end

function PetAmuletStarUpDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_AMULET_MAIN)
end

return PetAmuletStarUpDlg

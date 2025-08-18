-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPossessCareerDlg.lua

local ResPetPossessAttr = require("ClientData/ResPetPossessAttr")
local ResPetGifted = require("ClientData/ResPetGifted")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local EventConst = require("EventConst")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local BattleConst = require("Common/FrameBattle/BattleConst")
local CareerCell = Class("PetPossessCareerDlg_CareerCell", UIControls.Panel)

function CareerCell:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)
end

function CareerCell:init(clickCb, careerId)
	self.clickCb = clickCb
	self.careerId = careerId
end

function CareerCell:onClickBtn()
	self.clickCb(self)
end

function CareerCell:setSelect(value)
	self.btn:setEnable(not value)
end

local PetPossessCareerDlg = Class("PetPossessCareerDlg", UIControls.Window)

function PetPossessCareerDlg:ctor()
	self.slotOnClickCareerCell = Slot(self.onClickCareerCell, self)
	self.careerCellList = {}

	for i = 1, Const.CAREER_TYPE.ALL - 1 do
		if UIControls.checkControlFunc(self, "BgPanel/TabPanel/Btn" .. i) then
			local careerCell = CareerCell(self, "BgPanel/TabPanel/Btn" .. i)

			careerCell:init(self.slotOnClickCareerCell, i)
			table.insert(self.careerCellList, careerCell)
		end
	end

	self.imgCareer = UIControls.Image(self, "BgPanel/InfoPanel/TitlePanel/ImgCareer")
	self.imgCareerBg1 = UIControls.Image(self, "BgPanel/BgCareer1")
	self.imgCareerBg2 = UIControls.Image(self, "BgPanel/BgCareer2")
	self.attrCellList = {}

	for i = 1, 4 do
		local cell = HeroAttrPanel(self, "BgPanel/InfoPanel/AttrPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.attrCellList, cell)
	end

	self.tipsPanel = UIControls.Panel(self, "BgPanel/TipsPanel")
	self.tipsBgPanel = UIControls.Panel(self, "BgPanel/InfoPanel/AttrPanel/TextTitle/BtnTips/BgImg")
	self.btnOpenTipsPanel = UIControls.Button(self, "BgPanel/InfoPanel/AttrPanel/TextTitle/BtnTips")

	self.btnOpenTipsPanel:addEventClick(self.onClickBtnOpenTipsPanel)

	self.btnCloseTipsPanel = UIControls.Button(self, "BgPanel/TipsPanel/UIClickThrough")

	self.btnCloseTipsPanel:addEventClick(self.onClickBtnCloseTipsPanel)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.giftListPanel = UIControls.Panel(self, "BgPanel/InfoPanel/SkillPanel/SkillList")
	self.giftNoContentPanel = UIControls.Panel(self, "BgPanel/InfoPanel/SkillPanel/ImgNone")
	self.skillTipsPanel = UIControls.Panel(self, "BgPanel/SkillTipsPanel")
	self.giftCell = UIControls.GridPetGiftHeadChild(self, "BgPanel/SkillTipsPanel/SkillInfoPanel/SkillPanel", "System/Pet/GridEnchantSkill")

	self.giftCell:setVisible(true)
	self.giftCell:setClickEnable(false)

	self.imgPetHead = UIControls.Image(self, "BgPanel/SkillTipsPanel/SkillInfoPanel/PetHeadPanel/ImgPetHead")
	self.txtSkillName = UIControls.Label(self, "BgPanel/SkillTipsPanel/SkillInfoPanel/TextTitle")
	self.txtSkillDes = UIControls.Label(self, "BgPanel/SkillTipsPanel/SkillInfoPanel/TextTips")
	self.btnCloseSkillTipsPanel = UIControls.Button(self, "BgPanel/SkillTipsPanel/UIClickThrough")

	self.btnCloseSkillTipsPanel:addEventClick(self.onClickBtnCloseSkillTipsPanel)

	self.slotOnClickPetCell = Slot(self.onClickPetCell, self)
	self.slotOnClickGiftCell = Slot(self.onClickGiftCell, self)
	self.slotRefreshRight = Slot(self.refreshRight, self)

	EventCenter.addEventListener(EventConst.PET_POSSESS_DATA_CHANGE, self.slotRefreshRight)
	EventCenter.addEventListener(EventConst.PET_INTELLIGENCE_CHANGE, self.slotRefreshRight)
	EventCenter.addEventListener(EventConst.PET_GIFT_CHANGE, self.slotRefreshRight)
end

function PetPossessCareerDlg:destroy()
	PetPossessCareerDlg.super.destroy(self)
	EventCenter.removeEventListener(EventConst.PET_POSSESS_DATA_CHANGE, self.slotRefreshRight)
	EventCenter.removeEventListener(EventConst.PET_INTELLIGENCE_CHANGE, self.slotRefreshRight)
	EventCenter.removeEventListener(EventConst.PET_GIFT_CHANGE, self.slotRefreshRight)
end

function PetPossessCareerDlg:setData(selectCareerId)
	self.selectCareerId = selectCareerId or Const.CAREER_TYPE.TANK

	for _, careerCell in ipairs(self.careerCellList) do
		local checkSelect = careerCell.careerId == self.selectCareerId

		careerCell:setSelect(checkSelect)

		if checkSelect then
			self.selectCareerCell = careerCell
		end
	end

	self:refreshRight()
end

function PetPossessCareerDlg:refreshRight()
	self.imgCareer:setImage("Atlas/PetAtlas/PetEnchantAtlas1", "TxtTitle" .. self.selectCareerId)
	self.imgCareerBg1:setImage("Atlas/PetAtlas/PetEnchantAtlas2", "Bg" .. self.selectCareerId)
	self.imgCareerBg2:setImage("Atlas/PetAtlas/PetEnchantAtlas2", "Bg" .. self.selectCareerId)

	local data = CurAvatar:getPetPossessDataByCareerId(self.selectCareerId)
	local petIdList = data and data.petList or {}
	local petNum = #petIdList

	self.petList = {}

	if petIdList then
		for _, id in ipairs(petIdList) do
			local pet = CurAvatar:getPetByResId(id)

			table.insert(self.petList, pet)
		end
	end

	local maxNum = CurAvatar:getSingleCareerMaxPetPossessNum()

	maxNum = math.max(petNum, maxNum)
	self.petCellList = self.petCellList or {}

	local cellNum = #self.petCellList

	for i = 1, maxNum do
		local cell

		if i <= cellNum then
			cell = self.petCellList[i]
		else
			cell = UIControls.GridPetHeadChild(self, "BgPanel/InfoPanel/PetPanel", "System/Pet/GridPetHead")

			cell:init(self.slotOnClickPetCell)
			table.insert(self.petCellList, cell)
		end

		cell:setVisible(true)

		if i <= petNum then
			cell:setData(self.petList[i])
		else
			cell:setData(nil)
		end
	end

	if maxNum < cellNum then
		for i = maxNum + 1, cellNum do
			self.petCellList[i]:setVisible(false)
		end
	end

	local propDic = PropHelper.getPetPossessAttr(self.petList, self.selectCareerId)

	for _, configList in pairs(ResPetPossessAttr) do
		for index, config in ipairs(configList) do
			local attrName = BattleConst.PROP_TYPE_CONFIG[config.hero_attr]
			local value = propDic[attrName] or 0

			if index <= #self.attrCellList then
				self.attrCellList[index]:setPropInfo(attrName, value, nil, true)
			end
		end

		break
	end

	local giftIdList = {}
	local petIdList = {}

	for _, pet in pairs(self.petList) do
		for _, giftId in pairs(pet.giftList) do
			if giftId > 0 then
				table.insert(giftIdList, giftId)
				table.insert(petIdList, pet.id)
			end
		end
	end

	local checkShowGiftList = #giftIdList > 0

	self.giftListPanel:setVisible(checkShowGiftList)
	self.giftNoContentPanel:setVisible(not checkShowGiftList)

	if checkShowGiftList then
		self.giftCellList = self.giftCellList or {}

		local dataNum = #giftIdList
		local cellNum = #self.giftCellList

		for i = 1, dataNum do
			local cell

			if i <= cellNum then
				cell = self.giftCellList[i]
			else
				cell = UIControls.GridPetGiftHeadChild(self, "BgPanel/InfoPanel/SkillPanel/SkillList/Content", "System/Pet/GridEnchantSkill")

				cell:init(self.slotOnClickGiftCell)
				table.insert(self.giftCellList, cell)
			end

			cell:setVisible(true)
			cell:setData(giftIdList[i], petIdList[i])
		end

		if dataNum < cellNum then
			for i = dataNum + 1, cellNum do
				self.giftCellList[i]:setVisible(false)
			end
		end
	end
end

function PetPossessCareerDlg:onClickCareerCell(careerCell)
	if self.selectCareerCell == careerCell then
		return
	end

	if self.selectCareerCell then
		self.selectCareerCell:setSelect(false)
	end

	self.selectCareerCell = careerCell
	self.selectCareerId = self.selectCareerCell.careerId

	self.selectCareerCell:setSelect(true)
	self:refreshRight()
end

function PetPossessCareerDlg:onClickPetCell(cell)
	local ui = UIManager.getUI("petPossessInfoDlg", true)

	if ui then
		ui:setData(self.selectCareerId, cell.pet)
	end
end

function PetPossessCareerDlg:onClickGiftCell(cell)
	if self.selectGiftCell then
		self.selectGiftCell:setSelect(false)
	end

	self.selectGiftCell = cell

	self.selectGiftCell:setSelect(true)
	self.skillTipsPanel:setVisible(true)

	local giftId = cell.giftId

	self.giftCell:setData(giftId)

	local config = ResPetGifted[giftId]

	if config then
		self.txtSkillName:setText(config.name)
		self.txtSkillDes:setText(config.desc)
	end

	local pet = CurAvatar:getPetByResId(cell.petId)
	local iconPath = pet:getQIconPath()

	if iconPath then
		self.imgPetHead:setImage(iconPath[1], iconPath[2])
	end
end

function PetPossessCareerDlg:onClickBtnClose()
	self:setVisible(false)
end

function PetPossessCareerDlg:onClickBtnOpenTipsPanel()
	self.tipsPanel:setVisible(true)
	self.tipsBgPanel:setVisible(true)
end

function PetPossessCareerDlg:onClickBtnCloseTipsPanel()
	self.tipsPanel:setVisible(false)
	self.tipsBgPanel:setVisible(false)
end

function PetPossessCareerDlg:onClickBtnCloseSkillTipsPanel()
	self.skillTipsPanel:setVisible(false)
	self.selectGiftCell:setSelect(false)

	self.selectGiftCell = nil
end

return PetPossessCareerDlg

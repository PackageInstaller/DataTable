-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPossessMainDlg.lua

local ResPetDegreeLevel = require("ClientData/ResPetDegreeLevel")
local EventConst = require("EventConst")
local CareerCell = Class("PetPossessMainDlg_CareerCell", UIControls.Panel)

function CareerCell:ctor()
	self.imgCareer = UIControls.Image(self, self.mPath .. "/ImgCareer")
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(self.onClickBtn)

	self.slotOnClickPetCell = Slot(self.onClickPetCell, self)
end

function CareerCell:init(careerId)
	self.careerId = careerId
end

function CareerCell:setData(maxNum)
	local data = CurAvatar:getPetPossessDataByCareerId(self.careerId)
	local petList = data and data.petList
	local petNum = petList and #petList or 0

	self.petCellList = self.petCellList or {}

	local cellNum = #self.petCellList

	maxNum = math.max(petNum, maxNum)

	for i = 1, maxNum do
		local cell

		if i <= cellNum then
			cell = self.petCellList[i]
		else
			cell = UIControls.GridPetHeadChild(self, self.mPath .. "/PetEnchantPanel/GridPanel", "System/Pet/GridPetHead")

			cell:init(self.slotOnClickPetCell)
			table.insert(self.petCellList, cell)
		end

		cell:setVisible(true)

		if i <= petNum then
			local petId = petList[i]
			local pet = CurAvatar:getPetByResId(petId)

			cell:setData(pet)

			local checkRed = CurAvatar:checkPetPossessReplaceRedByPet(self.careerId, pet)

			cell:setRed(checkRed)
		else
			cell:setData(nil)
			cell:setRed(RedDotManager.getKeyState(UIConst.RD_HINT_PET_POSSESS))
		end
	end

	if maxNum < cellNum then
		for i = maxNum + 1, cellNum do
			self.petCellList[i]:setVisible(false)
		end
	end
end

function CareerCell:setCellBtnAddEnable(value)
	if self.petCellList then
		for _, cell in pairs(self.petCellList) do
			cell:setBtnAddEnable(value)
		end
	end
end

function CareerCell:onClickBtn()
	local ui = UIManager.getUI("petPossessCareerDlg", true)

	if ui then
		ui:setData(self.careerId)
	end
end

function CareerCell:onClickPetCell(cell)
	local ui = UIManager.getUI("petPossessInfoDlg", true)

	if ui then
		ui:setData(self.careerId, cell.pet)
	end
end

local DegereeCell = Class("PetPossessMainDlg_DegreeCell", UIControls.ScrollViewLoopCell)

function DegereeCell:ctor()
	self.txtLv = UIControls.Label(self, "TextLvNum")
	self.txtTotalNum = UIControls.Label(self, "TextTotalNum")
	self.txtSingleNum = UIControls.Label(self, "TextCareerNum")
	self.panelSelect = UIControls.Panel(self, "ImgSel")
end

function DegereeCell:setData(lv, totalMax, singleMax, checkSelect)
	if Const.REVIEW_VERSION then
		self.txtLv:setText(Lang.get(1203) .. lv)
	else
		self.txtLv:setText("LV." .. lv)
	end

	self.txtTotalNum:setText(totalMax)
	self.txtSingleNum:setText(singleMax)
	self.panelSelect:setVisible(checkSelect)
end

local PetPossessMainDlg = Class("PetPossessMainDlg", UIControls.Window)

function PetPossessMainDlg:ctor()
	self.txtPossessNum = UIControls.Label(self, "MainInfoPanel/EnchantNumPanel/TextNum")
	self.careerCellList = {}

	for i = 1, Const.CAREER_TYPE.ALL - 1 do
		if UIControls.checkControlFunc(self, "MainInfoPanel/CareerPanel/Btn" .. i) then
			local careerCell = CareerCell(self, "MainInfoPanel/CareerPanel/Btn" .. i)

			careerCell:init(i)
			table.insert(self.careerCellList, careerCell)
		end
	end

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.tipsPanel = UIControls.Panel(self, "TipsPanel")
	self.loopTips = UIControls.ScrollViewLoopV(self, "TipsPanel/BgPanel/TipsNumPanel")

	self.loopTips:addEventCellChanged(self.onLoopTipsChange)

	self.btnBottomTips = UIControls.Button(self, "MainInfoPanel/BtnTips")

	self.btnBottomTips:addEventClick(self.onClickBtnBottomTips)

	self.btnCloseTips = UIControls.Button(self, "TipsPanel/UIClickThrough")

	self.btnCloseTips:addEventClick(self.onClickBtnCloseTips)

	self.slotOnPetPossessDataChange = Slot(self.onPetPossessDataChange, self)

	EventCenter.addEventListener(EventConst.PET_POSSESS_DATA_CHANGE, self.slotOnPetPossessDataChange)
end

function PetPossessMainDlg:destroy()
	PetPossessMainDlg.super.destroy(self)
	EventCenter.removeEventListener(EventConst.PET_POSSESS_DATA_CHANGE, self.slotOnPetPossessDataChange)
end

function PetPossessMainDlg:onOpen()
	PetPossessMainDlg.super.onOpen(self)
	self:refreshShow()
end

function PetPossessMainDlg:refreshShow()
	self.toatlMaxNum = CurAvatar:getTotalMaxPetPossessNum()

	local singleCareerMax = CurAvatar:getSingleCareerMaxPetPossessNum()

	for _, cell in ipairs(self.careerCellList) do
		cell:setData(singleCareerMax)
	end

	self.txtPossessNum:setText(CurAvatar:getTotalPetPossessNum() .. "/" .. self.toatlMaxNum)
end

function PetPossessMainDlg:refreshTips()
	self.degreeConfigList = {}

	local lastPossessNum = 0
	local focusIdx = 0

	for _, config in ipairs(ResPetDegreeLevel) do
		if lastPossessNum < config.possess_num then
			lastPossessNum = config.possess_num

			table.insert(self.degreeConfigList, config)

			local checkSelect = self.toatlMaxNum == config.possess_num

			if checkSelect then
				focusIdx = #self.degreeConfigList
			end
		end
	end

	focusIdx = focusIdx >= #self.degreeConfigList - 5 and #self.degreeConfigList - 5 or focusIdx
	focusIdx = math.max(focusIdx, 1)

	self.loopTips:setTotalCount(#self.degreeConfigList, focusIdx)
end

function PetPossessMainDlg:onLoopTipsChange(sender, cell, idx)
	if not cell then
		cell = DegereeCell(sender, "System/Pet/PetEnchantTipsCell", idx)
	else
		cell.mIndex = idx
	end

	local config = self.degreeConfigList[idx]
	local singleNum = math.ceil(config.possess_num / (Const.CAREER_TYPE.ALL - 1))
	local checkSelect = self.toatlMaxNum == config.possess_num

	cell:setData(config.level, config.possess_num, singleNum, checkSelect)
end

function PetPossessMainDlg:setCellEnable(value)
	local check = value == 1 or false

	for _, careerCell in pairs(self.careerCellList) do
		careerCell:setCellBtnAddEnable(check)
	end
end

function PetPossessMainDlg:onClickBtnClose()
	self:setVisible(false)
end

function PetPossessMainDlg:onClickBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_POSSESS_MAIN)
end

function PetPossessMainDlg:onClickBtnBottomTips()
	self.tipsPanel:setVisible(true)
	self:refreshTips()
end

function PetPossessMainDlg:onClickBtnCloseTips()
	self.tipsPanel:setVisible(false)
end

function PetPossessMainDlg:onPetPossessDataChange(careerId)
	self:refreshShow()
end

return PetPossessMainDlg

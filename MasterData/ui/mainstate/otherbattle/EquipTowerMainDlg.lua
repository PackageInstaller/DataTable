-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\EquipTowerMainDlg.lua

local ResEquipTower = require("ClientData/ResEquipTower")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local SUIT_NUM = 4
local EquipTowerMainChooseCell = Class("EquipTowerMainChooseCell", UIControls.Panel)

function EquipTowerMainChooseCell:ctor()
	self.iconGroup = UIControls.Image(self, self.mPath .. "/iconGroup")
	self.textDesc = UIControls.Label(self, self.mPath .. "/TextDes")
	self.textLevel = UIControls.Label(self, self.mPath .. "/TextLv")
	self.textFinal = UIControls.Label(self, self.mPath .. "/TextFinal")
	self.imgSuits = {}

	for index = 1, SUIT_NUM do
		local newImage = UIControls.Image(self, self.mPath .. "/SuitPanel/IconSuit" .. index)

		table.insert(self.imgSuits, newImage)
	end

	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onCellClick)
end

function EquipTowerMainChooseCell:setData(towerType, towerData)
	self.towerType = towerType
	self.towerData = towerData

	if not self.iconNew then
		self.iconNew = UIControls.RedDot(self, self.mPath .. "/IconNew")
		self.iconNewSpe = UIControls.Image(self, self.mPath .. "/IconNewSpe")
	end

	if CurAvatar:isEquipTowerLimitNew(towerType) then
		self.iconNew:clearHint()
		self.iconNew:setVisible(false)
		self.iconNewSpe:setVisible(true)
	else
		self.iconNewSpe:setVisible(false)
		self.iconNew:addHint({
			UIConst["RD_HINT_EQUIPTOWER" .. towerType]
		})
	end

	self.passedLayer = towerData.layer or 0

	if self.passedLayer > 0 then
		if ResEquipTower[self.towerType] and ResEquipTower[self.towerType][self.passedLayer] then
			self.textLevel:setVisible(true)

			if self.passedLayer > 50 then
				self.textFinal:setVisible(true)

				local passedLayer = self.passedLayer - 50

				if passedLayer >= 10 then
					self.textLevel:setText(passedLayer)
				else
					self.textLevel:setText("0" .. passedLayer)
				end
			else
				self.textLevel:setText(self.passedLayer)
			end
		end
	else
		self.textLevel:setVisible(false)
	end

	local nextLayer = self.passedLayer + 1
	local resData = ResEquipTower[towerType]
	local nextData = resData[nextLayer]

	nextData = nextData or resData[self.passedLayer]

	self.textDesc:setText(nextData.battle_desc or "")

	local suits = nextData.suits or {}

	for index, img in ipairs(self.imgSuits) do
		local suitId = suits[index]

		if suitId then
			img:setVisible(true)

			if ResEquipSuit[suitId] and ResEquipSuit[suitId].iconPath then
				img:setImage(UIConst.COMMON_ICON_PATH .. ResEquipSuit[suitId].iconPath, ResEquipSuit[suitId].icon)
			end
		else
			img:setVisible(false)
		end
	end
end

function EquipTowerMainChooseCell:onCellClick()
	UIManager.getUI("equipTowerLevelDlg", true):refreshData(self.towerType)
end

local EQUIP_TOWER_NUM = 3
local strClassName = "EquipTowerMainDlg"
local EquipTowerMainDlg = Class(strClassName, UIControls.Window)

function EquipTowerMainDlg:ctor()
	self:initUI()
end

function EquipTowerMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onTipsClick)

	self.btnGofor = UIControls.Button(self, "MainInfoPanel/BtnGofor")

	self.btnGofor:addEventClick(self.onBtnGoforClick)

	self.towerCells = {}

	for index = 1, EQUIP_TOWER_NUM do
		local newCell = EquipTowerMainChooseCell(self, "MainInfoPanel/BtnGroup" .. index)

		table.insert(self.towerCells, newCell)
	end

	self.imgPrivilege = UIControls.Image(self, "ImgPrivilege")
end

function EquipTowerMainDlg:onCloseClick()
	self:setVisible(false)
end

function EquipTowerMainDlg:onOpen()
	EquipTowerMainDlg.super.onOpen(self)
	self:refreshData()
end

function EquipTowerMainDlg:refreshData()
	local towerData = CurAvatar.equipTowerData

	for towerType, cell in ipairs(self.towerCells) do
		cell:setData(towerType, towerData[towerType] or {})
	end

	self.btnGofor:setVisible(CurAvatar:hasEquipTowerGetCustomLayer())

	local state, time = CurAvatar:checkPrivielgeMonthCardEffect()

	if state then
		self.imgPrivilege:setVisible(true)
	else
		self.imgPrivilege:setVisible(false)

		if time then
			CurAvatar:checkPrivilegeMonthCardLapseShow(time, Const.PRIVITY_KEY_EQUIP_TOWER_SWEEP)
		end
	end
end

function EquipTowerMainDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_EQUIPTOWER)
end

function EquipTowerMainDlg:onBtnGoforClick()
	UIManager.getUI("equipSuitSpeInquireDlg", true):setData()
end

return EquipTowerMainDlg

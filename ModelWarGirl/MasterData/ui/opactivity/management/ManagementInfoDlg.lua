-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Management\\ManagementInfoDlg.lua

local ResBusinessLuckyUp = require("ClientData/ResBusinessLuckyUp")
local ManagementToyCell = require("UI/OpActivity/Management/ManagementToyCell")
local PetStarCell = Class("ManagementInfoDlg_PetStarCell", UIControls.Panel)

function PetStarCell:ctor()
	self.starPanelList = {}

	for i = 1, 5 do
		local panel = UIControls.Panel(self, self.mPath .. "/PetStarPanel/StarPanel/ImgStar" .. i .. "/ImgStar")

		table.insert(self.starPanelList, panel)
	end

	self.txtNum = UIControls.Label(self, self.mPath .. "/BuffPanel/TextNum")
	self.txtTips = UIControls.Label(self, self.mPath .. "/BuffPanel/TextTips")
end

function PetStarCell:setData(star, actData, config)
	for i = 1, 5 do
		self.starPanelList[i]:setVisible(i <= star)
	end

	local baseLucky = actData.miscData.base_lucky_value
	local maxLucky = actData.maxLucky
	local lucky = config and baseLucky + config.lucky_value or baseLucky
	local times = math.ceil(maxLucky / lucky)

	self.txtNum:setText("+" .. lucky)
	self.txtTips:setText(string.format(Lang.get(93288), times))
end

local PetStarMoreCell = Class("ManagementInfoDlg_PetStarMoreCell", UIControls.Child)

function PetStarMoreCell:ctor()
	self.selectPanel = UIControls.Panel(self, "ImgSel")
	self.starPanelList = {}

	for i = 1, 5 do
		local panel = UIControls.Panel(self, "StarPanel/ImgStar" .. i .. "/ImgStar")

		table.insert(self.starPanelList, panel)
	end

	self.txtNum = UIControls.Label(self, "TextNum")
	self.txtBurstNum = UIControls.Label(self, "TextBurstNum")
end

function PetStarMoreCell:setData(star, actData, config)
	for i = 1, 5 do
		self.starPanelList[i]:setVisible(i <= star)
	end

	local baseLucky = actData.miscData.base_lucky_value
	local maxLucky = actData.maxLucky
	local lucky = config and baseLucky + config.lucky_value or baseLucky
	local times = math.ceil(maxLucky / lucky)

	self.txtNum:setText("+" .. lucky)
	self.txtBurstNum:setText(string.format(Lang.get(90637), times))
end

function PetStarMoreCell:setSelect(value)
	self.selectPanel:setVisible(value)
end

local ManagementInfoDlg = Class("ManagementInfoDlg", UIControls.Window)

function ManagementInfoDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.txtRate = UIControls.Label(self, "BgPanel/ManagementInfoPanel/TextTitle1/TextEnergyRate")
	self.txtLv = UIControls.Label(self, "BgPanel/ManagementInfoPanel/TextTitle2/TextLvNum")
	self.btnTips = UIControls.Button(self, "BgPanel/TitlePanel/BtnTips")

	self.btnTips:addEventClick(self.onClickBtnTips)

	self.imgPet = UIControls.Image(self, "BgPanel/ImgPet")
	self.txtPetName = UIControls.Label(self, "BgPanel/ImgPet/TextTitle")
	self.curStarCell = PetStarCell(self, "BgPanel/StarPanel/CurrentStarPanel")
	self.nextStarCell = PetStarCell(self, "BgPanel/StarPanel/NextStarPanel")
	self.btnOpenStarMore = UIControls.Button(self, "BgPanel/BtnStarMore")

	self.btnOpenStarMore:addEventClick(self.onClickBtnOpenStarMore)

	self.starMorePanel = UIControls.Panel(self, "BuffPanel")
	self.btnCloseStarMore = UIControls.Button(self, "BuffPanel/UIClickThrough")

	self.btnCloseStarMore:addEventClick(self.onClickBtnCloseStarMore)

	self.slotOnClickToyCell = Slot(self.onClickToyCell, self)
	self.toyCellList = {}
	self.starCellList = {}
end

function ManagementInfoDlg:setData(actData)
	self.actData = actData
	self.actId = actData.actId

	local config = self.actData.miscData

	if config.pet_icon_name then
		self.imgPet:setImage("Atlas/" .. config.pet_icon_path, config.pet_icon_name)
	end

	if config.pet_name then
		self.txtPetName:setText(config.pet_name)
	end

	self.txtRate:setText(utils.format(self.actData.miscData.stamina_recovery_format2, self.actData.staminaRefreshStep / 60, self.actData.staminaRecoverySpeed))
	self.txtLv:setText(string.format(Lang.get(80803), self.actData.unlockToyQuality))

	local toyTypeList = self.actData.unlockToyTypeList
	local cellList = self.toyCellList
	local dataList = toyTypeList
	local dataNum = #dataList
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = ManagementToyCell(self, "BgPanel/ManagementInfoPanel/ToyRootPanel/GridToy", "System/Activity/ActivityManagement1/ToyNeedCell")

			cell:init(false, nil, self.slotOnClickToyCell)
			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local type = dataList[i]

		cell:setData(self.actId, type)
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end

	self.curStar = 0

	local petId = self.actData.miscData.related_pet_id
	local pet = CurAvatar:getPetByResId(petId)

	if pet then
		self.curStar = pet.star
	else
		pet = BaseObject.GetObject(petId)
	end

	self:refreshStar()
end

function ManagementInfoDlg:onClickToyCell(toyCell)
	local ui = UIManager.getUI("managementToyInfoDlg", true)

	if ui then
		ui:setData(self.actId, toyCell.type, toyCell.quality, self.actData.unlockToyQuality)
	end
end

function ManagementInfoDlg:refreshStar()
	local checkShowCur = false
	local checkShowNext = false

	for _, config in pairs(ResBusinessLuckyUp) do
		if config.pet_star == self.curStar then
			self.curStarCell:setData(config.pet_star, self.actData, config)

			checkShowCur = true
		end

		if config.pet_star == self.curStar + 1 then
			self.nextStarCell:setData(config.pet_star, self.actData, config)

			checkShowNext = true
		end

		if checkShowCur and checkShowNext then
			break
		end
	end

	if not checkShowCur then
		self.curStarCell:setData(0, self.actData)
	end

	self.nextStarCell:setVisible(checkShowNext)
end

function ManagementInfoDlg:refreshStarMore()
	local cellList = self.starCellList
	local dataList = ResBusinessLuckyUp
	local dataNum = #dataList + 1
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = PetStarMoreCell(self, "BuffPanel/BgPanel/BuffNumPanel", "System/Activity/ActivityManagement1/PetStarCell")

			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local star = 0

		if i == 1 then
			cell:setData(star, self.actData)
		else
			local data = dataList[i - 1]

			star = data.pet_star

			cell:setData(star, self.actData, data)
		end

		cell:setSelect(star == self.curStar)
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end
end

function ManagementInfoDlg:onClickBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(self.actData.miscData.pet_info_tip)
end

function ManagementInfoDlg:onClickBtnOpenStarMore()
	self.starMorePanel:setVisible(true)
	self:refreshStarMore()
end

function ManagementInfoDlg:onClickBtnCloseStarMore()
	self.starMorePanel:setVisible(false)
end

function ManagementInfoDlg:onClickBtnClose()
	self:setVisible(false)
end

return ManagementInfoDlg

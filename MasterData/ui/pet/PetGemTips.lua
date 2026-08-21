-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemTips.lua

local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local strClassName = "PetGemTips"
local PetGemTips = Class(strClassName, UIControls.Tips)

function PetGemTips:ctor(prefabPath, order, needShow)
	self:initUI()
end

function PetGemTips:initUI()
	self:initFuncBtn(3)

	self.funcPanel = UIControls.Panel(self, "BgPanel/Func")
	self.petInfoNone = UIControls.Panel(self, "BgPanel/PetInfoNone")
	self.petName = UIControls.Label(self, "BgPanel/PetInfo/PetName")
	self.gemInfoPart = PetGemInfoPart(self, "BgPanel/BgR/AttrPanel")
	self.iconStarRedNew = UIControls.Image(self, "BgPanel/Func/BtnFunc3/IconNew")
	self.petGemName = UIControls.Label(self, "BgPanel/BgR/PetGemName")
	self.gemImg = UIControls.Image(self, "BgPanel/BgR/PetGemItem")
	self.iconNew = UIControls.Image(self, "BgPanel/Func/BtnFunc3/IconNew")
	self.btnSwitch = UIControls.Button(self, "BgPanel/BtnChangeGroup/BtnSwitch")

	self.btnSwitch:addEventClick(self.onClickBtnSwitch)

	self.btnWash = UIControls.Button(self, "BgPanel/BtnChangeGroup/BtnWash")

	self.btnWash:addEventClick(self.onClickBtnWash)
end

function PetGemTips:_setObj(grid, params)
	self.grid = grid
	self.gem = grid.object
	self.pet = nil

	if params and params.pet then
		self.pet = params.pet
	elseif self.gem.inWearing then
		local petResId = self.gem.inWearing

		self.pet = CurAvatar.petDic[petResId]
	end

	local checkPet = self.pet ~= nil

	self.petInfoNone:setVisible(not checkPet)

	if checkPet then
		self.gridPet = UIControls.ItemGridChild(self, "BgPanel/PetInfo", "System/Common/Grid/GridMaterialItem", 0, 0, true)

		self.gridPet:setObj(self.pet)
		self.gridPet.btnSensor:setEnable(false)
		self.petName:setText(self.pet.name)
	end

	self.petGemName:setText(self.gem.name)

	if self.gemGrid == nil then
		self.gemGrid = UIControls.GridPetGemChild(self, "BgPanel/BgR/PetGemItem", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.gemGrid:setObj(self.gem)
	self.gemGrid:setGridClickEnable(false)

	if params and params.hideIconState then
		self.gemGrid:hideIconState()
	end

	self.gemInfoPart:setData(self.gem)
	self.iconNew:setVisible(not self.gem:isMaxLevel() and self.gem:checkGemCanLevelUp())

	local checkShowPetGemChange = params and params.checkShowPetGemChange or false

	self:refreshBtnSwitchAndBtnWash(checkShowPetGemChange)
end

function PetGemTips:setAllBtnVisible(v)
	self.funcPanel:setVisible(v)
end

function PetGemTips:refreshBtnSwitchAndBtnWash(checkShowPetGemChange)
	local checkSwitchEnterOpen = checkShowPetGemChange and CurAvatar:checkPetGemCanSwitch(self.gem)
	local checkWashEnterOpen = checkShowPetGemChange and CurAvatar:checkPetGemCanWash(self.gem)

	self.btnSwitch:setVisible(checkSwitchEnterOpen)
	self.btnWash:setVisible(checkWashEnterOpen)
end

function PetGemTips:onClickBtnSwitch()
	self:setVisible(false)

	local ui = UIManager.getUI("petGemSwitchDlg", true)

	if ui then
		ui:setData(self.gem)
	end
end

function PetGemTips:onClickBtnWash()
	self:setVisible(false)

	local ui = UIManager.getUI("petGemWashDlg", true)

	if ui then
		ui:setData(self.gem)
	end
end

return PetGemTips

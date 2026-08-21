-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\BtnSuitChosen.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local strClassName = "BtnSuitChosen"
local BtnSuitChosen = Class(strClassName, UIControls.Child)

function BtnSuitChosen:ctor()
	self:initUI()
end

function BtnSuitChosen:initUI()
	self.txtSuitName = UIControls.Label(self, "TxtSuitName")
	self.iconSuit = UIControls.Image(self, "IconSuit")
	self.btnSuitChosen = UIControls.Button(self, "")
	self.imgHero = UIControls.Image(self, "ImgHero")

	self.btnSuitChosen:addEventClick(self.onBtnSuitChosenClick)
end

function BtnSuitChosen:setSuitId(suitId, idx, heroId)
	self.suitId = suitId
	self.idx = idx

	if ResEquipSuit[self.suitId] then
		self.iconSuit:setImage(UIConst.COMMON_ICON_PATH .. ResEquipSuit[self.suitId].iconPath, ResEquipSuit[self.suitId].icon)
		self.txtSuitName:setText(ResEquipSuit[self.suitId].name)
	end

	if heroId then
		self.imgHero:setVisible(true)

		local fakeHero = BaseObject.GetObject(heroId)
		local iconPath = fakeHero:getQIconPath()

		if iconPath then
			self.imgHero:setImage(iconPath[1], iconPath[2])
		end
	else
		self.imgHero:setVisible(false)
	end
end

function BtnSuitChosen:onBtnSuitChosenClick()
	if self.idx then
		self.mWindow:delSelectedSuit(self.idx)
	end
end

return BtnSuitChosen

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\CardPetMixin.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "CardPetMixin"
local CardPetMixin = {}
local QUALITY_ATLAS = "Atlas/PetAtlas/PetCardCommonAtlas"

function CardPetMixin:ctorMixin()
	self:initUI()
end

function CardPetMixin:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onSelfClick)

	self.iconPet = UIControls.Image(self, "InfoPanel/IconPet")
	self.qualityImg01 = UIControls.Image(self, "InfoPanel/QualityImg01")
	self.qualityImg02 = UIControls.Image(self, "InfoPanel/QualityImg02")
	self.iconNew = UIControls.Image(self, "InfoPanel/IconNew")
	self.iconNew2 = UIControls.Image(self, "InfoPanel/IconNew2")
	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "InfoPanel/StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "InfoPanel/StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end

	self.panelSelect = UIControls.Panel(self, "InfoPanel/ImgSelect")
	self.panelInTeam = UIControls.Panel(self, "InfoPanel/ImgSelect02")

	if UIControls.checkControlFunc(self, "InfoPanel/ImgEnchantCareer") then
		self.panelPossessCareer = UIControls.Panel(self, "InfoPanel/ImgEnchantCareer")
		self.imgPossessCareer = UIControls.Image(self, "InfoPanel/ImgEnchantCareer/Image")
		self.imgPossessState = UIControls.Image(self, "InfoPanel/ImgEnchantState")
	end

	if UIControls.checkControlFunc(self, "InfoPanel/IconCD") then
		self.imgCd = UIControls.Image(self, "InfoPanel/IconCD")
	end
end

function CardPetMixin:setPet(object)
	self.pet = object
	self.object = object

	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= self.pet.star)
	end

	local iconPath = self.pet:getIconPath()

	if iconPath and iconPath[1] and iconPath[2] then
		self.iconPet:setImage(iconPath[1], iconPath[2])
	end

	local ImgStr1 = {
		"BgPetOrange1",
		"BgPetPurple1",
		"BgPetRed1"
	}
	local ImgStr2 = {
		"BgPetOrange2",
		"BgPetPurple2",
		"BgPetRed2"
	}

	self.qualityImg01:setImage(QUALITY_ATLAS, ImgStr1[self.pet.quality - 3] or ImgStr1[1])
	self.qualityImg02:setImage(QUALITY_ATLAS, ImgStr2[self.pet.quality - 3] or ImgStr2[1])
end

function CardPetMixin:setSelected(isSelected, inTeam)
	self.panelSelect:setVisible(isSelected)

	if inTeam then
		self.panelInTeam:setVisible(true)
	else
		self.panelInTeam:setVisible(false)
	end
end

function CardPetMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function CardPetMixin:clearSelectCallback(...)
	self.selectCallback = nil
end

function CardPetMixin:onSelfClick(sender)
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function CardPetMixin:showPossessCareer(career)
	if self.imgPossessCareer then
		self.panelPossessCareer:setVisible(career ~= nil)

		if career then
			self.imgPossessCareer:setImage("Atlas/PetAtlas/PetEnchantAtlas5", "IconCareer" .. career)
		end
	end
end

function CardPetMixin:showPossessState(value, career)
	if self.imgPossessState then
		self.imgPossessState:setVisible(value)

		if value then
			self.imgPossessState:setImage("Atlas/PetAtlas/PetEnchantAtlas5", "IconCareer" .. career)
		end
	end
end

function CardPetMixin:setRed2(value)
	self.iconNew2:setVisible(value)
end

function CardPetMixin:setCd(value)
	self:clearCd()

	local checkCd = value > 0

	if self.imgCd then
		self.imgCd:setVisible(checkCd)
	end

	if checkCd then
		self.slotCdTimerCb = self.slotCdTimerCb or Slot(self.cdTimerCb, self)
		self.cdTimer = Timer.New(self.slotCdTimerCb, value)
	end
end

function CardPetMixin:cdTimerCb()
	self.cdTimer = nil

	if self.imgCd then
		self.imgCd:setVisible(false)
	end
end

function CardPetMixin:clearCd()
	if self.cdTimer then
		self.cdTimer:Stop()

		self.cdTimer = nil

		if self.imgCd then
			self.imgCd:setVisible(false)
		end
	end
end

return CardPetMixin

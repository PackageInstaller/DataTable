-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPetGiftHeadMixin.lua

local ResPetGifted = require("ClientData/ResPetGifted")
local GridPetGiftHeadMixin = {}

function GridPetGiftHeadMixin:ctorMixin()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onClickBtn)

	self.imgIcon = UIControls.Image(self, "SkillIcon")
	self.imgQuality = UIControls.Image(self, "SkillIcon/ImgQuality")
	self.imgSelect = UIControls.Image(self, "ImgSel")
end

function GridPetGiftHeadMixin:init(clickCb)
	self.clickCb = clickCb
end

function GridPetGiftHeadMixin:setData(giftId, petId)
	self.giftId = giftId
	self.petId = petId

	local config = ResPetGifted[self.giftId]

	if config then
		self.imgIcon:setImage(config.icon_path, config.icon)
		self.imgQuality:setImage("Atlas/PetAtlas/PetEnchantAtlas1", "BgSkill" .. config.quality)
	end
end

function GridPetGiftHeadMixin:setClickEnable(value)
	self.btn:setEnable(value)
end

function GridPetGiftHeadMixin:setSelect(value)
	self.imgSelect:setVisible(value)
end

function GridPetGiftHeadMixin:onClickBtn()
	if self.clickCb then
		self.clickCb(self)
	end
end

return GridPetGiftHeadMixin

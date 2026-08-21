-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPetGiftDetailMixin.lua

local ResPetGifted = require("ClientData/ResPetGifted")
local GridPetGiftDetailMixin = {}

function GridPetGiftDetailMixin:ctorMixin()
	self.unlockPanel = UIControls.Panel(self, "UnlockPanel")
	self.imgIcon = UIControls.Image(self, "UnlockPanel/SkillIcon")
	self.giftHeadcell = UIControls.GridPetGiftHeadChild(self, "UnlockPanel/SkillIcon", "System/Pet/GridEnchantSkill")

	self.giftHeadcell:setVisible(true)
	self.giftHeadcell:setClickEnable(false)

	self.txtName = UIControls.Label(self, "UnlockPanel/TextTitle")
	self.txtDes = UIControls.Label(self, "UnlockPanel/Text")
	self.statePanel = UIControls.Panel(self, "UnlockPanel/IconState")
	self.imgNml = UIControls.Panel(self, "UnlockPanel/ImgNml")
	self.imgSel = UIControls.Panel(self, "UnlockPanel/ImgSel")
	self.imgNew = UIControls.Image(self, "UnlockPanel/IconNew")
	self.lockPanel = UIControls.Panel(self, "LockPanel")
	self.noContentPanel = UIControls.Panel(self, "NoContentPanel")
end

function GridPetGiftDetailMixin:setData(checkUnlock, giftId)
	self.giftId = giftId

	local checkData = checkUnlock and giftId > 0

	self.lockPanel:setVisible(not checkUnlock)
	self.unlockPanel:setVisible(checkData)
	self.noContentPanel:setVisible(checkUnlock and not checkData)

	if checkData then
		local config = ResPetGifted[giftId]

		if config then
			self.txtName:setText(config.name)
			self.txtDes:setText(config.desc)
			self.giftHeadcell:setData(giftId)
		end
	end
end

function GridPetGiftDetailMixin:setHave(value)
	self.statePanel:setVisible(value)
	self.imgSel:setVisible(value)
	self.imgNml:setVisible(not value)
end

function GridPetGiftDetailMixin:setNew(value)
	self.imgNew:setVisible(value)
end

return GridPetGiftDetailMixin

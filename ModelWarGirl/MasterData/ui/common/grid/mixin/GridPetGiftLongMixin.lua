-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPetGiftLongMixin.lua

local ResPetGifted = require("ClientData/ResPetGifted")
local ResClientNotice = require("ClientData/ResClientNotice")
local GridPetGiftLongMixin = {}

function GridPetGiftLongMixin:ctorMixin()
	self.unlockPanel = UIControls.Panel(self, "UnlockPanel")
	self.imgIcon = UIControls.Image(self, "UnlockPanel/SkillIcon")
	self.giftHeadcell = UIControls.GridPetGiftHeadChild(self, "UnlockPanel/SkillIcon", "System/Pet/GridEnchantSkill")

	self.giftHeadcell:setVisible(true)
	self.giftHeadcell:setClickEnable(false)

	self.txtName = UIControls.Label(self, "UnlockPanel/TextTitle")
	self.txtDes = UIControls.Label(self, "UnlockPanel/Text")
	self.lockPanel = UIControls.Panel(self, "LockPanel")
	self.strLock = UIControls.Label(self, "LockPanel/Text")
	self.noContentPanel = UIControls.Panel(self, "NoContentPanel")
	self.btnMore = UIControls.Button(self, "UnlockPanel/BtnMore")

	self.btnMore:addEventClick(self.onClickBtnMore)

	self.skillInfoPanel = UIControls.Panel(self, "UnlockPanel/SkillInfoPanel")
	self.btnClickThrough = UIControls.Button(self, "UnlockPanel/UIClickThrough")

	self.btnClickThrough:addEventClick(self.onClickBtnClickThrough)

	self.txtInfoName = UIControls.Label(self, "UnlockPanel/SkillInfoPanel/TextTitle")
	self.txtInfoDes = UIControls.Label(self, "UnlockPanel/SkillInfoPanel/TextTips")
end

function GridPetGiftLongMixin:setData(checkUnlock, giftId, unlockStar)
	self.giftId = giftId

	local checkData = checkUnlock and giftId > 0

	self.lockPanel:setVisible(not checkUnlock)
	self.unlockPanel:setVisible(checkData)
	self.noContentPanel:setVisible(checkUnlock and not checkData)

	if checkData then
		self.giftHeadcell:setData(giftId)

		local config = ResPetGifted[giftId]

		if config then
			self.txtName:setText(config.name)
			self.txtDes:setText(config.desc)
			self.txtInfoName:setText(config.name)
			self.txtInfoDes:setText(config.desc)
		end
	end

	if not checkUnlock and unlockStar then
		self.strLock:setText(string.format(ResClientNotice[761].notice, unlockStar))
	end
end

function GridPetGiftLongMixin:onClickBtnMore()
	self.skillInfoPanel:setVisible(true)
	self.btnClickThrough:setVisible(true)
end

function GridPetGiftLongMixin:onClickBtnClickThrough()
	self.skillInfoPanel:setVisible(false)
	self.btnClickThrough:setVisible(false)
end

return GridPetGiftLongMixin

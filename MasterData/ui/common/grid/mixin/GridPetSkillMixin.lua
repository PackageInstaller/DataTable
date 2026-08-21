-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPetSkillMixin.lua

local ResSkillConfig = require("ClientData/ResSkillConfig")
local ResPetAmulet = require("ClientData/ResPetAmulet")
local GridPetSkillMixin = {}

function GridPetSkillMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
end

function GridPetSkillMixin:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onGridClick)

	self.bg1 = UIControls.Image(self, "Bg1")
	self.iconSkill = UIControls.Image(self, "InfoPanel/IconPet")
	self.imgSelect = UIControls.Image(self, "InfoPanel/ImgSelect")
	self.starGroup = {}

	for i = 1, 5 do
		local star = UIControls.Panel(self, "InfoPanel/StartGroup/Start0" .. i)
		local checkmark = UIControls.Image(self, "InfoPanel/StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.starGroup, {
			star = star,
			checkmark = checkmark
		})
	end

	self.iconState = UIControls.Image(self, "InfoPanel/IconState")
	self.iconStarUpRed = UIControls.Image(self, "InfoPanel/IconNew2")
end

function GridPetSkillMixin:setObj(amulet)
	self.object = amulet

	if amulet == nil then
		self:clear()

		return
	end

	self:_setObj(amulet)
end

function GridPetSkillMixin:_setObj(amulet)
	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= amulet.star)
		self.starGroup[i].star:setVisible(i <= amulet.maxStar)
	end

	local iconPath = amulet:getIconPath()

	if iconPath and iconPath[1] and iconPath[2] then
		self.iconSkill:setImage(iconPath[1], iconPath[2])
	end

	self.iconState:setVisible(amulet.inWearing ~= nil)
end

function GridPetSkillMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	if self:isEmpty() then
		return
	end

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

function GridPetSkillMixin:setGridClickEnable(v)
	self.btnSelf:setEnable(v)
end

function GridPetSkillMixin:clear()
	self.object = nil
end

function GridPetSkillMixin:isEmpty()
	return self.object == nil
end

function GridPetSkillMixin:hideIconState()
	self.iconState:setVisible(false)
end

return GridPetSkillMixin

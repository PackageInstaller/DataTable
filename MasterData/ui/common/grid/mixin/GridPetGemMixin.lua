-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridPetGemMixin.lua

local ResPetGem = require("ClientData/ResPetGem")
local GridPetGemMixin = {}

function GridPetGemMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
	self.mEventDelClick = nil
end

function GridPetGemMixin:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onGridClick)

	self.iconSkill = UIControls.Image(self, "InfoPanel/IconGem")
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

	if UIControls.checkControlFunc(self, "InfoPanel/IconState") then
		self.iconState = UIControls.Image(self, "InfoPanel/IconState")
	end

	self.iconStarUpRed = UIControls.Image(self, "InfoPanel/IconNew2")

	if UIControls.checkControlFunc(self, "InfoPanel/ImgLock") then
		self.imgLock = UIControls.Image(self, "InfoPanel/ImgLock")
	end

	self.txtLv = UIControls.Label(self, "InfoPanel/GemLv/Text")

	if UIControls.checkControlFunc(self, "InfoPanel/BtnDel") then
		self.btnDel = UIControls.Button(self, "InfoPanel/BtnDel")

		self.btnDel:addEventClick(self.onBtnDelClick)
	end
end

function GridPetGemMixin:setObj(gem)
	self.object = gem

	if gem == nil then
		self:clear()

		return
	end

	self:_setObj(gem)
end

function GridPetGemMixin:_setObj(gem)
	self.gem = gem
	self.level = gem.level or gem.resData.level

	local showLevel = math.fmod(self.level, 3)

	showLevel = showLevel == 0 and 3 or showLevel

	for i, v in ipairs(self.starGroup) do
		self.starGroup[i].checkmark:setVisible(i <= showLevel)
		self.starGroup[i].star:setVisible(i <= showLevel)
	end

	self:setGemIcon()

	if self.iconState then
		self.iconState:setVisible(gem.inWearing ~= nil)
	end

	if Const.REVIEW_VERSION then
		self.txtLv:setText(string.format(Lang.get(111361), self.level))
	else
		self.txtLv:setText(string.format("Lv.%d", self.level))
	end
end

function GridPetGemMixin:setGemIcon()
	local iconPath = self.gem:getIconPath()

	if iconPath and iconPath[1] and iconPath[2] then
		self.iconSkill:setImage(iconPath[1], iconPath[2])
	end
end

function GridPetGemMixin:setRandIcon()
	local iconPath = self.gem:getIconPath(true)

	if iconPath and iconPath[1] and iconPath[2] then
		self.iconSkill:setImage(iconPath[1], iconPath[2])
	end
end

function GridPetGemMixin:setSelect(value)
	self.imgSelect:setVisible(value)
end

function GridPetGemMixin:onGridClick(sender)
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

function GridPetGemMixin:setGridClickEnable(v)
	self.btnSelf:setEnable(v)
end

function GridPetGemMixin:clear()
	self.object = nil
end

function GridPetGemMixin:isEmpty()
	return self.object == nil
end

function GridPetGemMixin:hideIconState()
	if self.iconState then
		self.iconState:setVisible(false)
	end
end

function GridPetGemMixin:setVisibleDelBtn(showDelBtn)
	if self.btnDel then
		self.btnDel:setVisible(showDelBtn)
	end
end

function GridPetGemMixin:onBtnDelClick()
	if self.mEventDelClick then
		self.mEventDelClick(self)
	end
end

return GridPetGemMixin

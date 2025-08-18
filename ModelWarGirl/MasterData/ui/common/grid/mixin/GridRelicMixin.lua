-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridRelicMixin.lua

local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local GridRelicMixin = {}

function GridRelicMixin:initUI()
	GridItemMixin.initUI(self)

	self.bgLv = UIControls.Panel(self, self.basePath .. "BgLv")
	self.imgMax = UIControls.Panel(self, self.basePath .. "BgLv/ImgMax")
	self.imgHero = UIControls.Image(self, self.basePath .. "ImgHero")
	self.txtLv = UIControls.Label(self, self.basePath .. "BgLv/TextLv")
	self.panelWearing = UIControls.Panel(self, self.basePath .. "IconState")
	self.imgSkillType = UIControls.Image(self, self.basePath .. "IconSkillType")
	self.bgGroup = UIControls.Panel(self, self.basePath .. "BgGroup")
	self.imgGroup = UIControls.Image(self, self.basePath .. "BgGroup/IconGroup")
	self.bgCareer = UIControls.Panel(self, self.basePath .. "BgCareer")
	self.imgCareer = UIControls.Image(self, self.basePath .. "BgCareer/IconCareer")
	self.sliderEnhance = UIControls.Slider(self, self.basePath .. "Slider")
	self.txtEnhanceNum = UIControls.Label(self, self.basePath .. "TextSliderNum")
end

function GridRelicMixin:hideLimitInfo()
	self.imgHero:setVisible(false)
	self.bgGroup:setVisible(false)
	self.bgCareer:setVisible(false)
	self.sliderEnhance:setVisible(false)
	self.txtEnhanceNum:setVisible(false)
	self.imgSelect:setVisible(false)
end

function GridRelicMixin:setIconGray(isGray)
	GridItemMixin.initUI(self, isGray)

	if self.imgHero and self.imgHero:getVisible() then
		self.imgHero:setImageGray(isGray)
	end

	if self.imgSkillType and self.imgSkillType:getVisible() then
		self.imgSkillType:setImageGray(isGray)
	end

	if self.imgCareer and self.imgCareer:getVisible() then
		self.imgCareer:setImageGray(isGray)
	end

	if self.imgGroup and self.imgGroup:getVisible() then
		self.imgGroup:setImageGray(isGray)
	end
end

function GridRelicMixin:_setObj(object)
	GridItemMixin._setObj(self, object)

	if not self.object:isEnhanceLvMax() then
		self.imgMax:setVisible(false)

		if self.inBag == true then
			self.sliderEnhance:setVisible(true)
			self.txtEnhanceNum:setVisible(true)

			local lvUpNeedInfo = self.object:getLvUpNeed()

			if lvUpNeedInfo then
				local haveNum = CurAvatar:getItemNumById(self.object.lvUpMaterialId)
				local needNum = lvUpNeedInfo[self.object.lvUpMaterialId]

				self.sliderEnhance:setValue(haveNum / needNum)
				self.txtEnhanceNum:setText(haveNum .. "/" .. needNum)
			end
		end
	else
		self.imgMax:setVisible(true)
		self.sliderEnhance:setVisible(false)
		self.txtEnhanceNum:setVisible(false)
	end

	self.imgNew:setVisible(self.inBag == true and CurAvatar:relicCanLvUp(self.object))
	self.bgLv:setVisible(self.object.enhanceLevel ~= 0)

	if self.object.enhanceLevel > 0 and self.object.enhanceLevel < self.object.maxLevel then
		self.txtLv:setVisible(true)
		self.txtLv:setText("+" .. self.object.enhanceLevel)
	else
		self.txtLv:setVisible(false)
	end

	local headPath = self.object:getHeroHeadPath()

	if headPath then
		self.imgHero:setImage(headPath[1], headPath[2])
		self.imgHero:setVisible(true)
	else
		self.imgHero:setVisible(false)
	end

	if object.inWearing then
		self.panelWearing:setVisible(true)
	else
		self.panelWearing:setVisible(false)
	end

	local campPath = self.object:getHeroCampPath()

	if campPath then
		self.imgGroup:setImage(campPath[1], campPath[2])
		self.bgGroup:setVisible(true)
	else
		self.bgGroup:setVisible(false)
	end

	local careerPath = self.object:getHeroCareerPath()

	if careerPath and not self.imgHero:getVisible() then
		self.imgCareer:setImage(careerPath[1], careerPath[2])
		self.bgCareer:setVisible(true)
	else
		self.bgCareer:setVisible(false)
	end

	local skillTypePath = self.object:getSkillTypePath()

	if skillTypePath then
		self.imgSkillType:setImage(skillTypePath[1], skillTypePath[2])
		self.imgSkillType:setVisible(true)
	else
		self.imgSkillType:setVisible(false)
	end
end

function GridRelicMixin:openTipsPanel()
	if self.mEnableTips then
		UIManager.getUI("relicTips"):show(self, self.mTipsConfig)
	end
end

function GridRelicMixin:clear()
	GridItemMixin.clear(self)
end

setmetatable(GridRelicMixin, {
	__index = GridItemMixin
})

return GridRelicMixin

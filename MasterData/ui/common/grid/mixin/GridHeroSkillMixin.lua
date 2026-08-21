-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridHeroSkillMixin.lua

local HeroSkillTips = require("UI/Common/Tips/HeroSkillTips")
local ResStepDes = require("ClientData/ResStepDes")
local ResStep = require("ClientData/ResStep")
local ResColor = require("ClientData/ResColor")
local GridHeroSkillMixin = {}

function GridHeroSkillMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
end

function GridHeroSkillMixin:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onGridClick)

	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtLv = UIControls.Label(self, "TextLv")
	self.imgType = UIControls.Image(self, "ImgType")
	self.imgLock = UIControls.Image(self, "IconLock")
	self.imgBgUp = UIControls.Image(self, "BgUp")
	self.txtUp = UIControls.Label(self, "BgUp/TextUp")
	self.imgSelect = UIControls.Image(self, "ImgDis")
	self.imgRelic = UIControls.Image(self, "IconRelic")
end

function GridHeroSkillMixin:setObj(skill, hero)
	self.object = skill
	self.hero = hero

	if skill == nil then
		self:clear()

		return
	end

	self:_setObj(skill)
end

function GridHeroSkillMixin:_setObj(skill)
	local iconPath = skill:getIconPath()

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
		self.imgIcon:setVisible(true)
	end

	if skill.level > 0 then
		self.txtLv:setText(skill.level)
	end

	self.txtLv:setVisible(skill.level > 0)
	self.imgLock:setVisible(skill.level == 0)
	self.imgIcon:setImageGray(skill.level == 0)

	local styleInfo = skill:getStyleInfo()

	if styleInfo then
		self.imgType:setImage(styleInfo[1], styleInfo[2])
	end

	self.imgBgUp:setVisible(false)

	local relic = self.hero and self.hero:getRelic()

	self.imgRelic:setVisible(self.hero and relic and relic.enhanceSkillField and relic.enhanceSkillField == skill.skillField)
end

function GridHeroSkillMixin:showUpInfo()
	self.imgBgUp:setVisible(true)

	if self.hero.recharge == self.hero.step then
		if ResStepDes[self.hero.id] and ResStepDes[self.hero.id][self.hero.recharge + 1] then
			self.txtUp:setText(string.format(Lang.get(30230), ResStepDes[self.hero.id][self.hero.recharge + 1].step_name))
		end
	elseif Const.REVIEW_VERSION then
		self.txtUp:setText(Lang.get(1203) .. ResStep[self.hero.recharge + 1].level_limit)
	else
		self.txtUp:setText("LV." .. ResStep[self.hero.recharge + 1].level_limit)
	end

	local sprite = self.object.level == 0 and "BgSkillLock" or "BgSkillUpgrade"
	local txtColor = self.object.level == 0 and ResColor.DARKBLUE or ResColor.QUALITYORANGE

	self.imgBgUp:setImage("Atlas/HeroAtlas/HeroAtlas", sprite)
	self.txtUp:setFontColor(txtColor)
end

function GridHeroSkillMixin:clear()
	self.object = nil

	self.imgIcon:setVisible(false)
end

function GridHeroSkillMixin:isEmpty()
	return self.object == nil
end

function GridHeroSkillMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	if self:isEmpty() then
		return
	end

	self:openTipsPanel()

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

function GridHeroSkillMixin:openTipsPanel()
	if self.mEnableTips and self.gridPanel then
		if not self.mParent.skillTips then
			self.mParent.skillTips = HeroSkillTips(self.mParent, UIConst.SKILL_TIPS_INFO[self.gridPanel].nodePath, "System/Common/Tips/SkillTipsInfoPanel", 0, 0, true)
		end

		if not self.mParent.btnSkillTipsSensor then
			self.mParent.btnSkillTipsSensor = UIControls.Button(self.mParent, UIConst.SKILL_TIPS_INFO[self.gridPanel].nodePath .. "/UIClickThrough")

			self.mParent.btnSkillTipsSensor:addEventClick(self.onBtnSkillTipsSensorClick)
		end

		if self.mParent.curSelectSkillGrid then
			self.mParent.curSelectSkillGrid.imgSelect:setVisible(false)
			self.mParent.curSelectSkillGrid.btnSelf:setEnable(true)
		end

		self.mParent.curSelectSkillGrid = self

		self.imgSelect:setVisible(true)
		self.btnSelf:setEnable(false)
		self.mParent.skillTips:setSkill(self)
		self.mParent.skillTips:setVisible(true)
		self.mParent.btnSkillTipsSensor:setVisible(true)
	end
end

function GridHeroSkillMixin:onBtnSkillTipsSensorClick()
	if self.skillTips then
		if self.curSelectSkillGrid then
			self.curSelectSkillGrid.imgSelect:setVisible(false)
			self.curSelectSkillGrid.btnSelf:setEnable(true)
		end

		self.skillTips:setVisible(false)
		self.btnSkillTipsSensor:setVisible(false)
	end
end

function GridHeroSkillMixin:setSelect(value)
	self.imgSelect:setVisible(value)
end

return GridHeroSkillMixin

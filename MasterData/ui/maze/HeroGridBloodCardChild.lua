-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\HeroGridBloodCardChild.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "HeroGridBloodCardChild"
local HeroGridBloodCardChild = Class(strClassName, UIControls.HeroCardChild)

function HeroGridBloodCardChild:initUI(...)
	HeroGridBloodCardChild.super.initUI(self)

	self.panelBlood = UIControls.Panel(self, "InfoPanel/BloodPanel")
	self.slider = UIControls.Slider(self, "InfoPanel/BloodPanel/Slider")
	self.txtValue = UIControls.Label(self, "InfoPanel/BloodPanel/Text")
	self.imgBgDie = UIControls.Image(self, "InfoPanel/BloodPanel/BgDie")
	self.imgBgStandBy = UIControls.Image(self, "InfoPanel/BloodPanel/BgStandby")
	self.imgSliderFill = UIControls.Image(self, "InfoPanel/BloodPanel/Slider/Fill")
	self.sensor = UIControls.Panel(self, "")
	self.showTips = true

	self.btnSelf:setEnable(true)
end

function HeroGridBloodCardChild:onDragGet()
	return
end

function HeroGridBloodCardChild:onDragClick(sender)
	return
end

function HeroGridBloodCardChild:setSelected(isSelected)
	self.beSelected = isSelected

	self.btnSelf:setEnable(not isSelected)
end

function HeroGridBloodCardChild:setHero(hero)
	HeroGridBloodCardChild.super.setHero(self, hero)
	self.sensor:setObjGray(false)
	self:setHeroBlood(hero.mazeHp)
end

function HeroGridBloodCardChild:setHeroBlood(hpPercentValue)
	if hpPercentValue then
		self.panelBlood:setVisible(true)

		if hpPercentValue <= 0 then
			self.txtValue:setVisible(false)
			self.slider:setVisible(false)
			self.imgBgDie:setVisible(true)
			self.imgBgStandBy:setVisible(false)
			self:stopUIEffect()
		else
			self.imgBgDie:setVisible(false)
			self.imgBgStandBy:setVisible(false)
			self.txtValue:setVisible(true)

			local hp = math.floor(hpPercentValue / 100 + 0.5)

			if hp == 0 and hpPercentValue > 0 then
				hp = 1
			elseif hp == 100 and hpPercentValue < 10000 then
				hp = 99
			end

			self.txtValue:setText(hp .. "%")

			local color = ResColor.GREEN

			if hp < 10 then
				color = ResColor.RED
			end

			self.txtValue:setFontColor(color)
			self.imgSliderFill:setColorByRGBA(color.r, color.g, color.b, color.a)
			self.slider:setVisible(true)
		end

		self.slider:setValue(hpPercentValue / 10000)
	else
		self.panelBlood:setVisible(true)
		self.slider:setVisible(false)
		self.txtValue:setVisible(false)
		self.imgBgDie:setVisible(false)
		self.imgBgStandBy:setVisible(true)
	end
end

return HeroGridBloodCardChild

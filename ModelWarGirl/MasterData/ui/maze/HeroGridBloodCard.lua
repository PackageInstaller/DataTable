-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\HeroGridBloodCard.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "HeroGridBloodCard"
local HeroGridBloodCard = Class(strClassName, UIControls.HeroCardLoop)

function HeroGridBloodCard:initUI(...)
	HeroGridBloodCard.super.initUI(self)

	self.panelBlood = UIControls.Panel(self, "InfoPanel/BloodPanel")
	self.slider = UIControls.Slider(self, "InfoPanel/BloodPanel/Slider")
	self.txtValue = UIControls.Label(self, "InfoPanel/BloodPanel/Text")
	self.imgBgDie = UIControls.Image(self, "InfoPanel/BloodPanel/BgDie")
	self.imgBgStandBy = UIControls.Image(self, "InfoPanel/BloodPanel/BgStandby")
	self.imgSliderFill = UIControls.Image(self, "InfoPanel/BloodPanel/Slider/Fill")
	self.imgDieSel = UIControls.Image(self, "InfoPanel/BloodPanel/BgDie/ImgSel")
	self.sensor = UIControls.Panel(self, "")

	self.sensor:addEventDragOnGet(self.onDragGet)
	self.sensor:addEventDragOnClick(self.onDragClick)

	self.showTips = true
	self.isDragTip = true
	self.showSelPic = false
end

function HeroGridBloodCard:onDragGet()
	return
end

function HeroGridBloodCard:onDragClick(sender)
	if self.showTips then
		if self.isDragTip then
			local tips = UIManager.getUI("battleDragHeroTips")

			tips:show(self)
			tips:correctPos(true)
		else
			local tips = UIManager.getUI("heroTips")

			tips:show(self)
		end
	end

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function HeroGridBloodCard:setSelected(isSelected)
	self.beSelected = isSelected

	self.btnSelf:setEnable(not isSelected)
end

function HeroGridBloodCard:setChooseState(v)
	if v then
		if self.imgBgDie:getVisible() then
			self.imgDieSel:setVisible(v)
			self.imgSel:setVisible(not v)
		else
			self.imgDieSel:setVisible(not v)
			self.imgSel:setVisible(v)
		end
	else
		self.imgDieSel:setVisible(v)
		self.imgSel:setVisible(v)
	end
end

function HeroGridBloodCard:setHero(hero)
	HeroGridBloodCard.super.setHero(self, hero)
	self.sensor:setObjGray(false)

	if hero.mazeHp then
		self.panelBlood:setVisible(true)

		if hero.mazeHp <= 0 then
			self.txtValue:setVisible(false)
			self.slider:setVisible(false)
			self.imgBgDie:setVisible(true)
			self.imgBgStandBy:setVisible(false)
			self:stopUIEffect()
		else
			self.imgBgDie:setVisible(false)
			self.imgBgStandBy:setVisible(false)
			self.txtValue:setVisible(true)

			local hp = math.floor(hero.mazeHp / 100 + 0.5)

			if hp == 0 and hero.mazeHp > 0 then
				hp = 1
			elseif hp == 100 and hero.mazeHp < 10000 then
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

		self.slider:setValue(hero.mazeHp / 10000)
	else
		self.panelBlood:setVisible(true)
		self.slider:setVisible(false)
		self.txtValue:setVisible(false)
		self.imgBgDie:setVisible(false)
		self.imgBgStandBy:setVisible(true)
	end
end

return HeroGridBloodCard

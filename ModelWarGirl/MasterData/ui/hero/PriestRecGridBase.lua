-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\PriestRecGridBase.lua

local strClassName = "PriestRecGridBase"
local PriestRecGridBase = Class(strClassName, UIControls.Panel)

function PriestRecGridBase:ctor()
	self:initUI()
end

function PriestRecGridBase:initUI()
	self.btnGo = UIControls.Button(self, self.mPath .. "/BtnGo")

	self.btnGo:addEventClick(self.onBtnGoClick)
end

function PriestRecGridBase:setHero(hero, pos)
	self.hero = hero
	self.pos = pos

	if not self.gridHero then
		self.gridHero = UIControls.HeroCardChild(self, self.mPath .. "/BgGrid", "System/Hero/GridHeroCard", 0, 0, true)
	end

	self.gridHero:setHero(self.hero)
	self.gridHero:setHeroRealLv()
	self.btnGo:setVisible(false)
end

function PriestRecGridBase:clear()
	self.hero = nil

	if self.gridHero then
		self.gridHero:destroy()
	end

	self.btnGo:setVisible(false)
end

function PriestRecGridBase:onBtnGoClick()
	return
end

return PriestRecGridBase

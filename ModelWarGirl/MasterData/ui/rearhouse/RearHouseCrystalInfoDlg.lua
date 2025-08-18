-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCrystalInfoDlg.lua

local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local CrystalInfoCell = Class("CrystalInfoCell", UIControls.Child)
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")

function CrystalInfoCell:ctor(...)
	self:initUI()
end

function CrystalInfoCell:initUI(...)
	self.txtBefore = UIControls.Label(self, "TextBefore")
	self.txtAfter = UIControls.Label(self, "TextAfter")
	self.txtLv = UIControls.Label(self, "TextAfter/TextLv")
	self.heroGrid = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")

	self.heroGrid:setVisible(true)

	self.panelCrystalLv = UIControls.Panel(self, "ImgCrystalLv")
	self.textCrystalLv = UIControls.Label(self, "ImgCrystalLv/TextCrystalLv")
	self.textCrystalOldLv = UIControls.Label(self, "ImgCrystalLv/TextOldLv")
	self.textCrystalOldLvTitle = UIControls.Label(self, "ImgCrystalLv/TextOldLv/Text")
end

function CrystalInfoCell:setData(hero)
	self.txtBefore:setText(hero.realLevel)

	local color = hero:getFakeCrystalColor()
	local crystalSecondLevel = hero:getFakeCrystalSecondLevel()

	if crystalSecondLevel and crystalSecondLevel > 9 then
		self.panelCrystalLv:setVisible(true)
		self.txtAfter:setVisible(false)
		self.textCrystalOldLv:setText(hero:getFakeCrystalLevel())
		self.textCrystalOldLv:setFontColor(color)
		self.textCrystalLv:setText(math.floor(crystalSecondLevel / 10))
		self.textCrystalOldLvTitle:setFontColor(color)
	else
		self.txtAfter:setText(hero:getFakeCrystalLevel())
		self.txtAfter:setFontColor(color)
		self.txtLv:setFontColor(color)
	end

	self.heroGrid:setHero(hero)
	self.heroGrid:hideLevel()
end

local strClassName = "RearHouseCrystalInfoDlg"
local RearHouseCrystalInfoDlg = Class(strClassName, UIControls.Window)

function RearHouseCrystalInfoDlg:ctor(...)
	self:initUI()
end

function RearHouseCrystalInfoDlg:initUI(...)
	return
end

function RearHouseCrystalInfoDlg:setData(data)
	table.sort(data, function(v1, v2)
		if v1.star == v2.star then
			if v1.level == v2.level then
				return v1.id > v2.id
			else
				return v1.level > v2.level
			end
		else
			return v1.star > v2.star
		end
	end)

	for i = 1, #data do
		local cell = CrystalInfoCell(self, "BgPanel/CrystalInfoList/Content", "System/Backyard/CrystalInfoCell", 0, 0, true)

		cell:setData(data[i])
	end
end

function RearHouseCrystalInfoDlg:destroy(...)
	RearHouseCrystalInfoDlg.super.destroy(self)
	RearHouseDragCenter.playShowEventByTurn()
end

return RearHouseCrystalInfoDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PetMaze\\BtnHeroAdd.lua

local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local BtnHeroAdd = Class("BtnHeroAdd", UIControls.Child)

function BtnHeroAdd:ctor()
	self.btnAdd = UIControls.Button(self, "")

	self.btnAdd:addEventClick(self.onClickBtnAdd)

	self.heroAddPanel = UIControls.Panel(self, "HeroAdd")
	self.gridHeroStarUp = GridHeroStarUp(self, "GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
end

function BtnHeroAdd:init(onClickAction)
	self.onClickAction = onClickAction
end

function BtnHeroAdd:setData(hero)
	self.hero = hero

	local checkData = hero ~= nil

	self.gridHeroStarUp:setVisible(checkData)
	self.heroAddPanel:setVisible(not checkData)

	if checkData then
		self.gridHeroStarUp:setHero(hero)
	end
end

function BtnHeroAdd:setEnable(value)
	self.btnAdd:setEnable(value)
end

function BtnHeroAdd:onClickBtnAdd()
	if self.onClickAction then
		self.onClickAction(self.hero)
	end
end

return BtnHeroAdd

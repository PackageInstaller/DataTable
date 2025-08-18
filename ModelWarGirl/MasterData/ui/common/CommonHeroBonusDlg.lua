-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonHeroBonusDlg.lua

local strClassName = "CommonHeroBonusDlg"
local CommonHeroBonusDlg = Class(strClassName, UIControls.Window)

function CommonHeroBonusDlg:ctor()
	self:initUI()
end

function CommonHeroBonusDlg:initUI()
	self.heroGrids = {}
	self.sizeLayout = UIControls.Panel(self, "Bg/HeroCardList")
end

function CommonHeroBonusDlg:onShow(heros)
	for index, hero in ipairs(heros) do
		local newGrid = UIControls.HeroCardChild(self, "Bg/HeroCardList/Content", "System/Hero/GridHeroCard")

		newGrid:setVisible(true)
		newGrid:setHero(hero)
		newGrid:setSelectCallback(Functor(self.showHeroTips, self, hero))
		table.insert(self.heroGrids, newGrid)
	end

	local size = self.sizeLayout:getRectSize()

	if #self.heroGrids <= 6 then
		self.sizeLayout:setRectSize(size.width, 310)
	else
		self.sizeLayout:setRectSize(size.width, 510)
	end
end

function CommonHeroBonusDlg:addHero(hero)
	local newGrid = UIControls.HeroCardChild(self, "Bg/HeroCardList/Content", "System/Hero/GridHeroCard")

	newGrid:setVisible(true)
	newGrid:setHero(hero)
	newGrid:setSelectCallback(Functor(self.showHeroTips, self, hero))
	table.insert(self.heroGrids, newGrid)

	local size = self.sizeLayout:getRectSize()

	if #self.heroGrids <= 6 then
		self.sizeLayout:setRectSize(size.width, 310)
	else
		self.sizeLayout:setRectSize(size.width, 510)
	end
end

function CommonHeroBonusDlg:showHeroTips(hero)
	local heroTips = UIManager.getUI("heroTips")

	heroTips:showObj(self, hero)
end

function CommonHeroBonusDlg:destroy()
	CurAvatar:showHeroSellReward()
	CommonHeroBonusDlg.super.destroy(self)
end

return CommonHeroBonusDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\RecHeroGrid.lua

local PriestRecGridBase = require("UI/Hero/PriestRecGridBase")
local strClassName = "RecHeroGrid"
local RecHeroGrid = Class(strClassName, PriestRecGridBase)

function RecHeroGrid:initUI()
	RecHeroGrid.super.initUI(self)

	self.btnExchange = UIControls.Button(self, self.mPath .. "/BtnExchange")

	self.btnExchange:addEventClick(self.onBtnExchangeClick)

	self.panelStarUp = UIControls.Panel(self, self.mPath .. "/StarUpPanel")
	self.txtSuggest = UIControls.Label(self, self.mPath .. "/StarUpPanel/TextSuggest")
	self.panelExchange = UIControls.Panel(self, self.mPath .. "/ExchangePanel")
end

function RecHeroGrid:setHero(hero, pos)
	RecHeroGrid.super.setHero(self, hero, pos)

	self.samePosPriest = self.mWindow.priestsDic[self.pos]

	self.btnGo:setVisible(self.hero.star < self.hero.previewStar)
	self.panelStarUp:setVisible(self.btnGo:getVisible())

	if self.panelStarUp:getVisible() then
		self.txtSuggest:setText(UIConst.HERO_STAR_EMOJI_DIC[self.hero.previewStar])
	end

	self.btnExchange:setVisible(not self.btnGo:getVisible() and self.samePosPriest ~= nil and self.samePosPriest.gid ~= self.hero.gid and self.samePosPriest.realLevel > self.hero.realLevel and self.samePosPriest.realLevel <= self.hero:getMaxStarLv())
	self.panelExchange:setVisible(self.btnExchange:getVisible())
end

function RecHeroGrid:clear()
	RecHeroGrid.super.clear(self)
	self.btnExchange:setVisible(false)
	self.panelExchange:setVisible(false)
	self.panelStarUp:setVisible(false)
end

function RecHeroGrid:onBtnGoClick()
	UIManager.getUI("heroStarUpDlg", true)
end

function RecHeroGrid:onBtnExchangeClick()
	if self.samePosPriest and self.hero then
		local heroGrowBecomeLeaderDlg = UIManager.getUI("heroGrowBecomeLeaderDlg", true)

		heroGrowBecomeLeaderDlg:setExchangeHeros(self.samePosPriest, self.hero)
	end
end

return RecHeroGrid

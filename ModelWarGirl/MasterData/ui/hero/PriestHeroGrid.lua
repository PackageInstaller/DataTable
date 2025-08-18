-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\PriestHeroGrid.lua

local PriestRecGridBase = require("UI/Hero/PriestRecGridBase")
local strClassName = "PriestHeroGrid"
local PriestHeroGrid = Class(strClassName, PriestRecGridBase)

function PriestHeroGrid:initUI()
	PriestHeroGrid.super.initUI(self)

	self.panelUpgrade = UIControls.Panel(self, self.mPath .. "/UpgradePanel")
	self.txtSuggest = UIControls.Label(self, self.mPath .. "/UpgradePanel/TextSuggest")
end

function PriestHeroGrid:setHero(hero, pos)
	PriestHeroGrid.super.setHero(self, hero, pos)
	self.panelUpgrade:setVisible(false)
end

function PriestHeroGrid:setRecLv(recLv)
	self.recLv = recLv

	self.panelUpgrade:setVisible(true)
	self.txtSuggest:setText(string.format(Lang.get(30362), self.recLv))
	self.btnGo:setVisible(true)
end

function PriestHeroGrid:clear()
	PriestHeroGrid.super.clear(self)
	self.panelUpgrade:setVisible(false)
end

function PriestHeroGrid:onBtnGoClick()
	local heroMainDlg = UIManager.getUI("heroMainDlg", true)

	heroMainDlg:initForContentPanel(Const.HERO_CONTENT_PANEL.BASE_INFO, self.hero.gid)
end

return PriestHeroGrid

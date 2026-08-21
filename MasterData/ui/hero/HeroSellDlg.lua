-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroSellDlg.lua

local strClassName = "HeroSellDlg"
local HeroSellListPanel = require("UI/Hero/HeroSellListPanel")
local HeroSellPreviewPanel = require("UI/Hero/HeroSellPreviewPanel")
local HeroSellDlg = Class(strClassName, UIControls.Window)

function HeroSellDlg:ctor()
	self:initUI()
end

function HeroSellDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.herolistPanel = HeroSellListPanel(self, "HeroListPanel")
	self.heroSellPreviewPanel = HeroSellPreviewPanel(self, "HeroSellPanel")
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)
	self:refreshData()
end

function HeroSellDlg:onCloseClick()
	self:setVisible(false)
end

function HeroSellDlg:setHeroToSell(hero, noRefresh)
	self.herolistPanel:delHero(hero, noRefresh)
	self.heroSellPreviewPanel:addHero(hero, noRefresh)
end

function HeroSellDlg:setHeroToBag(hero)
	self.herolistPanel:addHero(hero)
	self.heroSellPreviewPanel:delHero(hero)
end

function HeroSellDlg:isLastAsyncFormationHero(hero)
	local asyncCount = utils.getTableElemCount(CurAvatar.asyncPVPDefendFormation)
	local preAsyncCount = 0

	for _, preHero in pairs(self.heroSellPreviewPanel.heroList) do
		if CurAvatar.asyncPVPDefendFormation[preHero.gid] then
			preAsyncCount = preAsyncCount + 1
		end
	end

	if preAsyncCount == asyncCount - 1 and CurAvatar.asyncPVPDefendFormation[hero.gid] then
		return true
	end

	return false
end

function HeroSellDlg:refreshData()
	self.herolistPanel:setHeroList(CurAvatar:getCanSellHeroList())

	self.heroSellPreviewPanel.heroList = {}

	self.heroSellPreviewPanel:refreshPanel()
end

function HeroSellDlg:onBtnTipsClick()
	if CurAvatar:haveHeroCanPaint() then
		UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HERO_RECYCLE_PAINT)
	else
		UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HERO_RECYCLE)
	end
end

function HeroSellDlg:onReconnect()
	self:refreshData()
	self.panelFund:onRefresh()
end

return HeroSellDlg

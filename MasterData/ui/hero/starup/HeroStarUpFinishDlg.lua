-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\StarUp\\HeroStarUpFinishDlg.lua

local strClassName = "HeroStarUpFinishDlg"
local HeroStarUpInfoDlg = require("UI/Hero/StarUp/HeroStarUpInfoDlg")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local HeroStarUpFinishDlg = Class(strClassName, HeroStarUpInfoDlg)

function HeroStarUpFinishDlg:initUI()
	self.attrPanelList = {}

	for i = 1, 3 do
		local attrPanel = HeroAttrPanel(self, "BgPanel/InfoPanel/AttrPanel" .. i)

		self.attrPanelList[i] = attrPanel
	end

	self.btnBlock = UIControls.Button(self, "Block")

	self.btnBlock:addEventClick(self.onBtnBlockClick)

	self.panelUpInfo = UIControls.Panel(self, "BgPanel")
	self.imgStar = UIControls.Image(self, "BgPanel/ImgStar")

	local heroStarUpDlg = UIManager.getUI("heroStarUpDlg", nil, false)

	if heroStarUpDlg then
		heroStarUpDlg:playHeroStarUp()
	end
end

function HeroStarUpFinishDlg:setHero(hero, materials)
	HeroStarUpFinishDlg.super.setHero(self, hero, materials)

	local starPath = self.hero:getLargeStarPath()

	if starPath then
		self.imgStar:setImage(starPath[1], starPath[2])
	end
end

function HeroStarUpFinishDlg:_playStarUpEfx()
	self.panelUpInfo:setVisible(true)
end

function HeroStarUpFinishDlg:forceCloseTimerFunc()
	if not self:isInShow() or self.mOpening ~= false then
		ClientUtils.trySendException(Lang.get(30397), "Visible:" .. tostring(self._visible) .. "isHide" .. tostring(self:getHide()) .. "mOpening" .. tostring(self.mOpening))
		self:onBtnBlockClick()
	end
end

function HeroStarUpFinishDlg:onBtnBlockClick()
	self:setVisible(false)
end

function HeroStarUpFinishDlg:onClose()
	CurAvatar:revertHeroStarUpDlg()
	CurAvatar:showHeroSellReward()
	HeroStarUpFinishDlg.super.onClose(self)
end

return HeroStarUpFinishDlg

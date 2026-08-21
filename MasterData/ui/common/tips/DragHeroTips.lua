-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\DragHeroTips.lua

local HeroTipsInfoPanel = require("UI/Common/Tips/HeroTipsInfoPanel")
local strClassName = "DragHeroTips"
local DragHeroTips = Class(strClassName, UIControls.Window)

function DragHeroTips:ctor()
	self:initUI()
end

function DragHeroTips:initUI()
	self.panel = UIControls.Panel(self, "BgPanel")
	self.panelInfo = HeroTipsInfoPanel(self, "BgPanel", "System/Common/Tips/HeroTipsInfoPanel", 0, 0, true)
	self.imgBgPanel = UIControls.Image(self, "BgPanel")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function DragHeroTips:correctPos(isLorR)
	if isLorR == nil then
		self.panel:setPosition(0)
	elseif isLorR then
		self.panel:setPosition(-390)
	else
		self.panel:setPosition(390)
	end
end

function DragHeroTips:show(card)
	self.hero = card.hero or card.monster

	if not self.hero or not self.hero.resData then
		return
	end

	self.panelInfo:setHero(self.hero)

	self.setScrollStatus = coroutine.start(self.yieldSetBgPanelStatus, self)

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function DragHeroTips:yieldSetBgPanelStatus()
	coroutine.step()

	local contentSize = self.panelInfo.scrollSkillList:getContentSize()

	if contentSize[2] <= 726 then
		self.panelInfo.scrollSkillList:cancelScroll()
	end

	self.imgBgPanel:setSize(contentSize[1], math.min(contentSize[2], 726) + 215 + 20)
end

function DragHeroTips:onClose()
	if self.setScrollStatus then
		coroutine.stop(self.setScrollStatus)
	end

	DragHeroTips.super.onClose(self)
end

function DragHeroTips:clear()
	DragHeroTips.super.clear(self)
end

function DragHeroTips:onBtnCloseClick(sender)
	self:setVisible(false)
end

return DragHeroTips

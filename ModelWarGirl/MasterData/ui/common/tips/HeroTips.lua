-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\HeroTips.lua

local HeroTipsInfoPanel = require("UI/Common/Tips/HeroTipsInfoPanel")
local strClassName = "HeroTips"
local HeroTips = Class(strClassName, UIControls.Tips)

function HeroTips:ctor()
	self:initUI()
end

function HeroTips:initUI()
	self.panel = UIControls.Panel(self, "BgPanel")
	self.imgBgPanel = UIControls.Image(self, "BgPanel")
	self.panelInfo = HeroTipsInfoPanel(self, "BgPanel", "System/Common/Tips/HeroTipsInfoPanel", 0, 0, true)
end

function HeroTips:_setObj(card)
	self.hero = card.hero or card.monster or card.object

	if not self.hero or not self.hero.resData then
		return
	end

	self.panelInfo:setHero(self.hero)

	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
end

function HeroTips:setLoasderData(gridId)
	self.panelInfo:setLosderData(gridId)
end

function HeroTips:yieldSetScrollStatus()
	coroutine.step()

	local contentSize = self.panelInfo.scrollSkillList:getContentSize()

	if contentSize[2] <= 726 then
		self.panelInfo.scrollSkillList:cancelScroll()
	end

	self.imgBgPanel:setSize(contentSize[1], math.min(contentSize[2], 726) + 215 + 20)
end

function HeroTips:destroy()
	if self.setScrollStatus then
		coroutine.stop(self.setScrollStatus)
	end

	HeroTips.super.destroy(self)
end

function HeroTips:showJumpBtn(visible)
	self.panelInfo:showJumpBtn(visible)
end

function HeroTips:clear()
	HeroTips.super.clear(self)
end

return HeroTips

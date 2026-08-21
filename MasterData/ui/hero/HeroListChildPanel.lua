-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroListChildPanel.lua

local HeroGridCard = require("UI/Hero/Grid/HeroGridCard")
local strClassName = "HeroListChildPanel"
local HeroListChildPanel = Class(strClassName, UIControls.ScrollViewLoopCell)

function HeroListChildPanel:ctor()
	self:initUI()
end

function HeroListChildPanel:initUI()
	self.cardList = {}

	for i = 1, 3 do
		local heroGridCard = HeroGridCard(self, "GridHeroCard" .. i)

		self.cardList[i] = heroGridCard
	end
end

function HeroListChildPanel:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function HeroListChildPanel:setData(data, idx)
	self.data = data
	self.idx = idx

	for i, v in ipairs(self.cardList) do
		if self.data[i] then
			self.cardList[i]:setData(self.data[i], (self.idx - 1) * 3 + i)
			self.cardList[i]:setSelectCallback(Slot(self.onCardSelected, self))
			self.cardList[i]:setVisible(true)
		else
			self.cardList[i]:setVisible(false)
		end
	end
end

function HeroListChildPanel:onCardSelected(sender)
	self.selectCallback(sender)
end

return HeroListChildPanel

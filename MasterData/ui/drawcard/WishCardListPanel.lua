-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\WishCardListPanel.lua

local strClassName = "WishCardListPanel"
local WishCardListPanel = Class(strClassName, UIControls.Panel)
local WishHeroCell = Class("WishHeroCell", UIControls.Child)

function WishHeroCell:ctor(...)
	self:initUI()
end

function WishHeroCell:initUI(...)
	self.emptyPanel = UIControls.Panel(self, "HeroAdd")
	self.heroPanel = UIControls.HeroHeadGridPanel(self, "GridHeroPoolWish")
	self.heroPanel.mEventClick = Slot(self._onClickRootBtn, self)

	self.heroPanel.btnHeroHead:addEventHoldClick(Slot(self._onHoldRootBtn, self))
end

function WishHeroCell:setWishHero(heroId)
	if not heroId then
		self.emptyPanel:setVisible(true)
		self.heroPanel:setVisible(false)
	else
		self.emptyPanel:setVisible(true)
		self.heroPanel:setVisible(true)

		local hero = BaseObject.GetObject(heroId)

		self.heroPanel:setObj(hero)
	end

	self.heroId = heroId
end

function WishHeroCell:_onClickRootBtn()
	if self.heroId and self.mParent.cellClickCallback then
		self.mParent.cellClickCallback(self.mParent.camp, self.heroId)
	end
end

function WishHeroCell:_onHoldRootBtn(...)
	if self.heroId then
		local object = BaseObject.GetObject(self.heroId)

		UIManager.getUI("heroTips"):showObj(self, object)
	end
end

function WishCardListPanel:ctor(...)
	self:initUI()
end

function WishCardListPanel:initUI(...)
	self.rootBtn = UIControls.Button(self, self.mPath)

	self.rootBtn:addEventClick(self._onClickRootBtn)

	self.newIcon = UIControls.Image(self, self.mPath .. "/NewNode")
	self.contentPath = self.mPath .. "/Content"
	self.cellList = {}
end

function WishCardListPanel:setCardListInfo(camp, selectCB, cellClickCB)
	self.camp = camp
	self.selectCallback = selectCB
	self.cellClickCallback = cellClickCB
end

function WishCardListPanel:setWishList(heroList)
	for i = 1, 5 do
		local cell = self.cellList[i]

		if not cell then
			cell = WishHeroCell(self, self.contentPath, "System/HeroPool/BtnHeroPoolWish1", 0, 0, true)
			self.cellList[i] = cell
		end

		cell:setWishHero(heroList[i])
	end
end

function WishCardListPanel:setNew(isNew)
	self.newIcon:setVisible(isNew)
end

function WishCardListPanel:setSelected(isSelected)
	self.rootBtn:setEnable(not isSelected)
end

function WishCardListPanel:_onClickRootBtn(...)
	if self.selectCallback ~= nil then
		self.selectCallback(self.camp)
	end
end

return WishCardListPanel
